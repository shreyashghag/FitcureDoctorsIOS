//
//  AppDelegate+PushNotification.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 25/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import UserNotifications

// MARK:- Extension For :- Notification Methods
extension AppDelegate: UNUserNotificationCenterDelegate {
        
    // MARK:- Extension For :- Requst and UnRequest
    func checkPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().getNotificationSettings { (setting) in
            switch setting.authorizationStatus {
            case .notDetermined, .denied:
                self.registerForPushNotifications()
            default:
                if UserData.returnValue(.NotificationToken) == nil {
                    self.registerForPushNotifications()
                }
            }
        }
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (_ , error) in
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func deRegisterNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.unregisterForRemoteNotifications()
            }
        }
    }
    
    // MARK:- Extension For :- Request For Notification Methods
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        debugPrint("Device Token: 🔔🔔 \(token) 🔔🔔")
        strNotificationToken = token
        UserData.saveData(.NotificationToken, token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("🔕🔕 Failed to register for remote notifications with error: \(error) 🔕🔕")
    }
    
    // MARK:- Extension For :- UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        debugPrint("🔔🔔")
        debugPrint(notification.request.content.userInfo)
        debugPrint("🔔🔔")
        
        guard UIApplication.shared.applicationState == .active || UIApplication.shared.applicationState == .background else { return }
        
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        debugPrint("🔔🔔")
        debugPrint(response.notification.request.content.userInfo)
        debugPrint("🔔🔔")
        
        completionHandler()
    }
    
    // MARK:- Custom Methodo
    func clearAllNotifications() {
        let application = UIApplication.shared
        
        application.applicationIconBadgeNumber = 0
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.removeAllDeliveredNotifications()
            center.removeAllPendingNotificationRequests()
        } else {
            application.cancelAllLocalNotifications()
        }
    }
    
} //extension
