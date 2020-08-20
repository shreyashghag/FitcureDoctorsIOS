//
//  UploadDocVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 20/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class UploadDocVC: UIViewController {
    
    // MARK:- Doc Enums
    enum DocType: String {
        case Aadhaar            = "Upload Aadhaar Card Front and Back"
        case DegreeCertificate  = "Upload Degree Certificate"
        case RegistrationNumber = "Upload Registration Number"
        case CanceledCheque     = "Upload Canceled Cheque"
    }
    
    // MARK:- Outlet
    @IBOutlet private weak var lblTitle     : UILabel!
    @IBOutlet private weak var tableView    : UITableView!
        
    // MARK:- Variables
    var arrDocs = [DocType]()
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        self.navigationItem.setTitle(.UploadDoc)
        arrDocs = [.Aadhaar, .DegreeCertificate, .RegistrationNumber, .CanceledCheque]
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK:- Button Actions
    @objc private func btnBackPressed() {
        self.navigationController?.popViewController(animated: true)
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
