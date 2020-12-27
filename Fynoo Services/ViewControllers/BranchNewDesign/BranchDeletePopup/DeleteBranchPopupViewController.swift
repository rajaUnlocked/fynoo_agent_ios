//
//  DeleteBranchPopupViewController.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 14/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol DeleteBranchPopupViewControllerDelegate{
    func reloadPage()
}

class DeleteBranchPopupViewController: UIViewController {
var notifylist = NotificationApiModel()
    @IBOutlet weak var yes: UIButton!
    var delegate:DeleteBranchPopupViewControllerDelegate?
    @IBOutlet weak var no: UIButton!
    @IBOutlet weak var lbl: UILabel!
    var commission_list_model = ManageCommissionModel()
    var delete_commission : CommissionMasterDelete?
    var comm_id = ""
    var branchId: String = ""
    var proId: String = ""
    var isType = ""
//    var title = ""
    var isMain:Int = 0
    var pro_count: Int = 0
    var pro_status = ""
    var delete_branch: DeleteBank?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl.addShadowView(0.0, height: 3.0, Opacidade: 3.0, maskToBounds: true, radius: 0.0)
        self.yes.setAllSideShadow(shadowShowSize: 3.0)
        self.no.setAllSideShadow(shadowShowSize: 3.0)
        lbl.numberOfLines = 0
        lbl.text = "Are you sure you want to delete this branch?".localized
        if isType  == "Notification"{
            
            lbl.text = "Are you sure you want to delete it?"
        }
        if isType  == "PRODUCT"{
            lbl.text = "Are You Sure To Delete This Product?"
        }
        
        if isType  == "Commission"{
                   lbl.text = "Are you sure you want to delete \nthis commission?"
               }
               
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           let touch = touches.first
                if touch?.view == self.view {
                 
                dismiss(animated: true, completion: nil)
                 
               }
         }
    
    @IBAction func yesClick(_ sender: Any) {
          if isType  == "Notification"{
            ModalClass.startLoading(view)
            notifylist.notfid = proId
            notifylist.notifydeletelist { (success, response) in
                 ModalClass.stopLoading()
                ModalController.showSuccessCustomAlertWith(title: response?.value(forKey: "error_description") as! String, msg: "")
                self.delegate?.reloadPage()
                self.dismiss(animated: true)
            }
            }
        
       else if isType == "PRODUCT" {
            if pro_status == "0"{
                
                        deletebranch()
                  }
            else {
                ModalController.showNegativeCustomAlertWith(title: "You cannot delete products which have been saved successfully", msg: "")
                self.dismiss(animated: true, completion: nil)
                
                
            }

              

        }
        else if isType == "Commission"{
           commissionMasterDeleteAPI()
        }
        else {
        if pro_count > 0{
            ModalController.showNegativeCustomAlertWith(title: "There are product linked to the branch. You cannot delete it.".localized, msg: "")
            self.dismiss(animated: true, completion: nil)
        }
        else {
            if isMain == 1{
                ModalController.showNegativeCustomAlertWith(title: "Main branch cannot be deleted".localized, msg: "")
                self.dismiss(animated: true, completion: nil)
            }
            else{
              deletebranch()
            }
           
          
        }
    }
     
    }
    func commissionMasterDeleteAPI(){
       
        commission_list_model.commissionId = comm_id
        commission_list_model.deleteCommissionMaster { (success, response) in
            if success{
                self.delete_commission = response
                self.delegate?.reloadPage()
                self.dismiss(animated: true, completion: nil)
            }
            else{
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }

    @IBAction func noClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func deletebranch() {
        ModalClass.startLoading(self.view)
        let device_id = UIDevice.current.identifierForVendor!.uuidString
        var str = ""
        if isType == "PRODUCT" {
            str = "\(Constant.BASE_URL)\(Constant.deleteProduct)"
        }
        else {
            str = "\(Constant.BASE_URL)\(Constant.BranchDelete_List)"
        }
        
        var parameter = [String: Any]()
        if isType  == "PRODUCT" {
            parameter = [
                "pro_id":proId,
                "pro_bo_id": Singleton.shared.getUserId(),
                "type":"PRODUCT",
                "lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ]
        }
        else {
             parameter = [
                "user_id":Singleton.shared.getUserId(),
                "branch_id":branchId,
                "user_type":"BO",
                 "lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ]

        }
        print(parameter,"request")
        ServerCalls.postRequest(str, withParameters: parameter) { (response, success, resp) in
            
            ModalClass.stopLoading()
            
            if success == true {
                
                self.delete_branch = try! JSONDecoder().decode(DeleteBank.self, from: resp as! Data )
                
                if self.delete_branch!.error! {
                    ModalController.showNegativeCustomAlertWith(title:(self.delete_branch?.error_description)!, msg: "")
                    
                }
                    
                else{
                  
                        ModalController.showSuccessCustomAlertWith(title: (self.delete_branch?.error_description)!, msg: "")
                   
                    self.delegate?.reloadPage()
                    self.dismiss(animated: true, completion: nil)
                   
                }
            }else{
                if response == nil
                {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
        }
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

