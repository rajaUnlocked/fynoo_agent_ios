//
//  PopUpAcceptProductViewController.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 12/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit


protocol PopUpAcceptProductDelegate {
    func reloadPage()
    
}

protocol PopDeclineProductDelegate {
    func declineOrder()
    
}

class PopUpAcceptProductViewController: UIViewController {
    var delegate:PopUpAcceptProductDelegate?
    var delegateDecline:PopDeclineProductDelegate?
    
    @IBOutlet weak var containter: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var yesOutlet: UIButton!
    @IBOutlet weak var noOutlet: UIButton!
    var orderId = ""
    var itemId = 0
    var titleLabel = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.yesOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: self.yesOutlet.frame.size.width)
        self.noOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: self.yesOutlet.frame.size.width)

        if titleLabel == "Are you sure you want to decline?".localized {
            lblInstruction.text = titleLabel
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.containter {
            
        }else{
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func yesClicked(_ sender: Any){
        
        if titleLabel == "Are you sure want to accept?".localized{
            self.delegate?.reloadPage()
            self.dismiss(animated: true, completion: nil)
            return
        }
        if titleLabel == "Are you sure you want to decline?".localized{
            self.delegateDecline?.declineOrder()
            self.dismiss(animated: true, completion: nil)
            return
        }
        let str = Service.acceptIndivisualItem
        let param = ["user_id":Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"item_id":itemId] as [String : Any]
        print(param)
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
//            self.delegate?.reloadPage()
            
            print(response as Any)
            ModalClass.stopLoadingAllLoaders(self.view)
            if success == true {
                
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
                ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "error_description") as? String)!, msg: "")
//                    self.transactionListArray.removeAllObjects()
//                    self.tableView.reloadData()
                    
//                    self.delegate?.reloadPage()
                }
                else{
                    
                    
                    ModalController.showSuccessCustomAlertWith(title: ((ResponseDict.object(forKey: "error_description") as? String)!), msg: "")
                    self.delegate?.reloadPage()
                   
                }
            }else{
    
                if response == nil {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
            
//            self.delegate?.reloadPage()
           
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
    @IBAction func noClicked(_ sender: Any){
        
        self.dismiss(animated: true, completion: nil)

    }
}
