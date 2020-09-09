//
//  PrescriptionModel.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 09/09/20.
//  Copyright © 2020 redbytes. All rights reserved.
//


import Foundation


struct PrescriptionModel: Codable {
    var error: Bool?
    var message: String?
    var response:String?
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
        case response = "Response"
    }
    
    static func snedPrescriptionApi(_ parameter: [String: Any], complection: ((Result<String>)->())?) {
        APICall.webRequest(apiType: .POST, endPoint: .d_sendPrescription, parameters: parameter, decodableObj: PrescriptionModel.self) { (result) in
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? false), let firestObj = obj?.response {
                    complection?(.Success(firestObj))
                } else {
                    complection?(.CustomError(obj?.message ?? Alert.AlertMessage.Oops.rawValue))
                }
            case .CustomError(let str):
                complection?(.CustomError(str))
            }
        }
    }
    
} //struct


