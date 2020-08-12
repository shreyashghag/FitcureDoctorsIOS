//
//  FAQCell.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 09/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

class FAQCell: UITableViewCell {

    // MARK:- Outlet
    @IBOutlet private weak var imgvDropDown     : UIImageView!
    @IBOutlet private weak var lblQuestion	    : UILabel!
    @IBOutlet private weak var lblAnswer	    : UILabel!
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(_ strQuestion: String, _ strAnswer: String, isShow: Bool) {
        lblQuestion.text = strQuestion
        lblAnswer.text = strAnswer
        lblAnswer.isHidden = !isShow
        imgvDropDown.image = UIImage(named: !isShow ? "f_DropDown" : "f_DropUp")
    }
    
} //class
