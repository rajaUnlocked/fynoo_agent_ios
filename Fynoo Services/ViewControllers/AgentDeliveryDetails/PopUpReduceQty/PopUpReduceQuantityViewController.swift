//
//  PopUpReduceQuantityViewController.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 12/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

class PopUpReduceQuantityViewController: UIViewController {
    
    @IBOutlet weak var containter: UIView!
    @IBOutlet weak var rejectedlbl: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var txtQty:UITextField!
    var orderId = ""
    var itemId = 0
    var reasonId = 0

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.containter {
            
        }else{
            dismiss(animated: true, completion: nil)

        }
    }
    
    
    @IBAction func submitClicked(_ sender: Any){
        
        if txtQty.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Enter Qty")
            return
        }
        let str = Service.deleteIndivisualItem
        let param = ["user_id":Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"item_id":itemId,"order_id":orderId,"reason_id":reasonId] as [String : Any]
        print(param)
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
//            self.delegate?.reloadPage()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func closeClicked(_ sender: Any){
        
        self.dismiss(animated: true, completion: nil)

    }

}
