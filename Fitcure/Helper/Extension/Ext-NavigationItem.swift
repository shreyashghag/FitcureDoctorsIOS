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
        case AppName   = "Rehab Call Physiotherapist"
        case Home = "Home"
        case Profile = "Profile"
        case Settings = "Settings"
        case CreateProtile = "Create Profile"
        case YourAddress = "Address"
        case OTPVerification = "OTP Verification"
        case FamilyMember = "Family Member"
        case History = "History"
        case FAQ = "FAQ's"
        case UploadDoc = "Upload Document"
        case OutcomeMeasures = "Outcome Measures"
    }
    
    func setTitle(_ _title: NavTitle) {
        self.title = _title.rawValue
    }
    
    func setTitle(_ _title: String) {
        self.title = _title
    }
    
} //extension
