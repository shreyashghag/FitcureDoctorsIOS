//
//  PatientProfileCell.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 11/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class PatientProfileCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet private weak var lblTitle     : UILabel!
    @IBOutlet private weak var lblName      : UILabel!
    @IBOutlet private weak var lblMobileNo  : UILabel!
    @IBOutlet private weak var lblEmail     : UILabel!
    @IBOutlet private weak var lblGender    : UILabel!
    @IBOutlet private weak var lblAge       : UILabel!
    @IBOutlet private weak var lblCity      : UILabel!
    @IBOutlet private weak var viewBG       : UIView!
    
    var indexPath: IndexPath?
    var onEditPressed: ((IndexPath)->())?
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBG.setShadow(cornerRadi: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK:- Custom Methods
    func setData(_ obj: FamilyModel?, index: IndexPath) {
        guard let obj = obj else { return }
        indexPath = index
        lblTitle.text = "Family Member \(index.row + 1)"
        lblName.text = obj.name ?? ""
        lblMobileNo.text = obj.mobile ?? ""
        lblEmail.text = obj.email ?? ""
        lblGender.text = obj.gender ?? ""
        lblAge.text = "\(obj.age ?? 0)"
        lblCity.text = obj.city ?? ""
    }
    
    func setData(_ obj: PatientModel?, index: IndexPath) {
        guard let obj = obj else { return }
        indexPath = index
        lblTitle.text = "Patient Information"
        lblName.text = obj.name ?? ""
        lblMobileNo.text = obj.mobile ?? ""
        lblEmail.text = obj.email ?? ""
        lblGender.text = obj.gender ?? ""
        lblAge.text = "\(obj.age ?? 0)"
        lblCity.text = obj.city ?? ""
    }
    
    // MARK:- Edit Methods
    @IBAction private func btnEditPressed() {
        guard let index = indexPath else { return }
        onEditPressed?(index)
    }
    
} //class
