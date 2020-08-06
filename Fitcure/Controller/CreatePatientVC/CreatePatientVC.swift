//
//  CreatePatientVC.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 02/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

final class CreatePatientVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var imgvProfile      : UIImageView!
    @IBOutlet weak var btnCamera        : UIButton!
    @IBOutlet weak var txtfName         : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfPassword     : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfEmail        : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfAge          : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfCity         : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfMobileNo     : SkyFloatingLabelTextField!
    @IBOutlet weak var segGender        : UISegmentedControl!
    @IBOutlet weak var lblTC            : UILabel!
    @IBOutlet weak var btnTC            : UIButton!
    @IBOutlet weak var btnSave          : UIButton!
    
    // MARK:- Variable
    var genderStr = "male"
    var newString: NSString = ""
    var isTCButtonTapped = false
    var isCameraButtonTapped = false
    var imagePicker: ImagePicker!
    var media: APICall.Media?
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        setUpNavigation()
        
        btnTC.setImage(UIImage(named: "f_Tick"), for: .normal)
        btnTC.setImage(UIImage(named: "f_TickSelected"), for: .selected)
        txtfMobileNo.text = (UserData.returnValue(UserData.userDataKeys.Mobile) as! String)
        imgvProfile.setCorner(withRadius: imgvProfile.frame.height * 0.5)
        imgvProfile.backgroundColor = .f_ViewBack
        btnSave.isEnabled = false
        btnSave.alpha = 0.4
        setUpTextField()
        [txtfName, txtfPassword, txtfEmail,txtfAge,txtfCity,txtfMobileNo].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tcPressed))
        lblTC.addGestureRecognizer(gesture)
    }
    
    private func setUpTextField() {
        
        txtfPassword.isSecureTextEntry = true
        
        txtfName.returnKeyType = .next
        txtfPassword.returnKeyType = .next
        txtfEmail.returnKeyType = .next
        txtfAge.returnKeyType = .next
        txtfCity.returnKeyType = .next
        txtfMobileNo.returnKeyType = .next
        
        for txtf in [txtfName, txtfPassword, txtfEmail, txtfAge, txtfCity, txtfMobileNo,] {
            txtf?.selectedTitleColor = .f_AppColor
            txtf?.tintColor = .f_AppColor
            txtf?.textColor = .darkText
            txtf?.delegate = self
        }
        txtfEmail.keyboardType = .emailAddress
        txtfAge.keyboardType = .numberPad
        txtfMobileNo.keyboardType = .numberPad
    }
    func setUpNavigation() {
        self.navigationItem.setTitle(.CreateProtile)
        let backBtn = UIBarButtonItem(image: UIImage(named: "f_back"), style: .plain, target: self, action: #selector(backBtnPressed(_:)))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    @objc func backBtnPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
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
            let pass = txtfPassword.text, !pass.isEmpty,(txtfPassword.text?.count)!>=4,
            let name = txtfName.text, !name.isEmpty,(txtfName.text?.count)!>=1,
            let age = txtfAge.text, !age.isEmpty,(txtfAge.text?.count)!>=1,
            let city = txtfCity.text, !city.isEmpty,(txtfCity.text?.count)!>=1
            else {
                btnSave.isEnabled = false
                btnSave.alpha = 0.4
                return
        }
        if isTCButtonTapped, media != nil {
            btnSave.isEnabled = true
            btnSave.alpha = 1.0
        }
    }
    
    // MARK:- Button Action
    @IBAction func btnCameraPressed(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
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
    
    @IBAction func btnCheckTCPressed(_ sender: UIButton) {
        btnTC.isSelected.toggle()
        isTCButtonTapped.toggle()
        
        if isTCButtonTapped {
            btnSave.isEnabled = true
            btnSave.alpha = 1.0
             pushTCPopupVC()
        } else {
            btnSave.isEnabled = false
            btnSave.alpha = 0.4
           
        }
    }
    
    @IBAction func btnSavePressed(_ sender: UIButton) {
        guard media != nil else {
            Alert.show(.appName, .ProfilePicReq)
            return
        }
        api_create_patient()
    }
    
    @objc private func tcPressed() {
        self.view.endEditing(true)
        pushTCPopupVC()
    }
    
    // MARK:- Custom Methods
    func pushTabbarVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: TabBarVC.self)) as? TabBarVC else { return }
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func pushTCPopupVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: TermsConditionPopUpVC.self)) as? TermsConditionPopUpVC else { return }
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:- Deinit
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class
