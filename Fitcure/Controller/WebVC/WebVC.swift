//
//  WebVC.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 20/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import WebKit

final class WebVC: UIViewController {
    
    // MARK:- Outlets
    
    // MARK:- Variables
    var strUrl = ""
    var strTitle = ""
    var localFilePath: URL?
    var webView: WKWebView!
    var isPrivacyPolicy = false
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        self.navigationItem.setTitle(strTitle)
        let backBtn = UIBarButtonItem(image: UIImage(named: "f_back"), style: .plain, target: self, action: #selector(btnBackPressed))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        if let url = URL(string: strUrl) {
            let request = URLRequest(url: url)
            webView.load(request)
        } else if let path = localFilePath {
            let request = URLRequest(url: path)
            webView.load(request)
        }
    }
    
    // MARK:- Button Actions
    @objc private func btnBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK:- Custom Methods
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:-
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class

// MARK:- Extension For :- WKNavigationDelegate
extension WebVC: WKNavigationDelegate {
    
} //extension
