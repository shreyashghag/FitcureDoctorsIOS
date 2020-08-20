//
//  PickerPopVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 20/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class PickerPopVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet private weak var viewMain         : UIView!
    @IBOutlet private weak var datePicker       : UIDatePicker!
    @IBOutlet private weak var btnSelect        : UIButton!
    @IBOutlet private weak var btnCancel        : UIButton!
    @IBOutlet private weak var btnBack          : UIButton!
    
    // MARK:- Variables
    var onDidSelectDate: ((Date)->())?
    
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
        datePicker.date = Date()
        viewMain.setCorner(withRadius: 10)
    }
    
    // MARK:- Button Actions
    @IBAction private func btnSelectDatePressed() {
        onDidSelectDate?(datePicker.date)
        debugPrint(datePicker.date)
        self.dismiss(animated: true, completion: nil)
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
