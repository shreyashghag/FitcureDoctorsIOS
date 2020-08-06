//
//  ProfileVC+TableView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 11/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- UITableViewDelegate
extension ProfileVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 1 ? 80 : .leastNonzeroMagnitude
    }
    
} //extension

// MARK:- Extension For :- UITableViewDataSource
extension ProfileVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return patientObj != nil ? 2 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return patientObj != nil ? 1 : 0
        case 1:
            return arrFamilyMember.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PatientProfileCell.self), for: indexPath) as? PatientProfileCell else { return PatientProfileCell() }
        
        switch indexPath.section {
        case 0 :
            cell.setData(patientObj, index: indexPath)
        case 1:
            cell.setData(arrFamilyMember[indexPath.row], index: indexPath)
        default:
            break
        }
        cell.onEditPressed = self.onEditPressed
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileFooterCell.self)) as? ProfileFooterCell else { return nil }
            cell.btnAddMember.addTarget(self, action: #selector(btnAddFamilyMemberPressed), for: .touchUpInside)
            return cell
        } else {
            return  nil
        }
    }
} //extension
