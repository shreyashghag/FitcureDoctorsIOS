//
//  SignUpVC+APICall.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 02/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Extension For:- APICalls
extension SignUpVC {
    
    func api_Check_Mobile_Exits() {
        var parameter = [String: Any]()
        parameter["mobile"] = txtfMobileNumber.text ?? ""
        self.showLoader()
        SignUpModel.CheackUserExit(parameter) { (result) in
            self.hideLoader()
            switch result {
            case .Success(let str):
                Alert.show(.error, str)
            case .CustomError(_ ):
                self.api_SendOtpToUser()
            }
        }
    }
    
    func api_SendOtpToUser(){
        var parameter = [String: Any]()
        parameter["mobile"] = txtfMobileNumber.text ?? ""
        self.showLoader()
        OtpResponseModel.getOtpApi(parameter){(result) in
            self.hideLoader()
            switch result {
            case .Success(let obj):
                UserData.saveData(.Mobile,self.txtfMobileNumber.text ?? "" )
                self.pushOtpVerificationVC(optNum: obj)
            case .CustomError(let str):
               Alert.show(.error, str)
            }
        }
        
    }
    
} //extension
