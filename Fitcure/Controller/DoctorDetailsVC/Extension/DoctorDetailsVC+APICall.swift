//
//  DoctorDetailsVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 04/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- APICall
extension DoctorDetailsVC {
    
    func APICall_requestForMakePayment() {
        self.showLoader()
        self.objOrderRequest = nil
        ConsultOrderRequestModel.getRequest(amt: amt) { (response) in
            self.hideLoader()
            switch response {
            case .Success(let obj):
                guard
                    let strRKey = obj.razorpayID,
                    let strOKey = obj.orderID,
                    let strAmt = obj.amount,
                    !strRKey.isEmpty, !strRKey.isEmpty, !strAmt.isEmpty else {
                        Alert.show(.error, .Oops, controller: self)
                        return
                }
                self.objOrderRequest = obj
                self.makePayment(strRKey, amt: strAmt, orderID: strOKey)
            case .CustomError(let str):
                Alert.show(.error, str, controller: self)
            }
        }        
    }
    
    func APICall_createConsultation(_ parameter: [String: Any]) {
        self.showLoader()
        ConsultOrderRequestModel.createConsultation(param: parameter) { (response) in
            self.hideLoader()
            switch response {
            case .Success(let status):
                debugPrint(status)
                break
            case .CustomError(let str):
                Alert.show(.error, str, controller: self)
            }
        }
    }
    
    
} //extension
