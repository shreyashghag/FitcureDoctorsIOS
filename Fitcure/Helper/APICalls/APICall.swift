//
//  APICall.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 30/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import Alamofire

public enum ResultAPI<T> {
    case Success(T, Data, Int)
    case CustomError(String)
}

public enum Result<T> {
    case Success(T)
    case CustomError(String)
}

final class APICall {
    
    
    // MARK:- Helper Enums
    struct Media {
        var key: String
        var filename: String
        let data: Data
        let urlPath: URL? = nil
        let mimeType: String
        var img: UIImage?
        
        /**
            mimeType: application/pdf, image/jpeg
         */
        init?(data: Data, forKey: String, mimeType: String, fileName: String) {
            self.key = forKey
            self.mimeType = mimeType
            self.filename = fileName
            self.data = data
        }
        
        init?(withImage image: UIImage, forKey key: String, andFileName name: String = "__Profile.png") {
            self.key = key
            self.img = image
            self.mimeType = "image/jpeg"
            self.filename = name
            guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
            self.data = data
        }
    }//struct
    
    public enum HttpRequestType: String {
        case GET     = "GET"
        case POST    = "POST"
        case PUT     = "PUT"
        case PATCH   = "PATCH"
        case DELETE  = "DELETE"
    }
    
    public enum EncodingType: String {
        case UrlEncoding     = "urlEncoding"
        case JsonEncoding    = "jsonEncoding"
    }
    
    public enum SubUrl: String {
        
        case p_ConsultationRequest      = "create/order_id"
        case p_CreateConsultation       = "create/consultation"
        
        case d_Login                    = "login/doctor/"
        case d_CheckNo                  = "doctor/check/mobile/"
        case d_GenerateOtp              = "send/otp/"
        case d_CreateDoctor             = "create/doctor/"
        case d_CreateFamilyMember       = "create/familymember/"
        case d_DoctorList               = "get/doctors/"
        case d_PastConsultation         = "get/consultations/"
        case d_FamilyMember             = "get/patients/familymember/"
        case d_Patient                  = "get/patients/"
        case d_GetRelation              = "get/relations"
        case d_ConsultationFeedback     = "consultation/feedback"
        
        case d_PendingConsultation      = "get/consultation/pending/"
        case d_ActiveConsultation       = "get/consultation/active/"
        case d_RejectedConsultation     = "get/consultation/rejected/"
        case d_ChangeConsultation       = "consultation/change/"
        case d_NotifyPatient            = "notify/patient"
        case d_UploadDocs               = "upload/docs"
        case d_CallRequestSend          = "send/callingNotifications/"
        case d_helpinghand              = "create/helpinghand/"
        case d_sendPrescription         = "send/prescription/"
        case d_updateProfile            = "update/doctor/"
       
    }
        
    struct ErrorMessageModel: Codable {
        let detail: String?
        let message: String?
    }
    
    // MARK:- Private/Internal Variables
    static internal let strNoData_Err           = "Response data is null."
    static internal let strNoNetwork_Err        = "Network not available. Please try again...!"
    static private let reachabilityManager      = NetworkReachabilityManager()
    
    static internal var header: HTTPHeaders  {
        var headers = [String: String]()
        /*if let authToken = UserData.returnValue(.token) as? String {
            let strToken = "Token" + " " + authToken
            headers["Authorization"] = strToken
        }*/
        headers["Accept"] = "application/json"
        return headers
    }
        
    // MARK:- Public Variables
    static var isStaging            = true
    static var isNetworkAvailable   = false
    static var MainBaseURL: String  = {
        if isStaging {
            return "http://13.127.240.182:5000/"
        } else {
            return "http://13.127.240.182:3000/"
        }
    }()
    static let DocImgBaseURL: String = {
        return APICall.MainBaseURL + "staticmedia/doctors/images/"
    }()
    static let PaiImgBaseURL: String = {
        return APICall.MainBaseURL + "staticmedia/patients/images/"
    }()
    static let TearmsAndCondition: String = {
        return APICall.MainBaseURL + "staticmedia/docs/terms_conditions.html"
    }()
    static let PrivacyPolicy: String = {
        return APICall.MainBaseURL + "staticmedia/docs/privacy_policy.html"
    }()
    static let RefundPolicy: String = {
        return APICall.MainBaseURL + "staticmedia/docs/refund.html"
    }()
    static let bergBalanceScale: String = {
        return APICall.MainBaseURL + "staticmedia/training/fp-berg-balance-scale.pdf"
    }()
    static let DASH: String = {
        return APICall.MainBaseURL + "staticmedia/training/DASH.pdf"
    }()
    static let ViewPresecription: String = {
           return APICall.MainBaseURL + "staticmedia/prescription/"
       }()
    // MARK:- Public Network availibility
    class public func networkAvailibity() {
        reachabilityManager?.listener = { (status) in
            switch status {
            case .reachable(.ethernetOrWiFi), .reachable(.wwan):
                isNetworkAvailable = true
                debugPrint("🗼⚡️⚡️⚡️Internet Available⚡️⚡️⚡️🗼")
                
            case .unknown, .notReachable:
                isNetworkAvailable = false
                debugPrint("🗼⚡️⚡️⚡️Internet Not Available⚡️⚡️⚡️🗼")
            }
        }
        reachabilityManager?.startListening()
    }
    
    // MARK:- Public Stop All Sessions include download's as well
    class func stopAllSessions() {
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({$0.cancel()})
        }
    }
    // MARK:- Private/Internal APICall Request's
    class internal func getParameterEncoding(_ fromType: EncodingType)-> ParameterEncoding {
        switch fromType {
        case .JsonEncoding:
            return JSONEncoding.default
        case .UrlEncoding:
            return URLEncoding.default
        }
    }
    class internal func getHttpMethod(_ fromType: HttpRequestType)-> HTTPMethod {
        return HTTPMethod(rawValue: fromType.rawValue)!
    }
    
} //class


extension APICall {
    
    // MARK:-  APICall Request's  --Codable--
    class public func webRequest<T: Codable>(
        apiType: HttpRequestType = .GET,
        endPoint: SubUrl,
        strID: String = "",
        parameters: [String: Any]? = nil,
        encodingType: EncodingType = .UrlEncoding,
        forceDecoding: Bool = true,
        decodableObj: T.Type,
        complection: @escaping((ResultAPI<T?>)->())) {
        
        // Check Network
        guard isNetworkAvailable else {
            complection(.CustomError(strNoNetwork_Err))
            return
        }
        
        // Get Final URL
        var finalURL = MainBaseURL + endPoint.rawValue
        if !strID.isEmpty {
            finalURL = MainBaseURL + endPoint.rawValue + strID + ""
        }
        
        // Print API Url, Parameters
        debugPrint("-------API Call 🧨-------")
        debugPrint("URL:- ", finalURL)
        debugPrint("Header:- ", header)
        debugPrint("Parameter:- ", parameters ?? [:])
        
        // Call AF WebService
        Alamofire.request(finalURL, method: getHttpMethod(apiType), parameters: parameters, encoding: getParameterEncoding(encodingType), headers: header).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode else {
                complection(.CustomError(response.error?.localizedDescription ?? strNoData_Err))
                debugPrint("====== Status Code is null =======")
                return
            }
            
            debugPrint("Status Code:- ", statusCode)
            /*if  !(200...299).contains(statusCode) {
             let strCodeError = getErrorMessageFromErrorCode(statusCode, data: response.data)
             complection(.CustomError(strCodeError))
             return
             }*/
            
            guard let data = response.data, !data.isEmpty else {
                complection(.CustomError(response.error?.localizedDescription ?? strNoData_Err))
                return
            }
            
            do {
                /*if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    debugPrint(json)
                }*/
                
                let resModel = try JSONDecoder().decode(decodableObj, from: data)
                complection(.Success(resModel, data, statusCode))
            } catch let err {
                
                if !forceDecoding {
                    complection(.Success(nil, data, statusCode))
                } else {
                    complection(.CustomError(err.localizedDescription))
                }
            }
        }
    }
    
    // MARK:- APICall Request With Full URL --Codable--
    class public func webRequestWithFullURL<T: Codable>(
        apiType: HttpRequestType = .GET,
        url: String,
        parameters: [String: Any]? = nil,
        encodingType: EncodingType = .UrlEncoding,
        forceDecoding: Bool = true,
        decodableObj: T.Type,
        complection: ((ResultAPI<T?>)->())?) {
        
        // Check Network
        guard isNetworkAvailable else {
            complection?(.CustomError(strNoNetwork_Err))
            return
        }
        
        // Print API Url, Parameters
        debugPrint("-------API Call 🧨-------")
        debugPrint("URL:- ", url)
        debugPrint("Header:- ", header)
        debugPrint("Parameter:- ", parameters ?? [:])
        
        // Call AF WebService
        Alamofire.request(url, method: getHttpMethod(apiType), parameters: parameters, encoding: getParameterEncoding(encodingType), headers: header).validate().responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode else {
                complection?(.CustomError(response.error?.localizedDescription ?? strNoData_Err))
                debugPrint("====== Status Code is null =======")
                return
            }
            
            debugPrint("Status Code:- ", statusCode)
            /*if !(200...299).contains(statusCode)  {
             let strCodeError = getErrorMessageFromErrorCode(statusCode, data: response.data)
             complection(.CustomError(strCodeError))
             return
             }*/
            
            guard let data = response.data, !data.isEmpty else {
                complection?(.CustomError(response.error?.localizedDescription ?? strNoData_Err))
                return
            }
            
            do {
                let resModel = try JSONDecoder().decode(decodableObj, from: data)
                complection?(.Success(resModel, data, statusCode))
            } catch let err {
                if !forceDecoding {
                    complection?(.Success(nil, data, statusCode))
                } else {
                    complection?(.CustomError(err.localizedDescription))
                }
            }
        }
    }
    
    // MARK:- Download File Request  --Data--
    class public func webDownloadRequest(
        _ filePath: URL,
        _ complection: @escaping((Result<Data>)->())) {
        
        // Check Network
        guard isNetworkAvailable else {
            complection(.CustomError(strNoNetwork_Err))
            return
        }
        
        // Print API Url, Parameters
        debugPrint("-------API Call 🧨-------")
        debugPrint("URL:- ", filePath)
        
        let request = URLRequest(url: filePath)
        let destinationPath = DownloadRequest.suggestedDownloadDestination()
        
        // Call AF WebService
        Alamofire.download(request, to: destinationPath).validate().responseData { (response) in
            
            guard let resultFilePath = response.destinationURL else {
                complection(.CustomError(response.error?.localizedDescription ?? strNoData_Err))
                return
            }
            
            do {
                let objData = try Data(contentsOf: resultFilePath)
                complection(.Success(objData))
            } catch let err {
                complection(.CustomError(err.localizedDescription))
            }
        }
    }
    
    // MARK:- Upload File Request  --Codable--
    class public func webUploadRequest<T: Codable>(
        apiType: HttpRequestType = .POST,
        endPoint: SubUrl,
        parameters: [String: Any],
        arrMedia: [Media]?,
        strID: String = "",
        decodableObj: T.Type,
        forceDecoding: Bool = true,
        complection: @escaping((ResultAPI<T?>)->())) {
        
        // Check Network
        guard isNetworkAvailable else {
            complection(.CustomError(strNoNetwork_Err))
            return
        }
        
        // Get Final URL
        var finalURL = MainBaseURL + endPoint.rawValue
        if !strID.isEmpty {
            finalURL = MainBaseURL + endPoint.rawValue + strID + "/"
        }
        
        // Print API Url, Parameters
        debugPrint("-------API Call 🧨-------")
        debugPrint("URL:- ", finalURL)
        debugPrint("Header:- ", header)
        debugPrint("Parameter:- ", parameters)
        
        // Call AF WebService
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in parameters {
                if let dic = value as? [String: Any] {
                    if let dicData = try? JSONSerialization.data( withJSONObject: dic, options: []) {
                        multipartFormData.append(dicData, withName: key)
                    }
                } else if let dic = value as? [Any] {
                    if let dicData = try? JSONSerialization.data( withJSONObject: dic, options: []) {
                        multipartFormData.append(dicData, withName: key)
                    }
                } else if let intValue = value as? Int {
                    multipartFormData.append(("\(intValue)").data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                } else if let intValue = value as? Double {
                    multipartFormData.append(("\(intValue)").data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                } else if let intValue = value as? Bool {
                    var valueInInt = Int(truncating: NSNumber(booleanLiteral: intValue))
                    let data = Data(bytes: &valueInInt, count: MemoryLayout.size(ofValue: valueInInt))
                    multipartFormData.append(data, withName: key)
                } else {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            for mediaObj in arrMedia ?? [] {
                debugPrint("Media Name:- ", mediaObj.filename)
                multipartFormData.append(mediaObj.data, withName: mediaObj.key, fileName: mediaObj.filename , mimeType: mediaObj.mimeType)
            }
            
        }, usingThreshold: UInt64.init(), to: finalURL, method: getHttpMethod(apiType), headers: header) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    guard let statusCode = response.response?.statusCode else {
                        complection(.CustomError(response.error?.localizedDescription ?? strNoData_Err))
                        debugPrint("====== Status Code is null =======")
                        return
                    }
                    
                    debugPrint("Status Code:- ", statusCode)
                    
                    guard let data = response.data, !data.isEmpty else {
                        complection(.CustomError(response.error?.localizedDescription ?? strNoData_Err))
                        return
                    }
                    
                    do {
                        let resModel = try JSONDecoder().decode(decodableObj, from: data)
                        complection(.Success(resModel, data, statusCode))
                    } catch let err {
                        if !forceDecoding {
                            complection(.Success(nil, data, statusCode))
                        } else {
                            complection(.CustomError(err.localizedDescription))
                        }
                    }
                }
            case .failure(let error):
                complection(.CustomError(error.localizedDescription))
            }
        }
    }
    
} //extension
