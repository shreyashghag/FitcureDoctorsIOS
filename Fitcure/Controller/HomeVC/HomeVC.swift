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
    enum HomeSelectionTab { case Doctor, PastConsult }
    
    // MARK:- Outlets
    @IBOutlet weak var tableView    : UITableView!
    @IBOutlet weak var btnDoctor    : UIButton!
    @IBOutlet weak var btnPast      : UIButton!
    
    // MARK:- Variable
    var isLoading = false
    var intTotalDoctor = 0
    var intDoctorListPage = 1
    
    var type = HomeSelectionTab.Doctor
    
    var arrDoctors = [DoctorModel]()
    var arrPastConsults = [ConsultsModel]()
    
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
    @IBAction private func btnDoctorOrPastConsulantPressed(_ sender: UIButton) {
        switch sender {
        case btnDoctor:
            type = .Doctor
            setHomeSelection(type)
        case btnPast:
            type = .PastConsult
            setHomeSelection(type)
        default:
            break
        }
    }
    
    // MARK:- Custom Methods
    func setHomeSelection(_ type: HomeSelectionTab) {
        btnPast.setTitleColor(.white, for: .normal)
        btnDoctor.setTitleColor(.white, for: .normal)
        switch type {
        case .Doctor:
            intTotalDoctor = 0
            intDoctorListPage = 1
            
            btnDoctor.setTitleColor(.black, for: .normal)
            getDoctorListing()
        case .PastConsult:
            btnPast.setTitleColor(.black, for: .normal)
            getPastConsultsListing()
        }
        tableView.reloadData()
    }
    
    // MARK:- Push Methods
    func pushDoctorDetailsVC(_ obj: DoctorModel?) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: DoctorDetailsVC.self)) as? DoctorDetailsVC else { return }
        vc.obj = obj
        self.tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushPastConsultDetailsVC(_ obj: ConsultsModel?) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: PastConsultantDetailsVC.self)) as? PastConsultantDetailsVC else { return }
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
