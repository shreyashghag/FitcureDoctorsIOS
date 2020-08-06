//
//  LocationVC.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 02/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import CoreLocation
import SkyFloatingLabelTextField

class LocationVC: UIViewController {
    
    @IBOutlet weak var saveNextbtn: UIButton!
    @IBOutlet weak var locationText: UILabel!
    
    var locationManager = CLLocationManager()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveNextbtn.isEnabled = false
        saveNextbtn.alpha = 0.4
        setUpNavigation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setUpNavigation() {
        self.navigationItem.setTitle(.YourAddress)
        let backBtn = UIBarButtonItem(image: UIImage(named: "f_back"), style: .plain, target: self, action: #selector(backBtnPressed(_:)))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    @objc func backBtnPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveNextBtn(_ sender: UIButton) {
        pushCreatePaientVC()
    }
    
    @IBAction func getCurrentLocation(_ sender: UIButton) {
        locateMe()
    }
    
    @IBAction func enterManuallyClick(_ sender: UIButton) {
        pushNextLocationVC()
    }
    
    func pushNextLocationVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: NextLocationVC.self)) as? NextLocationVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func pushCreatePaientVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CreatePatientVC.self)) as? CreatePatientVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func locateMe() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = pdblLatitude
        //21.228124
        let lon: Double = pdblLongitude
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    self.locationText.text = addressString
                    print(addressString)
                    self.saveNextbtn.isEnabled = true
                    self.saveNextbtn.alpha = 1.0
                    UserData.saveData(.currentLocation, addressString)
                    
                }
        })
    }
}


extension LocationVC:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        getAddressFromLatLon(pdblLatitude: userLocation.coordinate.latitude, withLongitude: userLocation.coordinate.longitude)
    }
}
