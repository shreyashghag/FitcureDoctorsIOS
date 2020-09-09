//
//  ExpertOpenionModel.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 07/09/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation
// MARK: - LoginModel
struct ExpertOpenionModel: Codable {
    var error: Bool?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
    }
    
    static func CreateExpertOpenionApiCall(_ parameter: [String: Any], complection: ((Result<String>)->())?) {
        APICall.webRequest(apiType: .POST, endPoint: .d_helpinghand, parameters: parameter, decodableObj: ExpertOpenionModel.self) { (result) in
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
