//
//  AddAmountViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 29/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
protocol AddAmountDelegate {
    func reloadPage()
}
class AddAmountViewController: UIViewController {
    
    @IBOutlet weak var todaycodlbl: UILabel!
    
    @IBOutlet weak var descriplbl: UILabel!
    
    @IBOutlet weak var sar: UILabel!
    @IBOutlet weak var codamtlbl: UILabel!
    
    @IBOutlet weak var submit: UIButton!
    var delegate:AddAmountDelegate?
     var descrptxt = ""
    var isNotFill = false
    @IBOutlet weak var TopConst: NSLayoutConstraint!
    @IBOutlet weak var rejectedlbl: UILabel!
    @IBOutlet weak var rejecticon: UIImageView!
    @IBOutlet weak var descriptiontxt: UILabel!
    @IBOutlet weak var reasonView: UIView!
    @IBOutlet weak var containter: UIView!
    @IBOutlet weak var aamount: UITextField!
    var isFrom = false
    var taG = 0
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        todaycodlbl.font = UIFont(name:"\(fontNameLight)",size:14)
        descriplbl.font = UIFont(name:"\(fontNameLight)",size:14)
        sar.font = UIFont(name:"\(fontNameLight)",size:14)
        codamtlbl.font = UIFont(name:"\(fontNameLight)",size:14)
        aamount.font = UIFont(name:"\(fontNameLight)",size:14)
        submit.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:16)
        submit.setTitle("Done".localized, for: .normal)
        todaycodlbl.text = "Today's COD Amount".localized
        descriplbl.text = "You can enter the Today's COD amount and you can change it any time.".localized
        codamtlbl.text = "COD Amount".localized
        sar.text = "SAR".localized
        aamount.keyboardType = .numberPad
     
        if isFrom {
            TopConst.constant = 10
            reasonView.isHidden = false
            containter.isHidden = true
           descriptiontxt.text = descrptxt
            if isNotFill
            {
                TopConst.constant = -30
                rejecticon.image = UIImage(named: "info-gray")
                rejectedlbl.text = ""
            }
            else if taG == 1
            {
            rejecticon.image = UIImage(named: "cross-1")
                rejectedlbl.text = "Rejected"
            }
            else{
                TopConst.constant = -30
                rejecticon.image = UIImage(named: "info")
                rejectedlbl.text = ""
            }
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
        
        let param = ["user_id":Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"cod_amount":aamount.text!]
        print(param)
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
            self.delegate?.reloadPage()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
