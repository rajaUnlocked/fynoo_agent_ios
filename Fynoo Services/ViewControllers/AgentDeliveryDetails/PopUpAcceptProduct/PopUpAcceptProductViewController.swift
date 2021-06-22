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
    var orderId = ""
    var itemId = 0
    var titleLabel = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        if titleLabel == "Are you sure want to decline?" {
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
        
        if titleLabel == "Are you sure want to accept?"{
            self.delegate?.reloadPage()
            self.dismiss(animated: true, completion: nil)
            return
        }
        if titleLabel == "Are you sure want to decline?"{
            self.delegateDecline?.declineOrder()
            self.dismiss(animated: true, completion: nil)
            return
        }
        let str = Service.acceptIndivisualItem
        let param = ["user_id":Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"item_id":itemId] as [String : Any]
        print(param)
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
            self.delegate?.reloadPage()
            
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
                    
                    self.delegate?.reloadPage()
                }
                else{
                    
                    
                    ModalController.showSuccessCustomAlertWith(title: ((ResponseDict.object(forKey: "error_description") as? String)!), msg: "")
                   
                }
            }else{
    
                if response == nil {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
            
            self.delegate?.reloadPage()
           
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
    @IBAction func noClicked(_ sender: Any){
        
        self.dismiss(animated: true, completion: nil)

    }

}
