//
//  SignUpVC+TextField.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 30/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For:- UITextFieldDelegate
extension SignUpVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        let strText = textField.text ?? "" + string
        
        if strText.count == 10 {
            textField.resignFirstResponder()
        }
        
        return "0123456789".contains(string) && strText.count <= 9
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        btnSignUpPressed()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
} //extension
