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
    @IBOutlet weak var lblNotes: UILabel!{
        didSet {
            lblNotes.font = UIFont(name:"\(Constant.FONT_Light)",size:10)
            lblNotes.textColor = UIColor.AppThemeBlackTextColor()
//            self.lblNotes.text = "Customer has requested cancellation. Please confirm or reject the request within 15 mins,otherwise order will be automatically cancelled.".localized
        }
    }
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!{
        didSet {
            lblName.font = UIFont(name:"\(Constant.FONT_Light)",size:12)
            lblName.textColor = UIColor.AppThemeBlackTextColor()
        }
    }
    @IBOutlet weak var lblProductQty: UILabel!{
        didSet {
            lblProductQty.font = UIFont(name:"\(Constant.FONT_Light)",size:10)
            lblProductQty.textColor = UIColor.AppThemeBlackTextColor()
        }
    }
    
    @IBOutlet weak var lblOrderId: UILabel!{
        didSet {
            lblOrderId.font = UIFont(name:"\(Constant.FONT_Light)",size:12)
            lblOrderId.textColor = UIColor.AppThemeBlackTextColor()
        }
    }
    
    @IBOutlet weak var lblAddress: UILabel!{
        didSet {
            lblAddress.font = UIFont(name:"\(Constant.FONT_Light)",size:10)
            lblAddress.textColor = UIColor.AppThemeBlackTextColor()
        }
    }
    @IBOutlet weak var lblDate: UILabel!{
        didSet {
            lblDate.font = UIFont(name:"\(Constant.FONT_Light)",size:10)
            lblDate.textColor = UIColor.AppThemeBlackTextColor()
        }
    }
    @IBOutlet weak var lblAlmostPrice: UILabel!{
        didSet {
            lblAlmostPrice.font = UIFont(name:"\(Constant.FONT_Light)",size:12)
            lblAlmostPrice.textColor = UIColor.AppThemeBlackTextColor()
            self.lblAlmostPrice.text = "Almost Total Price".localized
        }
    }
    
    @IBOutlet weak var lblTotalPrice: UILabel!{
        didSet {
            lblTotalPrice.font = UIFont(name:"\(Constant.FONT_Light)",size:12)
            lblTotalPrice.textColor = UIColor.AppThemeGreenTextColor()
        }
    }
    
    @IBOutlet weak var lblStNote: UILabel!{
        didSet {
            lblStNote.font = UIFont(name:"\(Constant.FONT_Light)",size:12)
            lblStNote.textColor = UIColor.AppThemeBlackTextColor()
            let note = "Note".localized
            self.lblStNote.text = "\(note):"
        }
    }
    
    @IBOutlet weak var lblStcancelationRequest: UILabel!{
        didSet {
            lblStcancelationRequest.font = UIFont(name:"\(Constant.FONT_Extra_BOLD)",size:14)
            lblStcancelationRequest.textColor = UIColor.AppThemeBlackTextColor()
            self.lblStcancelationRequest.text = "Cancellation Request".localized
        }
    }
    
    @IBOutlet weak var btnStOnMyWay: UIButton!{
        didSet {
            btnStOnMyWay.titleLabel!.font = UIFont(name:"\(Constant.FONT_Light)",size:12)
            btnStOnMyWay.setTitleColor(UIColor.AppThemeGreenTextColor(), for: .normal)
            self.btnStOnMyWay.setTitle("I'm on my way".localized, for: .normal)
        }
    }
    @IBOutlet weak var btnStAccept: UIButton!{
        didSet {
            btnStAccept.titleLabel!.font = UIFont(name:"\(Constant.FONT_Light)",size:12)
            btnStAccept.setTitleColor(UIColor.AppThemeGreenTextColor(), for: .normal)
            self.btnStAccept.setTitle("Accept Cancellation".localized, for: .normal)
            
        }
    }
    var orderId = ""
    var cancelpDetail : agentCancelationDetailData?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getagentCancelDetail()
//        SetFont()

    }
    
    
//    func SetFont() {
//
//            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
//
//            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
//
//        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
//
//            self.lblDistanceAgentToBo.font = UIFont(name:"\(fontNameLight)",size:10)
//
//            self.lblDistanceBoToCustomer.font = UIFont(name:"\(fontNameLight)",size:10)
//
//        self.lblStAlmostTotalPrice.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblAlmostPurchasePrice.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblStpickupTime.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblStCreatedBy.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblStDeliveryPrice.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblStDeliveryPrice.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblpickupTime.font = UIFont(name:"\(fontNameLight)",size:10)
//
//        self.lblCreatedBy.font = UIFont(name:"\(fontNameLight)",size:10)
//        self.lblRating.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblQty.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblWeight.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblSize.font = UIFont(name:"\(fontNameLight)",size:12)
//
//        self.lblRating.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblQty.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblWeight.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblSize.font = UIFont(name:"\(fontNameLight)",size:12)
//
//        self.lblStAlmostPurchasePrice.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblDeliveryPrice.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblavgRating.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblAlmostTotalPrice.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.lblTime.font = UIFont(name:"\(fontNameLight)",size:25)
//        self.btnAcceptTxt.titleLabel?.font =  UIFont(name:"\(fontNameLight)",size:16)
//        self.btnDeclineTxt.titleLabel?.font =  UIFont(name:"\(fontNameLight)",size:16)
//
//
//        }
    
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
                    
                    
                    self.lblProductQty.text = "0\(cancelpDetail?.data?.order_qty ?? 0)"
                    let orderId = "Order Id:".localized
                    self.lblOrderId.text = "\(orderId)\(cancelpDetail?.data?.order_id ?? "")"
                    self.lblAddress.text = cancelpDetail?.data?.address
                    self.lblNotes.text = cancelpDetail?.data?.note
                    self.lblTotalPrice.text =  "\(cancelpDetail?.data?.currency_code ?? "")" + "\(cancelpDetail?.data?.order_price ?? 0)"
                    
                    
                }
            }
        }
    }
  
}
