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
        switch type {
        case .Doctor:
            if arrDoctors.count > indexPath.row {
                pushDoctorDetailsVC(arrDoctors[indexPath.row])
            } else {
                self.tableView.reloadData()
                Alert.show(.appName, .Oops)
            }
        case .PastConsult:
            if arrPastConsults.count > indexPath.row {
                pushPastConsultDetailsVC(arrPastConsults[indexPath.row])
            } else {
                self.tableView.reloadData()
                Alert.show(.appName, .Oops)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
} //extension

// MARK:- Extension For:- UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .Doctor:
            return arrDoctors.count
        case .PastConsult:
            return arrPastConsults.count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !isLoading, arrDoctors.count < intTotalDoctor, indexPath.row  >= arrDoctors.count - 2 else { return }
        self.intDoctorListPage += 1
        self.getDoctorListing()
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch type {
        case .Doctor:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeCell.self), for: indexPath) as? HomeCell else { return HomeCell() }
            cell.setDoctorData(arrDoctors[indexPath.row])
            return cell
            
        case .PastConsult:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PastConsultsVC.self), for: indexPath) as? PastConsultsVC else { return PastConsultsVC() }
            cell.setData(arrPastConsults[indexPath.row])
            return cell
        }
    }
    
} //extension
