//
//  UploadFooterCell.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 20/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class UploadFooterCell: UITableViewCell {

    // MARK:- Outlet
    @IBOutlet private weak var btnUpload: UIButton!
    
    // MARK:- Variables
    var onUploadPressed: (()->())?
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        btnUpload.setCorner(withRadius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK:- Button Action
    @IBAction private func btnUploadPressed(_ sender: UIButton) {
        onUploadPressed?()
    }
    
} //class
