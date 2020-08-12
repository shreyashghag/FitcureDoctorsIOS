//
//  PastConsultsVC.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 06/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

class PastConsultsCell: UITableViewCell {
    
    // MARK:- Outlet
    @IBOutlet private weak var lblName          : UILabel!
    @IBOutlet private weak var lblDate          : UILabel!
    @IBOutlet private weak var btnAccept        : UIButton!
    @IBOutlet private weak var btnReject        : UIButton!
    @IBOutlet private weak var viewBG           : UIView!
    @IBOutlet private weak var imgvProfile      : UIImageView!
    
    // MARK:- Variables
    var obj: PatientRequestModel?
    var onDeletePressed:((PatientRequestModel?)->())
    var onAcceptPressed:((PatientRequestModel?)->())
    
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .f_ViewBack
        self.contentView.backgroundColor = .f_ViewBack
        viewBG.setCorner(withRadius: 10)
        imgvProfile.setCorner(withRadius: 5)
        imgvProfile.backgroundColor = .f_ViewBack
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Custom Methods
    func setData(_ type: HomeVC.HomeSelectionTab, _ obj: PatientRequestModel) {
        self.obj = obj
        btnAccept.isHidden = !(type == .CallRequest)
        btnReject.isHidden = !(type == .CallRequest)
        
        lblName.text = obj.patient ?? ""
        lblDate.text = String.getDate(obj.createdAt)
        imgvProfile.setImage(str: obj.profileImage, isDoc: false)
    }
    
    // MARK:- Button Action Methods
    @IBAction private func btnAcceptPressed() {
        onAcceptPressed?(obj)
    }
    @IBAction private func btnRejectPressed() {
        onDeletePressed?(obj)
    }
    
} //class
