//
//  FeedBackVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 20/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- APICall
extension FeedBackVC {
    
    func submitFeedback() {
        
//        guard let id = obj?.conID else {
//            Alert.show(.appName, .Oops, controller: self) { [weak self] (_) in
//                guard let self = self else { return }
//                self.dismiss(animated: true, completion: nil)
//            }
//            return
//        }
//        self.showLoader()
//        
//        var parameter = [String : Any]()
//        parameter["consultation_id"] = id
//        parameter["feedbackText"] = txtvDescription.textColor != UIColor.lightGray ? txtvDescription.text : ""
//        parameter["rating"] = viewRating.rating
//        
//        
//        ConsultationFeedbackModel.sendFeedback(parameter: parameter) { (result) in
//            self.hideLoader()
//            
//            switch result {
//            case .Success(let str):
//                Alert.show(.appName, str, controller: self) { [weak self] (_) in
//                    guard let self = self else { return }
//                    self.dismiss(animated: true, completion: nil)
//                }
//            case .CustomError(let str):
//                Alert.show(.appName, str, controller: self) { [weak self] (_) in
//                    guard let self = self else { return }
//                    self.dismiss(animated: true, completion: nil)
//                }
//            }
//        }
    }
    
} //extension
