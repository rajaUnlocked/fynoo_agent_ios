//
//  OtpForCodViewC.swift
//  Fynoo Services
//
//  Created by Apple on 31/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import ObjectMapper
import MessageUI
class OtpForCodViewC: UIViewController,UITableViewDelegate,UITextFieldDelegate,OtpTableViewCellDelegate, InformationTableViewCellDelegate, AgentServiceListDelegate,MFMessageComposeViewControllerDelegate, BusinessOwnerTableViewCellDelegate {
    
    
   
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnConfirmDelivery: UIButton!
    
    
    var onTheWayTripDetailData : OnthewayTripDetailsData?
//    var reasonListData : reasonlistData?
//    var itemListArray:[Item_detail]?
    var orderId : String = ""
    var tripId = 0
    var txt1 = ""
    var txt2 = ""
    var txt3 = ""
    var txt4 = ""
    var cod : Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "BusinessOwnerTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessOwnerTableViewCell");
        tableView.register(UINib(nibName: "InformationTableViewCell", bundle: nil), forCellReuseIdentifier: "InformationTableViewCell");
        tableView.register(UINib(nibName: "OtpTableViewCell", bundle: nil), forCellReuseIdentifier: "OtpTableViewCell");
        
        tableView.delegate = self
        tableView.dataSource = self
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Product Details".localized
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
        SetFont()
        getOnTheWayTripDetail()
        
    }
    
    func SetFont() {

            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")

            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        self.btnConfirmDelivery.titleLabel!.font = UIFont(name:"\(fontNameLight)",size:16)!
        
    }

    
    
    func buyerInformationClicked(_ sender: Any) {
        print("Buy")
        let vc = ProductDetailsViewC()
        vc.checkInvoiceUploaded = true
        vc.orderId = onTheWayTripDetailData?.data?.trip_details?.order_id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func orderInformationClicked(_ sender: Any) {
        let vc = ProductDetailsViewC()
        vc.checkInvoiceUploaded = true
        vc.orderId = onTheWayTripDetailData?.data?.trip_details?.order_id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func invoiceClicked(_ sender: Any) {
        let vc = ViewInvoiceViewController()
        
    vc.imgurl = onTheWayTripDetailData?.data?.trip_details?.invoice_image ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func callClickedBo(_ sender: Any) {
        guard let phoneNumber = self.onTheWayTripDetailData?.data?.trip_details?.cust_mobile else { return}
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
        UIApplication.shared.open(number)
    }
    
    func messageClickedBo(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
         guard let phoneNumber = self.onTheWayTripDetailData?.data?.trip_details?.cust_mobile else { return}
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
     }
    
    func navigationClickedBo(_ sender: Any) {
        let vc = AgentDeliveryDetailViewController()
        vc.tripId = tripId
        vc.checkUsertype = onTheWayTripDetailData?.data?.trip_details?.user_type ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func callClicked(_ sender: Any) {
        guard let phoneNumber = self.onTheWayTripDetailData?.data?.trip_details?.cust_mobile else { return}
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
        UIApplication.shared.open(number)
    }
    
    func messageClicked(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
         guard let phoneNumber = self.onTheWayTripDetailData?.data?.trip_details?.cust_mobile else { return}
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
     }
   func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
       switch (result.rawValue) {
           case MessageComposeResult.cancelled.rawValue:
           print("Message was cancelled")
           self.dismiss(animated: true, completion: nil)
       case MessageComposeResult.failed.rawValue:
           print("Message failed")
           self.dismiss(animated: true, completion: nil)
       case MessageComposeResult.sent.rawValue:
           print("Message was sent")
           self.dismiss(animated: true, completion: nil)
       default:
           break;
       }
   }
    
    func navigationClicked(_ sender: Any) {
        let vc = AgentDeliveryDetailViewController()
        vc.tripId = tripId
        vc.checkUsertype = onTheWayTripDetailData?.data?.trip_details?.user_type ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    
    @IBAction func tappedTobtnConfirmDelivery(_ sender: UIButton) {
        
        if (txt1 == "") || (txt2 == "") || (txt3 == "") || (txt4 == ""){
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Enter Otp".localized)
            return
        }
        
        if ((onTheWayTripDetailData?.data?.trip_details?.payment_type) == "COD") {
            
        if cod == false {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Check COD Amount For Customer".localized)
            return
           }
        }
        
        callDeliverOrder()
    }
    
    func selectClicked(_ sender: Any) {
        
        let index = IndexPath(row: 0, section: 2)
           let cell: OtpTableViewCell = self.tableView.cellForRow(at: index) as! OtpTableViewCell
        
        if cell.btnReceivedCodAmt.isSelected == true {
            cell.imgCheck.image = #imageLiteral(resourceName: "uncheck")
            cell.btnReceivedCodAmt.isSelected = false
            cod = false
        }else
        {

        cell.imgCheck.image = #imageLiteral(resourceName: "check")
        cell.btnReceivedCodAmt.isSelected = true
        cod = true
//        self.tableView.reloadSections([2], with: .automatic)
        }
//        self.tableView.reloadSections([2], with: .automatic)
        self.tableView.reloadData()
        
    }
    
    
    func entryOtpCell(index : IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "OtpTableViewCell",for: index) as! OtpTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.txt1.keyboardType = .numberPad
        cell.txt2.keyboardType = .numberPad
        cell.txt3.keyboardType = .numberPad
        cell.txt4.keyboardType = .numberPad
        
        cell.txt1.addTarget(self, action: #selector(OtpForCodViewC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.txt2.addTarget(self, action: #selector(OtpForCodViewC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        cell.txt3.addTarget(self, action: #selector(OtpForCodViewC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.txt4.addTarget(self, action: #selector(OtpForCodViewC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        cell.txt1.tag = 1
        cell.txt2.tag = 2
        cell.txt3.tag = 3
        cell.txt4.tag = 4
        
        cell.txt1.delegate = self
        cell.txt2.delegate = self
        cell.txt3.delegate = self
        cell.txt4.delegate = self
        
        
//        let index = IndexPath(row: 0, section: 2)
//        let cell: OtpTableViewCell = self.tableView.cellForRow(at: index) as! OtpTableViewCell
        
        if ((onTheWayTripDetailData?.data?.trip_details?.payment_type) == "COD") {
            if (cell.txt1.text != "") && (cell.txt2.text != "") && (cell.txt3.text != "") && (cell.txt4.text != "") && (cell.btnReceivedCodAmt.isSelected == true){
                self.btnConfirmDelivery.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
            }else
            {
                self.btnConfirmDelivery.backgroundColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
            }
        }else
        {

        if (cell.txt1.text != "") && (cell.txt2.text != "") && (cell.txt3.text != "") && (cell.txt4.text != ""){
            self.btnConfirmDelivery.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
        }else
        {
            self.btnConfirmDelivery.backgroundColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
        }
    }
        
        
        if ((onTheWayTripDetailData?.data?.trip_details?.payment_type) == "COD") {
            cell.btnReceivedCodAmt.isHidden = false
            cell.imgCheck.isHidden = false
            cell.lblReceivedCodAmt.isHidden = false
        }
        cell.txt1.textAlignment = .center
        cell.txt2.textAlignment = .center
        cell.txt3.textAlignment = .center
        cell.txt4.textAlignment = .center
        
        return cell
    }
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        
        if textField.tag == 1{
            txt1 = textField.text!
        }else if textField.tag == 2 {
            txt2 = textField.text!
        }else if textField.tag == 3
        {
            txt3 = textField.text!
        }else
        {
            txt4 = textField.text!
        }
        let index = IndexPath(row: 0, section: 2)
        let cell: OtpTableViewCell = self.tableView.cellForRow(at: index) as! OtpTableViewCell
        
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case cell.txt1:
                cell.txt2.becomeFirstResponder()
            case cell.txt2:
                cell.txt3.becomeFirstResponder()
            case cell.txt3:
                cell.txt4.becomeFirstResponder()
            case cell.txt4:
                cell.txt4.resignFirstResponder()
           
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case cell.txt1:
                cell.txt1.becomeFirstResponder()
            case cell.txt2:
                cell.txt1.becomeFirstResponder()
            case cell.txt3:
                cell.txt2.becomeFirstResponder()
            case cell.txt4:
                cell.txt3.resignFirstResponder()
           
            default:
                break
            }
        }
        else{
            print("aanan")

        }
        
        

        if ((onTheWayTripDetailData?.data?.trip_details?.payment_type) == "COD") {
            if (cell.txt1.text != "") && (cell.txt2.text != "") && (cell.txt3.text != "") && (cell.txt4.text != "") && (cell.btnReceivedCodAmt.isSelected == true){
                self.btnConfirmDelivery.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
            }else
            {
                self.btnConfirmDelivery.backgroundColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
            }
        }else
        {

        if (cell.txt1.text != "") && (cell.txt2.text != "") && (cell.txt3.text != "") && (cell.txt4.text != ""){
            self.btnConfirmDelivery.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
        }else
        {
            self.btnConfirmDelivery.backgroundColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
        }
    }
        
        
        
        
        
        
       
        
//        let typeStr = cell1.userTypeField.text!
//        if typeStr == "" {
//            cell1.loginBtnOutlet.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
//            cell1.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), for: .normal)
//
//        }
//        let value = ModalController.isValidEmail(testStr: email)
//        if value{
//            cell1.emailView.borderColor = #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1)
//        }else{
//            cell1.emailView.borderColor = #colorLiteral(red: 0.9490196078, green: 0.3882352941, blue: 0.3960784314, alpha: 1)
//        }
//        if password.validPassword{
//            cell1.passwordView.borderColor = #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1)
//        }else{
//            cell1.passwordView.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
//        }
//        if selectedType != "" &&  value == true && email != "" && password != "" && password.validPassword == true{
//            cell1.loginBtnOutlet.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
//            cell1.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
//        }else{
//            cell1.loginBtnOutlet.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
//            cell1.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), for: .normal)
//        }
//        if !password.containArabicNumber{
//            password = String(password.dropLast())
//            cell1.passwordField.text = password
//                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passArabicNumber)
//        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil {
             return true
          } else {
          return false
       }
    }
    
    
    func getOnTheWayTripDetail(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["order_id": orderId,
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.onTheWayTripDetail)
        ServerCalls.postRequest(Service.onTheWayTripDetail, withParameters: param) { [self] (response, success) in
            if success{
                
                if let body = response as? [String: Any] {
                    self.onTheWayTripDetailData  = Mapper<OnthewayTripDetailsData>().map(JSON: body)
                    
                    print(self.onTheWayTripDetailData?.data?.trip_details?.bo_id ?? "")
                    
                    self.tableView.reloadData()

                }
            }
        }
    }
    
    
    func callDeliverOrder(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        ModalClass.startLoading(self.view)
        let param = ["order_id": String(orderId),
                     "user_id":String(userId),
                     "otp" :"\(txt1+txt2+txt3+txt4)",
                     "user_type":(onTheWayTripDetailData?.data?.trip_details?.user_type),
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected] as [String : Any]
        
        print("request:-", param)
        print("Url:-", Service.deliverOrder)
        ServerCalls.postRequest(Service.deliverOrder, withParameters: param) { [self] (response, success) in

            ModalClass.stopLoadingAllLoaders(self.view)
            
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    ModalController.showNegativeCustomAlertWith(title:msg, msg: "")
                }else{
                    ModalController.showSuccessCustomAlertWith(title:msg, msg: "")
                    let vc = OrderSuccessViewC()
                    
                    var dictData = [String:Any]()
                    dictData["cust_id"] = self.onTheWayTripDetailData?.data?.trip_details?.cust_id
                    dictData["cust_image"] = self.onTheWayTripDetailData?.data?.trip_details?.cust_image
                    dictData["cust_name"] = self.onTheWayTripDetailData?.data?.trip_details?.cust_name
                    dictData["order_id"] = self.onTheWayTripDetailData?.data?.trip_details?.order_id
                    dictData["bo_id"] = self.onTheWayTripDetailData?.data?.trip_details?.bo_id
                    dictData["bo_name"] = self.onTheWayTripDetailData?.data?.trip_details?.bo_name
                    dictData["bo_image"] = self.onTheWayTripDetailData?.data?.trip_details?.bo_image
                    dictData["user_type"] = self.onTheWayTripDetailData?.data?.trip_details?.user_type
                    dictData["del_service_id"] = self.onTheWayTripDetailData?.data?.trip_details?.del_service_id
                    dictData["service_status"] = self.onTheWayTripDetailData?.data?.trip_details?.service_status
                    dictData["isRating"] = true
                    
                    vc.confirmDeliveryData = dictData
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                  
                }
            }
            else{
                ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
            }
        }
    }
    
    
}


extension OtpForCodViewC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        

        if indexPath.section == 1{
            
                return 155
        }else if indexPath.section == 0{
            return 170
        }else
        {
            return 170
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
                if indexPath.section == 0{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessOwnerTableViewCell",for: indexPath) as! BusinessOwnerTableViewCell
            cell.selectionStyle = .none
                    cell.delegate = self
          
                    cell.lblBoName.text = onTheWayTripDetailData?.data?.trip_details?.cust_name ?? ""
                    cell.lblBoAddress.text = onTheWayTripDetailData?.data?.trip_details?.address ?? ""
                    cell.bo_total_rating.text = "(\(onTheWayTripDetailData?.data?.trip_details?.total_rating ?? "0"))"
                    cell.bo_rating.text = onTheWayTripDetailData?.data?.trip_details?.rating ?? "0"
                    cell.imgbo_pic.sd_setImage(with: URL(string: onTheWayTripDetailData?.data?.trip_details?.cust_image ?? ""), placeholderImage: UIImage(named: "profile_white.png"))

            return cell
                }else if indexPath.section == 1{
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell",for: indexPath) as! InformationTableViewCell
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.lblQty.text = "0\(onTheWayTripDetailData?.data?.trip_details?.order_qty ?? 0)"
                    
                  
                    let OrderId = "Order Id:".localized

                            cell.lblOrderId.text = "\(OrderId) \(onTheWayTripDetailData?.data?.trip_details?.order_id ?? "0")"


                    let timeSTAMP = "\(onTheWayTripDetailData?.data?.trip_details?.order_date ?? "")"
                    
                    cell.lblOrderDate.text = timeSTAMP
                    
//                    cell.lblOrderDate.text = ModalController.convert13DigitTimeStampIntoDate(timeStamp: timeSTAMP, format: "dd-MMM-yyyy HH:mm a")

                    cell.lblCurrencyCode.text = onTheWayTripDetailData?.data?.trip_details?.order_currency ?? "0"

                    cell.order_price.text = "\(onTheWayTripDetailData?.data?.trip_details?.order_price ?? 0.0)"
                    cell.imgInvoice.sd_setImage(with: URL(string: onTheWayTripDetailData?.data?.trip_details?.invoice_image ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                    cell.imgPaymentIcon.sd_setImage(with: URL(string: onTheWayTripDetailData?.data?.trip_details?.payment_icon ?? ""), placeholderImage: UIImage(named: "cod_icon"))

                    
                    return cell
                }else {
                    
                    return entryOtpCell(index: indexPath)
                    
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "OtpTableViewCell",for: indexPath) as! OtpTableViewCell
//                    cell.selectionStyle = .none
//
//
//                    if ((onTheWayTripDetailData?.data?.trip_details?.payment_type) == "COD") {
//                        cell.btnReceivedCodAmt.isHidden = false
//                        cell.imgCheck.isHidden = false
//                        cell.lblReceivedCodAmt.isHidden = false
//                    }
//                    cell.txt1.textAlignment = .center
//                    cell.txt2.textAlignment = .center
//                    cell.txt3.textAlignment = .center
//                    cell.txt4.textAlignment = .center
//                    cell.txt1.text = cell.txt1.text
//                    cell.txt2.text = cell.txt2.text
//                    cell.txt3.text = cell.txt3.text
//                    cell.txt4.text = cell.txt4.text
//
//                    return cell
                }
       }
    }
