//
//  SignaturePopUpVC.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 07/09/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import DrawSignatureView
protocol CreateDoctorVCDelegate: class {
    /// Remobve Calendar View
    func removePopUpView() 
       
    func selectedDigitalSig(digitalSig:UIImage)
}


final class SignaturePopUpVC: UIViewController {
        weak var delegate: CreateDoctorVCDelegate?
     // MARK:- Outlets
        @IBOutlet private weak var viewMain : UIView!
        @IBOutlet weak var signatureView: DrawSignatureView!
        @IBOutlet private weak var lblHeader: UILabel!

        @IBOutlet private weak var btnBack  : UIButton!
        @IBOutlet private weak var btnOkey  : UIButton!
        
        // MARK:- Variables
        
        // MARK:- View Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()
            setUpView()
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            UIView.animate(withDuration: 0.5) {
                self.btnBack.backgroundColor = .black
            }
        }
        
        // MARK:- SetUpView
        private func setUpView() {
            viewMain.setCorner(withRadius: 10)

            signatureView.layer.borderWidth = 0.5
            signatureView.layer.borderColor = UIColor.black.cgColor
            signatureView.layer.cornerRadius = 10
            self.signatureState()
        }
    /// Signature State by CallBack
     private func signatureState() {
     
       self.signatureView.currentTouchState = { [weak self] (touchState) in
        
         switch touchState {
             
         case .began:
           print("began")
          
         case .moved:
           print("moved")
         case .ended:
           print("ended")
         case .none:
           print("none")
         }
       }
     }
        
    @IBAction func clearBtnTapped(_ sender: UIButton) {
           
        
        self.signatureView.erase()
           
       }
        // MARK:- Button Actions
        @IBAction private func btnOkeyPressed() {
           // self.dismiss(animated: true, completion: nil)
            
            self.signatureView.captureSignature { [weak self] (signature) in
                   if let signature = signature {
                    print("Capture Signature: \(signature.image)")
                    print("Capture time: \(signature.date)")
                    delegate?.selectedDigitalSig(digitalSig: signature.image)
                    delegate?.removePopUpView()
                    //self?.dismiss(animated: true, completion: nil)
                   }
                  }
        }
        @IBAction private func btnBackPressed() {
            self.dismiss(animated: true, completion: nil)
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
