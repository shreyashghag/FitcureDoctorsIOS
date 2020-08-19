//
//  ExpertOpenionView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 19/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

final class ExpertOpenionView: UIView {

    // MARK:- Outlets
    @IBOutlet weak var viewBG           : UIView!
    @IBOutlet weak var txtfName         : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfAge          : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfAgreevating  : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfChiefCompl   : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfHistory      : SkyFloatingLabelTextField!
    @IBOutlet weak var txtfOtherIssue   : SkyFloatingLabelTextField!
    @IBOutlet weak var segGender        : UISegmentedControl!
    @IBOutlet weak var btnSubmit        : UIButton!
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        viewBG.setCorner(withRadius: 10)
        btnSubmit.setCorner(withRadius: 5)
    }
    
    // MARK:- Custom Methods

} //class
