//
//  SceneDelegate.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 29/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //guard let res = connectionOptions.notificationResponse, let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //appDelegate.checkNotificationAndOpen(res.notification.request.content.userInfo, isWithDelay: true)
    }


}

