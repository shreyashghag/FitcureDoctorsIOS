//
//  UploadDocVC+APICall.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 22/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- APICall
extension UploadDocVC {
    
    func checkValidation()->Bool {
        for obj in arrDocs {
            if obj.localFilePath ==  nil {
                Alert.show(.error, .AllpdfNeeded)
                return false
            }
        }
        return true
    }
    
    func api_UploadDocs() {
        guard checkValidation(),
            let path0 = arrDocs[0].localFilePath,
            let path1 = arrDocs[1].localFilePath,
            let path2 = arrDocs[2].localFilePath,
            let path3 = arrDocs[3].localFilePath
            else { return }
        
        var arrMedia = [APICall.Media]()
        
        do {
            let data0 = try Data(contentsOf: path0)
            let data1 = try Data(contentsOf: path1)
            let data2 = try Data(contentsOf: path2)
            let data3 = try Data(contentsOf: path3)
            
            if let obj = APICall.Media(data: data0, forKey: "pdf", mimeType: "application/pdf", fileName: "\(strMobileNo)_aadarcard.pdf") {
                arrMedia.append(obj)
            }
            if let obj = APICall.Media(data: data1, forKey: "pdf", mimeType: "application/pdf", fileName: "\(strMobileNo)_degreeCertificate.pdf") {
                arrMedia.append(obj)
            }
            if let obj = APICall.Media(data: data2, forKey: "pdf", mimeType: "application/pdf", fileName: "\(strMobileNo)_registrationNumberCertificate.pdf") {
                arrMedia.append(obj)
            }
            if let obj = APICall.Media(data: data3, forKey: "pdf", mimeType: "application/pdf", fileName: "\(strMobileNo)_canncelledCheque.pdf") {
                arrMedia.append(obj)
            }
        } catch {
            Alert.show(.error, error.localizedDescription)
        }
        
        self.showLoader()
        CustomModel.uploadDoc(arrMedia, ["mobile" : strMobileNo]) { (result) in
            self.hideLoader()
            switch result {
            case .Success(let str):
                Alert.show(.Success, str) { [weak self]_ in
                    guard let self = self else { return }
                    self.pushToSignUpVC()
                }
            case .CustomError(let str):
                Alert.show(.error, str)
            }
        }
    }
    
} //extension
