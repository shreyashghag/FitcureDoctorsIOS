//
//  OtpVerificationVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 18/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK:- Extension For :-
extension OtpVerificationVC {
    
    func SendOtpToUser() {
        var parameter = [String: Any]()
        parameter["mobile"] = strMobileNo
        self.showLoader()
        OtpResponseModel.getOtpApi(parameter){(result) in
            self.hideLoader()
            switch result {
            case .Success(let obj):
                self.otp = obj
            case .CustomError(let str):
               Alert.show(.error, str)
            }
        }
    }
} //extension
