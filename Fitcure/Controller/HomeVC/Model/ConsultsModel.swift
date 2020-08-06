//
//  ConsultsModel.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 06/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK: - ConsultsModel
struct ConsultsListModel: Codable {
    var error: Bool?
    var message: String?
    var response: [ConsultsModel]?

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
        case message = "Message"
    }
    
    static func getList(_ complection: ((Result<[ConsultsModel]>)->())?) {
        guard let id = UserData.returnValue(.userID) as? Int else {
            complection?(.CustomError(Alert.AlertMessage.Oops.rawValue))
            return
        }
        APICall.webRequest(apiType: .GET, endPoint: .P_PastConsultation, strID: "\(id)", parameters: [:], decodableObj: ConsultsListModel.self) { (result) in
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? false) {
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
struct ConsultsModel: Codable {
    var conID, doctorID: Int?
    var isAccepted: Int?
    var prescriptionPDF: String?
    var paymentStatus, familyMemberID: Int?
    var createdAt: String?
    var isCalled: Int?
    var purpose, doctor, mobile, profileImage: String?
    var speciality: String?
    var familyMemberName, relation: String?

    enum CodingKeys: String, CodingKey {
        case conID = "conId"
        case doctorID = "doctorId"
        case isAccepted
        case prescriptionPDF = "prescriptionPdf"
        case paymentStatus
        case familyMemberID = "familyMemberId"
        case createdAt, isCalled, purpose, doctor, mobile, profileImage, speciality, familyMemberName, relation
    }
}
