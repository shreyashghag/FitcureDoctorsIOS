//
//  UploadDocVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 20/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class UploadDocVC: UIViewController {
    
    // MARK:- Doc Enums
    struct DocModel {
        var type: DocType
        var localFilePath: URL? = nil
        
        static func getListing()->[DocModel] {
            var arr = [DocModel]()
            arr.append(DocModel(type: .Aadhaar))
            arr.append(DocModel(type: .DegreeCertificate))
            arr.append(DocModel(type: .RegistrationNumber))
            arr.append(DocModel(type: .CanceledCheque))
            return arr
        }
    }
    
    enum DocType: String {
        case Aadhaar            = "Upload Aadhaar Card Front and Back"
        case DegreeCertificate  = "Upload Degree Certificate"
        case RegistrationNumber = "Upload Registration Number"
        case CanceledCheque     = "Upload Canceled Cheque"
        case None               = ""
    }
    
    // MARK:- Outlet
    @IBOutlet private weak var lblTitle     : UILabel!
    @IBOutlet weak var tableView            : UITableView!
    
    // MARK:- Variables
    var strMobileNo = ""
    var selectedType: DocType?
    var arrDocs = [DocModel]()
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        setUpNavigation()
        arrDocs = DocModel.getListing()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpNavigation() {
        self.navigationItem.setTitle(.UploadDoc)
        let backBtn = UIBarButtonItem(image: UIImage(named: "f_back"), style: .plain, target: self, action: #selector(btnBackPressed))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    // MARK:- Button Actions
    @objc private func btnBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func btnUploadFilePressed() {
        api_UploadDocs()
    }
    
    // MARK:- Custom Methods
    func pushWebVC(_ strTitle: String, _ path: URL) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: WebVC.self)) as? WebVC else { return }
        vc.strTitle = strTitle
        vc.localFilePath = path
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToSignUpVC() {
        guard
            let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SignUpVC.self)) as? SignUpVC,
            let vc1 = self.storyboard?.instantiateViewController(withIdentifier: String(describing: LoginVC.self)) as? LoginVC
            else { return }
        self.navigationController?.setViewControllers([vc, vc1], animated: true)
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
