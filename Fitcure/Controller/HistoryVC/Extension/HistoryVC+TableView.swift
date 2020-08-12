//
//  HistoryVC+TableView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 12/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For:- UITableViewDelegate
extension HistoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushPastConsultDetailsVC(arrRequest[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
} //extension

// MARK:- Extension For:- UITableViewDataSource
extension HistoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRequest.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryConsultsCell.self), for: indexPath) as? HistoryConsultsCell else { return HistoryConsultsCell() }
        cell.setData(arrRequest[indexPath.row])
        return cell
    }
    
} //extension
