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
    
    func getPendingListing() {
        self.showLoader()
        PatientRequestMainModel.getPendingList { (result) in
            self.hideLoader()
            switch result {
            case .Success(let arr):
                self.arrRequest = arr
                self.tableView.reloadData()
            case .CustomError(let str):
                Alert.show(.error, str)
            }
        }
    }
    
    func getActiveListing() {
        self.showLoader()
        PatientRequestMainModel.getActiveList { (result) in
            self.hideLoader()
            switch result {
            case .Success(let arr):
                self.arrRequest = arr
                
                self.tableView.reloadData()
            case .CustomError(let str):
                Alert.show(.error, str)
            }
        }
    }
    
    func changeConsultationStatus(_ obj: PatientRequestModel, isAccept: Bool, index: Int) {
        PatientRequestMainModel.changeConsultationStatus(consID: obj.conID ?? 0, isAccept: isAccept) { (response) in
            switch response {
            case .Success(_):
                if self.arrRequest.count > index {
                    self.arrRequest.remove(at: index)
                }
                self.tableView.reloadData()
            case .CustomError(let str):
                Alert.show(.error, str)
            }
        }
    }
    
} //extension
