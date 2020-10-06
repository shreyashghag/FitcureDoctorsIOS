//
//  ForgotPasswordVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 05/10/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class ForgotPasswordVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var viewMobile   : MobileNumberView!
    @IBOutlet weak var viewPassword : ResetPasswordView!
    @IBOutlet weak var viewOTP	    : ForgotPasswordOTPView!
    
    // MARK:- Variables
    var strOTP = ""
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        viewMobile.setCorner(withRadius: 5)
        viewPassword.setCorner(withRadius: 5)
        viewOTP.setCorner(withRadius: 5)
        
        viewMobile.isHidden = false
        viewPassword.isHidden = true
        viewOTP.isHidden = true
        
        setUpActions()
    }
    
    private func setUpActions() {
        viewMobile.onVerifyPressed = { [weak self] strNo in
            guard let self = self else { return }
            if strNo.count != 10 {
                Alert.show(.error, .MobileNumber10)
                return
            }
            self.api_Check_Mobile_Exits()
        }
        
        viewOTP.onVerifyPressed = { [weak self] strOTP in
            guard let self = self else { return }
            if strOTP.count != 6 {
                debugPrint(self.strOTP)
                Alert.show(.error, .optEnter)
                return
            }
            if self.strOTP == strOTP {
                self.viewMobile.isHidden = true
                self.viewOTP.isHidden = true
                self.viewPassword.isHidden = false
            } else {
                debugPrint(self.strOTP)
                Alert.show(.error, .optNotMatch)
            }
        }
        
        viewPassword.onVerifyPressed = { [weak self] (strNewPassword, strConfirmPassword) in
            guard let self = self else { return }
            if strNewPassword.isEmpty || strConfirmPassword.isEmpty {
                Alert.show(.error, .password)
                return
            }
            if strNewPassword != strConfirmPassword {
                Alert.show(.error, .passwordMismatch)
                return
            }
            self.api_ResetPassword()
        }
    }
    
    // MARK:- Button Actions
    @IBAction private func btnBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK:- Custom Methods
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:-
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class
