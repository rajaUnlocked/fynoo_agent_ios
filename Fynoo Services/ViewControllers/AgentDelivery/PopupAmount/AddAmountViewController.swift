//
//  AddAmountViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 29/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class AddAmountViewController: UIViewController {

    @IBOutlet weak var aamount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        aamount.keyboardType = .numberPad
        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func submitClicked(_ sender: Any){
        
        if aamount.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Enter an amount")
            return
        }
        let str = Service.updateCod
        let param = ["user_id:1062","lang_code":"en","cod_amount":"1000"]
        print(param)
        ServerCalls.getRequests(str) { (response, success) in
            if success{
                
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
