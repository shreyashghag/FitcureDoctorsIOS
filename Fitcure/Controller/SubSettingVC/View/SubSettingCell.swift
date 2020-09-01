//
//  SubSettingCell.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 01/09/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

class SubSettingCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet private weak var viewBack         : UIView!
    @IBOutlet private weak var lblTitle         : UILabel!
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        viewBack.setCorner(withRadius: 10)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Custom Methods
    func setData(_ strText: String) {
        lblTitle.text = strText
    }
    
} //class
