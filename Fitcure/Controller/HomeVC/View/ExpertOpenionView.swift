//
//  ExpertOpenionView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 19/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

final class ExpertOpenionView: UIView {
 var newString: NSString = ""
 var genderStr = "male"
    // MARK:- Outlets
    @IBOutlet weak var viewBG           : UIView!
    @IBOutlet weak var txtfName         : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfAge          : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfAgreevating  : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfChiefCompl   : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfHistory      : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfOtherIssue   : SkyFloatingLabelTextField!
    @IBOutlet weak var segGender        : UISegmentedControl!
    @IBOutlet weak var btnSubmit        : UIButton!
    
    @IBAction func submitBtnClick(_ sender: Any) {
       api_create_ExpertOpenion()
       
    }
    
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        btnSubmit.isEnabled = false
        btnSubmit.alpha = 0.4
        viewBG.setCorner(withRadius: 10)
        btnSubmit.setCorner(withRadius: 5)
        setUpTextField()
         [txtfName, txtfAge, txtfAgreevating,txtfChiefCompl,txtfHistory,txtfOtherIssue ].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }
    @IBAction func segGenderSelectionChanged(_ sender: UISegmentedControl) {
           
           switch sender.selectedSegmentIndex {
           case 0:
               genderStr =  "male"
           case 1:
               genderStr =  "female"
           default:
               break
           }
       }
    private func setUpTextField() {
        
         txtfName.returnKeyType = .next
         txtfAge.returnKeyType = .next
         txtfAgreevating.returnKeyType = .next
         txtfChiefCompl.returnKeyType = .next
         txtfHistory.returnKeyType = .next
         txtfOtherIssue.returnKeyType = .next
         
         
         
         for txtf in [txtfName, txtfAge, txtfAgreevating, txtfChiefCompl, txtfHistory,txtfOtherIssue ] {
             txtf?.selectedTitleColor = .f_AppColor
             txtf?.tintColor = .f_AppColor
             txtf?.textColor = .darkText
             txtf?.delegate = self
         }
         
         txtfAge.keyboardType = .numberPad
         
     }
    
    @objc func editingChanged(_ textField: UITextField) {
         if textField.text?.count == 1 {
             if textField.text?.first == " " {
                 textField.text = ""
                 return
             }
         }
         guard
             let name = txtfName.text, !name.isEmpty,
             let Age = txtfAge.text, !Age.isEmpty,
             let agreevating = txtfAgreevating.text, !agreevating.isEmpty,
             let ChiefCompl = txtfChiefCompl.text, !ChiefCompl.isEmpty,(txtfChiefCompl.text?.count)!>=1,
             let nameOfCouncil = txtfHistory.text, !nameOfCouncil.isEmpty,(txtfHistory.text?.count)!>=1,
             let workingSince = txtfOtherIssue.text, !workingSince.isEmpty,(txtfOtherIssue.text?.count)!>=1
            else {
                 btnSubmit.isEnabled = false
                 btnSubmit.alpha = 0.4
                 return
         }
  
             btnSubmit.isEnabled = true
             btnSubmit.alpha = 1.0
         
     }
    

    
    // MARK:- Custom Methods

}


//class
