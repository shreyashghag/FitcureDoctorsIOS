//
//  PastConsultsVC.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 06/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

class PastConsultsVC: UITableViewCell {
    
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
    func setData(_ obj: ConsultsModel) {
        lblName.text = obj.doctor ?? ""
        lblDate.text = obj.createdAt ?? ""
        imgvProfile.setImage(str: obj.profileImage)
        
        switch obj.isAccepted ?? 0 {
        case 0:
            lblStatus.text = "Pending"
        case 1:
            lblStatus.text = "Accepted"
        case -1:
            lblStatus.text = "Rejected"
        default:
            lblStatus.text = " - "
        }
    }
    
} //class
