//
//  DoctorDetailsVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 07/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class DoctorDetailsVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet private weak var viewMain         : UIView!
    @IBOutlet private weak var imgvProfile      : UIImageView!
    
    @IBOutlet private weak var lblName	        : UILabel!
    @IBOutlet private weak var lblDegree        : UILabel!
    @IBOutlet private weak var lblHospital      : UILabel!
    @IBOutlet private weak var lblWorkingSince  : UILabel!
    @IBOutlet private weak var lblCity	        : UILabel!
    @IBOutlet private weak var lblLanguages	    : UILabel!
    
    @IBOutlet private weak var btnRequest       : UIButton!
    
    // MARK:- Variables
//    var obj: DoctorModel?
    var strReason: String?
    var objFamily: FamilyModel?
    
    // RazorPayObj Class scope
    var amt: Double = 35000//in paise
    var objOrderRequest: OrderRequestModel?
    private var razorPayObj: RazorPayHelper?
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        viewMain.setCorner(withRadius: 10)
        btnRequest.setCorner(withRadius: 5)
        DispatchQueue.main.async {
            self.imgvProfile.addGradientBlack()
            self.setData()
        }        
    }
    
    private func setData() {
//        guard let obj = obj else { return }
//        lblName.text = obj.name ?? ""
//        lblDegree.text = obj.qualification ?? ""
//        lblHospital.text = obj.associateHospital ?? ""
//        if let year = obj.workingSince {
//            lblWorkingSince.text = "\(year)"
//        } else {
//            lblWorkingSince.text = "NA"
//        }
//        lblCity.text = obj.city ?? ""
//        lblLanguages.text = obj.preferredLanguages ?? ""
//
//        imgvProfile.setImage(str: obj.profileImage)
    }
    
    // MARK:- Button Actions
    @IBAction private func btnBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction private func btnRequestForConsultantPressed() {
//        guard obj != nil else {
//            Alert.show(.appName, .Oops)
//            return
//        }
//        pushRequestForConsultVC()
    }
    
    // MARK:- Push Methods
    private func pushRequestForConsultVC() {
        strReason = nil
        objFamily = nil
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: RequestForConsultVC.self)) as? RequestForConsultVC else { return }
        
        vc.onMakePaymentPressed = { [weak self] (strReason, objFamily) in
            guard let self = self else { return }
            self.strReason = strReason
            self.objFamily = objFamily
            self.APICall_requestForMakePayment()
        }
        self.present(vc, animated: true, completion: nil)
    }
    // MARK:- Custom Methods
    
    
    // MARK:- RazorPayHelper Methods
    func makePayment(_ strKey: String, amt: String, orderID: String) {
        razorPayObj = nil
                
        let strName = UserData.returnValue(.name) as? String ?? ""
        let strEmail = UserData.returnValue(.Email) as? String ?? ""
        let strMobile = UserData.returnValue(.Mobile) as? String ?? ""
        
        razorPayObj = RazorPayHelper(strKey, self, totalPayable: amt, orderID: orderID)
        razorPayObj?.openPaymentGateway(name: strName, contact: strMobile, email: strEmail) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .Success(let dict):
                self.onPaymentSuccess(dict)
            case .CustomError(let str):
                Alert.show(.error, str)
            }
        }
    }
    
    func onPaymentSuccess(_ response: [String : Any]) {

//        var parameter = [String: Any]()
//        parameter["doctorId"] = obj?.id
//        parameter["patientId"] = UserData.returnValue(.userID) as? Int
//        parameter["purpose"] = self.strReason
//        parameter["razorpayOrderId"] = self.objOrderRequest?.orderID
//        parameter["paymentId"] = self.objOrderRequest?.razorpayID
//        parameter["orderReceiptId"] = self.objOrderRequest?.orderReceipt
//        parameter["familyId"] = self.objFamily?.familyMemberID
//
//        APICall_createConsultation(parameter)
    }
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:-
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class
