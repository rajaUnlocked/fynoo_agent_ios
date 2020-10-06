//
//  AddAmountViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 29/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class AddAmountViewController: UIViewController {

    @IBOutlet weak var reasonView: UIView!
    @IBOutlet weak var containter: UIView!
    @IBOutlet weak var aamount: UITextField!
    var isFrom = false
    override func viewDidLoad() {
        super.viewDidLoad()

        aamount.keyboardType = .numberPad
        if isFrom {
            reasonView.isHidden = false
            containter.isHidden = true
        }else{
            containter.isHidden = false
             reasonView.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.containter || touch?.view == self.reasonView {
            
        }else{
            dismiss(animated: true, completion: nil)

        }
    }
 
    @IBAction func submitClicked(_ sender: Any){
        
        if aamount.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Enter an amount")
            return
        }
        let str = Service.updateCod
//       let param = ["user_id:1062",
//                   "lang_code":"en",
            //                "cod_amount":"1000"]
        
        let param = ["user_id":"1128","lang_code":"en","cod_amount":"1000"]
        print(param)
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
            print(response)
        }
        
    }
}
