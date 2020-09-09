//
//  PrescriptionVC.swift
//  Fitcure
//
//  Created by Avinash Khairgave on 07/09/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SafariServices

import PDFKit

class PrescriptionVC: UIViewController {
    
    var pdfUrl = ""
    var obj: PatientRequestModel?
    fileprivate var outputAsData: Bool = false
    
    fileprivate func getImagePath(_ number: Int) -> String {
        return Bundle.main.path(forResource: "sample_\(number)", ofType: "jpg")!
    }
    
    fileprivate func getDestinationPath(_ number: Int) -> String {
        return NSHomeDirectory() + "/sample\(number).pdf"
    }
  
    
    @IBOutlet weak var adviceTxtFild: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var youTubeTxtFild: SkyFloatingLabelTextField!
    
    @IBOutlet weak var sendPrecrpBtn: UIButton!
    
    
    @IBOutlet weak var viewPrecrpBtn: UIButton!
    
    
    @IBAction func sendBtnClick(_ sender: UIButton) {
        generateSamplePDFFromViews()
        
    }
    
    @IBAction func viewPrecrpBtnClick(_ sender: UIButton) {
        openPDFViewer()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    // MARK:- SetUpView
    private func setUpView() {
        setUpNavigation()
        sendPrecrpBtn.isEnabled = false
        sendPrecrpBtn.alpha = 0.4
        viewPrecrpBtn.isEnabled = false
        viewPrecrpBtn.alpha = 0.4
        setUpTextField()
        [adviceTxtFild, youTubeTxtFild].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        
        
        
        
    }
    func generateSamplePDFFromViews() {
        
        api_sendPrescription()
        
        
    }
    
    fileprivate func openPDFViewer() {
        
        if pdfUrl.isEmpty || pdfUrl == ""{
            
            
        }
        else{
            if #available(iOS 9.0, *) {
                print(pdfUrl)
                let urlString:String = APICall.ViewPresecription+pdfUrl
                let encodeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //This will fill the spaces with the %20
               // let url = URL(string: APICall.ViewPresecription+pdfUrl)
                if let url = URL(string:encodeUrlString!){
                     let svc = SFSafariViewController(url:url)
                      self.present(svc, animated: true, completion: nil)
                    
                    
                }
               
            }
                
            else {
                
                
                
            }
        }
        
    }
    
    
    func test (markupText:String){
        
        let fmt = UIMarkupTextPrintFormatter(markupText: markupText)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect+
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        let printable = page.insetBy(dx: 0, dy: 0)
        
        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
        
        // 4. Create PDF context and draw
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: 0, height: 0), nil)
        
        for i in 1...render.numberOfPages
        {
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path  = "\(documentsPath)/file.pdf"
        pdfData.write(toFile: path, atomically: true)
        print("open \(path)")
        
        
        // print("open \(path)")
    }
    func createPDF(html: String, formmatter: UIViewPrintFormatter, filename: String) -> String {
        // From: https://gist.github.com/nyg/b8cd742250826cb1471f
        
        print("createPDF: \(html)")
        
        // 2. Assign print formatter to UIPrintPageRenderer
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(formmatter, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        let printable = page.insetBy(dx: 0, dy: 0)
        
        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
        
        // 4. Create PDF context and draw
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)
        
        for i in 1...render.numberOfPages {
            
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file
        let path = "\(NSTemporaryDirectory())\(filename).pdf"
        pdfData.write(toFile: path, atomically: true)
        print("open \(path)")
        
        return path
    }
    private func setUpTextField() {
        
        
        adviceTxtFild.returnKeyType = .next
        youTubeTxtFild.returnKeyType = .next
        
        
        
        for txtf in [youTubeTxtFild, adviceTxtFild] {
            txtf?.selectedTitleColor = .f_AppColor
            txtf?.tintColor = .f_AppColor
            txtf?.textColor = .darkText
            
        }
        
    }
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let num = adviceTxtFild.text, !num.isEmpty,
            let email = youTubeTxtFild.text,!email.isEmpty
            
            
            else {
                sendPrecrpBtn.isEnabled = false
                sendPrecrpBtn.alpha = 0.4
                viewPrecrpBtn.isEnabled = false
                viewPrecrpBtn.alpha = 0.4
                return
        }
        sendPrecrpBtn.isEnabled = true
        sendPrecrpBtn.alpha = 1.0
        viewPrecrpBtn.isEnabled = true
        viewPrecrpBtn.alpha = 1.0
        
    }
    
    func setUpNavigation() {
        self.navigationItem.setTitle(.Prescription)
        let backBtn = UIBarButtonItem(image: UIImage(named: "f_back"), style: .plain, target: self, action: #selector(backBtnPressed(_:)))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    @objc func backBtnPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
