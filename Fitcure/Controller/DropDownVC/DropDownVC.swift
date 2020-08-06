//
//  DropDownVC.swift
//  MarketPlace
//
//  Created by Shashikant's_Macmini on 22/04/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class DropDownVC: UIViewController {

    enum DropDownType {
        case Relations
    }
    // MARK:- Outlets
    @IBOutlet private weak var lblHeader    : UILabel!
    @IBOutlet private weak var viewHeader	: UIView!
    @IBOutlet private weak var tableView    : UITableView!
    
    // MARK:- Variables
    var _preferredContentSize: CGSize?
    var type: DropDownType = .Relations
    var strTitle = ""
    var arrListing = [Any]()
    var onValueSelection: ((Any)->())?
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let size = _preferredContentSize {
            self.preferredContentSize = size
        }
        
        lblHeader.text = strTitle
        viewHeader.isHidden = strTitle.isEmpty
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
} //class

// MARK:- Extension For :- UITableViewDelegate
extension DropDownVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch type {
        case .Relations:
            if arrListing.count > indexPath.row {
                onValueSelection?(arrListing[indexPath.row])
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
} //extension

// MARK:- Extension For :- UITableViewDataSource
extension DropDownVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .Relations:
            return arrListing.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DropDownCell.self), for: indexPath) as? DropDownCell else { return DropDownCell() }
        switch type {
        case .Relations:
            if let obj = arrListing[indexPath.row] as? RelationModel {
                cell.lblTitle.text = obj.relation ?? ""
            } else if let obj = arrListing[indexPath.row] as? FamilyModel {
                cell.lblTitle.text = obj.name ?? ""
            }
        }
        return cell
    }
} //extension

