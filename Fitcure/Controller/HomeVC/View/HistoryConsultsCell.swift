//
//  HistoryConsultsCell.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 12/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

class HistoryConsultsCell: UITableViewCell {
    
    // MARK:- Outlet
    @IBOutlet private weak var lblName          : UILabel!
    @IBOutlet private weak var lblDate          : UILabel!
    @IBOutlet private weak var lblStatus        : UILabel!
    @IBOutlet private weak var viewBG           : UIView!
    @IBOutlet private weak var imgvProfile      : UIImageView!
    
    // MARK:- Variables
    
    
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
    func setData(_ obj: PatientRequestModel) {
        lblName.text = obj.patient ?? ""
        lblDate.text = String.getDate(obj.createdAt)
        imgvProfile.setImage(str: obj.profileImage, isDoc: false)
        
        switch obj.isAccepted ?? 0 {
        case 0:
            lblStatus.textColor = .white
            lblStatus.text = "Pending"
            lblStatus.backgroundColor = .yellow
        case 1:
            lblStatus.textColor = .white
            lblStatus.text = "Accepted"
            lblStatus.backgroundColor = .blue
        case -1:
            lblStatus.textColor = .white
            lblStatus.text = "Rejected"
            lblStatus.backgroundColor = .red
        default:
            lblStatus.textColor = .black
            lblStatus.backgroundColor = .clear
            lblStatus.text = " - "
        }
        lblStatus.setCorner(withRadius: 5)
    }
    
} //class
