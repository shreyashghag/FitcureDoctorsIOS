//
//  MobileNumberView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 05/10/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

final class MobileNumberView: UIView {

    // MARK:- Outlet
    @IBOutlet weak var txtfMobile   : SkyFloatingLabelTextField!
    @IBOutlet weak var btnVerify    : UIButton!
    
    // MARK:- Variables
    var onVerifyPressed: ((String)->())?
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        txtfMobile.delegate = self
        txtfMobile.keyboardType = .phonePad
        btnVerify.setCorner(withRadius: 5)
    }
    
    // MARK:- Button Action
    @IBAction private func btnVerifyPressed() {
        onVerifyPressed?(txtfMobile.text ?? "")
    }
    
} //class

// MARK:- Extension For :-
extension MobileNumberView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        if !"0123456789".contains(string) {
            return false
        }
        if (string + (txtfMobile?.text ?? "")).count > 10 {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
} //extension
