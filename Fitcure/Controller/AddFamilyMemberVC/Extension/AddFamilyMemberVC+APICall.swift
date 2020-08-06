//
//  AddFamilyMemberVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 18/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- APICall
extension AddFamilyMemberVC {
    
    func getRelations() {
        self.showLoader()
        RelationListModel.getRelationsListing { (result) in
            self.hideLoader()
            switch result {
            case .Success(let arr):
                self.arrRelations = arr
                self.setData()
            case .CustomError(let str):
                Alert.show(.appName, str)
            }
        }        
    }
    
    func api_create_patient_family_fember() {
        
        var parameter = [String: Any]()
        parameter["patientId"] = UserData.returnValue(.userID)
        parameter["name"] =  txtfName.text ?? ""
        parameter["mobile"] = txtfMobileNo.text ?? ""
        parameter["gender"] = genderStr
         parameter["email"] = txtfEmail.text ?? ""
        parameter["age"] = txtfAge.text ?? ""
        parameter["city"] = txtfCity.text ?? ""
        parameter["relation"] = relationID
        
        var strID = ""
        if let id = obj?.familyMemberID {
            strID = "\(id)"
        }
        
        self.showLoader()
        RelationFamilyMemberModel.registerFamilyMemberPatientApi(strId: strID, parameters: parameter) { (result) in
            self.hideLoader()
            switch result {
            case .Success(let str):
                print("str==",str)
                DispatchQueue.main.async {
                    self.pushProfileVC()
                }
                
            case .CustomError(let strErr):
                Alert.show(.appName, strErr)
            }
        }
    }
} //extension
