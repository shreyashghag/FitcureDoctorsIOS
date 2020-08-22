//
//  Alert.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 30/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class Alert {
    
    /// Show Alert wit message enum and btns
    class func show(_ title: AlertTitle,_ message: AlertMessage, _ btnTitles: [AlertButton] = [AlertButton.Ok],  controller: UIViewController? = nil, _ handler: ((String)->())? = nil) {
        
        let alertController = UIAlertController.init(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        btnTitles.forEach { (btnTitle) in
            let action = UIAlertAction.init(title: btnTitle.rawValue, style: .default, handler: { (_ ) in
                handler?(btnTitle.rawValue)
            })
            alertController.addAction(action)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            present(alertController, controller: controller ?? AppDelegate().topViewController())
        }
    }
    
    /// Show Alert wit message enum with pbtn and nbtn
    class func show(_ title: AlertTitle,_ message: AlertMessage, _ pbtnTitles: AlertButton, _ nbtnTitle: AlertButton,  controller: UIViewController? = nil, _ handler: ((String)->())? = nil) {
        
        let alertController = UIAlertController.init(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        let action1 = UIAlertAction.init(title: pbtnTitles.rawValue, style: .default, handler: { (_ ) in
            handler?(pbtnTitles.rawValue)
        })
        alertController.addAction(action1)
        let action2 = UIAlertAction.init(title: nbtnTitle.rawValue, style: .destructive, handler: { (_ ) in
            handler?(nbtnTitle.rawValue)
        })
        alertController.addAction(action2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            present(alertController, controller: controller ?? AppDelegate().topViewController())
        }
    }
    
    /// Show Alert wit message string with btns
    class func show(_ title: AlertTitle,_ message: String, _ btnTitles: [AlertButton] = [AlertButton.Ok],  controller: UIViewController? = nil, _ handler: ((String)->())? = nil) {
        
        let alertController = UIAlertController.init(title: title.rawValue, message: message, preferredStyle: .alert)
        btnTitles.forEach { (btnTitle) in
            let action = UIAlertAction.init(title: btnTitle.rawValue, style: .default, handler: { (_ ) in
                handler?(btnTitle.rawValue)
            })
            alertController.addAction(action)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            present(alertController, controller: controller ?? AppDelegate().topViewController())
        }
    }
    
    /// Show Alert title as string, message string with btns
    class func show(_ title: String,_ message: String, _ btnTitles: [AlertButton] = [AlertButton.Ok],  controller: UIViewController? = nil, _ handler: ((String)->())? = nil) {
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        btnTitles.forEach { (btnTitle) in
            let action = UIAlertAction.init(title: btnTitle.rawValue, style: .default, handler: { (_ ) in
                handler?(btnTitle.rawValue)
            })
            alertController.addAction(action)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            present(alertController, controller: controller ?? AppDelegate().topViewController())
        }
    }
    /// Show Alert  message enum with btns on RootVC
    class func showOnRoot(_ title: AlertTitle,_ message: AlertMessage, _ btnTitles: [AlertButton] = [AlertButton.Ok], controller: UIViewController? = nil, _ handler: ((String)->())? = nil) {
        
        let alertController = UIAlertController.init(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        btnTitles.forEach { (btnTitle) in
            let action = UIAlertAction.init(title: btnTitle.rawValue, style: .default, handler: { (_ ) in
                handler?(btnTitle.rawValue)
            })
            alertController.addAction(action)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            present(alertController, controller: controller ?? AppDelegate().topViewController())
        }
    }
    
    /// Show Alert  message string with btns on RootVC
    class func showOnRoot(_ title: AlertTitle,_ message: String, _ btnTitles: [AlertButton] = [AlertButton.Ok],  controller: UIViewController? = nil, _ handler: ((String)->())? = nil) {
        
        let alertController = UIAlertController.init(title: title.rawValue, message: message, preferredStyle: .alert)
        btnTitles.forEach { (btnTitle) in
            let action = UIAlertAction.init(title: btnTitle.rawValue, style: .default, handler: { (_ ) in
                handler?(btnTitle.rawValue)
            })
            alertController.addAction(action)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            present(alertController, controller: controller ?? AppDelegate().topViewController())
        }
    }
    
    /// Show Actionsheet  message string with btns as enum
    class func showActionSheet(_ title: String,_ message: String, _ btnTitles: [AlertButton] = [AlertButton.Ok],  controller: UIViewController? = nil, _ handler: ((String)->())? = nil) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        btnTitles.forEach { (btnTitle) in
            let action = UIAlertAction.init(title: btnTitle.rawValue, style: .default, handler: { (_ ) in
                handler?(btnTitle.rawValue)
            })
            alertController.addAction(action)
        }
        
        let cancelAlert = UIAlertAction.init(title: AlertButton.Cancel.rawValue, style: .cancel, handler: { (_ ) in
            handler?(AlertButton.Cancel.rawValue)
        })
                
        cancelAlert.setValue(UIColor.systemRed, forKey: "titleTextColor")
                
        alertController.addAction(cancelAlert)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            present(alertController, controller: controller ?? AppDelegate().topViewController())
        }
    }
    
     /// Show Actionsheet  message string with btns as string
    class func showActionSheet(_ title: String,_ message: String, _ btnTitles: [String],  controller: UIViewController? = nil, _ handler: ((String)->())? = nil) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        btnTitles.forEach { (btnTitle) in
            let action = UIAlertAction.init(title: btnTitle, style: .default, handler: { (_ ) in
                handler?(btnTitle)
            })
            alertController.addAction(action)
        }
        
        let cancelAlert = UIAlertAction.init(title: AlertButton.Cancel.rawValue, style: .cancel, handler: { (_ ) in
            handler?(AlertButton.Cancel.rawValue)
        })
                
        cancelAlert.setValue(UIColor.systemRed, forKey: "titleTextColor")
                
        alertController.addAction(cancelAlert)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            present(alertController, controller: controller ?? AppDelegate().topViewController())
        }
    }
    
    class private func present(_ alert: UIAlertController, controller: UIViewController) {
        guard !(controller.isKind(of: UIAlertController.self)) else { return }
        controller.present(alert, animated: true, completion: nil)
    }
    
} //class

// MARK:- Enum For Alert Message
extension Alert {
    
    enum AlertMessage: String {
        case Oops               = "Oops something went. Please try again!"
        case MobileNumber10     = "Please enter 10 digit mobile number."
        case MobileNumber       = "Please enter valid mobile number"
        case optEnter           = "Please enter 6 digit otp."
        case optNotMatch        = "Please enter correct otp."
        case logoutCase         = "Are you sure you want to logout?"
        case phoneNoNotFound    = "We could found your mobile number. Please try again!"
        case nameRequired       = "Please enter your name."
        case invalidEmail       = "Please enter valid email."
        case Email              = "Please enter email."
        case profileUpdated     = "Your profile has been updated successfully."
        case password           = "Please enter password."
        case Age                = "Please enter your age."
        case City               = "Please enter city."
        case ValidBuildingName  = "Please enter valid building name"
        case ValidStreetName    = "Please enter valid street name"
        case ValidAreaName      = "Please enter valid area name"
        case ValidCityName      = "Please enter valid city name"
        case ProfilePicReq      = "Please select your profile picture."
        case ConsultationReason = "Please enter consultation reason."
        case PatientName        = "Please select patient name."
        case MailConfigure      = "Mail services are not available"
        case pdfAllowed         = "Please select pdf file."
        case AllpdfNeeded       = "Please all select files."
    }
    
} //Alert

// MARK:- Enum For Alert Controller Titles
extension Alert {
    
    enum AlertTitle: String {
        case error          = "Error!"
        case language       = "Language"
        case warning        = "Warning!"
        case login          = "Login"
        case Success        = "Success!"
        case FileSelected   = "File Selected"
        case sorry          = "Sorry!"
        case OTPGenerated   = "OTP Send"
    }
    
    /// Enum For Alert Button Titles
    enum AlertButton: String {
        case Ok             = "OK"
        case Yes            = "Yes"
        case No             = "No"
        case Done           = "Done"
        case Cancel         = "Cancel"
        case Logout         = "Logout"
        case Continue       = "Continue"
        case MALE           = "Male"
        case FEMALE         = "Female"
        case OTHER          = "Other"
        case EDIT           = "Edit"
        case REMOVE         = "Remove"
        case SETTING        = "Setting"
        case Update         = "Update"
        case Proceed        = "Proceed"
    }
        
} //Alert


