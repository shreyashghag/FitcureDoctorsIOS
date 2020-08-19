//
//  RequestForConsultVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 07/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class RequestForConsultVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet private weak var viewMain     : UIView!
    @IBOutlet private weak var txtvDesc     : UITextView!
    @IBOutlet private weak var btnBack      : UIButton!
    @IBOutlet private weak var btnPatient   : UIButton!
        
    // MARK:- Variables
    let strPlaceHolder = "Reason for Consultation"
    var isSelfSelected = false
    var selectedMember: FamilyModel?
    var arrFamilyMember = [FamilyModel]()
    
    var onMakePaymentPressed: ((String, FamilyModel)->())?
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        getFamilyMembers()
        UIView.animate(withDuration: 0.5) {
            self.btnBack.backgroundColor = .black
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.btnBack.backgroundColor = .clear
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        txtvDesc.delegate = self
        txtvDesc.setBorder(withRadius: 5)
        txtvDesc.textColor = UIColor.lightGray
        viewMain.setCorner(withRadius: 10)
        
        if let strName = UserData.returnValue(.name) as? String {
            isSelfSelected = true
            selectedMember = FamilyModel(familyMemberID: nil, patientID: nil, mobile: nil, name: strName, email: nil, gender: nil, age: nil, city: nil, relation: nil)
            btnPatient.setTitle(strName, for: .normal)
        }
    }
    
    // MARK:- Button Actions
    @IBAction private func btnBackPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSelectPatientPressed(_ sender: UIButton) {
        pushDropDownVC(arr: arrFamilyMember, sender: sender)
    }
    @IBAction func btnMakePayment(_ sender: UIButton) {
        guard checkValidations(), let obj = selectedMember else { return }
        self.dismiss(animated: true, completion: nil)
        onMakePaymentPressed?(txtvDesc.text, obj)
    }
    
    // MARK:- Push Methods
    func pushDropDownVC( arr: [Any],  sender: UIView) {
        guard arr.count > 0, let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: DropDownVC.self)) as? DropDownVC else { return }
        
        vc.arrListing = arr
        vc.onValueSelection = { [weak self] value in
            guard let self = self, let obj = value as? FamilyModel else { return }
            self.selectedMember = obj
            self.isSelfSelected = (obj.familyMemberID == nil && obj.name == "Self")
            self.btnPatient.setTitle(self.selectedMember?.name ?? "Patient Name", for: .normal)
        }
        
        var size = sender.frame.size
        size.width += size.width * 0.5
        size.height = CGFloat(arr.count * 50)
        if size.height > 250 {
            size.height = 250
        }
        if size.height < 100 {
            size.height = 100
        }
        vc._preferredContentSize = size
        
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.delegate = self
        vc.popoverPresentationController?.sourceView = sender
        vc.popoverPresentationController?.sourceRect = sender.bounds
        vc.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK:- Custom Methods
    private func checkValidations()->Bool {
        self.view.endEditing(true)
        
        let strReason = txtvDesc.text
        
        if strReason == strPlaceHolder {
            Alert.show(.error, .ConsultationReason, controller: self)
            return false
        }
        
        if selectedMember == nil {
            Alert.show(.error, .PatientName, controller: self)
            return false
        }
        
        return true
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

// MARK:- Extension For :- UIPopoverPresentationControllerDelegate
extension RequestForConsultVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
} //extension
