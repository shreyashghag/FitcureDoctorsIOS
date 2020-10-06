//
//  CustomModel.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 22/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK: - LoginModel
struct CustomModel: Codable {
    var error: Bool?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
    }
    
    static func callRequest(_ parameter: [String: Any], complection: ((Result<String>)->())?) {
        APICall.webRequest(apiType: .POST, endPoint: .d_CallRequestSend, parameters: parameter, decodableObj: CustomModel.self) { (result) in
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? false), let strMsg = obj?.message {
                    complection?(.Success(strMsg))
                } else {
                    complection?(.CustomError(obj?.message ?? Alert.AlertMessage.Oops.rawValue))
                }
            case .CustomError(let str):
                complection?(.CustomError(str))
            }
        }
    }
    
    static func notifyPatient(_ parameter: [String: Any], complection: ((Result<String>)->())?) {
        APICall.webRequest(apiType: .POST, endPoint: .d_NotifyPatient, parameters: parameter, decodableObj: CustomModel.self) { (result) in
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
    
    static func uploadDoc(_ arrDoc: [APICall.Media], _ parameter: [String: Any], complection: ((Result<String>)->())?) {
        
        APICall.webUploadRequest(endPoint: .d_UploadDocs, parameters: parameter, arrMedia: arrDoc, decodableObj: CustomModel.self) { (result) in
            
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
    
    static func resetPassword(_ parameter: [String: Any], complection: ((Result<String>)->())?) {
        
        APICall.webRequest(apiType: .POST, endPoint: .d_forgotpassword, parameters: parameter, decodableObj: CustomModel.self) { (result) in
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
}
