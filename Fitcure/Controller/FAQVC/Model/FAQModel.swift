//
//  FAQModel.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 09/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation

struct FAQModel {
    var strQuestion     = ""
    var strAnswer       = ""
    var strImgName      = ""
    var isShow          = false
        
    static func getListing()->[FAQModel] {
        var arr = [FAQModel]()
        arr.append(FAQModel(
            strQuestion: "How to Accept/Approve a call request from patient?",
            strAnswer:
            "Go to -> Call Request Tab -> Click on the Approve icon as highlighted below.",
            strImgName: "f_DoctorHelper"))
        
        arr.append(FAQModel(
        strQuestion: "Can I reject a call request?",
        strAnswer: "Yes, you can delete a request by simply clicking on the “Trash” icon shown in the above screenshot."))
        
        arr.append(FAQModel(
        strQuestion: "What is the next step once a request has been accepted?",
        strAnswer: "Go to -> “Active Consults” tab and click on the respective call request of the patient you want to start the call."))
        
        arr.append(FAQModel(
        strQuestion: "How many times do doctors have to try to contact the patients?",
        strAnswer: "Three times (if patient does not pick up in the first attempt try two more times within 4 hours."))
        
        arr.append(FAQModel(
        strQuestion: "What is the time period in which doctors have to call the patients?",
        strAnswer: "Within 4 hours after accepting the request"))
        
        arr.append(FAQModel(
        strQuestion: "How to update existing Doctor Profile?",
        strAnswer: "Click on the Profile Icon present at bottom centre and edit the required details"))
        
        arr.append(FAQModel(
        strQuestion: "How can a doctor reach out to other doctor?",
        strAnswer: "If there is an issue (regarding a patient) for which a doctor needs help or advise, he/she can reach out to experts via Expert Opinion Tab"))
                
        return arr
    }
} //class
