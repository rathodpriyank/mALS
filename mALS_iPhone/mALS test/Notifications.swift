//
//  Notifications.swift
//  mALS test
//
//  Created by Joshua Herrera on 7/23/15.
//  Copyright (c) 2015 Joshua Herrera. All rights reserved.
//

import Foundation

struct information {
    var _firstName = String()
    var _lastName = String()
    var _payload = String()
    var _location = String()
    var _timeRecieved = String()

    func getNotificationInfo() -> (_firstName: String, lastName: String, location: String, payload: String, timeRecieved: String) {
        return (_firstName, _lastName, _location, _payload, _timeRecieved)
    }
}


class Notifications {
   
}