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
      
        
        APICall.webRequest(apiType: .POST, endPoint: .P_Login, parameters: parameter, decodableObj: LoginModel.self) { (result) in
            switch result {
            case .Success(let obj, _, _):
                if !(obj?.error ?? false) {
                    guard let firstObj = obj?.response?.first,
                        let patientId = firstObj.patientID,
                        let name = firstObj.name,
                        let mobile = firstObj.mobile,
                        let email = firstObj.email
                    else {
                        complection?(.CustomError(obj?.message ?? Alert.AlertMessage.Oops.rawValue))
                        return
                    }
                    UserData.saveData(.userID, patientId)
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
    
} //struct

// MARK: - Response
struct UserModel: Codable {
    var patientID: Int?
    var mobile, name, password, email: String?
    var gender: String?
    var age: Int?
    var city, location: String?
    var relation: Int?
    var fcmToken, profileImage: String?
    
    static var obj: UserModel? = nil
        
    enum CodingKeys: String, CodingKey {
        case patientID = "patientId"
        case mobile, name, password, email, gender, age, city, location, relation
        case fcmToken = "fcm_token"
        case profileImage
    }
}
