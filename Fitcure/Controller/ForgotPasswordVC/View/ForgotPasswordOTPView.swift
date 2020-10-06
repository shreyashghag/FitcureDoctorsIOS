//
//  ForgotPasswordOTPView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 05/10/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class ForgotPasswordOTPView: UIView {
    
    // MARK:- Outlet
    @IBOutlet weak var viewOTP          : OTPView!
    @IBOutlet weak var btnVerify        : UIButton!
    
    // MARK:- Variables
    var onVerifyPressed: ((String)->())?
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        viewOTP.setUpView()
        btnVerify.setCorner(withRadius: 5)
    }
    
    // MARK:- Button Action
    @IBAction private func btnVerifyPressed() {
        onVerifyPressed?(viewOTP.getPin())
    }
    
} //class

