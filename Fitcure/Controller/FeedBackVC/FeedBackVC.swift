//
//  FeedBackVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 07/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import Cosmos

final class FeedBackVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet private weak var viewMain         : UIView!
    @IBOutlet private weak var lblTitle         : UILabel!
    @IBOutlet internal weak var txtvDescription : UITextView!
    @IBOutlet internal weak var viewRating      : CosmosView!
    @IBOutlet private weak var btnSend          : UIButton!
    @IBOutlet private weak var btnCancel        : UIButton!
    @IBOutlet private weak var btnBack          : UIButton!
    
    // MARK:- Variables
    var obj: ConsultsModel?
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.btnBack.backgroundColor = .clear
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
        txtvDescription.delegate = self
        txtvDescription.text = "Enter you review"
        txtvDescription.textColor = .lightGray
        txtvDescription.setBorder(withRadius: 10)
        
        lblTitle.text = "Review \(obj?.familyMemberName ?? "")"
    }
    
    // MARK:- Button Actions
    @IBAction private func btnBackPressed() {
    }
    
    @IBAction private func btnSendPressed() {
        submitFeedback()
    }
    @IBAction private func btnCancelPressed() {
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
