//
//  LoginVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 30/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For:- APICalls
extension LoginVC {
    
    func api_Login() {
        var parameter = [String: Any]()
        parameter["mobile"] = txtfMobileNumber.text ?? ""
        parameter["password"] = txtfPassword.text ?? ""
        parameter["token"] = strNotificationToken
        parameter["deviceType"] = "IOS"
        
        self.showLoader()
        LoginModel.login(parameter) { (result) in
            self.hideLoader()
            switch result {
            case .Success(let obj):
                UserModel.obj = obj
                self.pushTabbarVC()
            case .CustomError(let str):
                Alert.show(.error, str)
            }
        }
    }
    
} //extension
