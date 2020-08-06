//
//  OtpView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 29/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class OTPView: UIView {
    
    // MARK:- Outlets
    @IBOutlet private weak var lblPin1                 : UILabel!
    @IBOutlet private weak var lblPin2                 : UILabel!
    @IBOutlet private weak var lblPin3                 : UILabel!
    @IBOutlet private weak var lblPin4                 : UILabel!
    @IBOutlet private weak var lblPin5                 : UILabel!
    @IBOutlet private weak var lblPin6                 : UILabel!
    
    // MARK:- Variables
    private var pinCount    = 6
    private var strPin      = ""
    
    var normalTexClr = UIColor.f_AppColor
    var selectedClr = UIColor.f_AppColor
    var normalClr   = UIColor.f_AppColor
    
    var isEdit                  = false
    var hasText                 = false
    var isClearOnBeginEditing   = true
    var keyboardType    : UIKeyboardType = .numberPad
    var returnKeyType   : UIReturnKeyType = .done
    
    // MARK:- SetUpLabel
    func setUpView(_ intPinCount: Int = 6, strPinValue: String = "") {
                
        pinCount = intPinCount
        strPin = strPinValue
        if strPin.count == pinCount {
            setPin(strPin: strPin)
        } else {
            clearPin()
        }
        addTapGesture()
        
    }
    func getPin()->String {
        return strPin
    }
    
    func setPin(strPin: String) {
        var index = 0
        for str in strPin {
            setTextWith(String(str), index)
            index += 1
        }
        self.clearSeperator(nil)
        self.strPin = strPin
    }
    
    func clearPin() {
        let arrLBL = [lblPin1, lblPin2, lblPin3, lblPin4, lblPin5, lblPin6,]
        for lbl in arrLBL {
            lbl?.text = ""
        }
        strPin = ""
        self.clearSeperator(nil)
    }
    
    private func addTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnView(_ :)))
        self.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapOnView(_ gesture: UITapGestureRecognizer) {
        if isClearOnBeginEditing {
            self.clearPin()
        }
        isEdit = true
        _ = becomeFirstResponder()
    }
    
    private func setTextWith(_ strValue: String,_ location: Int) {
        switch location {
        case 0:
            lblPin1.text = strValue
            clearSeperator(lblPin1)
        case 1:
            lblPin2.text = strValue
            clearSeperator(lblPin2)
        case 2:
            lblPin3.text = strValue
            clearSeperator(lblPin3)
        case 3:
            lblPin4.text = strValue
            clearSeperator(lblPin4)
        case 4:
            lblPin5.text = strValue
            clearSeperator(lblPin4)
        case 5:
            lblPin6.text = strValue
            clearSeperator(lblPin4)
            
        default:
            break
        }
    }
    
    private func clearSeperator(_ selectedLbl: UILabel?) {
        let arrSeperator = [lblPin1, lblPin2, lblPin3, lblPin4, lblPin5, lblPin6,]
        for lbl in arrSeperator {
            DispatchQueue.main.async {
                
                let clr = ((lbl == selectedLbl) ? self.selectedClr : self.normalClr)
                let clrTxt = ((lbl == selectedLbl) ? self.selectedClr : self.normalTexClr)
                lbl?.textColor = clrTxt
                lbl?.addRoundedBottomBorderWithColor(color: clr, width: 2)
            }
        }
    }
} //class

// MARK:- Extension for - UIKeyInput
extension OTPView: UIKeyInput {
    
    override var canBecomeFirstResponder: Bool { return isEdit }
    
    func insertText(_ text: String) {
        guard "0123456789".contains(text) else { return }
        if strPin.count < pinCount {
            setTextWith(text, strPin.count)
            strPin.append(text)
        }
        
        if strPin.count == pinCount {
            clearSeperator(nil)
            _ = resignFirstResponder()
            isEdit = false
        }
    }
    
    func deleteBackward() {
        setTextWith("", strPin.count - 1)
        if strPin.count <= pinCount, strPin.count >= 1 {
            strPin.removeLast()
        }
        if strPin.count == 0 {
            clearSeperator(nil)
        }
    }
} //extension
