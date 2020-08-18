//
//  CreatePatientModel.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 14/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation
import Foundation

// MARK: - LoginModel
struct CreatePatientModel: Codable {
    var error: Bool?
    var message: String?
    var response:Int?
    
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
        case response = "Response"
        
        
    }
    
    static func registerPatientApi(parameters : [String : Any],media:[APICall.Media], complection: ((Result<Int>)->())?) {
        APICall.webUploadRequest(apiType: .POST, endPoint: .d_CreateDoctor, parameters: parameters, arrMedia: media, decodableObj: CreatePatientModel.self) { (result) in
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
    
  
    
 
 }
    
    
    




