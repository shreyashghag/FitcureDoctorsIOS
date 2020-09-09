//
//  ExpertOpenionView+APICall.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 07/09/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import Foundation
extension ExpertOpenionView{
    
      func api_create_ExpertOpenion()  {
        
        var parameter = [String: Any]()
        parameter["doctorId"] =  UserData.returnValue(.userID)
        parameter["name"] = txtfName.text ?? ""
        parameter["gender"] = genderStr
        parameter["age"] = txtfAge.text ?? ""
        parameter["agreevating_factors"] = txtfAgreevating.text ?? ""
        parameter["cheif_complain"] = txtfChiefCompl.text ?? ""
        parameter["history"] = txtfHistory.text ?? ""
        parameter["other_diseases"] = txtfOtherIssue.text ?? ""
        ExpertOpenionModel.CreateExpertOpenionApiCall(parameter) { (result) in
                   
                   switch result {
                   case .Success(let str):
                       Alert.show(.error, str)
                   case .CustomError(_ ):
                    break
                       
                   }
               }
        //self.showLoader()
        
       
           }
}
