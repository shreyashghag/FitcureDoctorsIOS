//
//  RequestForConsultVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 04/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- APICall
extension RequestForConsultVC {
    
    func getFamilyMembers() {
        self.showLoader()
        arrFamilyMember.removeAll()
        FamilyMemberModel.getListing { (result) in
            self.hideLoader()
            switch result {
            case .Success(let arr):
                self.arrFamilyMember = arr
                if let strName = UserData.returnValue(.name) as? String {
                    self.arrFamilyMember.insert(FamilyModel(familyMemberID: nil, patientID: nil, mobile: nil, name: strName, email: nil, gender: nil, age: nil, city: nil, relation: nil), at: 0)
                }
            case .CustomError(let str):
                Alert.show(.error, str, controller: self)
            }
        }
    }
} //extension
