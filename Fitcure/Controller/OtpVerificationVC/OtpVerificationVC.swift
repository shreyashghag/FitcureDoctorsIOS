//
//  OtpVerificationVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 29/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class OtpVerificationVC: UIViewController {
    
    var otp  = 0
    var strMobileNo = ""
    
    // MARK:- Outlets
    @IBOutlet private weak var viewOTP: OTPView!
    
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
        DispatchQueue.main.async {
            self.viewOTP.setUpView()
        }
    }
    
    // MARK:- Button Actions
    @IBAction private func btnVerifyOtpPressed() {
        debugPrint(otp)
        if viewOTP.getPin().isEmpty {
            Alert.show(.error, .optEnter)
            return
        }
        
        if otp == Int(viewOTP.getPin()) {
            pushLocationVC()
        } else {
            viewOTP.clearPin()
            Alert.show(.error, .optNotMatch)
        }
    }
    func setUpNavigation() {
        self.navigationItem.setTitle(.OTPVerification)
        let backBtn = UIBarButtonItem(image: UIImage(named: "f_back"), style: .plain, target: self, action: #selector(backBtnPressed(_:)))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    func pushLocationVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: LocationVC.self)) as? LocationVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction private func btnResendOtpPressed() {
        SendOtpToUser()
    }
    @objc func backBtnPressed(_ sender: UIBarButtonItem) {
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
