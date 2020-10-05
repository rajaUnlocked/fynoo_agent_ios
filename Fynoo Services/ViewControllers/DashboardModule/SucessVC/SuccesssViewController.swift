//
//  SuccessViewController.swift
//  Fynoo Business
//
//  Created by SENDAN on 09/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class SuccesssViewController: UIViewController {
  
    var isDataBank = false
    var timer: Timer?
    var counter = 60
    var newUser = ""
    var isFromAgentSignUp = false
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var downImage: UIImageView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerVw: NavigationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        downImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerVw.titleHeader.text = "Successfully"
        self.headerVw.backButton.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        
        if isFromAgentSignUp == true {
           self.titleLbl.text = "Successfully Registration With FYNOO"
        }else{
             self.titleLbl.text = "Payment Successful"
        }
        
    }

    @objc func action () {
        counter -= 1
        if counter == 57{
            timer?.invalidate()
            if isFromAgentSignUp == true {
                let vc = LanguageSelectionViewController(nibName: "LanguageSelectionViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
   //         if newUser == "1"{
//                let viewCOntroller  = SubcriptionPlanListViewController()
//                 let viewCOntroller  = SubcriptionPackageListViewController()
//                viewCOntroller.isfromVerify = true
//                self.navigationController?.pushViewController(viewCOntroller, animated: false)
   //         }
            else{
                let vc = AgentDashboardViewController(nibName: "AgentDashboardViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
