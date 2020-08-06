//
//  TermsConditionPopUpVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 20/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class TermsConditionPopUpVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet private weak var viewMain : UIView!
    @IBOutlet private weak var lblHeader: UILabel!
    @IBOutlet private weak var txtcBody : UITextView!
    @IBOutlet private weak var btnBack  : UIButton!
    @IBOutlet private weak var btnOkey  : UIButton!
    
    // MARK:- Variables
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.btnBack.backgroundColor = .black
        }
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        viewMain.setCorner(withRadius: 10)
    }
    
    // MARK:- Button Actions
    @IBAction private func btnOkeyPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction private func btnBackPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK:- Custom Methods
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:-
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class
