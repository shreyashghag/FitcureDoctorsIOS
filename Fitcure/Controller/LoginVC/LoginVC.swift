//
//  LoginVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 29/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

final class LoginVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var btnSecure        : UIButton!
    @IBOutlet weak var txtfMobileNumber : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfPassword     : SkyFloatingLabelTextField!
    
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
        setUpNavigation()
        
        txtfMobileNumber.selectedTitleColor = .f_AppColor
        txtfMobileNumber.tintColor = .f_AppColor
        txtfMobileNumber.textColor = .darkText
        txtfMobileNumber.delegate = self
        txtfMobileNumber.returnKeyType = .next
        txtfMobileNumber.keyboardType = .numberPad
        txtfMobileNumber.tintColor = .black
        txtfMobileNumber.textColor = .black
        
        txtfPassword.selectedTitleColor = .f_AppColor
        txtfPassword.textColor = .darkText
        txtfPassword.tintColor = .f_AppColor
        txtfPassword.delegate = self
        txtfPassword.returnKeyType = .done
        txtfPassword.isSecureTextEntry = true
        txtfPassword.tintColor = .black
        txtfPassword.textColor = .black
    }
    
    func setUpNavigation() {
        self.navigationItem.setTitle(.AppName)
        self.navigationController?.isNavigationBarHidden = false
        let backBtn = UIBarButtonItem(image: UIImage(named: "f_back"), style: .plain, target: self, action: #selector(backBtnPressed(_:)))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    // MARK:- Button Actions
    @objc func backBtnPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func btnSignUpPressed() {
        pushSignUpVC()
    }
    @IBAction private func btnLoginPressed() {
        guard checkValidations() else { return }
        api_Login()
    }
    @IBAction private func btnForgotPasswordPressed() {
        pushForgotPasswordVC()
    }
    @IBAction private func btnSecurePressed() {
        txtfPassword.isSecureTextEntry.toggle()
        btnSecure.setImage(UIImage(named: txtfPassword.isSecureTextEntry ? "f_HidePassword" : "f_ShowPassword"), for: .normal)
    }
    
    // MARK:- Custom Methods
    private func checkValidations()->Bool {
        self.view.endEditing(true)
        if (txtfMobileNumber.text ?? "").count != 10 {
            Alert.show(.error, .MobileNumber10)
            return false
        }
        if (txtfPassword.text ?? "").isEmpty {
            Alert.show(.error, .password)
            return false
        }
        return true
    }
    
    // MARK:- Push Methods
    private func pushSignUpVC() {
        self.navigationController?.popViewController(animated: true)
    }
    private func pushForgotPasswordVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: ForgotPasswordVC.self)) as? ForgotPasswordVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func pushTabbarVC() {
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
