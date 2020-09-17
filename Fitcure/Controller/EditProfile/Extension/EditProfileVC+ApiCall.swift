//
//  EditProfileVC+ApiCall.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 10/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Extension For :- APICall
extension EditProfileVC {
    
    
    func api_update_patient_info() {
        
        var parameter = [String: Any]()
        
        parameter["doctorId"] = UserData.returnValue(.userID)
        parameter["name"] =  txtfName.text ?? ""
        parameter["nameOfCouncil"] = txtfnameOfCouncil.text ?? ""
        parameter["email"] = txtfEmail.text ?? ""
        parameter["registrationNo"] = txtfregistratioNo.text ?? ""
        parameter["workingSince"] = doctorObj?.workingSince ?? ""
        parameter["qualification"] = txtfqualification.text ?? ""
        parameter["associateHospital"] = txtfassociateHospital.text ?? ""
        parameter["city"] = txtfCity.text ?? ""
        parameter["preferredLanguages"] = txtfpreferredLanguages.text ?? ""
        parameter["location"] = txtflocation.text ?? ""
        parameter["speciality"] = txtfspeciality.text ?? ""
        parameter["profileImage"] = "\( UserData.returnValue(.Mobile) ?? "")_Doctor_Profile.png"
                
        var arrMedia = [APICall.Media]()
        if let objM = media {
            arrMedia.append(objM)
        }
        self.showLoader()
        DoctorProfileModel.editProfileApi(parameters: parameter, media: arrMedia) { (result) in
            self.hideLoader()
            switch result {
            case .Success(let str):
                Alert.show(.appName, str, controller: self) { [weak self] _ in
                    guard let self = self else { return }
                    self.navigationController?.popViewController(animated: true)
                }
            case .CustomError(let strErr):
                Alert.show(.appName, strErr)
            }
        }
    }
    
}
