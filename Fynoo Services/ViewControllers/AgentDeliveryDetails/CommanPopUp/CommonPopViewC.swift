//
//  CommonPopViewC.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 16/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

class CommonPopViewC: UIViewController {
    
    @IBOutlet weak var containter: UIView!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblProductQty: UILabel!
    
    @IBOutlet weak var lblOrderId: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAlmostPrice: UILabel!
    
    @IBOutlet weak var lblTotalPrice: UILabel!
    
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
    
    @IBAction func onTheWayClicked(_ sender: Any) {
    }
    
    @IBAction func acceptCancelationClicked(_ sender: Any){
        
//        if aamount.text == ""{
//            ModalController.showNegativeCustomAlertWith(title: "", msg: "Enter an amount")
//            return
//        }
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
