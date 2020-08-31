//
//  FAQModel.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 09/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

struct FAQModel {
    var strQuestion     = ""
    var strAnswer       = ""
    var isShow          = false
        
    static func getListing()->[FAQModel] {
        var arr = [FAQModel]()
        arr.append(FAQModel(
            strQuestion: "How to request a call with doctor?",
            strAnswer:
            """
             1. Select a doctor as per your requirement
             2. Request consultation
             3. Reason for consultation
             4. Make payment
            """,
            isShow: false))
        
        arr.append(FAQModel(
        strQuestion: "Wait time until doctor contact us?",
        strAnswer: "Once a request is raised, doctors will contact you within 4 hours. ",
        isShow: false))
        
        arr.append(FAQModel(
        strQuestion: "How would I be able to receive the prescription?",
        strAnswer: "Once the doctor consult you, you will receive the prescription via email.\nAlso you can check the prescription in the application:\nOnce the consultation is over --> go to past consults --> view your prescription.",
        isShow: false))
        
        arr.append(FAQModel(
        strQuestion: "When can I get a refund, if doctor does not contact?",
        strAnswer: "If the doctor cannot contact you within 4 hours for any reason then you will get a refund within 7 days.",
        isShow: false))
        
        arr.append(FAQModel(
        strQuestion: "Can patient contact doctors?",
        strAnswer: "No, patient cannot contact doctors directly",
        isShow: false))
        
        arr.append(FAQModel(
        strQuestion: "What if patient does not answer the call, when doctor calls the patient?",
        strAnswer: "Doctors will try calling you thrice within 4 hours’ time period, you will get a SMS and app notification (if you are connected to internet). If patient fails to answer the call, the request will be cancelled and there won’t be any refund given to patient",
        isShow: false))
        
        arr.append(FAQModel(
        strQuestion: "For what duration is the appointment valid?",
        strAnswer: "The request will be valid for 30 minutes, if doctor accepts your request then doctor will call you within 4 hours.",
        isShow: false))
        
        arr.append(FAQModel(
        strQuestion: "How many times doctor can contact me with single appointment request?",
        strAnswer: "Doctor will only call you once for a single consultation request.",
        isShow: false))
        
        arr.append(FAQModel(
        strQuestion: "What if doctors reject your request?",
        strAnswer: "Patient will get refund within 7 days.",
        isShow: false))
        
        arr.append(FAQModel(
        strQuestion: "How long it takes for the appointment to be approved?",
        strAnswer: "Doctor accepts/approves the request within 30 minutes",
        isShow: false))
        
        arr.append(FAQModel(
        strQuestion: "If the initial request is not answered, then will patient be able to raise another request?",
        strAnswer: "If the initial request is not answered patient will get a refund and can raise another request for the same.",
        isShow: false))
        
        arr.append(FAQModel(
        strQuestion: "What if the amount is not refunded in 7 days?",
        strAnswer: "If due to any circumstances the amount is not refunded back to the patient in 7 days please contact us on the below email <Email ID> ",
        isShow: false))
        
        return arr
    }
} //class
