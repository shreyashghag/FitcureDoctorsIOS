//
//  SettingVC+TableView.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 01/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For:- UITableViewDelegate
extension SettingVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var type: SettingOptions
        if indexPath.section == 0 {
            type = arrApplication[indexPath.row]
        } else {
            type = arrAccount[indexPath.row]
        }
        
        switch type {
        case .PrivacyPolicy:
            pushWebVC(type.rawValue, APICall.PrivacyPolicy)
        case .TermsAndCondition:
            pushWebVC(type.rawValue, APICall.TearmsAndCondition)
        case .FAQ:
            pushToVideoCallingVC()
        case .Report:
            pushTCPopupVC()
        case .RateUs:
            break
        case .Logout:
            logoutHandle()            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
} //extension

// MARK:- Extension For:- UITableViewDataSource
extension SettingVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? arrApplication.count : arrAccount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingCell.self), for: indexPath) as? SettingCell else { return SettingCell() }
        if indexPath.section == 0 {
            cell.setData(arrApplication[indexPath.row])
        } else {
            cell.setData(arrAccount[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingCell.self)) as? SettingCell else { return nil }
        cell.setHeaderTitle(section == 0 ? "Application" : "Account", section != 0)
        return cell
    }
} //extension
