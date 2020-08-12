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
struct RelationFamilyMemberModel: Codable {
    var error: Bool?
    var message: String?
    var response:Int?
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
        case response = "Response"
    }
    
    static func registerFamilyMemberPatientApi(strId: String, parameters : [String : Any], complection: ((Result<Int>)->())?) {
        APICall.webRequest(apiType: strId.isEmpty ? .POST : .PUT, endPoint: .d_CreateFamilyMember, strID: strId, parameters: parameters, decodableObj: RelationFamilyMemberModel.self) { (result) in
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
    
    
    




