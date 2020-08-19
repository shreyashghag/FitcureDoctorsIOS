//
//  StoryboardExampleViewController.swift
//  SwiftyOnboardExample
//
//  Created by Jay on 3/27/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit
import SwiftyOnboard

class StoryboardExampleViewController: UIViewController {

    @IBOutlet weak var swiftonboard: SwiftyOnboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swiftonboard.style = .light
        swiftonboard.delegate = self
        swiftonboard.dataSource = self
        swiftonboard.backgroundColor = UIColor.white
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController?.isNavigationBarHidden = true
       }
    
    @objc func handleSkip() {
        swiftonboard?.goToPage(index: 2, animated: true)
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        print("index==",index)
        if(index == 2)
        {
            pushToSignUpVC()
        }
        swiftonboard?.goToPage(index: index + 1, animated: true)
    }
    // MARK:- Push Methods
      private func pushToSignUpVC() {
          guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SignUpVC.self)) as? SignUpVC else { return }
          self.navigationController?.setViewControllers([vc], animated: true)
      }
}

extension StoryboardExampleViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 3
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = CustomPage.instanceFromNib() as? CustomPage
        view?.image.image = UIImage(named: "w\(index).png")
        if index == 0 {
            //On the first page, change the text in the labels to say the following:
            view?.titleLabel.text = "Scheduling Appointments"
            view?.subTitleLabel.text = "Doctors can schedule appointments as per their needs. "
        } else if index == 1 {
            //On the second page, change the text in the labels to say the following:
            view?.titleLabel.text = "Update your Profile"
            view?.subTitleLabel.text = "Doctors can update their profile."
        } else {
            //On the thrid page, change the text in the labels to say the following:
            view?.titleLabel.text = "Doctor's Consulation"
            view?.subTitleLabel.text = "Doctors can consult patient through a video call"
        }
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = CustomOverlay.instanceFromNib() as? CustomOverlay
        overlay?.skip.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay?.buttonContinue.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let overlay = overlay as! CustomOverlay
        let currentPage = round(position)
        overlay.contentControl.currentPage = Int(currentPage)
        overlay.buttonContinue.tag = Int(position)
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.buttonContinue.setTitle("Continue", for: .normal)
            overlay.skip.setTitle("Skip", for: .normal)
            overlay.skip.isHidden = false
        } else {
            overlay.buttonContinue.setTitle("Get Started!", for: .normal)
            overlay.skip.isHidden = true
        }
    }
}
