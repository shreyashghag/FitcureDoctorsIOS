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
    @IBOutlet private weak var viewBG       : UIView!
    @IBOutlet private weak var imgvDoc      : UIImageView!
    @IBOutlet private weak var lblTitle     : UILabel!
    @IBOutlet private weak var btnDelete    : UIButton!
    @IBOutlet private weak var btnView      : UIButton!
    
    // MARK:- Variables
    var index: Int?
    var onDeleteBtnPressed: ((Int)->())?
    var onViewBtnPressed: ((Int)->())?
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBG.setCorner(withRadius: 10)
        btnDelete.isHidden = true
        btnView.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Custom Methods
    func setData(_ index: Int, _ obj: UploadDocVC.DocModel) {
        self.index = index
        lblTitle.text = obj.type.rawValue
        btnDelete.isHidden = obj.localFilePath == nil
        btnView.isHidden = obj.localFilePath == nil
        
    }
    
    // MARK:- Button Action Methods
    @IBAction private func btnViewPressed() {
        guard let index = index else { return }
        onViewBtnPressed?(index)
    }
    @IBAction private func btnDeletePressed() {
        guard let index = index else { return }
        btnDelete.isHidden = true
        btnView.isHidden = true
        onDeleteBtnPressed?(index)
    }
    
} //class
