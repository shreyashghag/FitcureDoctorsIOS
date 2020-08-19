//
//  SignUpModel.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 02/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation
import Foundation

// MARK: - LoginModel
struct SignUpModel: Codable {
    var error: Bool?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
    }
    
    static func CheackUserExit(_ parameter: [String: Any], complection: ((Result<String>)->())?) {
        APICall.webRequest(apiType: .POST, endPoint: .d_CheckNo, parameters: parameter, decodableObj: SignUpModel.self) { (result) in
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? false), let firestObj = obj?.message {
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


// MARK: - Response
struct OtpResponseModel: Codable {
    var error: Bool?
    var message: String?
    var Response:Int?
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
        case Response = "Response"
    }
    
    static func getOtpApi(_ parameter: [String: Any], complection: ((Result<Int>)->())?) {
        APICall.webRequest(apiType: .POST, endPoint: .d_GenerateOtp, parameters: parameter, decodableObj: OtpResponseModel.self) { (result) in
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? false), let firestObj = obj?.Response {
                    complection?(.Success(firestObj))
                } else {
                    complection?(.CustomError(obj?.message ?? Alert.AlertMessage.Oops.rawValue))
                }
            case .CustomError(let str):
                complection?(.CustomError(str))
            }
        }
    }
}
