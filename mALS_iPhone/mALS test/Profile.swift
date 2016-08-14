//
//  Profile.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/2/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import Foundation
import AVFoundation
import Darwin
import Moscapsule
import AudioToolbox


class Profile {

    private var _firstName = String()
    private var _lastName = String()
    private var _age: Int? = 20
    private var _location = String()
    private var _ssid = String()
    private var _secruityType = String()
    private var _password = String()
    private var _deviceId = ""
    
    //78A5042E413D - mac address of server we are using
    private var _alarmTopic: String? = "alarm"
    private var _notifTopic: String? = "notif"
    private var _confTopic: String? = "confg"

    private var _alarms = alarms(firstAlarm: "WATER", secondAlarm: "FOOD", thirdAlarm: "RESTROOM", fourthAlarm: "TV")

    private let QOS: Int32 = 1
    private var _host: String = ""
    private var _port: Int32? = 0
    // Temp clientId and clientPass
    private let clientId = "client"
    private let clientPass = "pass"
    
    private var mqttConfig: MQTTConfig!
    private var mqttClient: MQTTClient!
    
    private var currentViewController: UIViewController?
    
    var audio = AVAudioPlayer()
    
    func setProfileInfo(#firstName: String, lastName: String, host: String, port: Int32, age: Int, location: String, ssid: String, securityType: String, password: String) -> Void {
        _firstName = firstName
        _lastName = lastName
        _host = host
        _port = port
        _age = age
        _location = location
        _ssid = ssid
        _secruityType = securityType
        _password = password
    }
    
    func getProfileInfo() -> (firstName: String?, lastName: String?, age: Int?, location: String?, id: String?) {
        return (_firstName, _lastName, _age, _location, _deviceId)
    }
    
    func getProfileTopic() -> (wifiConfigTopic: String?, notificationsTopic: String?, alarmTopic: String?) {
        return (_confTopic, _notifTopic, _alarmTopic)
    }
    // MQTT Related Stuff
    
    func connect() -> Void {
        let path = NSBundle.mainBundle().pathForResource("al", ofType: "wav")
        var song = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!), error: nil)
        
        mqttConfig = MQTTConfig(clientId: clientId, host: _host, port: _port!, keepAlive: 60)
        mqttConfig.onPublishCallback = { messageId in
            NSLog("published (mid=\(messageId))")
        }
        
        mqttConfig.onMessageCallback = {
            mqttMessage in NSLog("MQTT Message received: payload=\(mqttMessage.payloadString)")
            var t = time_t(); time(&t); let x = localtime(&t);
            arrayOfNotifications.addObject(Notifications(firstName: self._firstName,
                lastName: self._lastName,
                location: self._location,
                payload: mqttMessage.payloadString!,
                timeRecieved: ("\(x.memory.tm_hour)"+":"+"\(x.memory.tm_min)")));
            self.sendAlertNotification("Alert: " + mqttMessage.payloadString!)
            if(self.currentViewController?.title == "Notifications") {
                dispatch_async(dispatch_get_main_queue(),
                    { (self.currentViewController as? NotificationsTableViewController)?.updateView() } );
            }
            if(mqttMessage.payloadString == "ON") {
                song.prepareToPlay()
                song.numberOfLoops = -1
                song.play()
            }
            else if (mqttMessage.payloadString == "OFF") {
                song.pause()
            }
        }
        mqttConfig.onConnectCallback = {
            messageId in NSLog("Connected")
            self.subscribe()
            self.publishToConfig()
        }
        
        mqttConfig.onDisconnectCallback = {
            messageId in NSLog("Disconnected")
        }
        mqttClient = MQTT.newConnection(mqttConfig)
    }
    

    func disconnect() -> Void {
        self.unsubscribe()
        mqttClient.disconnect()
    }
    
    func subscribe() -> Void {
        mqttClient.subscribe(_alarmTopic!, qos: QOS)
        mqttClient.subscribe(_notifTopic!, qos: QOS)
    }
    
    func publishToConfig() -> Void {
        
        // Publish data to a topic related to what it is. EX) SSID + Password should be published to wConfigTopic 
        
        // Wifi settings
        mqttClient.publishString("wifi_config.ini" + " " + _ssid + " " + _password, topic: _confTopic!, qos: QOS, retain: false)
        // Notification Settings
        mqttClient.publishString("noti_config.ini" + " " + _alarms.firstAlarm + " " + _alarms.secondAlarm + " " + _alarms.thirdAlarm + " " + _alarms.fourthAlarm, topic: _confTopic!, qos: QOS, retain: false)
        // Local settings
//        mqttClient.publishString("locl_config.ini" + " " + "6000" + " " + "7" + " " + "7", topic: _confTopic!, qos: QOS, retain: false)
        
        // Delete Settings
 
    }

    func unsubscribe() -> Void {
        mqttClient.unsubscribe(_alarmTopic!)
    }

    func isConnected() -> Bool! {
        return mqttClient.isConnected
    }
    
    func sendAlertNotification(alert: String?) {
        var notification = UILocalNotification()
        notification.alertBody = alert
        notification.alertAction = "open"
        notification.fireDate = nil
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = nil
        notification.category = "Notifications"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func setCurrentViewController(viewController: UIViewController?) -> Void {
        self.currentViewController = viewController
    }
}

func ==(inout left: Profile, right: Profile?) -> Bool {
    let temp1 = left.getProfileInfo()
    let temp2 = right?.getProfileInfo()
    
    return ((temp1.firstName == temp2?.firstName) && (temp1.lastName == temp2?.lastName) && (temp1.age == temp2?.age) && (temp1.location == temp2?.location))
}