//
//  CreateDoctorVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 07/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For:- APICalls
extension CreateDoctorVC {
    
    func api_create_patient() {
        
        var parameter = [String: Any]()
        parameter["name"] =  txtfName.text ?? ""
        parameter["mobile"] = txtfMobileNo.text ?? ""
        parameter["gender"] = genderStr
        parameter["password"] = txtfPassword.text ?? ""
        parameter["nameOfCouncil"] = txtfnameOfCouncil.text ?? ""
        parameter["email"] = txtfEmail.text ?? ""
        parameter["registrationNo"] = txtfMobileNo.text ?? ""
        parameter["workingSince"] = txtfworkingSince.text ?? ""
        parameter["qualification"] = txtfqualification.text ?? ""
        parameter["associateHospital"] = txtfassociateHospital.text ?? ""
        parameter["city"] = txtfCity.text ?? ""
        parameter["location"] = UserData.returnValue(.currentLocation) as? String ?? ""
        parameter["preferredLanguages"] = txtfpreferredLanguages.text ?? ""
        parameter["speciality"] = txtfspeciality.text ?? ""
        parameter["fcm_token"] = ""
        parameter["speciality"] = txtfspeciality.text ?? ""
        parameter["profile_image"] = "\( txtfMobileNo.text ?? "")_Doctor_Profile.png"
        parameter["signature"] = "\( txtfMobileNo.text ?? "")_Doctor_Digital_Signature.png"
        parameter["signature_bitmap"] = "\( txtfMobileNo.text ?? "")_Doctor_Bitmap_Signature.png"
        
        var arrMedia = [APICall.Media]()
        if let objM = media {
            arrMedia.append(objM)
        }
        if let objM = mediaForSigimg {
            arrMedia.append(objM)
        }
        if let objM = mediaForSigView {
            arrMedia.append(objM)
        }
        
        self.showLoader()
        
        CreateDoctorModel.registerDoctorApi(parameters: parameter, media: arrMedia) { (result) in
            self.hideLoader()
            switch result {
            case .Success( _ ):
                self.pushUploadDocVC()
            case .CustomError(let strErr):
                Alert.show(.error, strErr)
            }
        }
    }
    
} //extension
