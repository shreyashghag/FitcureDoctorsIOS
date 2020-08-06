//
//  Ext-AppDelegate.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 30/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For:- AppDelegate
extension AppDelegate {
    
    /// Get Top viewController on app
    func rootController()-> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return self.rootController() ?? UIViewController()
    }
    
} //extension
