//
//  DoctorListModel.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 04/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK: - DoctorListModel
struct DoctorListModel: Codable {
    var error: Bool?
    var message: String?
    var pageNumber: String?
    var totalDoctors: Int?
    var response: [DoctorModel]?
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
        case pageNumber = "PageNumber"
        case totalDoctors = "TotalDoctors"
        case response = "Response"
    }
    
    static func getList(page: Int, _ complection: ((Result<(Int?, [DoctorModel])>)->())?) {
        
        APICall.webRequest(apiType: .POST, endPoint: .P_DoctorList, parameters: ["page": page], decodableObj: DoctorListModel.self) { (result) in
            
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? false) {
                    complection?(.Success((obj?.totalDoctors, obj?.response ?? [])))
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
struct DoctorModel: Codable {
    var id: Int?
    var name, profileImage, qualification, city, associateHospital: String?
    var workingSince: Int?
    var nameOfCouncil, email, registrationNo, mobile, gender, password: String?
    var preferredLanguages: String?
    var location, signatureImage, signatureBitmapImage: String?
    var speciality, fcmToken: String?
    var razorpayOrderID, paymentID, orderReceiptID: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, profileImage, qualification, city, workingSince, associateHospital
        case mobile, gender, password, nameOfCouncil, email, registrationNo, preferredLanguages, location, signatureImage, signatureBitmapImage, speciality
        case fcmToken = "fcm_token"
        case razorpayOrderID = "razorpayOrderId"
        case paymentID = "paymentId"
        case orderReceiptID = "orderReceiptId"
    }
}
