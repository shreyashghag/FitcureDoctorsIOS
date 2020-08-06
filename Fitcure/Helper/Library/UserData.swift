//
//  UserData.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 04/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

final class UserData {

    enum userDataKeys : String {
        case userID                     = "User_ID"
        case token                      = "App_Token"
        case NotificationToken          = "Notification_Token"
        case isProfileVerified          = "is_Profile_Verified"
        case name                       = "UserName"
        case Email                      = "EmailID"
        case Profile                    = "Profile"
        case Latitude                   = "latitude"
        case Longitude                  = "Longitude"
        case Mobile                     = "MobileNo"
        case Tutorials                  = "ShowTutorials"
        case BikeTutorials              = "ShowBikeTutorials"
        case CustomerNumber             = "customerSupport"
        case currentLocation            = "currentLocation"
    }
    
    // MARK:- init Methods
    private init() {}
    private static let userdefault = UserDefaults.standard
    
    // MARK:- Save Data
    class func saveData(_ type: userDataKeys, _ value: Any) {
        userdefault.set(value, forKey: type.rawValue)
    }
    
    // MARK:- Get Data
    class func returnValue(_ type: userDataKeys)->Any? {
        return userdefault.value(forKey: type.rawValue)
    }
    
    // MARK:- Synchronize
    class func synchronize() {
        userdefault.synchronize()
    }
    
    // MARK:- Clear Data
    class func clearData() {
        let domain = Bundle.main.bundleIdentifier!
        userdefault.removePersistentDomain(forName: domain)
        userdefault.synchronize()
    }
    
    class func clearDataForKey(arr: [userDataKeys]) {
        for key in arr {
            userdefault.removeObject(forKey: key.rawValue)
        }
    }
    
} //class
