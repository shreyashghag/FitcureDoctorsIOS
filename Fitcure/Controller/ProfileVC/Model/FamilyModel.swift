//
//  FamilyModel.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 11/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK: - FamilyMemberModel
struct FamilyMemberModel: Codable {
    var error: Bool?
    var message: String?
    var noOfFamilyMembers: Int?
    var response: [FamilyModel]?

    enum CodingKeys: String, CodingKey {
        case message
        case error = "Error"
        case noOfFamilyMembers = "NoOfFamilyMembers"
        case response = "Response"
    }
    
    static func getListing(_ complection: ((Result<[FamilyModel]>)->())?) {
        guard let id = UserData.returnValue(.userID) as? Int else {
            complection?(.CustomError(Alert.AlertMessage.Oops.rawValue))
            return
        }
        
        APICall.webRequest(apiType: .GET, endPoint: .P_FamilyMember, strID: "\(id)", parameters: [:], decodableObj: FamilyMemberModel.self) {
            (result) in
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
struct FamilyModel: Codable {
    var familyMemberID, patientID: Int?
    var mobile, name, email, gender: String?
    var age: Int?
    var city: String?
    var relation: Int?

    enum CodingKeys: String, CodingKey {
        case familyMemberID = "familyMemberId"
        case patientID = "patientId"
        case mobile, name, email, gender, age, city, relation
    }
}
