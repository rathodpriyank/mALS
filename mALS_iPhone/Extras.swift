//
//  Extras.swift
//  
//
//  Created by Joshua Herrera on 7/23/15.
//
//

import Foundation

enum sortType {
    case ABCFirstName
    case ABCLastName
    case AgeOLD
    case AgeYOUNG
}

struct alarms {
    var firstAlarm = String()
    var secondAlarm = String()
    var thirdAlarm = String()
    var fourthAlarm = String()
}

class Notifications {
    var _firstName = String()
    var _lastName = String()
    var _payload = String()
    var _location = String()
    var _timeRecieved = String()
    
    init(# firstName: String, lastName: String, location: String, payload: String, timeRecieved: String) {
        _firstName = firstName
        _lastName = lastName
        _location = location
        _payload = payload
        _timeRecieved = timeRecieved
    }
    
    func getNotificationInfo() -> (firstName: String, lastName: String, location: String, payload: String, timeRecieved: String) {
        return (_firstName, _lastName, _location, _payload, _timeRecieved)
    }
}


var arrayOfNotifications = NSMutableArray()