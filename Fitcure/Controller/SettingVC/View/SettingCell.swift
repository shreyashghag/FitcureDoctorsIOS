//
//  SettingCell.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 01/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class SettingCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet private weak var viewSeperator    : UIView!
    @IBOutlet private weak var imgvIcon         : UIImageView!
    @IBOutlet private weak var lblTitle         : UILabel!
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSeperator.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Custom Methods
    func setHeaderTitle(_ strTitle: String, _ showSeperator: Bool = false) {
        lblTitle.font = UIFont.boldSystemFont(ofSize: 14)
        lblTitle.text = strTitle
        lblTitle.textColor = .f_AppColor
        imgvIcon.isHidden = true
        viewSeperator.isHidden = !showSeperator
    }
    
    func setData(_ type: SettingVC.SettingOptions) {
        lblTitle.font = UIFont.systemFont(ofSize: 16)
        lblTitle.text = type.rawValue
        
        switch type {
        case .PrivacyPolicy:
            imgvIcon.image = UIImage(named: "f_DataPolicy")
        case .TermsAndCondition, .FAQ:
            imgvIcon.image = UIImage(named: "f_TAndC")
        case .Report:
            imgvIcon.image = UIImage(named: "f_Report")
        case .RateUs:
            imgvIcon.image = UIImage(named: "f_Rate")
        case .Logout:
            imgvIcon.image = UIImage(named: "f_Logout")
        }
    }

} //class
