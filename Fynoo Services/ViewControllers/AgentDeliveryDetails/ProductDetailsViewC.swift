//
//  ProductDetailsViewC.swift
//  Fynoo Services
//
//  Created by Apple on 20/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import ObjectMapper
import MessageUI
import MTPopup
import MessageUI
import AMShimmer

class ProductDetailsViewC: UIViewController,ProductListDelegate,PopUpAcceptProductDelegate,AddInvoiceInformationDelegate, OpenGalleryDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,DECancellationReasonViewControllerDelegate,AgentServiceListDelegate,MFMessageComposeViewControllerDelegate, BusinessOwnerTableViewCellDelegate,ConfirmToreceiveItemTableViewCellDelegate {
    
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnChangeStatus: UIButton!
    
    var orderDetailData : orderDetail?
    var reasonListData : reasonlistData?
    var itemListArray:[Item_detail]?
    var agentViewModel = AgentModel()
    var orderId = ""
    var tripId = 0
    var isInvoiceEnable = true
    var checkInvoiceUploaded : Bool = false
    
    var selectedImg : UIImage!
    var amoutnWithoutVat = ""
    var vatAmount = ""
    var amoutWithVat = ""
    var checkReceivedItem : Bool = false
    var distanceAgentToBo = ""
    var distanceBoToCustomer = ""
    var boToCustomerDistance = ""
    var agentToBoDistance : Int = 0
    var boToCustomerDistancec : Int = 0
    var lblWatingTime = ""
    var checkcondition = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "BusinessOwnerTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessOwnerTableViewCell");
        tableView.register(UINib(nibName: "BOCustomerTableViewCell", bundle: nil), forCellReuseIdentifier: "BOCustomerTableViewCell");
        tableView.register(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell");
        tableView.register(UINib(nibName: "AddInvoiceInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "AddInvoiceInformationTableViewCell");
        tableView.register(UINib(nibName: "ConfirmToreceiveItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ConfirmToreceiveItemTableViewCell");
        tableView.register(UINib(nibName: "AddedNewViewBoTableViewCell", bundle: nil), forCellReuseIdentifier: "AddedNewViewBoTableViewCell");
        
       
        tableView.delegate=self
        tableView.dataSource=self
        
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Order Details".localized
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(notify), name: NSNotification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: nil)
        
        SetFont()
        getOrderDetail()
        
    }
    
        func SetFont() {
    
                let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
    
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
    
            self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
    
            self.btnChangeStatus.titleLabel?.font =  UIFont(name:"\(fontNameLight)",size:16)
    
    
            }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func reloadPage() {
        getOrderDetail()
    }
    
    
    func callClickedBo(_ sender: Any) {
        guard let phoneNumber = self.orderDetailData?.data?.bo_mob_no else { return}
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
        UIApplication.shared.open(number)
    }
    
    func messageClickedBo(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
         guard let phoneNumber = self.orderDetailData?.data?.bo_mob_no else { return}
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
        vc.checkUsertype = orderDetailData?.data?.user_type ?? ""
        vc.checkUsertype = "BO"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func callClicked(_ sender: Any) {
        guard let phoneNumber = self.orderDetailData?.data?.cust_mob_no else { return}
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
        UIApplication.shared.open(number)
    }
    
    func messageClicked(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
         guard let phoneNumber = self.orderDetailData?.data?.cust_mob_no else { return}
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
        vc.checkUsertype = orderDetailData?.data?.user_type ?? ""
        vc.checkUsertype = "CUSTOMER"

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @objc func notify(_ userInfo:NSNotification) {
        
        if let pushMessage = userInfo.object as? Dictionary<String,Any>{
            guard let order_idd = pushMessage["order_id"] as? String else { return}
//            self.orderId = order_idd
            if self.orderId == order_idd {
                self.getOrderDetail()
            }
           
//            AMShimmer.start(for: self.tabvw)
//                      ModalClass.startLoading(self.view)
//                      orderModal.getSharedOrderDetail(orderId) { (success, response) in
//                      ModalClass.stopLoading()
//                        ModalClass.stopLoadingAllLoaders(self.view)
//                      AMShimmer.stop(for: self.tabvw)
//                      if success{
//                          if response != nil{
//                            ModalClass.stopLoading()
//                            ModalClass.stopLoadingAllLoaders(self.view)
//                              self.orderDetailsResponse = response
//                          }
//                        ModalClass.stopLoadingAllLoaders(self.view)
//                          self.reloadTableData()
//                      }
//                    }
        }
          
      }
    
    
    func selectedCancelReason(reasonID: String) {
        print(reasonID)
        callAgentCancelOrder(reasonID: reasonID)
    }
    
        func getOrderDetail(){
            isInvoiceEnable = true
            var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
            if userId == "0"{
                userId = ""
                
            }
            let param = ["order_id": orderId,
                         "user_id":userId,
                         "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
            
            print("request:-", param)
            print("Url:-", Service.orderDetail)
            ModalClass.startLoading(self.view)
            ServerCalls.postRequest(Service.orderDetail, withParameters: param) { [self] (response, success) in
                if success{
                    ModalClass.stopLoadingAllLoaders(self.view)
                    if let body = response as? [String: Any] {
                        self.orderDetailData  = Mapper<orderDetail>().map(JSON: body)
                        
                        
                        callCalculateDistance()
                        if orderDetailData?.data?.user_type == "BO" {
                            callMainButtonstatusForBO()
                        }
                        callGetDistance()
                        self.tableView.reloadData()
                        
                        print(orderDetailData?.data?.is_vat_available)
//                        self.tableView.reloadSections([3], with: .automatic)
                        

                    }
                }
            }
        }
    
    
    func callAgentCancelOrder(reasonID: String){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["order_id": orderId,
                     "user_id":userId,
                     "reason_id":reasonID,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.agentCancelOrder)
        ServerCalls.postRequest(Service.agentCancelOrder, withParameters: param) { [self] (response, success) in
            if success{
                
                    if let value = response as? NSDictionary{
                        let msg = value.object(forKey: "error_description") as! String
                        let error = value.object(forKey: "error_code") as! Int
                        if error == 100{
                            ModalController.showNegativeCustomAlertWith(title:msg, msg: "")
                        }else{
    //                        self.imageId = ""
                            ModalController.showSuccessCustomAlertWith(title:msg, msg: "")
                            print("msggggggggggg")
                            self.getOrderDetail()
     
                        }
                    }
                    else{
                        ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                    }
     
            }
        }
    }
    
    
    
    func callReasonForReturnApi(selectedTag : Int){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["reason_for":"6",
                     "reason_at":"3",
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.reasonforreturn)
        ServerCalls.postRequest(Service.reasonforreturn, withParameters: param) { [self] (response, success) in
            if success{
                
                if let body = response as? [String: Any] {
                    self.reasonListData  = Mapper<reasonlistData>().map(JSON: body)
                    
                    print(self.reasonListData?.data?.reason_list ?? "")
                    
                    let vc = ReasonForDeleteViewController(nibName: "ReasonForDeleteViewController", bundle: nil)
                    vc.delegateDelegate = self
                    vc.modalPresentationStyle = .overFullScreen
                    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                    
                    vc.reasonListData =  self.reasonListData
                    let itemQty = "Item Qty".localized
                    vc.lblProductQty.text = "\(itemQty): \(orderDetailData?.data?.item_detail? [selectedTag].qty ?? 0)"
                    vc.lblProductName.text = "\(orderDetailData?.data?.item_detail? [selectedTag].pro_name ?? "")"

                    vc.imgProduct.sd_setImage(with: URL(string: orderDetailData?.data?.item_detail?[selectedTag].product_pic ?? ""), placeholderImage: UIImage(named: "profile_white.png"))

                    vc.orderId = orderDetailData?.data?.order_id ?? ""
                    vc.itemId = orderDetailData?.data?.item_detail? [selectedTag].item_id ?? 0

                  
                    self.present(vc, animated: true, completion: nil)

                }
            }
        }
    }
    
    
    func callReduceQuantityApi(selectedTag : Int){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["reason_for":"7",
                     "reason_at":"3",
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.reasonforreturn)
        ServerCalls.postRequest(Service.reasonforreturn, withParameters: param) { [self] (response, success) in
            if success{
                
                if let body = response as? [String: Any] {
                    self.reasonListData  = Mapper<reasonlistData>().map(JSON: body)
                    
                    print(self.reasonListData?.data?.reason_list ?? "")
                    
                    let vc = PopUpReduceQuantityViewController(nibName: "PopUpReduceQuantityViewController", bundle: nil)
                    vc.delegateDelegate = self
                    vc.modalPresentationStyle = .overFullScreen
                    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                    vc.reasonListData =  self.reasonListData
                    
                    let itemQty = "Item Qty".localized
                    vc.lblProductQty.text = "\(itemQty): \(orderDetailData?.data?.item_detail? [selectedTag].qty ?? 0)"
                    vc.lblProductName.text = "\(orderDetailData?.data?.item_detail? [selectedTag].pro_name ?? "")"

                    vc.imgProduct.sd_setImage(with: URL(string: orderDetailData?.data?.item_detail?[selectedTag].product_pic ?? ""), placeholderImage: UIImage(named: "profile_white.png"))

                    vc.orderId = orderDetailData?.data?.order_id ?? ""
                    vc.itemId = orderDetailData?.data?.item_detail? [selectedTag].item_id ?? 0

                    self.present(vc, animated: true, completion: nil)
                    
                    self.tableView.reloadData()

                }
            }
        }
    }
    
    
    
    
    func callAgentReachedToBoStore(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["order_id": orderId,
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.agentReachedToBoStore)
        ServerCalls.postRequest(Service.agentReachedToBoStore, withParameters: param) { [self] (response, success) in
            if success{
                
                    if let value = response as? NSDictionary{
                        let msg = value.object(forKey: "error_description") as! String
                        let error = value.object(forKey: "error_code") as! Int
                        if error == 100{
                            ModalController.showNegativeCustomAlertWith(title:msg, msg: "")
                        }else{
    //                        self.imageId = ""
                            ModalController.showSuccessCustomAlertWith(title:msg, msg: "")
                            print("msggggggggggg")
                            self.getOrderDetail()
     
                        }
                    }
                    else{
                        ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                    }
     
            }
        }
    }
    
    
    func callAgentConfirmToReceivItems(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["order_id": orderId,
                     "user_id":userId,
                     "user_type":"\(orderDetailData?.data?.user_type ?? "")",
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.agentConfirmToReceiveItems)
        ServerCalls.postRequest(Service.agentConfirmToReceiveItems, withParameters: param) { [self] (response, success) in
            if success{
                
                    if let value = response as? NSDictionary{
                        let msg = value.object(forKey: "error_description") as! String
                        let error = value.object(forKey: "error_code") as! Int
                        if error == 100{
                            ModalController.showNegativeCustomAlertWith(title:msg, msg: "")
                        }else{
    //                        self.imageId = ""
                            ModalController.showSuccessCustomAlertWith(title:msg, msg: "")
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
    }
    
    
    func deleteClicked(_ sender: Any) {
        print("delete")
        callReasonForReturnApi(selectedTag: (sender as AnyObject).tag)
    }
    
    func reduceQuantityClicked(_ sender: Any) {
        print("reduce")
        
        callReduceQuantityApi(selectedTag: (sender as AnyObject).tag)
    }
    
    func cartClicked(_ sender: Any) {
        print("cart")
        
        let vc = PopUpAcceptProductViewController(nibName: "PopUpAcceptProductViewController", bundle: nil)
//                    vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.present(vc, animated: true, completion: nil)
    }
    
    func acceptClicked(_ sender: Any) {
        
        
        if orderDetailData?.data?.user_type == "BO"  {
            print("bo")
        }else
        {
    
            if checkInvoiceUploaded == true || orderDetailData?.data?.order_status == 3 || orderDetailData?.data?.order_status == 2 || orderDetailData?.data?.item_detail?[(sender as AnyObject).tag].item_status == 3 || orderDetailData?.data?.item_detail?[(sender as AnyObject).tag].item_status == 1 {
                
            }else
            {
      
//        let vc = PopUpAcceptProductViewController(nibName: "PopUpAcceptProductViewController", bundle: nil)
//                vc.itemId = orderDetailData?.data?.item_detail?[(sender as AnyObject).tag].item_id ?? 0
//        vc.delegate = self
//        vc.modalPresentationStyle = .overFullScreen
//        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//            self.present(vc, animated: true, completion: nil)
                callAcceptIndivisualItems(itemId: orderDetailData?.data?.item_detail?[(sender as AnyObject).tag].item_id ?? 0)
        }
        }
    }
    
    func anyProblemClicked(_ sender: Any) {
//        let vc = CancelReasonViewController(nibName: "CancelReasonViewController", bundle: nil)
////      vc.delegate = self
//        vc.modalPresentationStyle = .overFullScreen
//        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        self.present(vc, animated: true, completion: nil)
        
        if orderDetailData?.data?.order_status == 3 && orderDetailData?.data?.report_to_bo == true {
            callReportTOBo()
        }else
        {
        
        let vc = CancelReasonViewController()
//        vc.orderId = tripListListArray?[indexPath.row].order_id ?? ""
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func ClickedAnyProblem(_ sender: Any) {
        let vc = CancelReasonViewController()
//        vc.orderId = tripListListArray?[indexPath.row].order_id ?? ""
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func ClickedReceivedItem(_ sender: Any) {
        let index = IndexPath(row: 0, section: 2)
           let cell: ConfirmToreceiveItemTableViewCell = self.tableView.cellForRow(at: index) as! ConfirmToreceiveItemTableViewCell
        
        if cell.btnReceiveItemOutlet.isSelected == true {
            cell.imgCheck.image = #imageLiteral(resourceName: "uncheck")
            cell.btnReceiveItemOutlet.isSelected = false
            checkReceivedItem = false
        }else
        {

        cell.imgCheck.image = #imageLiteral(resourceName: "check")
        cell.btnReceiveItemOutlet.isSelected = true
            checkReceivedItem = true
//        self.tableView.reloadSections([2], with: .automatic)
        }
//        self.tableView.reloadSections([2], with: .automatic)
        self.tableView.reloadData()
    }
    
    
    
    func uploadClicked(_ sender: Any) {
        let vc = GalleryPopUpViewController(nibName: "GalleryPopUpViewController", bundle: nil)
       
        vc.choosenOption = { (str) in
            OpenGallery.shared.delegate = self
            OpenGallery.shared.viewControl = self
            
            if str == "Camera".localized{
                OpenGallery.shared.delegate = self
                OpenGallery.shared.viewControl = self
                OpenGallery.shared.openCamera()
            }else{
                OpenGallery.shared.delegate = self
                OpenGallery.shared.viewControl = self
                OpenGallery.shared.openGallery()
                //self.imgaes()
            }
        }
        let popupController = MTPopupController(rootViewController: vc)
        popupController.autoAdjustKeyboardEvent = false
        popupController.style = .bottomSheet
        popupController.navigationBarHidden = true
        popupController.hidesCloseButton = false
        let blurEffect = UIBlurEffect(style: .dark)
        popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
        popupController.backgroundView?.alpha = 0.6
        popupController.containerView?.backgroundColor = UIColor.clear
        popupController.backgroundView?.onClick {
            popupController.dismiss()
        }
        popupController.present(in: self)
        
    }
    
    
    //arv
    
    
    func openCamera(){
        let imagePicker = UIImagePickerController()
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func  openGallery()
    {
        let imagePicker = UIImagePickerController()
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.dismiss(animated: true, completion: nil)
        }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            self.dismiss(animated: true, completion: nil)
            guard let selectedImage = info[.originalImage] as? UIImage else {
                print("Image not found!")
                return
            }
          
            let selectedImageNew = selectedImage.resizeWithWidth(width: 700)!
            let compressData = selectedImageNew.jpegData(compressionQuality: 0.8) //max value is 1.0 and minimum is 0.0
            let compressedImage = UIImage(data: compressData!)
            
            
      //   self.profileImg.image = compressedImage
     //     UploadProfileImage_API()
    //        self.profileImg.image = selectedImage
    //        UploadProfileImage_API(img: selectedImage)
        }
        
        func gallery(img: UIImage, imgtype: String) {
//            self.profileImg.image = img
            
            selectedImg = img
            print(img)
            self.tableView.reloadSections([3], with: .automatic)
//            UploadInvoice_API()
        }
    
        func UploadInvoice_API()
        {
            
            let str = "\(Constant.BASE_URL)\(Constant.upload_invoice)"

            let param = [
                "user_id":"\(Singleton.shared.getUserId())","lang_code":"\(HeaderHeightSingleton.shared.LanguageSelected)","order_id":"\(orderDetailData?.data?.order_id ?? "")","tta_without_vat":amoutnWithoutVat,"vat_amount":vatAmount,"tta_with_vat":amoutWithVat
            ]
            print(param)


            ModalClass.startLoading(self.view)

            ServerCalls.fileUploadAPINew(inputUrl: str, parameters: param, imageName: "invoice", imageFile:selectedImg) { (response, success, resp) in

                ModalClass.stopLoading()
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
    
    
    func UploadInvoice_APIForBo()
    {
        
        let str = "\(Constant.BASE_URL)\(Constant.upload_invoiceForBo)"

        let param = [
            "user_id":"\(Singleton.shared.getUserId())","lang_code":"\(HeaderHeightSingleton.shared.LanguageSelected)","order_id":"\(orderDetailData?.data?.order_id ?? "")"
        ]
        print(param)


        ModalClass.startLoading(self.view)

        ServerCalls.fileUploadAPINew(inputUrl: str, parameters: param, imageName: "invoice", imageFile:selectedImg) { (response, success, resp) in

            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    ModalController.showNegativeCustomAlertWith(title:msg, msg: "")
                }else{
//                        self.imageId = ""
                    ModalController.showSuccessCustomAlertWith(title:msg, msg: "")
                    print("msggggggggggg")
                    
                    self.getOrderDetail()

                }
            }
            else{
                ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
            }
        }
    }
    func callAcceptIndivisualItems(itemId : Int){

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
                    self.getOrderDetail()
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
    
    
    func callReportTOBo(){
        
       
        let str = Service.reportToBoByAgent
        let param = ["user_id":Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"order_id":orderDetailData?.data?.order_id ?? "0"] as [String : Any]
        print(param)
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
           
          
            
            ModalClass.stopLoadingAllLoaders(self.view)
            if success == true {
                
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
                ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "error_description") as? String)!, msg: "")

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
          
        }
    }
    
    
    
    
    @IBAction func tapToBtnUploadInvoice(_ sender: UIButton) {
        
        if orderDetailData?.data?.user_type == "BO" {
            
           /*
            switch orderDetailData?.data?.is_agent_reached {
            case 0:
                callAgentReachedToBoStore()
              
            case 1:
                
                if selectedImg == nil{
                    ModalController.showNegativeCustomAlertWith(title: "", msg: "Please add invoice file".localized)
                    return
                }
                UploadInvoice_APIForBo()
            case 2:
                if checkReceivedItem == false {
                    ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Check i received the items from BO".localized)
                    return
                   }
                
                callAgentConfirmToReceivItems()
               
           
            default:
                return
              }
        */
            
            //Mark new Design change
            if checkReceivedItem == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Check i received the items from BO".localized)
                return
               }
            callAgentConfirmToReceivItems()
            
        }else
        {
        
        switch orderDetailData?.data?.order_status {
        case 0:
            checkValidation()
          
        case 4:
            let vc = CommonPopViewC(nibName: "CommonPopViewC", bundle: nil)
//          vc.delegate = self
            vc.orderId = orderId
            vc.modalPresentationStyle = .overFullScreen
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                self.present(vc, animated: true, completion: nil)
       
        default:
            return
          }
        }
    
    }
    
    
    
    func checkValidation(){
        
        
        if isInvoiceEnable == false{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please accept / reject all products in the order ".localized)
            return
        }
        
        if selectedImg == nil{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please add invoice file".localized)
            return
        }
        if self.amoutnWithoutVat == ""{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter total amount without vat".localized)
            return
        }
        if orderDetailData?.data?.is_vat_available == true  {
            if self.vatAmount == "" {
                ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter vat amount".localized)
                return
            }
           
        }
        
        UploadInvoice_API()
        
    }
    
    
    func checkValidationForBo(){
       
        if isInvoiceEnable == false{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please accept / reject all products in the order ".localized)
            return
        }
        
        if selectedImg == nil{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please add invoice file".localized)
            return
        }
        if self.amoutnWithoutVat == ""{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter total amount without vat".localized)
            return
        }
        if orderDetailData?.data?.is_vat_available == true{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter vat amount".localized)
            return
        }
        
        UploadInvoice_API()
        
    }
    
    
    
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 1000{
            amoutnWithoutVat = textField.text!
        }else if textField.tag == 1001 {
            vatAmount = textField.text!
        }else
        {
            amoutWithVat = textField.text!
        }
        let index = IndexPath(row: 0, section: 3)
        let cell: AddInvoiceInformationTableViewCell = self.tableView.cellForRow(at: index) as! AddInvoiceInformationTableViewCell
        
        
        let totalWtVat = Double(cell.txtTotalAmtWithoughtVat.text!) ?? 0.0
        let Vat = Double(cell.txtVatAmt.text!) ?? 0.0
        
        let total = Double(totalWtVat) + Double(Vat)
        
        cell.txtTotalAmountWithVat.text = "\(total)"
        

           self.amoutnWithoutVat = cell.txtTotalAmtWithoughtVat.text!
           self.vatAmount = cell.txtVatAmt.text!
           self.amoutWithVat = cell.txtTotalAmountWithVat.text!
        
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
    
    
    // Mark--button status for bo
    
    func callMainButtonstatusForBO()  {
        /*
        switch orderDetailData?.data?.is_agent_reached {
        case 0:
            self.btnChangeStatus.setTitle("I have reached BO's store".localized, for: .normal)
           
        case 1:
            self.btnChangeStatus.setTitle("Confirm & Upload Invoice".localized, for: .normal)
        case 2:
            self.btnChangeStatus.setTitle("Confirm to received items".localized, for: .normal)
            
            Singleton.shared.setDeliveryDashBoardTabID(tabId: 2)
            Singleton.shared.setDelServiceID(delServiceId: "\((orderDetailData?.data?.del_service_id)!)")
           
        default:
           print("")
        }
        
 */
        //Mark new Design change
        
        self.btnChangeStatus.setTitle("Confirm to received items".localized, for: .normal)
        
        Singleton.shared.setDeliveryDashBoardTabID(tabId: 2)
        Singleton.shared.setDelServiceID(delServiceId: "\((orderDetailData?.data?.del_service_id)!)")
        //
        
        if orderDetailData?.data?.is_agent_reached == 2 && orderDetailData?.data?.order_status == 1 {
            self.btnChangeStatus.setTitle("Invoice Uploaded".localized, for: .normal)
            
        }else if  orderDetailData?.data?.is_agent_reached == 2 && orderDetailData?.data?.order_status == 2 {
            self.btnChangeStatus.setTitle("Delivered".localized, for: .normal)
            self.btnChangeStatus.isUserInteractionEnabled = false
            self.btnChangeStatus.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
            Singleton.shared.setDeliveryDashBoardTabID(tabId: 3)
            Singleton.shared.setDelServiceID(delServiceId: "\((orderDetailData?.data?.del_service_id)!)")
        }
        
        if orderDetailData?.data?.order_status == 3 {
            self.btnChangeStatus.setTitle("CancelledStatus".localized, for: .normal)
            self.btnChangeStatus.isUserInteractionEnabled = false
            self.btnChangeStatus.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            Singleton.shared.setDeliveryDashBoardTabID(tabId: 4)
            Singleton.shared.setDelServiceID(delServiceId: "\((orderDetailData?.data?.del_service_id)!)")
        }
    }
    
    
    
    func entryCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AddInvoiceInformationTableViewCell",for: index) as! AddInvoiceInformationTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        
//        cell.emailField.isUserInteractionEnabled = false
        cell.txtTotalAmtWithoughtVat.keyboardType = .decimalPad
        cell.txtVatAmt.keyboardType = .decimalPad
        cell.txtTotalAmountWithVat.keyboardType = .decimalPad
        
        cell.txtTotalAmtWithoughtVat.addTarget(self, action: #selector(ProductDetailsViewC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.txtVatAmt.addTarget(self, action: #selector(ProductDetailsViewC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        cell.txtTotalAmountWithVat.addTarget(self, action: #selector(ProductDetailsViewC.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        cell.txtTotalAmtWithoughtVat.tag = 1000
        cell.txtVatAmt.tag = 1001
        cell.txtTotalAmtWithoughtVat.delegate = self
        cell.txtVatAmt.delegate = self
        cell.txtTotalAmountWithVat.delegate = self
        
        cell.lblAlmostAmountPrice.text = "\(orderDetailData?.data?.currency_code ?? "") " + "\(orderDetailData?.data?.order_price ?? 0)"
      
        if selectedImg != nil {
            cell.tapToBtnUploadInvoice.setImage(selectedImg, for: .normal)
            cell.imgInvoiceUploaded.isHidden = false
        }

        if isInvoiceEnable == false {
//            cell.viewForShowHide.isUserInteractionEnabled = false
            cell.viewForShowHide.alpha = 0.8
            cell.tapToBtnUploadInvoice.isUserInteractionEnabled = false
            cell.txtTotalAmtWithoughtVat.isUserInteractionEnabled = false
            cell.txtVatAmt.isUserInteractionEnabled = false
            cell.txtTotalAmountWithVat.isUserInteractionEnabled = false
            cell.btnAnyProblem.isUserInteractionEnabled = true
            
        }else
        {
            cell.viewForShowHide.isUserInteractionEnabled = true
            cell.viewForShowHide.alpha = 1
            cell.tapToBtnUploadInvoice.isUserInteractionEnabled = true
            cell.txtTotalAmtWithoughtVat.isUserInteractionEnabled = true
            if orderDetailData?.data?.is_vat_available == true {
                cell.txtVatAmt.isUserInteractionEnabled = true
            }
           
            cell.txtTotalAmountWithVat.isUserInteractionEnabled = true
            cell.btnAnyProblem.isUserInteractionEnabled = true
        }
        if ((orderDetailData?.data?.is_vat_available) == false){

            cell.txtVatAmt.isUserInteractionEnabled = false
        }
        
        switch orderDetailData?.data?.order_status {
        case 3:
            self.btnChangeStatus.setTitle("CancelledStatus".localized, for: .normal)
            self.btnChangeStatus.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.btnChangeStatus.isUserInteractionEnabled = false
            cell.contentView.isUserInteractionEnabled = false
            Singleton.shared.setDeliveryDashBoardTabID(tabId: 4)
            Singleton.shared.setDelServiceID(delServiceId: "\((orderDetailData?.data?.del_service_id)!)")
            
            if orderDetailData?.data?.report_to_bo == true {
                cell.btnAnyProblem.isHidden = false
//                cell.btnAnyProblem.setTitle("Report Business Owner", for: .normal)
//                let myNormalAttributedTitle = NSAttributedString(string: "Report Business Owner".localized,attributes: [NSAttributedString.Key.foregroundColor : UIColor.AppThemeBlueTextColor(),.underlineStyle: NSUnderlineStyle.single.rawValue])
//                cell.btnAnyProblem.setAttributedTitle(myNormalAttributedTitle, for: .normal)
                
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
                let lineView1 = UIView(frame: CGRect(x: 0, y: cell.btnAnyProblem.frame.size.height - 12, width: ("Report Business Owner".localized ).widthOfString(usingFont: UIFont(name: "\(fontNameLight)", size: 12)!), height: 0.6))
                lineView1.backgroundColor = Constant.Blue_TEXT_COLOR
                cell.btnAnyProblem.addSubview(lineView1)
                cell.btnAnyProblem.setTitle("Report Business Owner".localized, for: .normal)
                cell.btnAnyProblem.titleLabel?.textColor = Constant.Blue_TEXT_COLOR
                
                cell.contentView.isUserInteractionEnabled = true
                cell.tapToBtnUploadInvoice.isUserInteractionEnabled = false
                cell.txtTotalAmtWithoughtVat.isUserInteractionEnabled = false
                cell.txtVatAmt.isUserInteractionEnabled = false
                cell.txtTotalAmountWithVat.isUserInteractionEnabled = false
            }else
            {
            cell.btnAnyProblem.isHidden = true
            }
        case 2:
            self.btnChangeStatus.setTitle("Delivered".localized, for: .normal)
            self.btnChangeStatus.isUserInteractionEnabled = false
            self.btnChangeStatus.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.imgInvoiceUploaded.isHidden = false
            cell.btnAnyProblem.isHidden = true
            cell.contentView.isUserInteractionEnabled = false
            
            cell.tapToBtnUploadInvoice.sd_setImage(with: URL(string: orderDetailData?.data?.invoice_image ?? ""), for: .normal, placeholderImage: UIImage(named: "profile_white.png"))
            
            cell.txtTotalAmtWithoughtVat.text = "\(orderDetailData?.data?.total_amount_without_vat ?? 0)"
            cell.txtVatAmt.text = "\(orderDetailData?.data?.vat_amount ?? 0)"
            cell.txtTotalAmountWithVat.text = "\(orderDetailData?.data?.total_amount_with_vat ?? 0)"
//            cell.btnAnyProblem.isHidden = false
            Singleton.shared.setDeliveryDashBoardTabID(tabId: 3)
            Singleton.shared.setDelServiceID(delServiceId: "\((orderDetailData?.data?.del_service_id)!)")
        case 4:
            self.btnChangeStatus.setTitle("Cancel Request Received".localized, for: .normal)
            Singleton.shared.setDeliveryDashBoardTabID(tabId: 4)
            Singleton.shared.setDelServiceID(delServiceId: "\((orderDetailData?.data?.del_service_id)!)")
        default:
            self.btnChangeStatus.setTitle("Confirm and upload invoice".localized, for: .disabled)
            //Done
            Singleton.shared.setDeliveryDashBoardTabID(tabId: 2)
            Singleton.shared.setDelServiceID(delServiceId: "\((orderDetailData?.data?.del_service_id)!)")
        }
        if checkInvoiceUploaded == true {
            self.btnChangeStatus.setTitle("Invoice Uploaded".localized, for: .normal)
            self.btnChangeStatus.isUserInteractionEnabled = false
            
            cell.imgInvoiceUploaded.isHidden = false
            cell.btnAnyProblem.isHidden = true
            cell.contentView.isUserInteractionEnabled = false
            
            cell.tapToBtnUploadInvoice.sd_setImage(with: URL(string: orderDetailData?.data?.invoice_image ?? ""), for: .normal, placeholderImage: UIImage(named: "profile_white.png"))
            
            cell.txtTotalAmtWithoughtVat.text = "\(orderDetailData?.data?.total_amount_without_vat ?? 0)"
            cell.txtVatAmt.text = "\(orderDetailData?.data?.vat_amount ?? 0)"
            cell.txtTotalAmountWithVat.text = "\(orderDetailData?.data?.total_amount_with_vat ?? 0)"
        }
        
        
        return cell
    }
    
    
    
    func entryCellForBo(index : IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AddInvoiceInformationTableViewCell",for: index) as! AddInvoiceInformationTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.viewForBoToAgent.isHidden = false

        
        cell.lblAlmostAmountPrice.text = "\(orderDetailData?.data?.currency_code ?? "") " + "\(orderDetailData?.data?.order_price ?? 0)"
        
        cell.lblAlmostAmount.text = "Total Amount".localized
        if selectedImg != nil {
            cell.tapToBtnUploadInvoice.setImage(selectedImg, for: .normal)
            cell.imgInvoiceUploaded.isHidden = false
        }

        if isInvoiceEnable == false {
            cell.viewForShowHide.isUserInteractionEnabled = false
            cell.viewForShowHide.alpha = 0.5
        }else
        {
            cell.viewForShowHide.isUserInteractionEnabled = true
            cell.viewForShowHide.alpha = 1
            
        }

       
        
//        switch orderDetailData?.data?.is_agent_reached {
//        case 0:
//            self.btnChangeStatus.setTitle("I have reached BO's store".localized, for: .normal)
//            cell.tapToBtnUploadInvoice.isUserInteractionEnabled = false
//
//
//        case 1:
//            self.btnChangeStatus.setTitle("Confirm & Upload Invoice".localized, for: .normal)
//            cell.tapToBtnUploadInvoice.isUserInteractionEnabled = true
//        case 2:
//            self.btnChangeStatus.setTitle("Confirm to received Items".localized, for: .normal)
//
//        default:
//           print("")
//        }
        
        
        
        
        if checkInvoiceUploaded == true {
            self.btnChangeStatus.setTitle("Invoice Uploaded".localized, for: .normal)
            self.btnChangeStatus.isUserInteractionEnabled = false
            
            cell.imgInvoiceUploaded.isHidden = false
            cell.btnAnyProblem.isHidden = true
            cell.contentView.isUserInteractionEnabled = false
            
            cell.tapToBtnUploadInvoice.sd_setImage(with: URL(string: orderDetailData?.data?.invoice_image ?? ""), for: .normal, placeholderImage: UIImage(named: "profile_white.png"))
            
            cell.txtTotalAmtWithoughtVat.text = "\(orderDetailData?.data?.total_amount_without_vat ?? 0)"
            cell.txtVatAmt.text = "\(orderDetailData?.data?.vat_amount ?? 0)"
            cell.txtTotalAmountWithVat.text = "\(orderDetailData?.data?.total_amount_with_vat ?? 0)"
        }
        
        
        return cell
    }
    
    
    
    func entryCellForBoConfirmForReceiveItem(index : IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ConfirmToreceiveItemTableViewCell",for: index) as! ConfirmToreceiveItemTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
       
        let ItemQty = "Box Qty".localized
        
        cell.lblQty.text = "\(ItemQty): 0\(orderDetailData?.data?.item_detail? [index.row].qty ?? 0)"
        let totalWeight = "Total Weight".localized
        let kg = "kg".localized
        let cm = "cm".localized
        cell.lblOrderId.text = "\(totalWeight):  \(orderDetailData?.data?.total_weight ?? 0.0)\(kg)"
        let totalSize = "Total Size".localized
        cell.lblDate.text = "\(totalSize):  \(orderDetailData?.data?.total_size ?? 0.0)\(cm)"

        let testString = "\(orderDetailData?.data?.otp ?? "")"
        let ansTest = testString.enumerated().compactMap({ ($0 > 0) && ($0 % 1 == 0) ? "  \($1)" : "\($1)" }).joined()
        cell.lblOtp.text =  ansTest
        
        cell.lblOrderPrice.text = "\(orderDetailData?.data?.delivery_price ?? "0.00")"
        cell.imgPaymentIcon.sd_setImage(with: URL(string: orderDetailData?.data?.payment_icon ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
        cell.lblCurrency.text = orderDetailData?.data?.currency_code
        
//        switch orderDetailData?.data?.is_agent_reached {
//        case 0:
//            self.btnChangeStatus.setTitle("I have reached BO's store".localized, for: .normal)
//            cell.tapToBtnUploadInvoice.isUserInteractionEnabled = false
//
//
//        case 1:
//            self.btnChangeStatus.setTitle("Confirm & Upload Invoice".localized, for: .normal)
//            cell.tapToBtnUploadInvoice.isUserInteractionEnabled = true
//        case 2:
//            self.btnChangeStatus.setTitle("Confirm to received Items".localized, for: .normal)
//
//        default:
//           print("")
//        }
        
        
        
        
//        if checkInvoiceUploaded == true {
//            self.btnChangeStatus.setTitle("Invoice Uploaded".localized, for: .normal)
//            self.btnChangeStatus.isUserInteractionEnabled = false
//
//            cell.imgInvoiceUploaded.isHidden = false
//            cell.btnAnyProblem.isHidden = true
//            cell.contentView.isUserInteractionEnabled = false
//
//            cell.tapToBtnUploadInvoice.sd_setImage(with: URL(string: orderDetailData?.data?.invoice_image ?? ""), for: .normal, placeholderImage: UIImage(named: "profile_white.png"))
//
//            cell.txtTotalAmtWithoughtVat.text = "\(orderDetailData?.data?.total_amount_without_vat ?? 0)"
//            cell.txtVatAmt.text = "\(orderDetailData?.data?.vat_amount ?? 0)"
//            cell.txtTotalAmountWithVat.text = "\(orderDetailData?.data?.total_amount_with_vat ?? 0)"
//        }
        
        
        return cell
    }
    
    
    
    func productListCellForBo(index : IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell",for: index) as! ProductListTableViewCell
        
           
                cell.selectionStyle = .none
                cell.btnDelete.isHidden = true
                cell.btnReduceQuantity.isHidden = true
                cell.lblLineReduceQty.isHidden = true
                cell.btnAccept.isHidden = true
        let ItemQty = "Item Qty".localized
        
        cell.lblQty.text = "\(ItemQty): 0\(orderDetailData?.data?.item_detail? [index.row].qty ?? 0)"
        cell.lblAddress.text = orderDetailData?.data?.item_detail? [index.row].pro_name ?? ""
        let Items_price_Almost = "Items price :".localized
        cell.lblPriceAlmost.text = "\(Items_price_Almost) \(orderDetailData?.data?.item_detail? [index.row].currency_code ?? "")\(orderDetailData?.data?.item_detail? [index.row].price ?? 0)"
        
        cell.imgProduct.sd_setImage(with: URL(string: orderDetailData?.data?.item_detail?[index.row].product_pic ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                if orderDetailData?.data?.order_status == 3 {
                    cell.imgCart.image = #imageLiteral(resourceName: "shopping-cartgrayCross")
                    
                }else
                {
                    cell.imgCart.image = #imageLiteral(resourceName: "shopping-cartGreen")
                }
        
            if checkInvoiceUploaded == true {
                cell.contentView.isUserInteractionEnabled = false
                
            }
       
            cell.delegate = self
        

            
            return cell
        }
    
    
    func addeddNewViewForBo(index : IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AddedNewViewBoTableViewCell",for: index) as! AddedNewViewBoTableViewCell
        
        cell.lblExptViewHeight.constant = 0
        cell.viewExptDel.isHidden = true
        cell.stackUpperConstant.constant = 0
        
        if orderDetailData?.data?.order_status == 3 {
            cell.lblCancelReason.isHidden = false
        }
        
        
        let boxQty = "Box Qty".localized
        
        cell.lblBoxQty.text = "\(boxQty): 0\(orderDetailData?.data?.order_qty ?? 0)"
        let totalWeight = "Total Weight".localized
        let kg = "kg".localized
        let cm = "cm".localized
        cell.lblOrderId.text = "\(totalWeight):  \(orderDetailData?.data?.total_weight ?? 0.0)\(kg)"
        let totalSize = "Total Size".localized
        cell.lblSize.text = "\(totalSize):  \(orderDetailData?.data?.total_size ?? 0.0)\(cm)"

        
        cell.lblCurrencyCode.text = "\(orderDetailData?.data?.currency_code ?? "")"
        cell.order_price.text = "\(orderDetailData?.data?.delivery_price ?? "")"
        let cancellationReason = "Cancellation Reason".localized
        cell.lblCancelReason.text = "\(cancellationReason):\(orderDetailData?.data?.cancellation_reason ?? "")"
        
        
        
            return cell
        
        }
    
 //arv
    
    
    
    func callGetDistance(){
           let dispatchGroup = DispatchGroup()
           
        let agentLat = Double.getDouble(self.orderDetailData?.data?.agent_lat)
           let agentLng = Double.getDouble(self.orderDetailData?.data?.agent_long)
           let boLat = Double.getDouble(self.orderDetailData?.data?.bo_lat)
           let boLng = Double.getDouble(self.orderDetailData?.data?.bo_long)
           let custLat = Double.getDouble(self.orderDetailData?.data?.cust_lat)
           let custLng = Double.getDouble(self.orderDetailData?.data?.cust_long)

           dispatchGroup.enter()   // <<---
        let distanceUrlFromAgentToBO = "\(Constant.GOOGLE_API_DISTANCE)origin=\(agentLat),\(agentLng)&destination=\(boLat),\(boLng)&key=\(Constant.GOOGLE_API_KEY)"
           agentViewModel.getDistance(distanceUrlFromAgentToBO) { (succes, response) in
               if succes{
//                   self.lblBoLocation.text = "\(response?.routes?.first?.legs?.first?.distance?.text ?? "")".uppercased()
                self.agentToBoDistance = (response.routes?.first?.legs?.first?.distance?.value ?? 0)
               
               
                   DispatchQueue.main.async {
                                
                                  dispatchGroup.leave()   // <<----
                              }
                
               }
           }

           dispatchGroup.enter()   // <<---
           let distanceUrlFromBOToCustomer = "\(Constant.GOOGLE_API_DISTANCE)origin=\(boLat),\(boLng)&destination=\(custLat),\(custLng)&key=\(Constant.GOOGLE_API_KEY)"
           agentViewModel.getDistance(distanceUrlFromBOToCustomer) { (succes, response) in
                      if succes{
//                       self.lblCustomerLocation.text = "\(response?.routes?.first?.legs?.first?.distance?.text ?? "")".uppercased()
                         self.boToCustomerDistancec = (response.routes?.first?.legs?.first?.distance?.value ?? 0)
                       
                       DispatchQueue.main.async {
                                    
                                      dispatchGroup.leave()   // <<----
                                  }
                      }
                  }

           dispatchGroup.notify(queue: .main) {
               // whatever you want to do when both are done
               self.calculateExpectedDelTime()
           }
       }
       
       func calculateExpectedDelTime()  {
           let agentToBoDist = agentToBoDistance/1000
           let BoToCustomerDist = boToCustomerDistancec/1000
           let totaldistance = (agentToBoDist + BoToCustomerDist)
           
           for i in 0...((self.orderDetailData?.data?.delivery_times?.count ?? 0) - 1) {
               
               guard let dataa = self.orderDetailData?.data?.delivery_times else {return}
               if totaldistance < Int((dataa[i]).distance ?? "") ?? 0{
                lblWatingTime = (dataa[i]).time ?? ""
                   checkcondition = true
                self.tableView.reloadSections([1], with: .automatic)
                   break
               }
           }
           if checkcondition == false {
            lblWatingTime = self.orderDetailData?.data?.delivery_times?[((self.orderDetailData?.data?.delivery_times?.count ?? 0) - 1)].time ?? ""
            self.tableView.reloadSections([1], with: .automatic)
           }
       }

    
    
    
    func calculateDistanceFromLatLong() {
        
        
//        self.reloadTableData()
        
        let distanceFromAgentToBo = calculateDistance(mobileLocationX:Double.getDouble(orderDetailData?.data?.agent_lat ?? ""), mobileLocationY:Double.getDouble(orderDetailData?.data?.agent_long ?? ""), DestinationX:Double.getDouble(orderDetailData?.data?.bo_lat ?? ""), DestinationY:Double.getDouble(orderDetailData?.data?.bo_long ?? ""))

        print("distanceFromAgentToBo = \(distanceFromAgentToBo)")
        
        
        
        let distanceFromBoToCustomer = calculateDistance(mobileLocationX:Double.getDouble(orderDetailData?.data?.bo_lat ?? ""), mobileLocationY:Double.getDouble(orderDetailData?.data?.bo_long ?? ""), DestinationX:Double.getDouble(orderDetailData?.data?.cust_lat ?? ""), DestinationY:Double.getDouble(orderDetailData?.data?.cust_long ?? ""))

        print("distanceFromBoToCustomer = \(distanceFromBoToCustomer)")
        
        let totalDistance = distanceFromAgentToBo+distanceFromBoToCustomer
        
        print("Total distance = \(totalDistance)")
      
    }
    
    
    func callCalculateDistance(){

          let agentLat = Double.getDouble(orderDetailData?.data?.agent_lat)
          let agentLng = Double.getDouble(orderDetailData?.data?.agent_long)
          let boLat = Double.getDouble(orderDetailData?.data?.bo_lat)
          let boLng = Double.getDouble(orderDetailData?.data?.bo_long)
          let custLat = Double.getDouble(orderDetailData?.data?.cust_lat)
          let custLng = Double.getDouble(orderDetailData?.data?.cust_long)
          
        let distanceUrlFromAgentToBO = "\(Constant.GOOGLE_API_DISTANCE)origin=\(agentLat),\(agentLng)&destination=\(boLat),\(boLng)&key=\(Constant.GOOGLE_API_KEY)"
          agentViewModel.getDistance(distanceUrlFromAgentToBO) { (succes, response) in
              if succes{
                self.distanceAgentToBo = "\(response.routes?.first?.legs?.first?.distance?.text ?? "")".uppercased()
                print("distAgToBO = \(self.distanceAgentToBo)")
              }
          }
        let distanceUrlFromBOToCustomer = "\(Constant.GOOGLE_API_DISTANCE)origin=\(boLat),\(boLng)&destination=\(custLat),\(custLng)&key=\(Constant.GOOGLE_API_KEY)"
          agentViewModel.getDistance(distanceUrlFromBOToCustomer) { (succes, response) in
                     if succes{
                        self.distanceBoToCustomer = "\(response.routes?.first?.legs?.first?.distance?.text ?? "")".uppercased()
                        print("distBoToCustomer = \(self.distanceBoToCustomer)")
                     }
                 }
     
      }
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
//        if orderDetailData?.data?.user_type == "BO"  {
//            print("bo")
//        }else
//        {
//
//        if indexPath.section == 2 {
//
//            if checkInvoiceUploaded == true || orderDetailData?.data?.order_status == 3 || orderDetailData?.data?.order_status == 2 || orderDetailData?.data?.item_detail?[indexPath.row].item_status == 3  {
//
//            }else
//            {
//
//        let vc = PopUpAcceptProductViewController(nibName: "PopUpAcceptProductViewController", bundle: nil)
//        vc.itemId = orderDetailData?.data?.item_detail?[indexPath.row].item_id ?? 0
//        vc.delegate = self
//        vc.modalPresentationStyle = .overFullScreen
//        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//            self.present(vc, animated: true, completion: nil)
//        }
//
//        }
//        }
    
    }
 
}

extension ProductDetailsViewC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
//        if ((orderDetailData?.data?.user_type == "BO") && (orderDetailData?.data?.is_agent_reached == 2) && (orderDetailData?.data?.order_status == 0)){
//            return 3
        
        //Mark new design change
        
        if ((orderDetailData?.data?.user_type == "BO")){
            return 3
            
        }else
        {
            return 4
        }
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            
//            if ((orderDetailData?.data?.user_type == "BO") && (orderDetailData?.data?.is_agent_reached == 2) && (orderDetailData?.data?.order_status == 0))
//            {
//             return 1
            //Mark new design change
            if ((orderDetailData?.data?.user_type == "BO") && (orderDetailData?.data?.order_status == 0))
            {
             return 1
            
            }else
            {
            return orderDetailData?.data?.item_detail?.count ?? 0
            }
        }else
        {
            return orderDetailData?.data?.item_detail?.count ?? 0 == 0 ? 0 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        

        if indexPath.section == 1{
            
//            if (orderDetailData?.data?.user_type == "BO") && (orderDetailData?.data?.is_agent_reached == 2)  {
//               return 180
            
            //Mark new design change
            if (orderDetailData?.data?.user_type == "BO"){
               return 180
                
            }else
            {
            
            if (orderDetailData?.data?.order_status == 3) || (orderDetailData?.data?.order_status == 2){
                return 280
            }else
            {
                return 320
            }
            }
        }else if indexPath.section == 3{
            return 380
        }else if indexPath.section == 0{
            return 170
        }else if indexPath.section == 2
        {
            if orderDetailData?.data?.user_type == "BO" {
//                if (orderDetailData?.data?.is_agent_reached) == 2 && (orderDetailData?.data?.order_status) == 0{
//                    return 350
//                }
                
                //Mark new design change
                   if (orderDetailData?.data?.order_status) == 0{
                       return 450
                   }else
                   {
                    return 250
                   }
            }
            if (orderDetailData?.data?.item_detail? [indexPath.row].reason ?? "") != "" {
                return 160
            }
//            return 160
            return UITableView.automaticDimension
        }else
        {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

                if indexPath.section == 0{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessOwnerTableViewCell",for: indexPath) as! BusinessOwnerTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
                    cell.lblBoName.text = orderDetailData?.data?.bo_name ?? ""
                    cell.lblBoAddress.text = orderDetailData?.data?.bo_address ?? ""
                    cell.bo_total_rating.text = "(\(orderDetailData?.data?.bo_total_rating ?? "0"))"
                    cell.bo_rating.text = orderDetailData?.data?.bo_rating ?? "0"
                    
                    cell.imgbo_pic.sd_setImage(with: URL(string: orderDetailData?.data?.bo_pic ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                    
                    
                    if orderDetailData?.data?.order_status == 3 || orderDetailData?.data?.order_status == 2{
                        
                        cell.btnNavWidth.constant = 0
                    }
                    
                    if checkInvoiceUploaded == true {
                        cell.btnNavWidth.constant = 0
                    }
                    
//                    cell.langugae.text = "\(deliverData?.data?.user_lang ?? "")"
            
//            cell.tripAchivementData = deliverData?.data?.agent_information?.trips_achievements
//            cell.collectionView.reloadData()
            
            return cell
                }else if indexPath.section == 1{
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BOCustomerTableViewCell",for: indexPath) as! BOCustomerTableViewCell
                    cell.selectionStyle = .none
                    cell.delegate = self
                    
                    cell.lblCustName.text = orderDetailData?.data?.cust_name ?? ""
                    cell.lblCustAddress.text = orderDetailData?.data?.cust_address ?? ""
                    
                    cell.lblQty.text = "0\(orderDetailData?.data?.order_qty ?? 0)"
                    cell.lblStAlmosttoalPrice.text = "Total Amount".localized
                    let orderId = "Order Id:".localized
                    cell.lblOrderId.text = "\(orderId) \(orderDetailData?.data?.order_id ?? "0")"
                    
                    let timeSTAMP = "\(orderDetailData?.data?.order_date ?? 0)"
                    
                    cell.lblOrderDate.text = ModalController.convert13DigitTimeStampIntoDate(timeStamp: timeSTAMP, format: "dd-MMM-yyyy HH:mm a")
                    
                    cell.lblCustrating.text = orderDetailData?.data?.cust_rating ?? "0"
                    cell.lblCusttotalrating.text = "(\(orderDetailData?.data?.cust_total_rating ?? "0"))"
                    cell.lblCurrencyCode.text = orderDetailData?.data?.currency_code ?? ""
                    
                    cell.order_price.text = "\(orderDetailData?.data?.order_price ?? 0.0)"
                    cell.imgCustpic.sd_setImage(with: URL(string: orderDetailData?.data?.cust_pic ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                    cell.imgPaymentIcon.sd_setImage(with: URL(string: orderDetailData?.data?.payment_icon ?? ""), placeholderImage: UIImage(named: "cod_icon"))
                    cell.lblTotalOrder.text = "0\(orderDetailData?.data?.total_accepted_order ?? 0)"
                    cell.lblTotalAcceptedOrder.text = "0\(orderDetailData?.data?.total_order ?? 0)"
                    
                    if (orderDetailData?.data?.total_accepted_order == orderDetailData?.data?.total_order) {
                        cell.lblTotalOrder.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                    }else
                    {
                        cell.lblTotalOrder.textColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
                    }
                    
                    if orderDetailData?.data?.order_status == 3 || orderDetailData?.data?.order_status == 2{
                        cell.viewForHideExpectedDelivery.constant = 50
                        cell.btnNavWidth.constant = 0
                    }
                    
                    if orderDetailData?.data?.user_type == "BO" {
                        
//                        if orderDetailData?.data?.is_agent_reached == 2{
//                            cell.viewFortotalOutoff.isHidden = true
//                        }
                        //Mark new design change
                        cell.viewFortotalOutoff.isHidden = true
                    }
                  
                    cell.lblTime.text = lblWatingTime
                    
                    return cell
                }else if indexPath.section == 3{
                    
                    if orderDetailData?.data?.user_type == "BO" {
                        
                        return entryCellForBo(index: indexPath)
                    }else
                    {
                    return entryCell(index: indexPath)
                    }
                    
                }else
                {
                    if orderDetailData?.data?.user_type == "BO"  {
//                        if ((orderDetailData?.data?.is_agent_reached == 2) &&  (orderDetailData?.data?.order_status == 0))  {
//                            return entryCellForBoConfirmForReceiveItem(index: indexPath)
//                        }else
//                        {
//                        return productListCellForBo(index: indexPath)
//                        }
                        
                        //Mark- New Design change
                        if (orderDetailData?.data?.order_status == 0){
                          return entryCellForBoConfirmForReceiveItem(index: indexPath)
                        }else
                        {
                            return addeddNewViewForBo(index: indexPath)
                        }
                       
                    }else
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell",for: indexPath) as! ProductListTableViewCell
                        cell.selectionStyle = .none
                    
                    if orderDetailData?.data?.item_detail? [indexPath.row].item_status == 0 {
                        cell.imgCart.image = #imageLiteral(resourceName: "Accepted")
                        cell.btnAccept.setTitle("Accept".localized, for: .normal)
                        cell.imgaccepted.image = #imageLiteral(resourceName: "accept")
                    }
                    if orderDetailData?.data?.item_detail? [indexPath.row].item_status == 1 {
                        cell.imgCart.image = #imageLiteral(resourceName: "shopping-cartGreen")
                        cell.btnAccept.setTitle("Accepted".localized, for: .normal)
                        cell.imgaccepted.image = #imageLiteral(resourceName: "accepted-1")
                    }
                    
                    if orderDetailData?.data?.item_detail? [indexPath.row].item_status == 2 || (orderDetailData?.data?.item_detail? [indexPath.row].item_status == 0 && orderDetailData?.data?.order_status == 3) || (orderDetailData?.data?.item_detail? [indexPath.row].item_status == 1 && orderDetailData?.data?.order_status == 3){
                        cell.imgCart.image = #imageLiteral(resourceName: "shopping-cartgrayCross")
//                        cell.btnReduceQuantity.isHidden = true
//                        cell.lblLineReduceQty.isHidden = true
                        cell.btnDelete.isHidden = true
                        cell.lblCancelReasonn.isHidden = false
                        cell.btnAccept.isHidden = true

                    }
                    
                    
//                    if orderDetailData?.data?.item_detail? [indexPath.row].item_status == 3 {
//                        cell.imgCart.image = #imageLiteral(resourceName: "Accepted")
//                        cell.lblLineReduceQty.isHidden = false
//                        cell.btnDelete.isHidden = false
//                        cell.btnDelete.alpha = 0.5
//                        cell.btnAccept.isHidden = false
//                    }
                    
                    
//                    if  orderDetailData?.data?.item_detail? [indexPath.row].qty ?? 0 < 2 && orderDetailData?.data?.item_detail? [indexPath.row].item_status == 1{
//                        cell.btnReduceQuantity.isHidden = true
//                        cell.lblLineReduceQty.isHidden = true
//                    }
                    
                    if  orderDetailData?.data?.item_detail? [indexPath.row].qty ?? 0 < 2 {
                        
                        cell.btnReduceQuantity.isHidden = true
                        cell.lblLineReduceQty.isHidden = true
                    }else
                    {
                        cell.btnReduceQuantity.isHidden = false
                        cell.lblLineReduceQty.isHidden = false
                        
                    }
                    
                    if orderDetailData?.data?.item_detail? [indexPath.row].item_status == 3{
                        cell.btnReduceQuantity.setTitle(orderDetailData?.data?.item_detail? [indexPath.row].reason, for: .normal)
                        cell.lblLineReduceQty.isHidden = true
                        cell.btnReduceQuantity.isUserInteractionEnabled = false
                        let fontNameLight = NSLocalizedString("LightFontName", comment: "")

                        cell.btnReduceQuantity.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
                        cell.btnReduceQuantity.titleLabel?.textColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
                        cell.btnAccept.isHidden = true
                        cell.imgCart.image = #imageLiteral(resourceName: "Accepted")
                        cell.btnDelete.isHidden = false
                        cell.btnDelete.alpha = 0.5
                       
                    }else
                    {
                        
                        cell.btnReduceQuantity.isUserInteractionEnabled = true
                        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
                        cell.btnReduceQuantity.setTitle("Reduce Qty", for: .normal)
                        cell.btnReduceQuantity.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:10)
                        cell.btnReduceQuantity.titleLabel?.textColor = UIColor.AppThemeBlueTextColor()
//                        cell.btnAccept.isHidden = false
                        cell.btnDelete.alpha = 1
                    }
                    
                    
                    let ItemQty = "Qty".localized
                    
                    cell.lblQty.text = "\(ItemQty):0\(orderDetailData?.data?.item_detail? [indexPath.row].qty ?? 0)"
                    cell.lblAddress.text = orderDetailData?.data?.item_detail? [indexPath.row].pro_name ?? ""
                    let Items_price_Almost = "Items price (Almost)".localized
                    cell.lblPriceAlmost.text = "\(Items_price_Almost):  \(orderDetailData?.data?.item_detail? [indexPath.row].price ?? 0)"
                        cell.lblCancelReasonn.text = "\(orderDetailData?.data?.item_detail? [indexPath.row].reason ?? "")"
                        
                    
                    cell.imgProduct.sd_setImage(with: URL(string: orderDetailData?.data?.item_detail?[indexPath.row].product_pic ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                    
                    
                    if (orderDetailData?.data?.item_detail?[indexPath.row].item_status) == 0 || (orderDetailData?.data?.item_detail?[indexPath.row].item_status) == 3 {
                        isInvoiceEnable = false
                    }else
                    {
//                        isInvoiceEnable = true
                        
                    }
                    
                    if checkInvoiceUploaded == true {
                        cell.contentView.isUserInteractionEnabled = false
                        
                    }
                        
                        if checkInvoiceUploaded == true || orderDetailData?.data?.order_status == 3 || orderDetailData?.data?.order_status == 2 || orderDetailData?.data?.item_detail?[indexPath.row].item_status == 3  {
                            cell.btnDelete.isUserInteractionEnabled = false
                            cell.btnReduceQuantity.isUserInteractionEnabled = false
                            cell.btnCart.isEnabled = false
                        }
                        
                        cell.delegate = self
                        cell.tag = indexPath.row
     
                        return cell
                }
           
            }
       }
    }
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          if section == 0{
              return 0
          }
          return 70
      }
      
    

extension ProductDetailsViewC : UITableViewDelegate {
}
