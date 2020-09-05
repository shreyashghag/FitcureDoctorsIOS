//
//  PastConsultantDetailsVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 07/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class PastConsultantDetailsVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet private weak var viewMain             : UIView!
    @IBOutlet private weak var imgvProfile          : UIImageView!
    
    @IBOutlet private weak var lblName              : UILabel!
    @IBOutlet private weak var lblPatientName       : UILabel!
    @IBOutlet private weak var lblAge               : UILabel!
    @IBOutlet private weak var lblPurpose           : UILabel!
    
    @IBOutlet private weak var btnVideoCall         : UIButton!
    @IBOutlet private weak var btnWritePrescription : UIButton!
    @IBOutlet private weak var btnNotify            : UIButton!
        
    // MARK:- Variables
    var showActive = false
    var obj: PatientRequestModel?
    
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
        btnVideoCall.setCorner(withRadius: 5)
        btnWritePrescription.setCorner(withRadius: 5)
        btnNotify.setCorner(withRadius: 5)
        btnVideoCall.isHidden = !showActive
        btnWritePrescription.isHidden = !showActive
        btnNotify.isHidden = !showActive
        
        DispatchQueue.main.async {
            self.imgvProfile.addGradientBlack()
            self.setData()
        }
    }
    
    private func setData() {
        guard let obj = obj else { return }
        lblName.text = obj.patient ?? ""
        lblPatientName.text = obj.patient ?? ""
        lblAge.text = "\(obj.patientage ?? 0)"
        lblPurpose.text = obj.purpose ?? ""
        btnVideoCall.isHidden = !showActive
        btnWritePrescription.isHidden = !showActive
        btnNotify.isHidden = !showActive
        imgvProfile.setImage(str: obj.profileImage, isDoc: false)
    }
    
    // MARK:- Button Actions
    @IBAction private func btnBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction private func btnVideoCallPressed() {
        api_CallRequest()
    }
    @IBAction private func btnWritePrescriptionPressed() {
        
    }
    @IBAction private func btnNotifyPatientPressed() {
        pushPickerPopUpVC()
    }
    
    // MARK:- Push Methods
    private func pushSendFeedbackVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: FeedBackVC.self)) as? FeedBackVC else { return }
        //vc.obj = obj
        self.present(vc, animated: true, completion: nil)
    }
    private func pushPickerPopUpVC() {
        debugPrint(obj?.updatedAt ?? "")
        guard let date = Date.getDate(obj?.updatedAt ?? ""), Date() >= date else {
            Alert.show(.error, .Oops)
            return
        }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PickerPopVC.self)) as? PickerPopVC else { return }
        vc.maxDate = Date.addDurationOn(date: date, component: .hour, 4)
        vc.onDidSelectDate = { [weak self] selectedDate in
            guard let self = self else { return }
            let strDate = String.getTime(selectedDate)
            self.api_NotifyPatient(strDate)            
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func pushToVideoCallingVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: VideoChatViewController.self)) as? VideoChatViewController else { return }
        vc.userID = UInt(self.obj?.doctorID ?? 0)
        vc.remoteUserIDs = [UInt(self.obj?.patientID ?? 0)]
        vc.channelName = "\(self.obj?.patientID ?? 0)\(self.obj?.doctorID ?? 0)"
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK:- Custom Methods
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:-
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class
