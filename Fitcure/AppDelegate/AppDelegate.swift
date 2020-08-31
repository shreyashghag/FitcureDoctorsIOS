//
//  AppDelegate.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 29/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

/// 9967206664 123456

import UIKit
import IQKeyboardManagerSwift
import NVActivityIndicatorView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Network Monitor
        APICall.networkAvailibity()
        
        // Loader
        setUpLoader()
        
        // Keyboard Manager
        setUpIQKeyboardManager()
        
        // Notification Methods
        checkPushNotifications()
        
        if let notification = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable: Any] {
            //checkNotificationAndOpen(notification, isWithDelay: true)
        }
        
        return true
    }

    // MARK:- Custom Methods
    private func setUpLoader() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballClipRotatePulse
    }
    
    private func setUpIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
} //class

