//
//  SignUpVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 29/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

final class SignUpVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var txtfMobileNumber: SkyFloatingLabelTextField!
    
    // MARK:- Variables
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        self.navigationController?.isNavigationBarHidden = false
        
        txtfMobileNumber.selectedTitleColor = .f_AppColor
        txtfMobileNumber.delegate = self
        txtfMobileNumber.returnKeyType = .next
        txtfMobileNumber.keyboardType = .numberPad
        txtfMobileNumber.tintColor = .black
        txtfMobileNumber.textColor = .black
    }
    
    // MARK:- Button Actions
    @IBAction func btnSignUpPressed() {
        self.view.endEditing(true)
        guard checkValidations() else { return }
        
        api_Check_Mobile_Exits()
    }
    @IBAction private func btnLoginPressed() {
        pushLoginVC()
    }
    
    // MARK:- Custom Methods
    
    private func checkValidations()->Bool {
        self.view.endEditing(true)
        if (txtfMobileNumber.text ?? "").count != 10 {
            Alert.show(.appName, .MobileNumber10)
            return false
        }
        return true
    }
    
    // MARK:- Push Methods
    private func pushLoginVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: LoginVC.self)) as? LoginVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func pushOtpVerificationVC(optNum:Int) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: OtpVerificationVC.self)) as? OtpVerificationVC else { return }
        vc.strMobileNo = txtfMobileNumber.text ?? ""
        vc.otp = optNum
        self.navigationController?.pushViewController(vc, animated: true)
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
