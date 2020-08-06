//
//  ConsultRequestOrderModel.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 04/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK: - ConsultRequestOrderModel
struct ConsultOrderRequestModel: Codable {
    let error: Bool?
    let message: String?
    let response: OrderRequestModel?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case error = "Error"
        case response = "Response"
    }
    
    static func getRequest(amt: Double = 350, _ complection: ((Result<OrderRequestModel>)->())?) {
                
        APICall.webRequest(apiType: .POST, endPoint: .p_ConsultationRequest, parameters: ["amount" : amt], decodableObj: ConsultOrderRequestModel.self) {
            (result) in
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? true), let rObj = obj?.response {
                    complection?(.Success(rObj))
                } else {
                    complection?(.CustomError(obj?.message ?? Alert.AlertMessage.Oops.rawValue))
                }
            case .CustomError(let str):
                complection?(.CustomError(str))
            }
        }
    }
    
    static func createConsultation(param: [String: Any], _ complection: ((Result<Bool>)->())?) {
                
        APICall.webRequest(apiType: .POST, endPoint: .p_CreateConsultation, parameters: param, decodableObj: ConsultOrderRequestModel.self) {
            (result) in
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? true) {
                    complection?(.Success(true))
                } else {
                    complection?(.CustomError(obj?.message ?? Alert.AlertMessage.Oops.rawValue))
                }
            case .CustomError(let str):
                complection?(.CustomError(str))
            }
        }
    }
    
}

// MARK: - Response
struct OrderRequestModel: Codable {
    let orderID, orderReceipt, razorpayID, amount: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case orderReceipt = "order_receipt"
        case razorpayID = "razorpay_id"
        case amount
    }
}
