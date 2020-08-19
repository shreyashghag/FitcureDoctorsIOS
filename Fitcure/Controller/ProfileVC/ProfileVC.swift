//
//  ProfileVC.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 01/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

final class ProfileVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet private weak var viewMain         : UIView!
    @IBOutlet private weak var viewProfileBack  : UIView!
    @IBOutlet private weak var viewProfile      : UIView!
    @IBOutlet private weak var imgvProfile      : UIImageView!
    @IBOutlet private weak var btnEdit          : UIButton!
    
    @IBOutlet private weak var lblName          : UILabel!
    @IBOutlet private weak var lblDegree        : UILabel!
    @IBOutlet private weak var lblEmail         : UILabel!
    @IBOutlet private weak var lblMobileNo      : UILabel!
    @IBOutlet private weak var lblWorkingSince  : UILabel!
    @IBOutlet private weak var lblAssociateHos  : UILabel!
    @IBOutlet private weak var lblLanguage      : UILabel!
    @IBOutlet private weak var lblRegisNo       : UILabel!
    @IBOutlet private weak var lblCity          : UILabel!
        
    // MARK:- Variable
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
        
    // MARK:- SetUpView
    private func setUpView() {
        self.navigationItem.setTitle(.Profile)
        viewProfile.setCorner(withRadius: viewProfile.frame.height * 0.5)
        imgvProfile.setCorner(withRadius: imgvProfile.frame.height * 0.5)
    }

    // MARK:- Button Action
    @objc func btnAddFamilyMemberPressed() {
        pushAddFamilyMemberVC()
    }
    
    // MARK:- Custom Methods
        
    
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
