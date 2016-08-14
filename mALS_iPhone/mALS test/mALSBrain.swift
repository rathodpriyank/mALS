//
//  mALS.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/2/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import Foundation
import UIKit


class mALSBrain {
    private var profiles: [Profile] = []

    init(){
        
    }
    
    //
    // Reconnect and disconnect are for when the app goes between terminated and inital run.
    //
    func reconnect() -> Void {
        // Make a loop to reconnect all profiles
        profiles.first?.connect()
    }
    
    func disconnect() -> Void {
        // Make loop to disconnect all profiles
        profiles.first?.disconnect()
    }
    
    
    // addProfile creates the profile and adds profile to the array of profiles. Once its added it then connects the last profile added. This is so it can work for any amount of profiles
    func addProfile(firstName: String, lastName: String, host: String?, port: Int, age: Int, location: String, ssid: String, securityType: String, password: String) -> Void{
        let profile = Profile()
        profile.setProfileInfo(firstName: firstName, lastName: lastName, host: host!, port: Int32(port), age: age, location: location, ssid: ssid, securityType: securityType, password: password)
        profiles.append(profile)
        profiles.first?.connect()
    }

    // Removes profile and disconnects before it gets a profile gets removed from profiles
    // Has a check to make sure there are profiles to remove.
    func removeProfile(index: Int) -> Bool{
        if(!(profiles.isEmpty)){
            profiles[index].disconnect()
            profiles.removeAtIndex(index)
            return true
        }
        else {
            NSLog("No profiles in array\n")
            return false
        }
        
    }
    
    // ABC Order for now
    // Make it so an argument can be passed so its based off of
    // Age, ABC order first name, ABC order last name
    // Add more type of sorts, maybe ALS severity etc.
    func sortprofilesInProfile(sort: sortType) -> Void{
        var i: Int
        var j: Int
        var temp = Profile()
        
        switch sort {
        case .ABCFirstName:
            for i = 0; i < profiles.count; ++i{
                for j = i + 1; j < profiles.count; ++j{
                    if(profiles[i].getProfileInfo().firstName > profiles[j].getProfileInfo().firstName){
                        temp = profiles[i]
                        profiles[i] = profiles[j]
                        profiles[j] = temp
                    }
                }
            }
        case .ABCLastName:
            for i = 0; i < profiles.count; ++i{
                for j = i + 1; j < profiles.count; ++j{
                    if(profiles[i].getProfileInfo().lastName > profiles[j].getProfileInfo().lastName){
                        temp = profiles[i]
                        profiles[i] = profiles[j]
                        profiles[j] = temp
                    }
                }
            }
        case .AgeOLD:
            for i = 0; i < profiles.count; ++i{
                for j = i + 1; j < profiles.count; ++j{
                    if(profiles[i].getProfileInfo().age < profiles[j].getProfileInfo().age){
                        temp = profiles[i]
                        profiles[i] = profiles[j]
                        profiles[j] = temp
                    }
                }
            }
        case .AgeYOUNG:
            for i = 0; i < profiles.count; ++i{
                for j = i + 1; j < profiles.count; ++j{
                    if(profiles[i].getProfileInfo().age > profiles[j].getProfileInfo().age){
                        temp = profiles[i]
                        profiles[i] = profiles[j]
                        profiles[j] = temp
                    }
                }
            }
        default:
            NSLog("Sort did not happen\n")
        }
    }
    
    // Returns all profile info necessary to generate a table. 
    // Returns First and Last names. Returns the age of the person assiociated with the profile
    // Returns the location of the profile. (Room number)
    func getProfileInfoAtIndex(index: Int) -> (firstName: String, lastName: String, age: Int, location: String){
        return (profiles[index].getProfileInfo().firstName!, profiles[index].getProfileInfo().lastName!, profiles[index].getProfileInfo().age!, (profiles[index].getProfileInfo().location)!)
    }
    
    // Returns the amount of profile
    func getProfileCount() -> Int?{
        return profiles.count
    }
    
    // Currently just checks the first profile to see if it is connected to the MQTT host. Client
    // side only.
    //
    // Goal -
    // Check if profile at a given index is connected to the  MQTT host or not and will return true 
    // or false. This function is app client sided only. This does not check if the sensor device
    // is connected to the MQTT host.
    func isConnected() -> Bool{
        if(profiles.isEmpty) {
            return false
        }
        else {
            return (profiles.first?.isConnected())!
        }
    }
    
    // For debug purposes only. Prints the first and last name of each profile in the profiles 
    // array to the terminal
    func getProfiles() -> Void{
        for person in profiles{
            NSLog("%@ %@\n", (person.getProfileInfo().firstName)!, (person.getProfileInfo().lastName)!)
        }
    }
    
    // Need to fix below things about Notifications due to it being an open variable and anything outside of mALSBrain being able to access it
    // Returns the number of notifications that have been received. This value can be reset due to
    // the above issue.
    func getNumberOfNotifications() -> Int?{
        return arrayOfNotifications.count
    }
    
    // Returns a Notification struct at a given index. This is used for table generation.
    // Notification struct has the time and payload received.
    func getNotificationInfoAtIndex(index: Int) -> Notifications? {
        return arrayOfNotifications[index] as? Notifications
    }
    
    // Sets the current view controller that a profile has. This is so it knows if its on the
    // notifications table and if it needs a real time update of the table.
    // A work around needs to be made so that this is more proper than each profile in the 
    // array having its own view controller status.
    func setCurrentViewController(viewController: UIViewController?) -> Void {
        profiles.last?.setCurrentViewController(viewController)
    }

}

