//
//  SplashVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 04/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class SplashVC: UIViewController {
    
    // MARK:- Outlets
    
    // MARK:- Variables
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if UserData.returnValue(.userID) != nil {
                self.pushToTabBarVC()
            } else {
                self.pushToOnboardVC()
            }
        }
    }
    private func pushToOnboardVC() {
          guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: StoryboardExampleViewController.self)) as? StoryboardExampleViewController else { return }
          self.navigationController?.setViewControllers([vc], animated: true)
      }
        
    // MARK:- Push Methods
    private func pushToSignUpVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SignUpVC.self)) as? SignUpVC else { return }
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    private func pushToTabBarVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: TabBarVC.self)) as? TabBarVC else { return }
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:-
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class
