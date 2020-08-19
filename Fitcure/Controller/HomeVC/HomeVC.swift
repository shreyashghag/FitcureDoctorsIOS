//
//  HomeVC.swift
//  Fitcure
//
//  Created by Shashikant Bhadke on 01/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class HomeVC: UIViewController {
    
    // MARK:- Enums
    enum HomeSelectionTab { case ActiveConsults, CallRequest, ExpertOpinion}
    
    // MARK:- Outlets
    @IBOutlet weak var tableView            : UITableView!
    @IBOutlet weak var viewExpert           : ExpertOpenionView!
    @IBOutlet weak var btnActiveConsults    : UIButton!
    @IBOutlet weak var btnCallRequest       : UIButton!
    @IBOutlet weak var btnExpertOpinion     : UIButton!
    
    // MARK:- Variable
    var type = HomeSelectionTab.ActiveConsults
    var arrRequest = [PatientRequestModel]()
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        self.navigationItem.setTitle(.Home)
        self.view.backgroundColor = .f_ViewBack
        tableView.backgroundColor = .f_ViewBack
        
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.async {
            self.setHomeSelection(self.type)
        }
    }
    
    // MARK:- Button Action
    @IBAction private func btnHomeOptionsPressed(_ sender: UIButton) {
        switch sender {
        case btnActiveConsults:
            type = .ActiveConsults
            setHomeSelection(type)
        case btnCallRequest:
            type = .CallRequest
            setHomeSelection(type)
        case btnExpertOpinion:
            type = .ExpertOpinion
            setHomeSelection(type)
        default:
            break
        }
    }
    
    // MARK:- Custom Methods
    func setHomeSelection(_ type: HomeSelectionTab) {
        arrRequest = []
        btnActiveConsults.setTitleColor(.white, for: .normal)
        btnCallRequest.setTitleColor(.white, for: .normal)
        btnExpertOpinion.setTitleColor(.white, for: .normal)
        
        switch type {
        case .ActiveConsults:
            tableView.isHidden = false
            viewExpert.isHidden = true
            btnActiveConsults.setTitleColor(.black, for: .normal)
            getActiveListing()
            
        case .CallRequest:
            tableView.isHidden = false
            viewExpert.isHidden = true
            btnCallRequest.setTitleColor(.black, for: .normal)
            getPendingListing()
            
        case .ExpertOpinion:
            tableView.isHidden = true
            viewExpert.isHidden = false
            btnExpertOpinion.setTitleColor(.black, for: .normal)
        }
        tableView.reloadData()
    }
    
    func isAcceptRequest(_ obj: PatientRequestModel?, index: Int?) {
        guard let obj = obj, let index = index else { return }
        changeConsultationStatus(obj, isAccept: true, index: index)
    }
    func isRejectRequest(_ obj: PatientRequestModel?, index: Int?) {
        guard let obj = obj, let index = index else { return }
        changeConsultationStatus(obj, isAccept: false, index: index)
    }
    
    // MARK:- Push Methods
    func pushPastConsultDetailsVC(_ obj: PatientRequestModel?) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PastConsultantDetailsVC.self)) as? PastConsultantDetailsVC else { return }
        vc.showActive = true
        vc.obj = obj
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:- Deinit
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class
