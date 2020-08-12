//
//  HistoryVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 12/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

// MARK:- Extension For :- APICall
extension HistoryVC {
    
    func getHistoryListing() {
        self.showLoader()
        PatientRequestMainModel.getRejectedList { (result) in
            self.hideLoader()
            switch result {
            case .Success(let arr):
                self.arrRequest = arr
                self.tableView.reloadData()
            case .CustomError(let str):
                Alert.show(.appName, str)
            }
        }
    }
    
} //extension
