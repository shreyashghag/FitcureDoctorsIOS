//
//  HomeVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 04/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK:- Extension For :- APICall
extension HomeVC {
    
    func getDoctorListing() {
        self.showLoader()
        self.isLoading = true
        DoctorListModel.getList(page: intDoctorListPage) { (result) in
            self.hideLoader()
            switch result {
            case .Success(let options):
                
                self.intTotalDoctor = options.0 ?? 0
                self.arrDoctors = options.1
                self.tableView.reloadData()
                
            case .CustomError(let str):
                Alert.show(.appName, str)
            }
            self.isLoading = false
        }
    }
    
    func getPastConsultsListing() {
        self.showLoader()
        self.isLoading = true
        ConsultsListModel.getList() { (result) in
            self.hideLoader()
            switch result {
            case .Success(let arr):
                self.arrPastConsults = arr
                self.tableView.reloadData()
            case .CustomError(let str):
                Alert.show(.appName, str)
            }
            self.isLoading = false
        }
    }
    
} //extension
