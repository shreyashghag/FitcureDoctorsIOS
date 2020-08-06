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
    @IBOutlet private weak var viewMain         : UIView!
    @IBOutlet private weak var imgvProfile      : UIImageView!
    
    @IBOutlet private weak var lblName          : UILabel!
    @IBOutlet private weak var lblPatientName   : UILabel!
    @IBOutlet private weak var lblPurpose       : UILabel!
    @IBOutlet private weak var lblStatus        : UILabel!
    
    @IBOutlet private weak var btnFeedBack      : UIButton!
    @IBOutlet private weak var btnPrescription  : UIButton!
        
    // MARK:- Variables
    var obj: ConsultsModel?
    
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
        btnFeedBack.setCorner(withRadius: 5)
        btnPrescription.setCorner(withRadius: 5)
        btnFeedBack.isHidden = true
        btnPrescription.isHidden = true
        DispatchQueue.main.async {
            self.imgvProfile.addGradientBlack()
            self.setData()
        }
    }
    
    private func setData() {
        guard let obj = obj else { return }
        lblName.text = obj.doctor ?? ""
        lblPatientName.text = obj.doctor ?? ""
        lblPurpose.text = obj.purpose ?? ""
        
        switch obj.isAccepted ?? 0 {
        case 0:
            lblStatus.text = "Pending"
        case 1:
            lblStatus.text = "Accepted"
            btnFeedBack.isHidden = false
        case -1:
            lblStatus.text = "Rejected"
        default:
            lblStatus.text = " - "
        }
        btnPrescription.isHidden = (obj.prescriptionPDF ?? "").isEmpty
        imgvProfile.setImage(str: obj.profileImage)
        
    }
    
    // MARK:- Button Actions
    @IBAction private func btnBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction private func btnSendFeedbackPressed() {
        pushSendFeedbackVC()
    }
    @IBAction private func btnViewPrescriptionPressed() {
        
    }
    
    // MARK:- Push Methods
    private func pushSendFeedbackVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: FeedBackVC.self)) as? FeedBackVC else { return }
        vc.obj = obj
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
