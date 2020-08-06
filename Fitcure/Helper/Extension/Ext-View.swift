//
//  Ext-View.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 29/06/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- UIView
extension UIView {
    
    func addRoundedBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.name = "masklayer"
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width
            , height: width)
        border.cornerRadius = width*0.5
        clipsToBounds = true
        self.layer.addSublayer(border)
    }
    
    func setCorner(withRadius radii: CGFloat = 5.0) {
        layer.cornerRadius = radii
        layer.masksToBounds = true
    }
    
    func setBorder(withRadius radii: CGFloat = 5.0) {
        layer.cornerRadius = radii
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.masksToBounds = true
    }
    
    func setShadow(clr: UIColor = .darkGray, sRadius: CGFloat = 4.0, cornerRadi: CGFloat = 5) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadi
        self.layer.shadowRadius  = sRadius
        self.layer.shadowColor   = clr.cgColor
        self.layer.shadowOffset  = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowOpacity = 0.3
        self.layer.contentsScale = UIScreen.main.scale
        
    }
    
    func roundCorner(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
} //extension
