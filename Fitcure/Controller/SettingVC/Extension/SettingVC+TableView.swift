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
        var type: SettingOptions = .OutcomeMeasures

        switch indexPath.section {
        case 0:
            type = .OutcomeMeasures
        case 1:
            type = arrApplication[indexPath.row]
        case 2:
            type = arrAccount[indexPath.row]
        default:
            break
        }
                
        switch type {
            case .OutcomeMeasures:
            pushSubSettingVC()
        case .PrivacyPolicy:
            pushWebVC(type.rawValue, APICall.PrivacyPolicy)
        case .TermsAndCondition:
            pushWebVC(type.rawValue, APICall.TearmsAndCondition)
        case .RefundPolicy:
            pushWebVC(type.rawValue, APICall.RefundPolicy)
        case .FAQ:
            pushFAQVC()
        case .Report:
            sendEmail()
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return arrApplication.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingCell.self), for: indexPath) as? SettingCell else { return SettingCell() }
        switch indexPath.section {
        case 0:
            cell.setData(.OutcomeMeasures)
        case 1:
            cell.setData(arrApplication[indexPath.row])
        case 2:
            cell.setData(arrAccount[indexPath.row])
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingCell.self)) as? SettingCell else { return nil }
        switch section {
        case 0:
            cell.setHeaderTitle("Training", false)
        case 1:
            cell.setHeaderTitle("Application", true)
        case 2:
            cell.setHeaderTitle("Account", true)
        default:
            break
        }
        return cell
    }
} //extension
