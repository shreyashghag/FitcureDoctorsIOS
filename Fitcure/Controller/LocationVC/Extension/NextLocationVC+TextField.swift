//
//  NextLocationVC+TextField.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 14/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField
// MARK:- Extension For :- UITextFieldDelegate
extension NextLocationVC: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                switch textField {
                case buildText:
                    streetText.becomeFirstResponder()
                case streetText:
                    areaText.becomeFirstResponder()
                case areaText:
                    cityText.becomeFirstResponder()
             
                default:
                    textField.resignFirstResponder()
                }
                return true
    }
     

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
       
           
           if  textField == buildText
           {
              
                   
                   let maxLength = 10
                   let currentString: NSString = textField.text! as NSString
                   newString =
                       currentString.replacingCharacters(in: range, with: string) as NSString
                   
                   if(newString.length<3)
                   {
                    buildText.errorMessage = Alert.AlertMessage.ValidBuildingName.rawValue
                       
                       
                   }
                       
                       
                       
                   else{
                       
                       buildText.errorMessage = ""
                       
                   }
                   if(newString.length==0)
                   {
                        buildText.errorMessage = Alert.AlertMessage.ValidBuildingName.rawValue
                       
                   }
                   return newString.length <= maxLength
                   // return allowedCharacters.isSuperset(of: characterSet)
                   
               
              
               
               
           }
          
               
           else if textField == cityText
           {
               let maxLength = 20
               let currentString: NSString = textField.text! as NSString
               newString =
                   currentString.replacingCharacters(in: range, with: string) as NSString
               
               if(newString.length<4)
               {
                cityText.errorMessage = Alert.AlertMessage.ValidCityName.rawValue
                   
               }
                   
                   
                   
               else{
                   cityText.errorMessage = ""
                   
                   
               }
               if(newString.length==0)
               {
                  cityText.errorMessage = Alert.AlertMessage.ValidCityName.rawValue
                   
               }
               return newString.length <= maxLength
               
           }
            else if textField == areaText
                      {
                          let maxLength = 20
                          let currentString: NSString = textField.text! as NSString
                          newString =
                              currentString.replacingCharacters(in: range, with: string) as NSString
                          
                          if(newString.length<4)
                          {
                           areaText.errorMessage = Alert.AlertMessage.ValidAreaName.rawValue
                              
                          }
                              
                              
                              
                          else{
                              areaText.errorMessage = ""
                              
                              
                          }
                          if(newString.length==0)
                          {
                             areaText.errorMessage = Alert.AlertMessage.ValidAreaName.rawValue
                              
                          }
                          return newString.length <= maxLength
                          
                      }
            else if textField ==  streetText
                      {
                          let maxLength = 20
                          let currentString: NSString = textField.text! as NSString
                          newString =
                              currentString.replacingCharacters(in: range, with: string) as NSString
                          
                          if(newString.length<4)
                          {
                           streetText.errorMessage = Alert.AlertMessage.ValidStreetName.rawValue
                              
                          }
                              
                              
                              
                          else{
                              streetText.errorMessage = ""
                              
                              
                          }
                          if(newString.length==0)
                          {
                             streetText.errorMessage = Alert.AlertMessage.ValidStreetName.rawValue
                              
                          }
                          return newString.length <= maxLength
                          
                      }
               
       
           
           return true
           
           
           
       }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
} //extension

