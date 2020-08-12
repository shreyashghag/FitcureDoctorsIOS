//
//  PatientInfoModel.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 15/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

//
//  ConsultsModel.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 06/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK: - ConsultsModel
struct PatientInfoModel: Codable {
    var error: Bool?
    var response: [PatientModel]?

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
     
    }
    
     static func getPetienInfo(id:Int,_ complection: ((Result<[PatientModel]>)->())?) {
         
          APICall.webRequest(apiType: .GET, endPoint: .d_Patient, strID: "\(id)", parameters: [:], decodableObj: PatientInfoModel.self) { (result) in
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
}

// MARK: - Response
struct PatientModel: Codable {
    var patientId: Int?
    var relation: Int?
    var mobile: String?
    var name :String?
    var password: String?
    var email: String?
    var gender: String?
    var age: Int?
    var city: String?
    var location: String?
    var fcm_token: String?
    var profileImage: String?    
}
