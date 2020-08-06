//
//  RelationModel.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 18/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK: - RelationListModel
struct RelationListModel: Codable {
    let error: Bool?
    let message: String?
    let response: [RelationModel]?

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
        case response = "Response"
    }
    
    static func getRelationsListing(_ complection: ((Result<[RelationModel]>)->())?) {
        APICall.webRequest(apiType: .GET, endPoint: .p_GetRelation, parameters: [:], decodableObj: RelationListModel.self) { (result) in
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? true) {
                    complection?(.Success(obj?.response ?? []))
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
struct RelationModel: Codable {
    let id: Int?
    let relation: String?
}
