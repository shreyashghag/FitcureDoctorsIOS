//
//  ConsultationFeedbackModel.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 20/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK: - ConsultationFeedbackModel
struct ConsultationFeedbackModel: Codable {
    let error: Bool?
    let message: String?
    let response: Int?

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
        case response = "Response"
    }
    
    static func sendFeedback(parameter: [String : Any], _ complection: ((Result<String>)->())?) {
        APICall.webRequest(apiType: .POST, endPoint: .p_ConsultationFeedback, parameters: parameter, decodableObj: ConsultationFeedbackModel.self) { (result) in
            
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? true) {
                    complection?(.Success(obj?.message ?? "Success"))
                } else {
                    complection?(.CustomError(obj?.message ?? Alert.AlertMessage.Oops.rawValue))
                }
            case .CustomError(let str):
                complection?(.CustomError(str))
            }
        }
    }
}
