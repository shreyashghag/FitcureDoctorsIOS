//
//  ProfileFooterCell.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 11/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class ProfileFooterCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet weak var btnAddMember: UIButton!
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        btnAddMember.setCorner(withRadius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

} //class
