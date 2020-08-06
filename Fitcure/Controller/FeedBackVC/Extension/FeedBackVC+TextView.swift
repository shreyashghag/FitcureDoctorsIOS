//
//  FeedBackVC+TextView.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 20/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- UITextViewDelegate
extension FeedBackVC: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor == UIColor.lightGray {
            textView.textColor = .black
            textView.text = ""
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = "Enter you review"
        }
    }
    
} //extension
