//
//  ResetPasswordView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 05/10/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

final class ResetPasswordView: UIView {
    
    // MARK:- Outlet
    @IBOutlet weak var txtfNewPass      : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfConfirmPass  : SkyFloatingLabelTextField!
    @IBOutlet weak var btnUpdate        : UIButton!
    
    // MARK:- Variables
    var onVerifyPressed: ((String, String)->())?
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        
        txtfNewPass.isSecureTextEntry = true
        txtfConfirmPass.isSecureTextEntry = true        
        txtfNewPass.delegate = self
        txtfConfirmPass.delegate = self
        btnUpdate.setCorner(withRadius: 5)
    }
    
    // MARK:- Button Action
    @IBAction private func btnUpdatePressed() {
        onVerifyPressed?(txtfNewPass.text ?? "", txtfConfirmPass.text ?? "")
    }
    @IBAction private func btnShowNewPasswordPressed() {
        txtfNewPass.isSecureTextEntry.toggle()
    }
    @IBAction private func btnShowConfirmPasswordPressed() {
        txtfConfirmPass.isSecureTextEntry.toggle()
    }
    
} //class

// MARK:- Extension For :-
extension ResetPasswordView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtfNewPass:
            txtfConfirmPass.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return !(textField.text ?? "").isEmpty
    }
} //extension
