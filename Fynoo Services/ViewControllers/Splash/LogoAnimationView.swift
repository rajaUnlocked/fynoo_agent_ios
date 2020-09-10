//
//  LogoAnimationView.swift
//  AnimatedGifLaunchScreen-Example
//
//  Created by Amer Hukic on 13/09/2018.
//  Copyright © 2018 Amer Hukic. All rights reserved.
//

import UIKit
import SwiftyGif

class LogoAnimationView: UIView {
    
    let logoGifImageView: UIImageView = {
        guard let gifImage = try? UIImage(gifName: "logo-animeted.gif") else {
            return UIImageView()
        }
        return UIImageView(gifImage: gifImage, loopCount: 1)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
       let height = ModalController.getTheContentForKey("height")        
        let width = ModalController.getTheContentForKey("width")
//        backgroundColor = UIColor(white: 246.0 / 255.0, alpha: 1)
        backgroundColor = UIColor.clear
        addSubview(logoGifImageView)
        logoGifImageView.contentMode = .scaleAspectFit
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.widthAnchor.constraint(equalToConstant: width as! CGFloat).isActive = true
        logoGifImageView.heightAnchor.constraint(equalToConstant: height as! CGFloat).isActive = true
    }
}
