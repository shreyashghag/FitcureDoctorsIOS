//
//  CreatePatientVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 07/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For:- APICalls
extension CreatePatientVC {
    
    func api_create_patient() {
        
        var parameter = [String: Any]()
        parameter["name"] =  txtfName.text ?? ""
        parameter["mobile"] = txtfMobileNo.text ?? ""
        parameter["gender"] = genderStr
        parameter["password"] = txtfPassword.text ?? ""
        parameter["email"] = txtfEmail.text ?? ""
        parameter["age"] = txtfAge.text ?? ""
        parameter["city"] = txtfCity.text ?? ""
        parameter["location"] = UserData.returnValue(.currentLocation) as? String ?? ""
        parameter["fcm_token"] = ""
        parameter["profile_image"] = "\( txtfMobileNo.text ?? "")_Patient_Profile.png"
        
        var arrMedia = [APICall.Media]()
        if let objM = media {
            arrMedia.append(objM)
        }
        
        self.showLoader()
        CreatePatientModel.registerPatientApi(parameters: parameter, media: arrMedia) { (result) in
            self.hideLoader()
            switch result {
            case .Success(let str):
                print("str==",str)
                DispatchQueue.main.async {
                    self.getPatientInfo(response: str)
                }
                
            case .CustomError(let strErr):
                Alert.show(.appName, strErr)
            }
        }
    }
    
    func getPatientInfo(response:Int) {
        self.showLoader()
        PatientInfoModel.getPetienInfo(id: response){(result) in
            self.hideLoader()
            switch result {
            case .Success(let arr):
                guard let firstObj = arr.first,
                    let patientId = firstObj.patientId,
                    let name = firstObj.name,
                    let mobile = firstObj.mobile,
                    let email = firstObj.email
                else {
                    Alert.show(.appName, .Oops)
                    return
                }
                UserData.saveData(.userID, patientId)
                UserData.saveData(.name, name)
                UserData.saveData(.Mobile, mobile)
                UserData.saveData(.Email, email)
                DispatchQueue.main.async {
                    self.pushTabbarVC()
                }
                
            case .CustomError(let str):
                Alert.show(.appName, str)
            }
        }
    }
    
} //extension
