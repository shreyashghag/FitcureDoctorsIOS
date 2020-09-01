//
//  SubSettingVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 01/09/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class SubSettingVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK:- Variable
    let arrItems = ["Berg Balance Test and Rating Scale", "Disabilities of Arm, Shoulder and Hand"]    
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        self.navigationItem.setTitle(.OutcomeMeasures)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = .f_ViewBack
        self.tableView.backgroundColor = .f_ViewBack
        
        let backBtn = UIBarButtonItem(image: UIImage(named: "f_back"), style: .plain, target: self, action: #selector(btnBackPressed))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    // MARK:- Button Action
    @objc private func btnBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Push Methods
    func pushWebVC(_ strTitle: String, _ strURL: String) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: WebVC.self)) as? WebVC else { return }
        vc.strTitle = strTitle
        vc.strUrl = strURL
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:- Deinit
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class
