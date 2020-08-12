//
//  HomeVC+TableView.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 01/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For:- UITableViewDelegate
extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard type == .ActiveConsults else { return }
        pushPastConsultDetailsVC(arrRequest[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
} //extension

// MARK:- Extension For:- UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRequest.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PastConsultsCell.self), for: indexPath) as? PastConsultsCell else { return PastConsultsCell() }
        cell.setData(type, arrRequest[indexPath.row], index: indexPath.row)
        cell.onAcceptPressed = isAcceptRequest
        cell.onDeletePressed = isRejectRequest
        return cell
    }
    
} //extension
