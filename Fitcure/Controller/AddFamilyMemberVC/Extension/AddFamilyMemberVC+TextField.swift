//
//  AddFamilyMemberVC+TextField.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 11/07/20.
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
extension AddFamilyMemberVC: UITextFieldDelegate {
    
    func checkValidations()->Bool {
        if (txtfName.text ?? "").isEmpty {
            Alert.show(.error, .nameRequired)
            return false
        }
        if (txtfEmail.text ?? "").isEmpty {
            Alert.show(.error, .Email)
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case txtfName:
            txtfEmail.becomeFirstResponder()
        case txtfAge:
            txtfCity.becomeFirstResponder()
        case txtfCity:
            txtfMobileNo.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
               
        
            if textField == txtfName
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
       else if  textField == txtfMobileNo
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
        else if textField == txtfAge
        {
            let maxLength = 2
            let currentString: NSString = textField.text! as NSString
            newString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            
            if(newString.length<2)
            {
                txtfAge.errorMessage = Alert.AlertMessage.Age.rawValue
                
            }
                
                
                
            else{
                
                txtfAge.errorMessage = ""
                
                
            }
            if(newString.length==0)
            {
                txtfAge.errorMessage = Alert.AlertMessage.Age.rawValue
                
            }
            return newString.length <= maxLength
            
        }
        
        
        
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
} //extension
