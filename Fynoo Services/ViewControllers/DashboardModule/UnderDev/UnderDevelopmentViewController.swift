//
//  UnderDevelopmentViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya on 31/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class UnderDevelopmentViewController: UIViewController {

    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var downImage: UIImageView!
    @IBOutlet weak var comeSoonOutlet: UIButton!
    var showBack = false
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUIMethod()
    }
    
    func setupUIMethod(){
         downImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
            self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
            headerView.titleHeader.text = "Under Construction"
            self.headerView.viewControl = self
        if showBack{
            self.headerView.isHidden  = false
            self.headerView.backButton.isHidden = false
        }else{
              self.headerView.isHidden  = true
        self.headerView.backButton.isHidden = true
        }
          self.comeSoonOutlet.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: 132)
        }
            
    @IBAction func comeSoonBtn(_ sender: Any) {
    }
}
