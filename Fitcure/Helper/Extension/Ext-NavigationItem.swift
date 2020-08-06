//
//  Ext-NavigationItem.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 01/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For:- UINavigationItem
extension UINavigationItem {
    
    enum NavTitle: String {
        case Home = "Home"
        case Profile = "Profile"
        case Settings = "Settings"
        case CreateProtile = "Create Profile"
        case YourAddress = "Address"
        case OTPVerification = "OTP Verification"
        case FamilyMember = "Family Member"
    }
    
    func setTitle(_ _title: NavTitle) {
        self.title = _title.rawValue
    }
    
    func setTitle(_ _title: String) {
        self.title = _title
    }
    
} //extension
