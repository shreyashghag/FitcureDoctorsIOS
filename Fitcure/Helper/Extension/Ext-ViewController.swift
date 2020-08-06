//
//  Ext-ViewController.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 02/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

// MARK:- Extension For :- NVActivityIndicatorViewable
extension UIViewController: NVActivityIndicatorViewable {
    func showLoader() {
        DispatchQueue.main.async {
            self.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.stopAnimating()
        }
    }
} //extension
