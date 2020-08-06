//
//  SettingVC.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 01/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class SettingVC: UIViewController {
    
    // MARK:- Enums
    enum SettingOptions: String {
        case PrivacyPolicy = "Privacy Policy"
        case TermsAndCondition = "Terms And Condition"
        case FAQ = "FAQ"
        case Report = "Report A Problem"
        case RateUs = "Rate Us"
        case Logout = "Logout"
    }
    
    // MARK:- Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK:- Variable
    let arrApplication: [SettingOptions] = [.PrivacyPolicy, .TermsAndCondition, .FAQ, .Report, .RateUs]
    let arrAccount: [SettingOptions] = [.Logout]
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        self.navigationItem.setTitle(.Settings)
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK:- Button Action
    
    // MARK:- Custom Methods
    func logoutHandle() {
        Alert.show(.appName, .logoutCase, .No, .Yes) { [weak self] strBtn in
            guard let self = self, strBtn == Alert.AlertButton.Yes.rawValue else { return }
            UserData.clearData()
            self.pushToSignUpVC()
        }
    }
    
    // MARK:- Push Methods
    func pushWebVC(_ strTitle: String, _ strURL: String) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: WebVC.self)) as? WebVC else { return }
        vc.strTitle = strTitle
        vc.strUrl = strURL
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    private func pushToSignUpVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SignUpVC.self)) as? SignUpVC else { return }
        self.tabBarController?.navigationController?.setViewControllers([vc], animated: true)
    }
    func pushTCPopupVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: TermsConditionPopUpVC.self)) as? TermsConditionPopUpVC else { return }
        self.present(vc, animated: true, completion: nil)
    }
    func pushToVideoCallingVC() {
         guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: VideoChatViewController.self)) as? VideoChatViewController else { return }
         self.present(vc, animated: true, completion: nil)
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