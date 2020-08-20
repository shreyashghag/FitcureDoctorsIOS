//
//  LoginModel.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 30/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    var error: Bool?
    var message: String?
    var response: [UserModel]?

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
        case response = "Response"
    }
    
    static func login(_ parameter: [String: Any], complection: ((Result<UserModel>)->())?) {
      
        
        APICall.webRequest(apiType: .POST, endPoint: .d_Login, parameters: parameter, decodableObj: LoginModel.self) { (result) in
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? false) {
                    guard let firstObj = obj?.response?.first,
                        let id = firstObj.id,
                        let name = firstObj.name,
                        let mobile = firstObj.mobile,
                        let email = firstObj.email
                    else {
                        complection?(.CustomError(obj?.message ?? Alert.AlertMessage.Oops.rawValue))
                        return
                    }
                    UserData.saveData(.userID, id)
                    UserData.saveData(.name, name)
                    UserData.saveData(.Mobile, mobile)
                    UserData.saveData(.Email, email)
                    complection?(.Success(firstObj))
                } else {
                    complection?(.CustomError(obj?.message ?? Alert.AlertMessage.Oops.rawValue))
                }
            case .CustomError(let str):
                complection?(.CustomError(str))
            }
        }
    }
    
    static func getDoctorInfo(id:Int,_ complection: ((Result<[UserModel]>)->())?) {
            
             APICall.webRequest(apiType: .GET, endPoint: .d_DoctorList, strID: "\(id)", parameters: [:], decodableObj: LoginModel.self) { (result) in
                 switch result {
                 case .Success(let obj, _, _):
                     if !(obj?.error ?? false) {
                         complection?(.Success(obj?.response ?? []))
                     } else {
                       complection?(.CustomError(obj?.error.debugDescription ?? Alert.AlertMessage.Oops.rawValue))
                     }
                 case .CustomError(let str):
                     complection?(.CustomError(str))
                 }
             }
         }
} //struct

// MARK: - Response
struct UserModel: Codable {
    
    static var obj: UserModel? = nil
        
    let id: Int?
    let name, mobile, gender, password: String?
    let nameOfCouncil, email, registrationNo: String?
    let workingSince: Int?
    let qualification, associateHospital, city, preferredLanguages: String?
    let location, profileImage, signatureImage, signatureBitmapImage: String?
    let speciality, fcmToken: String?
    let razorpayOrderID, paymentID, orderReceiptID: String?
    let isApproved: Int?
    let createdAt: String?
    let approvedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, mobile, gender, password, nameOfCouncil, email, registrationNo, workingSince, qualification, associateHospital, city, preferredLanguages, location, profileImage, signatureImage, signatureBitmapImage, speciality
        case fcmToken = "fcm_token"
        case razorpayOrderID = "razorpayOrderId"
        case paymentID = "paymentId"
        case orderReceiptID = "orderReceiptId"
        case isApproved, createdAt, approvedAt
    }
}
