//
//  HomeCell.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 01/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class HomeCell: UITableViewCell {

    // MARK:- Outlet
    @IBOutlet private weak var lblName          : UILabel!
    @IBOutlet private weak var lblYear          : UILabel!
    @IBOutlet private weak var lblAdd1          : UILabel!
    @IBOutlet private weak var lblAdd2          : UILabel!
    @IBOutlet private weak var viewBG           : UIView!
    @IBOutlet private weak var imgvProfile      : UIImageView!
    @IBOutlet private weak var collectionView   : UICollectionView!
    
    // MARK:- VAriables
    var arrTags = [String]()
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .f_ViewBack
        self.contentView.backgroundColor = .f_ViewBack
        viewBG.setCorner(withRadius: 10)
        imgvProfile.backgroundColor = .f_ViewBack
        imgvProfile.setCorner(withRadius: 5)
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Custom Methods
    func setDoctorData(_ obj: DoctorModel) {
        lblName.text = obj.name ?? ""
        lblYear.text = ""
        if let year = obj.workingSince {
            lblYear.text = "\(year)"
        }
        lblAdd1.text = obj.associateHospital ?? ""
        lblAdd2.text = obj.city ?? ""
        imgvProfile.setImage(str: obj.profileImage)
        
        arrTags = (obj.qualification ?? "").components(separatedBy: ", ")
        collectionView.reloadData()
    }
    
} //class

// MARK:- Extension For:-
extension HomeCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TagCell.self), for: indexPath) as? TagCell else { return TagCell() }
        cell.lblTitle.text = arrTags[indexPath.item]
        return cell
    }
} //extension
