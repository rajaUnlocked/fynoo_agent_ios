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
    @IBOutlet weak var yes: UIButton!
    var delegate:DeleteBranchPopupViewControllerDelegate?
    @IBOutlet weak var no: UIButton!
    @IBOutlet weak var lbl: UILabel!
  
    var comm_id = ""
    var branchId: String = ""
    var proId: String = ""
    var isType = ""
//   var title = ""
    var isMain:Int = 0
    var pro_count: Int = 0
    var pro_status = ""

    
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
    
    @IBAction func yesClick(_ sender: Any)
    {
         var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
                          if userId == "0" {
                                   userId = ""
                                 }
          let url = "\(Constant.BASE_URL)\(Constant.removedatasellproduct)"
    
          let param  =  ["lang_code":"\(HeaderHeightSingleton.shared.LanguageSelected)",
              "pro_id":proId,
              ] as [String : Any]
          print(param)
        ModalClass.startLoading(self.view)
          ServerCalls.postRequest(url, withParameters: param) { (response, success) in
            ModalClass.stopLoading()
              if let value = response as? NSDictionary{
                  let error = value.object(forKey: "error") as! Int
                  if error == 0{
                      if let body = response as? [String: Any] {
                    let msg =  value.object(forKey: "error_description") as! String
                        ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                        self.dismiss(animated: true, completion: nil)
                        self.delegate?.reloadPage()
                          return
                      }
                    
                  }else{
                      let msg =  value.object(forKey: "error_description") as! String
                      ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                    self.dismiss(animated: true, completion: nil)
                  }
                  
              }
          }
      }
    
    @IBAction func noClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 

}

