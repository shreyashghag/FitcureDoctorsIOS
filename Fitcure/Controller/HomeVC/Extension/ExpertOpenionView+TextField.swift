//
//  ExpertOpenionView+TextField.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 07/09/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
extension ExpertOpenionView:UITextFieldDelegate{
    
//    @IBOutlet weak var txtfName         : SkyFloatingLabelTextField!
//       @IBOutlet weak var txtfAge          : SkyFloatingLabelTextField!
//       @IBOutlet weak var txtfAgreevating  : SkyFloatingLabelTextField!
//       @IBOutlet weak var txtfChiefCompl   : SkyFloatingLabelTextField!
//       @IBOutlet weak var txtfHistory      : SkyFloatingLabelTextField!
//       @IBOutlet weak var txtfOtherIssue   : SkyFloatingLabelTextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case txtfName:
            txtfAge.becomeFirstResponder()
        case txtfAge:
            txtfAgreevating.becomeFirstResponder()
        case txtfAgreevating:
            txtfChiefCompl.becomeFirstResponder()
        case txtfChiefCompl:
            txtfHistory.becomeFirstResponder()
        case txtfHistory:
            txtfOtherIssue.becomeFirstResponder()
            default:
            textField.resignFirstResponder()
        }
        return true
    }
    
     func textFieldDidEndEditing(_ textField: UITextField) {
         textField.text = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
     }

    
}
