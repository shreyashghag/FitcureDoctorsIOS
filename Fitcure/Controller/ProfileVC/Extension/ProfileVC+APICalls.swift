//
//  ProfileVC+APICalls.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 11/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- APICalls
extension ProfileVC {
    
    func getFamilyMembers() {
        self.showLoader()
        FamilyMemberModel.getListing { (result) in
            self.hideLoader()
            switch result {
            case .Success(let arr):
                self.arrFamilyMember = arr
                self.tableView.reloadData()
            case .CustomError(let str):
                Alert.show(.appName, str)
            }
        }
    }
    
    func getPatientInfo() {
        guard let id = UserData.returnValue(.userID) as? Int else {
            Alert.show(.appName, .Oops)
            return
        }
        self.showLoader()
        PatientInfoModel.getPetienInfo(id: id) {(result) in
            self.hideLoader()
            switch result {
            case .Success(let arr):
                self.patientObj = arr.first
                self.imgvProfile.setImage(str: self.patientObj?.profileImage, isDoc: false)
                self.tableView.reloadData()
            case .CustomError(let str):
                Alert.show(.appName, str)
            }
            self.getFamilyMembers()
        }
    }
    
} //extension
