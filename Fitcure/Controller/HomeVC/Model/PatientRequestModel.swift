//
//  PatientRequestModel.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 11/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK: - PatientRequestModel
struct PatientRequestMainModel: Codable {
    let error: Bool?
    let message: String?
    let response: [PatientRequestModel]?

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
        case response = "Response"
    }
    
    static func getPendingList(_ complection: ((Result<[PatientRequestModel]>)->())?) {
        guard let id = UserData.returnValue(.userID) as? Int else {
            complection?(.CustomError(Alert.AlertMessage.Oops.rawValue))
            return
        }
        APICall.webRequest(apiType: .GET, endPoint: .d_PendingConsultation, strID: "\(id)", parameters: [:], decodableObj: PatientRequestMainModel.self) { (result) in
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
    static func getActiveList(_ complection: ((Result<[PatientRequestModel]>)->())?) {
        guard let id = UserData.returnValue(.userID) as? Int else {
            complection?(.CustomError(Alert.AlertMessage.Oops.rawValue))
            return
        }
        APICall.webRequest(apiType: .GET, endPoint: .d_ActiveConsultation, strID: "\(id)", parameters: [:], decodableObj: PatientRequestMainModel.self) { (result) in
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
    static func getRejectedList(_ complection: ((Result<[PatientRequestModel]>)->())?) {
        guard let id = UserData.returnValue(.userID) as? Int else {
            complection?(.CustomError(Alert.AlertMessage.Oops.rawValue))
            return
        }
        APICall.webRequest(apiType: .GET, endPoint: .d_RejectedConsultation, strID: "\(id)", parameters: [:], decodableObj: PatientRequestMainModel.self) { (result) in
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
    
    
    // Accept or Reject Consultation Request
    static func changeConsultationStatus(consID: Int, isAccept: Bool, _ complection: ((Result<Bool>)->())?) {
        var parameter = [String: Any]()
        parameter["consultation_id"] = consID
        parameter["isAccepted"] = isAccept ? 1 : -1
        
        APICall.webRequest(apiType: .POST, endPoint: .d_ChangeConsultation, parameters: parameter, decodableObj: PatientRequestMainModel.self) { (result) in
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? false) {
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
struct PatientRequestModel: Codable {
    let conID, doctorID, patientID: Int?
    let purpose: String?
    let isAccepted, paymentStatus: Int?
    let createdAt: String?
    let updatedAt: String?
    let familyMemberID: Int?
    let patient: String?
    let patientage: Int?
    let profileImage: String?
    let familyMember: String?
    let familymemberage: Int?

    enum CodingKeys: String, CodingKey {
        case conID = "conId"
        case doctorID = "doctorId"
        case patientID = "patientId"
        case purpose, isAccepted, paymentStatus, createdAt, updatedAt
        case familyMemberID = "familyMemberId"
        case patient, patientage, profileImage
        case familyMember = "family_member"
        case familymemberage
    }
}
