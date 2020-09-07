//
//  CreateDoctorVC+TextField.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 07/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
// MARK:- Extension For :- UITextFieldDelegate
extension CreateDoctorVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case txtfName:
            txtfPassword.becomeFirstResponder()
        case txtfPassword:
            txtfEmail.becomeFirstResponder()
        case txtfEmail:
            txtfassociateHospital.becomeFirstResponder()
        case txtfassociateHospital:
            txtfpreferredLanguages.becomeFirstResponder()
        case txtfpreferredLanguages:
            txtfworkingSince.becomeFirstResponder()
        case txtfworkingSince:
            txtfnameOfCouncil.becomeFirstResponder()
        case txtfnameOfCouncil:
            txtfMobileNo.becomeFirstResponder()
        case txtfMobileNo:
            txtfqualification.becomeFirstResponder()
        case txtfqualification:
            txtfCity.becomeFirstResponder()
        case txtfCity:
            txtfspeciality.becomeFirstResponder()
            
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        if  textField == txtfMobileNo
        {
            
            
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if(newString.length<maxLength)
            {
                txtfMobileNo.errorMessage = Alert.AlertMessage.MobileNumber.rawValue
                
                
            }
                
                
                
            else{
                
                txtfMobileNo.errorMessage = ""
                
            }
            if(newString.length==0)
            {
                txtfMobileNo.errorMessage = Alert.AlertMessage.MobileNumber.rawValue
                
            }
            return newString.length <= maxLength
            // return allowedCharacters.isSuperset(of: characterSet)
            
            
            
            
            
        }
        else if textField == txtfEmail
        {
            
            if let text = txtfEmail.text {
                if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
                    if(!isValidEmail(testStr: text)) {
                        
                        txtfEmail.errorMessage = Alert.AlertMessage.invalidEmail.rawValue
                        
                    }
                    else {
                        
                        // The error message will only disappear when we reset it to nil or empty string
                        
                        
                        //LoginBtn.backgroundColor = UIColor.black
                        txtfEmail.errorMessage = ""
                    }
                    if(text.count==0)
                    {
                        
                        txtfEmail.errorMessage = Alert.AlertMessage.invalidEmail.rawValue
                        
                        
                    }
                }
            }
            return true
            
            
        }
            
        else if textField == txtfPassword
        {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if(newString.length<4)
            {
                txtfPassword.errorMessage = Alert.AlertMessage.password.rawValue
                
            }
                
                
                
            else{
                txtfPassword.errorMessage = ""
                
                
            }
            if(newString.length==0)
            {
                txtfPassword.errorMessage = Alert.AlertMessage.password.rawValue
                
            }
            return newString.length <= maxLength
            
        }
        else if textField == txtfName
        {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if(newString.length<4)
            {
                txtfName.errorMessage = Alert.AlertMessage.nameRequired.rawValue
                
            }
                
                
                
            else{
                txtfName.errorMessage = ""
                
                
            }
            if(newString.length==0)
            {
                txtfName.errorMessage = Alert.AlertMessage.nameRequired.rawValue
                
            }
            return newString.length <= maxLength
            
        }
        else if textField == txtfnameOfCouncil
        {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if(newString.length<4)
            {
                txtfnameOfCouncil.errorMessage = "PLEASE ENTER YOUR COUNCIL "
                
            }
                
                
                
            else{
                txtfnameOfCouncil.errorMessage = ""
                
                
            }
            if(newString.length==0)
            {
               txtfnameOfCouncil.errorMessage = "PLEASE ENTER YOUR COUNCIL "
                
            }
            return newString.length <= maxLength
            
        }
        else if textField == txtfqualification
        {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if(newString.length<4)
            {
                txtfqualification.errorMessage = "PLEASE ENTER YOUR QUALIFICATION "
                
            }
                
                
                
            else{
                txtfqualification.errorMessage = ""
                
                
            }
            if(newString.length==0)
            {
                txtfqualification.errorMessage = Alert.AlertMessage.nameRequired.rawValue
                
            }
            return newString.length <= maxLength
            
        }
        else if textField == txtfassociateHospital
        {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if(newString.length<4)
            {
                txtfassociateHospital.errorMessage = "PLEASE ENTER YOUR ASSOCIATE HOSPITAL "
                
            }
                
                
                
            else{
                txtfassociateHospital.errorMessage = ""
                
                
            }
            if(newString.length==0)
            {
                txtfassociateHospital.errorMessage = "PLEASE ENTER YOUR ASSOCIATE HOSPITAL "
                
            }
            return newString.length <= maxLength
            
        }
        else if textField == txtfpreferredLanguages
        {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if(newString.length<4)
            {
                txtfpreferredLanguages.errorMessage = "PLEASE ENTER PREFERRED LANGUAGES "
                
            }
                
                
                
            else{
                txtfpreferredLanguages.errorMessage = ""
                
                
            }
            if(newString.length==0)
            {
                txtfpreferredLanguages.errorMessage = "PLEASE ENTER PREFERRED LANGUAGES "
                
            }
            return newString.length <= maxLength
            
        }
        else if textField == txtfspeciality
        {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if(newString.length<4)
            {
                txtfspeciality.errorMessage = "PLEASE ENTER SPECIALITY "
                
            }
                
                
                
            else{
                txtfspeciality.errorMessage = ""
                
                
            }
            if(newString.length==0)
            {
                txtfspeciality.errorMessage = "PLEASE ENTER SPECIALITY "
                
            }
            return newString.length <= maxLength
            
        }
        else if textField == txtfworkingSince
        {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if(newString.length<4)
            {
                txtfworkingSince.errorMessage = "PLEASE ENTER WORKING SIENCE "
                
            }
                
                
                
            else{
                txtfworkingSince.errorMessage = ""
                
                
            }
            if(newString.length==0)
            {
                txtfworkingSince.errorMessage = "PLEASE ENTER WORKING SIENCE "
                
            }
            return newString.length <= maxLength
            
        }
            
            
        else if textField == txtfCity
        {
            let maxLength = 20
            let currentString: NSString = textField.text! as NSString
            newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if(newString.length<2)
            {
                txtfCity.errorMessage = Alert.AlertMessage.City.rawValue
                
            }
                
                
                
            else{
                txtfCity.errorMessage = ""
                
                
            }
            if(newString.length==0)
            {
                txtfCity.errorMessage = Alert.AlertMessage.City.rawValue
                
            }
            return newString.length <= maxLength
            
        }
        
        
        
        
        return true
        
        
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
} //extension
func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
