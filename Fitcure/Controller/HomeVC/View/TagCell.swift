//
//  TagCell.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 01/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class TagCell: UICollectionViewCell {
    
    // MARK:- Outlet
    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        self.backgroundColor = .f_AppColor
        lblTitle.textColor = .white
    }
    
    // MARK:- Custom Methods
    
} //class
