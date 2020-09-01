//
//  SubSettingVC+TableView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 01/09/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- UITableViewDelegate
extension SubSettingVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = indexPath.row == 0 ? APICall.bergBalanceScale : APICall.DASH
        pushWebVC(arrItems[indexPath.row], str)
    }
    
} //extension

// MARK:- Extension For :- UITableViewDataSource
extension SubSettingVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SubSettingCell.self), for: indexPath) as? SubSettingCell else { return SubSettingCell() }
        cell.setData(arrItems[indexPath.row])
        return cell
    }
} //extension
