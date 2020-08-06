//
//  AddFamilyMemberVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 11/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AddFamilyMemberVC: UIViewController {
    
    var newString: NSString = ""
    var genderStr = "male"
    var relationID = 0
    
    // MARK:- Outlets
    @IBOutlet weak var txtfName         : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfEmail        : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfAge          : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfCity         : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfMobileNo     : SkyFloatingLabelTextField!
    @IBOutlet weak var segGender        : UISegmentedControl!
    @IBOutlet weak var btnRelation      : UIButton!
    @IBOutlet weak var btnSave          : UIButton!
    
    // MARK:- Variable
    var obj: FamilyModel?
    var arrRelations = [RelationModel]()
    var selectedRelation: RelationModel?
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        btnSave.isEnabled = false
        btnSave.alpha = 0.4
        [txtfName, txtfEmail,txtfAge,txtfCity,txtfMobileNo].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if arrRelations.isEmpty {
            self.getRelations()
        }
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        setUpTextField()
        setUpNavigation()
    }
    
    private func setUpTextField() {
        txtfName.returnKeyType = .next
        txtfEmail.returnKeyType = .next
        txtfAge.returnKeyType = .next
        txtfCity.returnKeyType = .next
        txtfMobileNo.returnKeyType = .next
        
        for txtf in [txtfName, txtfEmail, txtfAge, txtfCity, txtfMobileNo,] {
            txtf?.selectedTitleColor = .f_AppColor
            txtf?.textColor = .darkText
            txtf?.delegate = self
            txtf?.tintColor = .black
            txtf?.textColor = .black
        }
        txtfEmail.keyboardType = .emailAddress
        txtfAge.keyboardType = .numberPad
        txtfMobileNo.keyboardType = .numberPad
    }
    
    func setUpNavigation() {
        self.navigationItem.setTitle(.FamilyMember)
        let backBtn = UIBarButtonItem(image: UIImage(named: "f_back"), style: .plain, target: self, action: #selector(backBtnPressed(_:)))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    func setData() {
        guard let obj = obj else { return }
        
        txtfName.text = obj.name
        txtfEmail.text = obj.email
        if let age = obj.age {
            txtfAge.text = "\(age)"
        }
        txtfCity.text = obj.city
        txtfMobileNo.text = obj.mobile
        relationID = obj.relation ?? 0
        genderStr =  obj.gender ?? "male"
        segGender.selectedSegmentIndex = (obj.gender ?? "male" == "male") ? 0 : 1
        
        if relationID != 0 {
            selectedRelation = arrRelations.filter({ (rObj) -> Bool in
                return rObj.id == obj.relation ?? 0
                }).first
            
            btnSave.isEnabled = true
            btnSave.alpha = 1.0
        }
        self.btnRelation.setTitle(selectedRelation?.relation ?? "Select", for: .normal)
        
    }
    
    // MARK:- Button Action
    @objc func backBtnPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func segGenderSelectionChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            genderStr =  "male"
        case 1:
            genderStr =  "female"
        default:
            break
        }
    }
    
    @IBAction func btnRelationShipPressed(_ sender: UIButton) {
        pushDropDownVC(arrQuantity: arrRelations, sender: sender)
    }
    
    @IBAction func btnSavePressed(_ sender: UIButton) {
        api_create_patient_family_fember()
    }
    
    // MARK:- Custom Methods
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let num = txtfMobileNo.text, !num.isEmpty,
            let email = txtfEmail.text, !email.isEmpty,isValidEmail(testStr: txtfEmail.text!),
            let name = txtfName.text, !name.isEmpty,(txtfName.text?.count)!>=1,
            let age = txtfAge.text, !age.isEmpty,(txtfAge.text?.count)!>=1,
            let city = txtfCity.text, !city.isEmpty,(txtfCity.text?.count)!>=1
            else {
                btnSave.isEnabled = false
                btnSave.alpha = 0.4
                return
        }
        btnSave.isEnabled = true
        btnSave.alpha = 1.0
        
    }
    
    // MARK:- Push Methods
    func pushProfileVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: ProfileVC.self)) as? ProfileVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushDropDownVC( arrQuantity: [Any],  sender: UIView) {
        guard arrQuantity.count > 0, let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: DropDownVC.self)) as? DropDownVC else { return }
        
        vc.arrListing = arrQuantity
        vc.onValueSelection = { [weak self] value in
            guard let self = self, let obj = value as? RelationModel else { return }
            self.selectedRelation = obj
            self.relationID = self.selectedRelation?.id ?? 0
            self.btnRelation.setTitle(obj.relation ?? "Select", for: .normal)
        }
        
        var size = sender.frame.size
        size.height = CGFloat(arrQuantity.count * 50)
        if size.height > 250 {
            size.height = 250
        }
        if size.height < 150 {
            size.height = 150
        }
        vc._preferredContentSize = size
        
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.delegate = self
        vc.popoverPresentationController?.sourceView = sender
        vc.popoverPresentationController?.sourceRect = sender.bounds
        vc.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK:- Receive Memory Warning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:- Deinit
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class

// MARK:- Extension For :- UIPopoverPresentationControllerDelegate
extension AddFamilyMemberVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
} //extension
