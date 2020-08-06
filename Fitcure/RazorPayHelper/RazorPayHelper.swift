//
//  RazorPayHelper.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 04/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//


import UIKit
import Razorpay

/**
 ## Link:- https://razorpay.com/docs/payment-gateway/ios-integration/standard/
 
 ## USAGE,
 
 ```
     var razorPayObj: RazorPayHelper? //Class scope
 ```
 ..........
 ..........
 ..........
 ```
     razorPayObj = nil
     razorPayObj = RazorPayHelper(razorpayKeyID, self, totalPayable: totalAmt, orderID: razorpayOrderID)
     razorPayObj?.openPaymentGateway(name: name, contact: contact, email: email) { [weak self] (result) in
     guard let self = self else { return }
     switch result {
         case .Success(let dict):
         // TODO:- Handle Success
         
         case .CustomError(let str):
         // TODO:- Handle Error
         
         }
     }
 ```
 
 ## Other Helpful:-
 ```
     public enum Result<T> {
         case Success(T)
         case CustomError(String)
     }
 ```
 */

final class RazorPayHelper: NSObject, RazorpayPaymentCompletionProtocolWithData {
    
    // MARK:- Variables
    // Private
    private var razorPay: RazorpayCheckout?
    private var razorKey: String
    private var controller: UIViewController
    private var orderID: String
    
    // Public
    var totalPayable: String
    var onComplection: ((Result<[String: Any]>)->())?
    
    
    // MARK:- SetUpMethods
    required init?(_ key: String, _ controller: UIViewController, totalPayable: String, orderID: String) {
        
        self.razorKey = key
        self.controller = controller
        self.totalPayable = totalPayable
        self.orderID = orderID
    }
    
    // MARK:- Button Actions
    func openPaymentGateway(name: String, contact: String, email: String, onComplection: ((Result<[String: Any]>)->())?) {
        self.onComplection = onComplection
        razorPay = RazorpayCheckout.initWithKey(razorKey, andDelegateWithData: self)
        
        guard razorPay != nil else {
            fatalError("Please call methods before calling this function.")
        }
        
        let options: [String:Any] = [
            "amount" : totalPayable,
            "description": "Consulting Charges",
            "name": name,
            "order_id" : self.orderID,
            "prefill": [
                "contact": contact,
                "email": email
            ]
        ]
        debugPrint(options)
        razorPay?.open(options)
    }
    
    
    // MARK:- RazorPay Delegate
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        debugPrint("₹₹₹ RazorPay ₹₹₹")
        debugPrint("\(code)\n\(str)")
        debugPrint("₹₹₹ RazorPay ₹₹₹")
        onComplection?(.CustomError("\(code)\n\(str)"))
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        debugPrint("₹₹₹ RazorPay ₹₹₹")
        debugPrint(response ?? [:])
        debugPrint("₹₹₹ RazorPay ₹₹₹")
        if let razorpay_payment_id = response?["razorpay_payment_id"] as? String,
            let razorpay_signature = response?["razorpay_signature"] as? String {
            
            let razorpay = ["razorpay_payment_id" : razorpay_payment_id,
                            "razorpay_signature" : razorpay_signature,
                            "razorpay_order_id" : self.orderID,
                            "total_payable" : totalPayable] as [String : Any]
            onComplection?(.Success(razorpay))
        } else {
            onComplection?(.CustomError(Alert.AlertMessage.Oops.rawValue))
        }
    }
    
} //class
