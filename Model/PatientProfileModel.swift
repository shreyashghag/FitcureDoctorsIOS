//
//  PatientProfileModel.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 11/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation


// MARK: - LoginModel
struct DoctorProfileModel: Codable {
    var error: Bool?
    var message: String?
    var response:Int?
    
    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case message = "Message"
        case response = "Response"
    }
  
    
    
static func editProfileApi(parameters : [String : Any], media:[APICall.Media], complection: ((Result<String>)->())?) {
        APICall.webUploadRequest(apiType: .POST, endPoint:.d_updateProfile, parameters: parameters, arrMedia: media, decodableObj: DoctorProfileModel.self) { (result) in
               switch result {
               case .Success(let obj, _, _):
                       if !(obj?.error ?? false), let msg = obj?.message {
                                  complection?(.Success(msg))
                              } else {
                                  complection?(.CustomError(obj?.message ?? Alert.AlertMessage.Oops.rawValue))
                              }
               case .CustomError(let str):
                   complection?(.CustomError(str))
               }
           }
       }
    
 }
    
    
    




