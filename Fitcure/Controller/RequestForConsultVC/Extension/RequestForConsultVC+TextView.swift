//
//  RequestForConsultVC+TextView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 04/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- UITextViewDelegate
extension RequestForConsultVC: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor == UIColor.lightGray {
            textView.textColor = .black
            textView.text = ""
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.isEmpty {
            return true
        }        
        return (text + textView.text).count <= 300
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = strPlaceHolder
        }
    }
    
} //extension
