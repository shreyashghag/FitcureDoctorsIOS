//
//  UploadDocVC+TableView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 20/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- TableViewDelegate
extension UploadDocVC: UITableViewDelegate {
    
} //extension

// MARK:- Extension For :- TableViewDataSource
extension UploadDocVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? arrDocs.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UploadDocCell.self), for: indexPath) as? UploadDocCell else { return UploadDocCell() }
            cell.setData(arrDocs[indexPath.row])
            return cell
        } else  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UploadFooterCell.self), for: indexPath) as? UploadFooterCell else { return UploadFooterCell() }
            return cell
        }
    }
    
    
} //extension
