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
                strNotificationToken = (UserData.returnValue(.NotificationToken) as? String) ?? "No Notification Available Right Now..."
            }
        }
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (_ , error) in
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            debugPrint(error?.localizedDescription ?? "")
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
        let dict = notification.request.content.userInfo as? [String : Any] ?? [:]
        let strMessage = dict["messageFrom"] as? String ?? ""
            
        switch strMessage {
        case "Video Call Request Rejected":
            NotificationCenter.default.post(name: .callCanceled, object: nil)
        default:
            break
        }
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        debugPrint("🔔🔔")
        debugPrint(response.notification.request.content.userInfo)
        debugPrint("🔔🔔")
                
        let dict = response.notification.request.content.userInfo as? [String : Any] ?? [:]
        let strMessage = dict["messageFrom"] as? String ?? ""
            
        switch strMessage {
        case "Video Call Request Rejected":
            NotificationCenter.default.post(name: .callCanceled, object: nil)
        default:
            break
        }
        
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
