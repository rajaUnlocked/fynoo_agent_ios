//
//  CommonPopViewC.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 16/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import ObjectMapper
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
    var cancelpDetail : agentCancelationDetailData?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getagentCancelDetail()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.containter {
            
        }else{
            dismiss(animated: true, completion: nil)

        }
    }
    
    @IBAction func onTheWayClicked(_ sender: Any) {
        
        
        let str = Service.agentRejectCancellation
        let param = ["user_id":Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"order_id":orderId] as [String : Any]
        print(param)
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
//            self.delegate?.reloadPage()
            self.dismiss(animated: true, completion: nil)
            
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    ModalController.showNegativeCustomAlertWith(title:msg, msg: "")
                }else{
//                        self.imageId = ""
                    ModalController.showSuccessCustomAlertWith(title:msg, msg: "")
                    print("msggggggggggg")
                    
                    let vc = OtpForCodViewC()
                    vc.orderId = self.orderId
                    self.navigationController?.pushViewController(vc, animated: true)

                }
            }
            else{
                ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
            }
        }
        
    }
    
    @IBAction func acceptCancelationClicked(_ sender: Any){
        

        let str = Service.agentAcceptCancellation
        let param = ["user_id":Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"order_id":orderId] as [String : Any]
        print(param)
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
//            self.delegate?.reloadPage()
            self.dismiss(animated: true, completion: nil)
      
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    ModalController.showNegativeCustomAlertWith(title:msg, msg: "")
                }else{
//                        self.imageId = ""
                    ModalController.showSuccessCustomAlertWith(title:msg, msg: "")
                    print("msggggggggggg")
                    
                    let vc = OtpForCodViewC()
                    vc.orderId = self.orderId
                    self.navigationController?.pushViewController(vc, animated: true)

                }
            }
            else{
                ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
            }
            
            
           
        }
        
    }
    
    
    @IBAction func closeClicked(_ sender: Any){
        
        self.dismiss(animated: true, completion: nil)

    }
    func getagentCancelDetail(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["order_id": orderId,
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.agentCancellationDetail)
        ServerCalls.postRequest(Service.agentCancellationDetail, withParameters: param) { [self] (response, success) in
            if success{
                
//                self.addPullUpController(animated: true)
               
                if let body = response as? [String: Any] {
                    self.cancelpDetail  = Mapper<agentCancelationDetailData>().map(JSON: body)
                    
                    print(self.cancelpDetail?.data?.cus_name ?? "")
                    
                    self.lblName.text = cancelpDetail?.data?.cus_name ?? ""
                    
                    let timeSTAMP = "\(cancelpDetail?.data?.order_date ?? 0)"
                    lblDate.text = ModalController.convert13DigitTimeStampIntoDate(timeStamp: timeSTAMP, format: "dd-MMM-yyyy HH:mm a")
                    
                    
                    self.lblProductQty.text = "\(cancelpDetail?.data?.order_qty ?? 0)"
                    self.lblOrderId.text = cancelpDetail?.data?.order_id
                    self.lblAddress.text = cancelpDetail?.data?.address
                    self.lblNotes.text = cancelpDetail?.data?.note
                    self.lblTotalPrice.text = "\(cancelpDetail?.data?.order_price ?? 0)"
                    
                    
                }
            }
        }
    }
  
}
