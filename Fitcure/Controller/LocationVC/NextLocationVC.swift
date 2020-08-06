//
//  NextLocationVC.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 02/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class NextLocationVC: UIViewController {
    var newString: NSString = ""
    var location = ""
    @IBOutlet weak var btnSave: UIButton!
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        location = "\(buildText.text ?? "") , \(streetText.text ?? "") ,\(areaText.text ?? "") ,\(cityText.text ?? "")"
        UserData.saveData(.currentLocation, location)
        pushCreatePatientVC()
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!
    @IBOutlet weak var buildText: SkyFloatingLabelTextField!
    @IBOutlet weak var streetText: SkyFloatingLabelTextField!
    @IBOutlet weak var areaText: SkyFloatingLabelTextField!
    @IBOutlet weak var cityText: SkyFloatingLabelTextField!
    
    
    @IBAction func saveNextClick(_ sender: UIButton) {
        
        
    }
    
    
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpTextField()
        [buildText, streetText, areaText,cityText].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        // Add touch gesture for contentView
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnTextView(gesture:))))
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        btnSave.isEnabled = false
        btnSave.alpha = 0.4
        setUpTextField()
        [buildText, streetText, areaText,cityText].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        setUpNavigation()
    }
    func setUpNavigation() {
        self.navigationItem.setTitle(.YourAddress)
        let backBtn = UIBarButtonItem(image: UIImage(named: "f_back"), style: .plain, target: self, action: #selector(backBtnPressed(_:)))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
    }
        
    private func setUpTextField() {
        
        buildText.returnKeyType = .next
        streetText.returnKeyType = .next
        areaText.returnKeyType = .next
        cityText.returnKeyType = .next
        
        
        for txtf in [buildText, streetText, areaText, cityText,] {
            txtf?.selectedTitleColor = .f_AppColor
            txtf?.tintColor = .darkText
            txtf?.textColor = .darkText
            txtf?.delegate = self
        }
        
        
    }
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let build = buildText.text, !build.isEmpty,
            let street = streetText.text, !street.isEmpty,
            let area = areaText.text, !area.isEmpty,(areaText.text?.count)!>=4,
            let city = cityText.text, !city.isEmpty,(cityText.text?.count)!>=1
            
            
            else {
                btnSave.isEnabled = false
                btnSave.alpha = 0.4
                return
        }
        btnSave.isEnabled = true
        btnSave.alpha = 1.0
    }
    // MARK:- Custom Methods
    @objc func backBtnPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:- Deinit
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    func pushCreatePatientVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CreatePatientVC.self)) as? CreatePatientVC else { return }
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    @objc func returnTextView(gesture: UIGestureRecognizer) {
        guard activeField != nil else {
            return
        }
        
        activeField?.resignFirstResponder()
        activeField = nil
    }
    
}

