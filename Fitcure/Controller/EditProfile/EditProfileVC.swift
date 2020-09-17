//
//  EditProfileVC.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 10/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class EditProfileVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var imgvProfile      : UIImageView!
    @IBOutlet weak var btnCamera        : UIButton!
    @IBOutlet weak var btnSave          : UIButton!
    @IBOutlet weak var txtfName         : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfEmail        : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfCity         : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfnameOfCouncil: SkyFloatingLabelTextField!
    @IBOutlet weak var txtfregistratioNo : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfqualification: SkyFloatingLabelTextField!
    @IBOutlet weak var txtfassociateHospital: SkyFloatingLabelTextField!
    @IBOutlet weak var txtfpreferredLanguages: SkyFloatingLabelTextField!
     @IBOutlet weak var txtflocation: SkyFloatingLabelTextField!
    @IBOutlet weak var txtfspeciality: SkyFloatingLabelTextField!
    
    var newString: NSString = ""
    var imagePicker: ImagePicker!
    var isCameraButtonTapped = false
    var media: APICall.Media?
    // MARK:- Variable
    var doctorObj: UserModel?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        setUpView()
        btnSave.isEnabled = false
        btnSave.alpha = 0.4
        [txtfName, txtfEmail,txtfCity,txtfnameOfCouncil,txtfregistratioNo,txtfqualification,txtfassociateHospital,txtfpreferredLanguages,txtflocation,txtfspeciality].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        setData()
    }
    
    
    // MARK:- Push Methods
    func pushProfileVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: ProfileVC.self)) as? ProfileVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let txtfnameOfCouncil   = txtfnameOfCouncil.text, !txtfnameOfCouncil.isEmpty,
            let email = txtfEmail.text, !email.isEmpty,isValidEmail(testStr: txtfEmail.text!),
            let name  = txtfName.text, !name.isEmpty,(txtfName.text?.count)!>=1,
            let city  = txtfCity.text, !city.isEmpty,(txtfCity.text?.count)!>=1,
            let associateHospital   = txtfassociateHospital.text, !associateHospital.isEmpty,(txtfassociateHospital.text?.count)!>=1,
            let registratioNo   = txtfregistratioNo.text, !registratioNo.isEmpty,(txtfregistratioNo.text?.count)!>=1,
            let qualification   = txtfqualification.text, !qualification.isEmpty,(txtfqualification.text?.count)!>=1,
            let preferredLanguages   = txtfpreferredLanguages.text, !preferredLanguages.isEmpty,(txtfpreferredLanguages.text?.count)!>=1,
            let speciality   = txtfspeciality.text, !speciality.isEmpty,(txtfspeciality.text?.count)!>=1,
            let location   = txtflocation.text, !location.isEmpty,(txtflocation.text?.count)!>=1
            
            else {
                btnSave.isEnabled = false
                btnSave.alpha = 0.4
                return
        }
        btnSave.isEnabled = true
        btnSave.alpha = 1.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        setUpTextField()
        setUpNavigation()
    }
    
    private func setUpTextField() {
        
        txtfName.returnKeyType = .next
        txtfEmail.returnKeyType = .next
        txtfnameOfCouncil.returnKeyType = .next
        txtfregistratioNo.returnKeyType = .next
        txtfqualification.returnKeyType = .next
        txtfassociateHospital.returnKeyType = .next
        txtfCity.returnKeyType = .next
        txtfpreferredLanguages.returnKeyType = .next
        txtflocation.returnKeyType = .next
        txtfspeciality.returnKeyType = .next
    
        
        for txtf in [txtfName, txtfEmail, txtfCity, txtfnameOfCouncil,txtfregistratioNo,txtfqualification,txtfpreferredLanguages,txtflocation,txtfspeciality] {
            txtf?.selectedTitleColor = .f_AppColor
            txtf?.textColor = .darkText
            txtf?.delegate = self
            txtf?.tintColor = .black
            txtf?.textColor = .black
        }
        txtfEmail.keyboardType = .emailAddress
       
        
        
        
    }
    
    func setUpNavigation() {
        self.navigationItem.setTitle(.Profile)
        let backBtn = UIBarButtonItem(image: UIImage(named: "f_back"), style: .plain, target: self, action: #selector(backBtnPressed(_:)))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    func setData() {
      
        imgvProfile.setCorner(withRadius: imgvProfile.frame.height * 0.5)
        imgvProfile.backgroundColor = .f_ViewBack
        guard let obj = doctorObj else { return }
        txtfName.text = obj.name
        txtfEmail.text = obj.email
        txtfCity.text = obj.city
        txtflocation.text = (UserData.returnValue(.currentLocation) as? String) ?? obj.location ?? ""
       self.imgvProfile.setImage(str: self.doctorObj?.profileImage, isDoc: false)
    }
    // MARK:- Button Action
    @objc func backBtnPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnSavePressed(_ sender: UIButton) {
        api_update_patient_info()
    }
    
    // MARK:- Button Action
    @IBAction func btnCameraPressed(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
}
