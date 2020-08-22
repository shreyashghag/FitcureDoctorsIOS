//
//  PastConsultantDetailsVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 22/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- APICall
extension PastConsultantDetailsVC {
    
    func api_NotifyPatient(_ strTime: String) {
        var parameter = [String: Any]()
        parameter["conId"] = obj?.conID ?? 0
        parameter["time"] = strTime
        
        self.showLoader()
        CustomModel.notifyPatient(parameter) { (result) in
            self.hideLoader()
            switch result {
            case .Success(let str):
                Alert.show(.Success, str)
            case .CustomError(let str):
                Alert.show(.error, str)
            }
        }
    }
    
} //extension
