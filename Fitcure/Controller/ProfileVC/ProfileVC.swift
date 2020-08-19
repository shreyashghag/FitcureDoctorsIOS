//
//  ProfileVC.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 01/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class ProfileVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet private weak var viewMain         : UIView!
    @IBOutlet private weak var viewProfileBack  : UIView!
    @IBOutlet private weak var viewProfile      : UIView!
    @IBOutlet weak var tableView                : UITableView!
    @IBOutlet weak var imgvProfile              : UIImageView!
    
    // MARK:- Variable
    var patientObj: PatientModel?
    var arrFamilyMember = [FamilyModel]()
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
        
    // MARK:- SetUpView
    private func setUpView() {
        DispatchQueue.main.async {            
//            self.viewMain.setShadow(cornerRadi: 10)
//            self.viewProfileBack.roundCorner(corners: [.topLeft, .topRight], radius: 10)
//            self.viewProfile.setCorner(withRadius: self.viewProfile.frame.height * 0.5)
//            self.imgvProfile.setCorner(withRadius: self.imgvProfile.frame.height * 0.5)
//              self.getPatientInfo()
        }
                        
        self.navigationItem.setTitle(.Profile)
    }

    // MARK:- Button Action
    @objc func btnAddFamilyMemberPressed() {
        pushAddFamilyMemberVC()
    }
    
    // MARK:- Custom Methods
    func onEditPressed(_ indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1, indexPath.row < arrFamilyMember.count {
            let objFamily = arrFamilyMember[indexPath.row]
            self.pushAddFamilyMemberVC(objFamily)
        }
    }
    
    
    // MARK:- Push Methods
    func pushAddFamilyMemberVC(_ obj: FamilyModel? = nil) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: AddFamilyMemberVC.self)) as? AddFamilyMemberVC else { return }
        vc.obj = obj
        self.navigationController?.pushViewController(vc, animated: true)
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
