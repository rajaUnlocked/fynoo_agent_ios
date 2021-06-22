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

class ProductDetailsViewC: UIViewController,ProductListDelegate,PopUpAcceptProductDelegate,AddInvoiceInformationDelegate, OpenGalleryDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,DECancellationReasonViewControllerDelegate {
   
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnChangeStatus: UIButton!
    
    var orderDetailData : orderDetail?
    var reasonListData : reasonlistData?
    var itemListArray:[Item_detail]?
    var orderId = ""
    var isInvoiceEnable = true
    var selectedImg : UIImage!
    var amoutnWithoutVat = ""
    var vatAmount = ""
    var amoutWithVat = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "BusinessOwnerTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessOwnerTableViewCell");
        tableView.register(UINib(nibName: "BOCustomerTableViewCell", bundle: nil), forCellReuseIdentifier: "BOCustomerTableViewCell");
        tableView.register(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell");
        tableView.register(UINib(nibName: "AddInvoiceInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "AddInvoiceInformationTableViewCell");
        
        
       
        tableView.delegate=self
        tableView.dataSource=self
        
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Product Details"
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
        
        getOrderDetail()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func reloadPage() {
        getOrderDetail()
    }
    
    func selectedCancelReason(reasonID: String) {
        print(reasonID)
        callAgentCancelOrder(reasonID: reasonID)
    }
    
        func getOrderDetail(){
            
            var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
            
            if userId == "0"{
                userId = ""
                
            }
            let param = ["order_id": orderId,
                         "user_id":userId,
                         "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
            
            print("request:-", param)
            print("Url:-", Service.orderDetail)
            ServerCalls.postRequest(Service.orderDetail, withParameters: param) { [self] (response, success) in
                if success{
                    
                    if let body = response as? [String: Any] {
                        self.orderDetailData  = Mapper<orderDetail>().map(JSON: body)
                        
                        print(self.orderDetailData?.data?.bo_name ?? "")
                        
                        self.tableView.reloadData()
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
                    vc.lblProductQty.text = "Item Qty: \(orderDetailData?.data?.item_detail? [selectedTag].qty ?? 0)"
                    vc.lblProductName.text = "Item Qty: \(orderDetailData?.data?.item_detail? [selectedTag].pro_name ?? "")"

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
                    vc.lblProductQty.text = "Item Qty: \(orderDetailData?.data?.item_detail? [selectedTag].qty ?? 0)"
                    vc.lblProductName.text = "Item Qty: \(orderDetailData?.data?.item_detail? [selectedTag].pro_name ?? "")"

                    vc.imgProduct.sd_setImage(with: URL(string: orderDetailData?.data?.item_detail?[selectedTag].product_pic ?? ""), placeholderImage: UIImage(named: "profile_white.png"))

                    vc.orderId = orderDetailData?.data?.order_id ?? ""
                    vc.itemId = orderDetailData?.data?.item_detail? [selectedTag].item_id ?? 0

                    self.present(vc, animated: true, completion: nil)
                    
                    self.tableView.reloadData()

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
    
    func anyProblemClicked(_ sender: Any) {
//        let vc = CancelReasonViewController(nibName: "CancelReasonViewController", bundle: nil)
////      vc.delegate = self
//        vc.modalPresentationStyle = .overFullScreen
//        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        self.present(vc, animated: true, completion: nil)
        
        let vc = CancelReasonViewController()
//        vc.orderId = tripListListArray?[indexPath.row].order_id ?? ""
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
        
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
    
    
    
    
    @IBAction func tapToBtnUploadInvoice(_ sender: UIButton) {
        
//        if orderDetailData?.data?.order_status == 0 {
//            checkValidation()
//        }
        
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
    
    
    
    func checkValidation(){
        
//        let index = IndexPath(row: 0, section: 3)
//           let cell: AddInvoiceInformationTableViewCell = self.tableView.cellForRow(at: index) as! AddInvoiceInformationTableViewCell
//
//           self.amoutnWithoutVat = cell.txtTotalAmtWithoughtVat.text!
//           self.vatAmount = cell.txtVatAmt.text!
//           self.amoutWithVat = cell.txtTotalAmountWithVat.text!
        
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
        if orderDetailData?.data?.is_vat_available == false{
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
    
    
    
    
    func entryCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AddInvoiceInformationTableViewCell",for: index) as! AddInvoiceInformationTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
//        cell.emailField.isUserInteractionEnabled = false
        cell.txtTotalAmtWithoughtVat.keyboardType = .numberPad
        cell.txtVatAmt.keyboardType = .numberPad
        cell.txtTotalAmountWithVat.keyboardType = .numberPad
        
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
            cell.viewForShowHide.isUserInteractionEnabled = false
            cell.viewForShowHide.alpha = 0.5
        }else
        {
            cell.viewForShowHide.isUserInteractionEnabled = true
            cell.viewForShowHide.alpha = 1
            
        }

        if ((orderDetailData?.data?.is_vat_available) == false){

            cell.txtVatAmt.isUserInteractionEnabled = false
        }

        switch orderDetailData?.data?.order_status {
        case 3:
            self.btnChangeStatus.setTitle("Cancelled".localized, for: .normal)
            self.btnChangeStatus.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.btnChangeStatus.isUserInteractionEnabled = false
        case 2:
            self.btnChangeStatus.setTitle("Delivered".localized, for: .normal)
        case 4:
            self.btnChangeStatus.setTitle("Cancel Request Received".localized, for: .normal)
        default:
            self.btnChangeStatus.setTitle("Confirm and upload invoice".localized, for: .disabled)
        }
        
        
        return cell
    }
    
 //arv
    
    
    
    func calculateDistanceFromLatLong() {
        
        
//        self.reloadTableData()
        
        let distanceFromAgentToBo = calculateDistance(mobileLocationX:Double.getDouble(orderDetailData?.data?.agent_lat ?? ""), mobileLocationY:Double.getDouble(orderDetailData?.data?.agent_long ?? ""), DestinationX:Double.getDouble(orderDetailData?.data?.bo_lat ?? ""), DestinationY:Double.getDouble(orderDetailData?.data?.bo_long ?? ""))

        print("distanceFromAgentToBo = \(distanceFromAgentToBo)")
        
        
        
        let distanceFromBoToCustomer = calculateDistance(mobileLocationX:Double.getDouble(orderDetailData?.data?.bo_lat ?? ""), mobileLocationY:Double.getDouble(orderDetailData?.data?.bo_long ?? ""), DestinationX:Double.getDouble(orderDetailData?.data?.cust_lat ?? ""), DestinationY:Double.getDouble(orderDetailData?.data?.cust_long ?? ""))

        print("distanceFromBoToCustomer = \(distanceFromBoToCustomer)")
        
        let totalDistance = distanceFromAgentToBo+distanceFromBoToCustomer
        
        print("Total distance = \(totalDistance)")
      
//        let agentLat = Double.getDouble(self.orderDetailData?.data?.agent_lat ?? "")
//        let agentLng = Double.getDouble(self.orderDetailData?.data?.agent_long ?? "")
//        let boLat = Double.getDouble(self.orderDetailData?.data?.bo_lat ?? "")
//        let boLng = Double.getDouble(self.orderDetailData?.data?.bo_long ?? "")
//        let custLat = Double.getDouble(self.orderDetailData?.data?.cust_lat ?? "")
//        let custLng = Double.getDouble(self.orderDetailData?.data?.cust_long ?? "")
//
//        let distanceUrlFromAgentToBO = "\(Constant.GOOGLE_API_DISTANCE)origin=\(agentLat),\(agentLng)&destination=\(boLat),\(boLng)&key=\(Constant.GOOGLE_API_KEY)"
//        AgentProfile.getDistance(distanceUrlFromAgentToBO) { (succes, response) in
//            if succes{
//                self.lblBoLocation.text = "\(response?.routes?.first?.legs?.first?.distance?.text ?? "")".uppercased()
//            }
//        }
//        let distanceUrlFromBOToCustomer = "\(Constant.GOOGLE_API_DISTANCE)origin=\(boLat),\(boLng)&destination=\(custLat),\(custLng)&key=\(Constant.GOOGLE_API_KEY)"
//        AgentProfile.getDistance(distanceUrlFromBOToCustomer) { (succes, response) in
//                   if succes{
//                    self.lblCustomerLocation.text = "\(response?.routes?.first?.legs?.first?.distance?.text ?? "")".uppercased()
//                   }
//               }
    }
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
      
        let vc = PopUpAcceptProductViewController(nibName: "PopUpAcceptProductViewController", bundle: nil)
        vc.itemId = orderDetailData?.data?.item_detail?[indexPath.row].item_id ?? 0
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.present(vc, animated: true, completion: nil)
            
        }
}
    
    
  
 
}

extension ProductDetailsViewC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            return orderDetailData?.data?.item_detail?.count ?? 0
        }else
        {
        
          return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        

        if indexPath.section == 1{
            
            if orderDetailData?.data?.order_status == 3 {
                return 280
            }
                return 320
        }else if indexPath.section == 3{
            return 380
        }else if indexPath.section == 0{
            return 170
        }else
        {
            return 160
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        
                if indexPath.section == 0{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessOwnerTableViewCell",for: indexPath) as! BusinessOwnerTableViewCell
            cell.selectionStyle = .none
          
                    cell.lblBoName.text = orderDetailData?.data?.bo_name ?? ""
                    cell.lblBoAddress.text = orderDetailData?.data?.bo_address ?? ""
                    cell.bo_total_rating.text = orderDetailData?.data?.bo_total_rating ?? "0"
                    cell.bo_rating.text = orderDetailData?.data?.bo_rating ?? "0"
                    
                    cell.imgbo_pic.sd_setImage(with: URL(string: orderDetailData?.data?.bo_pic ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                    
                    
                    if orderDetailData?.data?.order_status == 3 {
                        
                        cell.btnNavWidth.constant = 0
                    }
                    
//                    cell.langugae.text = "\(deliverData?.data?.user_lang ?? "")"
            
//            cell.tripAchivementData = deliverData?.data?.agent_information?.trips_achievements
//            cell.collectionView.reloadData()
            
            return cell
                }else if indexPath.section == 1{
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BOCustomerTableViewCell",for: indexPath) as! BOCustomerTableViewCell
                    cell.selectionStyle = .none
                    
                    
                    cell.lblCustName.text = orderDetailData?.data?.cust_name ?? ""
                    cell.lblCustAddress.text = orderDetailData?.data?.cust_address ?? ""
                    
                    cell.lblQty.text = "\(orderDetailData?.data?.order_qty ?? 0)"
                    
                    cell.lblOrderId.text = " Order Id :  \(orderDetailData?.data?.order_id ?? "0")"
                    
                    let timeSTAMP = "\(orderDetailData?.data?.order_date ?? 0)"
                    cell.lblOrderDate.text = ModalController.convert13DigitTimeStampIntoDate(timeStamp: timeSTAMP, format: "dd-MMM-yyyy HH:mm a")
                    
                    cell.lblCustrating.text = orderDetailData?.data?.cust_rating ?? "0"
                    cell.lblCusttotalrating.text = orderDetailData?.data?.cust_total_rating ?? "0"
                    cell.lblCurrencyCode.text = orderDetailData?.data?.currency_code ?? "0"
                    
                    cell.order_price.text = "\(orderDetailData?.data?.order_price ?? 0.0)"
                    cell.imgCustpic.sd_setImage(with: URL(string: orderDetailData?.data?.cust_pic ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                    cell.imgPaymentIcon.sd_setImage(with: URL(string: orderDetailData?.data?.payment_icon ?? ""), placeholderImage: UIImage(named: "cod_icon"))
                    cell.lblTotalOrder.text = "\(orderDetailData?.data?.total_accepted_order ?? 0)"
                    cell.lblTotalAcceptedOrder.text = "\(orderDetailData?.data?.total_order ?? 0)"
                    
                    if (orderDetailData?.data?.total_accepted_order == orderDetailData?.data?.total_order) {
                        cell.lblTotalOrder.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                    }else
                    {
                        cell.lblTotalOrder.textColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
                    }
                    
                    if orderDetailData?.data?.order_status == 3 {
                        cell.viewForHideExpectedDelivery.constant = 50
                        cell.btnNavWidth.constant = 0
                    }
                    
                    calculateDistanceFromLatLong()
                    
//                    let dist = calculateDistance(mobileLocationX:Double.getDouble(orderDetailData?.data?.bo_lat ?? ""), mobileLocationY:Double.getDouble(orderDetailData?.data?.bo_long ?? ""), DestinationX:Double.getDouble(orderDetailData?.data?.cust_lat ?? ""), DestinationY:Double.getDouble(orderDetailData?.data?.cust_long ?? ""))
//
//                    print("abc\(dist)")
                    
                    
                    return cell
                }else if indexPath.section == 3{
                    
                    
                    return entryCell(index: indexPath)
                    
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "AddInvoiceInformationTableViewCell",for: indexPath) as! AddInvoiceInformationTableViewCell
//                    cell.selectionStyle = .none
//                    cell.delegate = self
//                    cell.lblAlmostAmountPrice.text = "\(orderDetailData?.data?.currency_code ?? "") " + "\(orderDetailData?.data?.order_price ?? 0)"
//
//                    if selectedImg != nil {
//                        cell.tapToBtnUploadInvoice.setImage(selectedImg, for: .normal)
//                        cell.imgInvoiceUploaded.isHidden = false
//                    }
//
//                    if isInvoiceEnable == false {
//                        cell.viewForShowHide.isUserInteractionEnabled = false
//                        cell.viewForShowHide.alpha = 0.5
//                    }
//
//                    if ((orderDetailData?.data?.is_vat_available) != true){
//
//                        cell.txtVatAmt.isUserInteractionEnabled = false
//                    }
//
//
//
//
//                    return cell
                }else
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell",for: indexPath) as! ProductListTableViewCell
                    cell.selectionStyle = .none
                    
                    
                    if orderDetailData?.data?.item_detail? [indexPath.row].item_status == 0 {
                        cell.imgCart.image = #imageLiteral(resourceName: "Accepted")
                    }
                    if orderDetailData?.data?.item_detail? [indexPath.row].item_status == 1 {
                        cell.imgCart.image = #imageLiteral(resourceName: "shopping-cartGreen")

                    }
                    
                    if orderDetailData?.data?.item_detail? [indexPath.row].item_status == 2 || (orderDetailData?.data?.item_detail? [indexPath.row].item_status == 0 && orderDetailData?.data?.order_status == 3) || (orderDetailData?.data?.item_detail? [indexPath.row].item_status == 1 && orderDetailData?.data?.order_status == 3)   {
                        cell.imgCart.image = #imageLiteral(resourceName: "shopping-cartgrayCross")
                        cell.btnReduceQuantity.isHidden = true
                        cell.lblLineReduceQty.isHidden = true
                        cell.btnDelete.isHidden = true

                    }
                    
                    
                    if orderDetailData?.data?.item_detail? [indexPath.row].item_status == 3 {
                        cell.imgCart.image = #imageLiteral(resourceName: "Accepted")
                        cell.lblLineReduceQty.isHidden = false
                        cell.btnDelete.isHidden = false
                        cell.btnDelete.alpha = 0.5
                    }
                    
                    
//                    if  orderDetailData?.data?.item_detail? [indexPath.row].qty ?? 0 < 2 && orderDetailData?.data?.item_detail? [indexPath.row].item_status == 1{
//                        cell.btnReduceQuantity.isHidden = true
//                        cell.lblLineReduceQty.isHidden = true
//                    }
                    
                    if  orderDetailData?.data?.item_detail? [indexPath.row].qty ?? 0 < 2 {
                        cell.btnReduceQuantity.isHidden = true
                        cell.lblLineReduceQty.isHidden = true
                    }
                    
                    if orderDetailData?.data?.item_detail? [indexPath.row].item_status == 3{
                        cell.btnReduceQuantity.setTitle(orderDetailData?.data?.item_detail? [indexPath.row].reason, for: .normal)
                        cell.lblLineReduceQty.isHidden = true
                        cell.btnReduceQuantity.isUserInteractionEnabled = false
                        let fontNameLight = NSLocalizedString("LightFontName", comment: "")

                        cell.btnReduceQuantity.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
                        cell.btnReduceQuantity.titleLabel?.textColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
                    }
                    
                    cell.lblQty.text = "Item Qty: \(orderDetailData?.data?.item_detail? [indexPath.row].qty ?? 0)"
                    cell.lblAddress.text = orderDetailData?.data?.item_detail? [indexPath.row].pro_name ?? ""
                    cell.lblPriceAlmost.text = "Item Price (Almost):  \(orderDetailData?.data?.item_detail? [indexPath.row].price ?? 0)"
                    
                    cell.imgProduct.sd_setImage(with: URL(string: orderDetailData?.data?.item_detail?[indexPath.row].product_pic ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                    
                    
                    if (orderDetailData?.data?.item_detail?[indexPath.row].item_status) == 0 || (orderDetailData?.data?.item_detail?[indexPath.row].item_status) == 3 {
                        isInvoiceEnable = false
                    }else
                    {
                        isInvoiceEnable = true
                        
                    }
                    
                    cell.delegate = self
                    cell.tag = indexPath.row
 
                    return cell
                }
       }
    }
    

    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//
//
////                let vc = PopUpAcceptProductViewController()
//////                vc.serviceID = ModalController.toString(((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_id") as! NSNumber) as Any)
////                self.navigationController?.pushViewController(vc, animated: true)
//        let vc = PopUpAcceptProductViewController(nibName: "PopUpAcceptProductViewController", bundle: nil)
////                    vc.delegate = self
//        vc.modalPresentationStyle = .overFullScreen
//        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        present(vc, animated: true, completion: nil)
//}
    

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
           
//           if cell.tag == 999999 {
//
//               currentPageNumber += 1
//               self.getTripData()
//           }
       }
    
    func loadingCell() -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        cell.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        cell.tag = 999999
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = cell.contentView.backgroundColor
        activityIndicator.frame = CGRect(x: (UIScreen.main.bounds.size.width / 2) - 10, y: 12, width: 20, height: 20)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          if section == 0{
              return 0
          }
          return 70
      }
      
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0{
//            return UIView()
//        }else{
//
//            if headerView1 == nil
//            {
//
//                headerView1 = DataBankHeader()
//
//                headerView1!.delegate = self
//            }
//            headerView1!.selectedIndex = Index
//
//            return headerView1
//
//
//        }
//
//    }
//}

extension ProductDetailsViewC : UITableViewDelegate {
}
