//
//  ForgotPasswordVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 06/10/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :-
extension ForgotPasswordVC {
    func api_Check_Mobile_Exits() {
        var parameter = [String: Any]()
        parameter["mobile"] = viewMobile.txtfMobile.text ?? ""
        self.showLoader()
        SignUpModel.CheackUserExit(parameter) { (result) in
            self.hideLoader()
            switch result {
            case .Success(_ ):
                self.api_SendOtpToUser()
            case .CustomError(_ ):
                Alert.show(.error, "Could not found user with this mobile number.")
            }
        }
    }
    
    func api_SendOtpToUser(){
        var parameter = [String: Any]()
        parameter["mobile"] = viewMobile.txtfMobile.text ?? ""
        self.showLoader()
        OtpResponseModel.getOtpApi(parameter){(result) in
            self.hideLoader()
            switch result {
            case .Success(let obj):
                self.strOTP = "\(obj)"
                self.viewMobile.isHidden = true
                self.viewOTP.isHidden = false
                self.viewPassword.isHidden = true
            case .CustomError(let str):
                Alert.show(.error, str)
            }
        }
    }
    
    func api_ResetPassword() {
        self.view.endEditing(true)
        var parameter = [String: Any]()
        parameter["new_password"] = viewPassword.txtfConfirmPass.text ?? ""
        parameter["mobile"] = viewMobile.txtfMobile.text ?? ""
        
        self.showLoader()
        CustomModel.resetPassword(parameter) { (result) in
            self.hideLoader()
            switch result {
            case .Success(let str):
                Alert.show(.Success, str) { [weak self] _ in
                    guard let self = self else { return }
                    self.navigationController?.popViewController(animated: true)
                }
            case .CustomError(let str):
                Alert.show(.error, str) { [weak self] _ in
                    guard let self = self else { return }
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
} //extension
