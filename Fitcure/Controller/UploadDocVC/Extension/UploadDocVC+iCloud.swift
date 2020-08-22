//
//  UploadDocVC+iCloud.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 22/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import MobileCoreServices

// MARK:- Extension For :- iCloud
extension UploadDocVC: UIDocumentPickerDelegate {
    
    func openiCloud() {
        let documentPickerController = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF), String(kUTTypeImage), String(kUTTypePlainText)], in: .import)
        documentPickerController.delegate = self
        self.present(documentPickerController, animated: true, completion: nil)
    }
    
    // MARK:- Delegate Methods
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let filePath = urls.first else {
            controller.dismiss(animated: true, completion: nil)
            return
        }
        
        let file = filePath
        
        let fileExtension = file.absoluteString.fileExtension()
        if !fileExtension.isEmpty {
            if fileExtension.uppercased() == "PDF"  {
                switch selectedType ?? .None  {
                case .Aadhaar:
                    if arrDocs[0].type == .Aadhaar {
                        arrDocs[0].localFilePath = file
                    } else {
                        arrDocs.insert(DocModel(type: .Aadhaar, localFilePath: file), at: 0)
                    }
                case .DegreeCertificate:
                    if arrDocs[1].type == .DegreeCertificate {
                        arrDocs[1].localFilePath = file
                    } else {
                        arrDocs.insert(DocModel(type: .DegreeCertificate, localFilePath: file), at: 1)
                    }
                case .RegistrationNumber:
                    if arrDocs[2].type == .RegistrationNumber {
                        arrDocs[2].localFilePath = file
                    } else {
                        arrDocs.insert(DocModel(type: .RegistrationNumber, localFilePath: file), at: 2)
                    }
                case .CanceledCheque:
                    if arrDocs[3].type == .CanceledCheque {
                        arrDocs[3].localFilePath = file
                    } else {
                        arrDocs.insert(DocModel(type: .CanceledCheque, localFilePath: file), at: 3)
                    }
                    
                default:
                    break
                }
                tableView.reloadData()
                self.dismiss(animated: true, completion: nil)
            } else {
                Alert.show(.error, .pdfAllowed)
            }
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
} //extension
