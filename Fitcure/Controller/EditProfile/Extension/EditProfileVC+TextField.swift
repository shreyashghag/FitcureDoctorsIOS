//
//  EditProfileVC+TextField.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 10/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

//@IBOutlet weak var txtfName         : SkyFloatingLabelTextField!
//@IBOutlet weak var txtfEmail        : SkyFloatingLabelTextField!
//@IBOutlet weak var txtfAge          : SkyFloatingLabelTextField!
//@IBOutlet weak var txtfCity         : SkyFloatingLabelTextField!
//@IBOutlet weak var txtfMobileNo     : SkyFloatingLabelTextField!

// MARK:- Extension For :- UITextFieldDelegate
extension EditProfileVC: UITextFieldDelegate {
    
    func checkValidations()->Bool {
        if (txtfName.text ?? "").isEmpty {
            Alert.show(.appName, .nameRequired)
            return false
        }
        if (txtfEmail.text ?? "").isEmpty {
            Alert.show(.appName, .Email)
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        
        
        switch textField {
        case txtfName:
            txtfEmail.becomeFirstResponder()
        case txtfEmail:
            txtfnameOfCouncil.becomeFirstResponder()
        case txtfnameOfCouncil:
            txtfregistratioNo.becomeFirstResponder()
        case txtfregistratioNo:
            txtfqualification.becomeFirstResponder()
        case txtfqualification:
             txtfassociateHospital.becomeFirstResponder()
        case txtfassociateHospital:
             txtfCity.becomeFirstResponder()
        case txtfCity:
            txtfpreferredLanguages.becomeFirstResponder()
        case txtfpreferredLanguages:
            txtflocation.becomeFirstResponder()
        case txtflocation:
            txtfspeciality.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
  
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
} //extension

