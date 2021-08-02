//
//  SuccessViewController.swift
//  Fynoo Business
//
//  Created by SENDAN on 09/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol dismiss {
    func dismissController()
}
class SuccesssViewController: UIViewController {
  
    var isDataBank = false
    var timer: Timer?
    var counter = 60
    var newUser = ""
    var isFromAgentSignUp = false
     var isFromWhere = ""
        
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var downImage: UIImageView!
   
     
    override func viewDidLoad() {
        super.viewDidLoad()
        downImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
     
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        
        if isFromAgentSignUp == true {
            self.titleLbl.text = "Successfully Registration With FYNOO".localized
        }else{
             self.titleLbl.text = "Payment Successful".localized
        }
    }

    @objc func action () {
        counter -= 1
        if counter == 57{
            timer?.invalidate()
            if isFromAgentSignUp == true {
                let vc = LanguageSelectionViewController(nibName: "LanguageSelectionViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if isFromWhere == "DataEntryBO" {
                DispatchQueue.main.async {
                  
                    var isHomeThere = false
                    
                    if var viewControllers = self.navigationController?.viewControllers
                    {
                        for controller in viewControllers
                        {
                            if controller is DataEntryListingViewController
                            {
                                isHomeThere = true
                                for controller in self.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: DataEntryListingViewController.self) {
                                        NotificationCenter.default.post(name: Notification.Name("refreshDataEntryList"), object: nil, userInfo: nil)
                                        self.navigationController!.popToViewController(controller, animated: true)
                                        break
                                    }
                                }
                            }
                        }
                    }
                    if isHomeThere == false {
                        NotificationCenter.default.post(name: Notification.Name("refreshDataEntryList"), object: nil, userInfo: nil)
                        
                        let vc = DataEntryListingViewController(nibName: "DataEntryListingViewController", bundle: nil)
                        vc.hidesBottomBarWhenPushed = true
                        vc.createHeaderAgain = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
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
