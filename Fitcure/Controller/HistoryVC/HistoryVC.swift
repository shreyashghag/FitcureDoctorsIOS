//
//  HistoryVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 12/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var tableView            : UITableView!
    
    // MARK:- Variables
    var arrRequest = [PatientRequestModel]()
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHistoryListing()
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        self.navigationItem.setTitle(.History)
        tableView.backgroundColor = .f_ViewBack        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK:- Button Actions
    @objc private func btnBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK:- Custom Methods
    func pushPastConsultDetailsVC(_ obj: PatientRequestModel?) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PastConsultantDetailsVC.self)) as? PastConsultantDetailsVC else { return }
        vc.obj = obj
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:-
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class
