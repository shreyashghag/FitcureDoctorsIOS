//
//  UploadDocCell.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 20/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class UploadDocCell: UITableViewCell {
    
    // MARK:- Outlet
    @IBOutlet private weak var viewBG   : UIView!
    @IBOutlet private weak var imgvDoc  : UIImageView!
    @IBOutlet private weak var lblTitle : UILabel!
    
    // MARK:- Variables
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBG.setCorner(withRadius: 10)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Custom Methods
    func setData(_ type: UploadDocVC.DocType) {
        lblTitle.text = type.rawValue
    }
    
} //class
