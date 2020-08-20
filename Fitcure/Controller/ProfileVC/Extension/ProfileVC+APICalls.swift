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
    
    func getPatientInfo() {
        guard let id = UserData.returnValue(.userID) as? Int else {
            Alert.show(.error, .Oops)
            return
        }
        self.showLoader()
        LoginModel.getDoctorInfo(id: id) {(result) in
            self.hideLoader()
            switch result {
            case .Success(let arr):
                self.profileObj = arr.first
                self.imgvProfile.setImage(str: self.profileObj?.profileImage, isDoc: true)
            case .CustomError(let str):
                Alert.show(.error, str)
            }
            self.setUpData()
        }
    }
    
} //extension
