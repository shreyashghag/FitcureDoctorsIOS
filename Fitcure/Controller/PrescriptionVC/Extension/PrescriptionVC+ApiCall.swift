//
//  PrescriptionVC+ApiCall.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 09/09/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation
extension PrescriptionVC {
    
    func api_sendPrescription() {
        var parameter = [String: Any]()
        parameter["advice"] = adviceTxtFild.text ?? ""
        parameter["youtubeLink"] = youTubeTxtFild.text ?? ""
        parameter["consultation_id"] = obj?.conID ?? 0
        
        self.showLoader()
        PrescriptionModel.snedPrescriptionApi(parameter) { (result) in
            self.hideLoader()
            switch result {
            case .Success(let obj):
                self.pdfUrl = obj
               Alert.show(.Success, "Prescription sent to Patient")
                self.adviceTxtFild.text = ""
                self.youTubeTxtFild.text = ""
            case .CustomError(let str):
                Alert.show(.error, str)
            }
        }
    }
    
}
