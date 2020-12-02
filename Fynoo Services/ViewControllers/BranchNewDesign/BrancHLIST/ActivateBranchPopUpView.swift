//
//  ActivateBranchPopUpView.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 31/03/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ActivateBranchPopUpView: UIViewController {
    
    var isFrom = ""
    
    var status = 0
    var status_commission = 1
    var activateHandler : ((String)-> Void)?
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var titleBody: UILabel!
    
    @IBOutlet weak var yesOutlet: UIButton!
    
    @IBOutlet weak var noOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.yesOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        self.noOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        
        if status == 0{
            imgStatus.image = UIImage(named: "activeBranch")
            
            if isFrom == "Product"{
                titleBody.text = "Are you sure you want to activate this Product?"
            }
            else if isFrom == "Commission"
            {
                titleBody.text = "Are you sure you want to activate your commission?"
            }
            else if isFrom == "ManageDropShipping"
            {
                titleBody.text = "Are you sure you want to activate this commission?"
            }
                
            else if isFrom == "SingleProductApplyCommission"
            {
                titleBody.text = "Are you sure, you want to activate your commission?"
            }
               
            else{
                titleBody.text = "Are you sure you want to activate this branch?"
                
            }
            
        }else{
            imgStatus.image = UIImage(named: "deactivated")
            if isFrom == "Product"{
                titleBody.text = "Are you sure you want to deactivate this product?"
                
            }
            else if isFrom == "Commission"{
                titleBody.text = "Are you sure you want to deactivate your commission?"
            }
            else if isFrom == "ManageDropShipping"
            {
                titleBody.text = "Are you sure you want to deactivate this commission?"
            }
            else if isFrom == "SingleProductApplyCommission"
            {
                titleBody.text = "Are you sure, you want to deactivate your commission?"
            }
                
            else{
                titleBody.text = "Are you sure you want to deactivate this branch?"
                
            }
            
        }
        if isFrom == "MainToggleCommission"{
            if status_commission == 1{
                
                imgStatus.image = UIImage(named: "activeBranch")
                titleBody.text = "Are you sure, you want to activate this commission in all your products?"
                
                
            }
            else {
                imgStatus.image = UIImage(named: "deactivated")
                titleBody.text = "Are you sure, you want to deactivate your commission in all your products?"
            }
        }
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func yesClicked(_ sender: Any) {
        
        activateHandler!("true")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func noClicked(_ sender: Any) {
        activateHandler!("false")
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
