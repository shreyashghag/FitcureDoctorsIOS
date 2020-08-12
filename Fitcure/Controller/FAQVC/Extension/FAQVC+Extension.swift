//
//  FAQVC+Extension.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 09/08/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- UITableViewDelegate
extension FAQVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrFAQ[indexPath.row].isShow.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
} //extension

// MARK:- Extension For :- UITableViewDataSource
extension FAQVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFAQ.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FAQCell.self), for: indexPath) as? FAQCell else { return FAQCell() }
        cell.setData(arrFAQ[indexPath.row].strQuestion, arrFAQ[indexPath.row].strAnswer, isShow: arrFAQ[indexPath.row].isShow)
        return cell
    }
} //extension
