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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        selectedType = arrDocs[indexPath.row].type
        openiCloud()
    }
    
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
            cell.setData(indexPath.row, arrDocs[indexPath.row])
            cell.onViewBtnPressed = { [weak self] index in
                guard let self = self, self.arrDocs.count > index, let path = self.arrDocs[index].localFilePath else { return }
                self.pushWebVC("Selected File", path)
            }
            cell.onDeleteBtnPressed = { [weak self] index in
                guard let self = self, self.arrDocs.count > index else { return }
                self.arrDocs[index].localFilePath = nil
                self.tableView.reloadData()
            }
            return cell
        } else  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UploadFooterCell.self), for: indexPath) as? UploadFooterCell else { return UploadFooterCell() }
            cell.onUploadPressed = self.btnUploadFilePressed
            return cell
        }
    }
    
    
} //extension
