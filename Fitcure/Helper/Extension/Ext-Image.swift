//
//  Ext-Image.swift
//  Fitcure
//
//  Created by Shashikant's_Macmini on 04/07/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import Kingfisher

// MARK:- Extension for - UIImage
extension UIImage {
    func fixOrientation() -> UIImage? {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }

        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
} //extension

// MARK:- Extension for:- UIImageView
extension UIImageView {

    func setImage(str: String?, _ placeholderImageName: String = "f_placeholder", isDoc: Bool = true) {
        var str = str ?? ""
        if str.contains(" ") {
            str = str.replacingOccurrences(of: " ", with: "%20")
        }
        guard !str.isEmpty, let url = URL(string: (isDoc ? APICall.DocImgBaseURL : APICall.PaiImgBaseURL) + str) else { return }
        let scale = UIScreen.main.scale
        let imgsize = CGSize(width: self.frame.size.width * scale, height: self.frame.size.height * scale)
        let resizeProcessor = ResizingImageProcessor(referenceSize: imgsize)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeholderImageName.isEmpty ? nil : UIImage(named: placeholderImageName), options: [.fromMemoryCacheOrRefresh, .processor(resizeProcessor), .transition(.fade(0.2))])
    }
    func setImageWithoutResize(str: String?, _ placeholderImageName: String = "f_placeholder", isDoc: Bool = true) {
        var str = str ?? ""
        if str.contains(" ") {
            str = str.replacingOccurrences(of: " ", with: "%20")
        }
        guard !str.isEmpty, let url = URL(string: (isDoc ? APICall.DocImgBaseURL : APICall.PaiImgBaseURL) + str) else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeholderImageName.isEmpty ? nil : UIImage(named: placeholderImageName), options: [.fromMemoryCacheOrRefresh, .transition(.fade(0.2))])
    }
    
    func cancelImgDownload() {
        self.kf.cancelDownloadTask()
    }
    
    func addGradientBlack(sHeight: CGFloat = 60) {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
                
        let width = self.bounds.width
        let height = self.bounds.height
        let shadow = UIColor.black.withAlphaComponent(0.6).cgColor

        // Add gradient bar for image on top
        let topImageGradient = CAGradientLayer()
        topImageGradient.frame = CGRect(x: 0, y: 0, width: width, height: sHeight)
        topImageGradient.colors = [shadow, UIColor.clear.cgColor]
        layer.insertSublayer(topImageGradient, at: 0)

        let bottomImageGradient = CAGradientLayer()
        bottomImageGradient.frame = CGRect(x: 0, y: height - sHeight, width: width, height: sHeight)
        bottomImageGradient.colors = [UIColor.clear.cgColor, shadow]
        layer.insertSublayer(bottomImageGradient, at: 0)
    }
    
} //extension
