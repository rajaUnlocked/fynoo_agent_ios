//
//  CompanyRegViewController.swift
//  Fynoo Business
//
//  Created by Sendan IT on 15/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import PopupDialog
import MobileCoreServices

protocol companybackbtnDelegate {
   func activeBoAction()
}
class CompanyRegViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CompanyRegTableViewCellDelegate,AgentProfileImageTableViewCellDelegate,ImageSelectPopUpDialogViewControllerDelegate,UITextFieldDelegate,CompanyAgentBasicInformationTableViewCellDelegate,SearchCategoryViewControllerDelegate,CompanyAgentBankDetailsTableViewCellDelegate,CompanyAgentVatDetailTableViewCellDelegate,AgentCompanyUserPolicyTableViewCellDelegate,UIDocumentPickerDelegate {
    
   
   
    func loginClickedd(_ sender: Any) {
        var isLoginThere = false
        
        if var viewControllers = self.navigationController?.viewControllers
        {
            for controller in viewControllers
            {
                if controller is LoginNewDesignViewController
                {
                    isLoginThere = true
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: LoginNewDesignViewController.self) {
                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    }
                }
            }
        }
        
        if isLoginThere == false
        {
            let vc = LoginNewDesignViewController(nibName: "LoginNewDesignViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    var value = ""
    var mobilNoo = ""
    
    var mobileValue = ""
    var MobileNumber = ""
    
    var vatValue = ""
    var VatNumber = ""
    
    var accountValue = ""
    var accountNumber = ""
    
    var mobileNumberWithoutGap = ""
    var PhoneNumberWithoutGap = ""
    
    var AgentSERVICE:AgentService?
     var bankNameIdentifierList:bankIdentifier_list?
    @IBOutlet weak var tabView: UITableView!
    var delegate: companybackbtnDelegate?
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var headerView: NavigationView!
    var showButton = UIButton()
    var showConfirmButton = UIButton()
    var tempImage: UIImage!
    var selectedImage: UIImage!
    var imageupload:ImageUpload?
    var selectedArray:NSMutableArray = NSMutableArray()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var SelectedIndex:NSMutableArray = NSMutableArray()
    var selectedAgentCountryDict : NSDictionary = NSDictionary()
    var selectedCityDict : NSMutableDictionary = NSMutableDictionary()
    var selectedBankDict : NSMutableDictionary = NSMutableDictionary()
     var selectedCountryCodeDict : NSMutableDictionary = NSMutableDictionary()
     var selectedPhoneCodeDict : NSMutableDictionary = NSMutableDictionary()
    var sectionHeaderTextArray = ["Services".localized,"Basic Information".localized,"Bank Details".localized,"Vat Information".localized]
    var maroofLink = ""
    var ibanPrefix = ""
    var ispassword:Bool = true
    var isConfirmPassword:Bool = true
    var isVatYesClicked:Bool = false
    var isVatNoClicked:Bool = false
    var isCountryChangeAgain:Bool = true
    
    var isUserPolicySelected:Bool = false
    var everythingFilled:Bool = false
    @IBOutlet weak var downImage: UIImageView!
    var isImageUploaded:Bool = false
     var agentSignUPModal = AgentSignUPModal()
    
    var isFromVatDocument:Bool = false
     var documentImageSize = NSMutableArray()
    var size = 0.0
     var vatInformationModal = AgentVatInformationModal()
     var agentVatInfoDatas : VatInfoModal?
    
    var IBANinformationModal = AgentIbanLengthModal()
     var agentIbanInfoDatas : IbanLengthInfoModal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.selectServiceStr = ""
        self.serviceAPI()
        self.getVatInfoAPI()
        self.registerAgentNotifications()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        downImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        
        self.tabView.delegate = self
        self.tabView.dataSource = self
        
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.view.bringSubviewToFront(headerView)
        maroofLink = "https://www.maroof.com/".localized;
//        ibanPrefix = "SA".localized;
        
        tabView.register(UINib(nibName: "CompanyRegTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyRegTableViewCell")
        tabView.register(UINib(nibName: "AgentCompanyServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "AgentCompanyServicesTableViewCell")
        tabView.register(UINib(nibName: "AgentProfileImageTableViewCell", bundle: nil), forCellReuseIdentifier: "AgentProfileImageTableViewCell")
        tabView.register(UINib(nibName: "CompanyAgentBasicInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyAgentBasicInformationTableViewCell")
        tabView.register(UINib(nibName: "AgentCompanyUserPolicyTableViewCell", bundle: nil), forCellReuseIdentifier: "AgentCompanyUserPolicyTableViewCell")
        tabView.register(UINib(nibName: "CompanyAgentBankDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyAgentBankDetailsTableViewCell")
        tabView.register(UINib(nibName: "CompanyAgentVatDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyAgentVatDetailTableViewCell")
        
        self.showButton.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        self.showConfirmButton.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        self.showButton.tag = 1001
        self.showConfirmButton.tag = 1002
        self.tabView.separatorStyle = .none
        self.headerView.titleHeader.text = "Welcome, Let's Create An Account".localized
        headerView.viewControl = self
    }
    
    @objc func showPassword(_ sender: UIButton) {
        
        if sender.tag == 1001{
            if sender.isSelected == true{
                sender.isSelected = false
            }else{
                sender.isSelected = true
            }
        }else{
            if sender.isSelected == true{
                sender.isSelected = false
            }else{
                sender.isSelected = true
            }
        }
    }
    func registerAgentNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationChangeServiceIconClicked(_:)), name: NSNotification.Name(rawValue: "changeServiceIcon"), object: nil)
    }
    @objc func methodOfReceivedNotificationChangeServiceIconClicked(_ notification: NSNotification) {
        self.tabView.reloadData()
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        self.dismiss(animated: true, completion: nil)
//        guard let selectedImage = info[.originalImage] as? UIImage else {
//            print("Image not found!")
//            return
//        }
//
//        let selectedImageNew = selectedImage.resizeWithWidth(width: 700)!
//        let compressData = selectedImageNew.jpegData(compressionQuality: 0.8) //max value is 1.0 and minimum is 0.0
//        let compressedImage = UIImage(data: compressData!)
//
//        self.profileImg.image = compressedImage
//        UploadProfileImage_API(img: compressedImage!)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage else {
                return
        }

        tempImage = image.resizeWithWidth(width: 700)!
        self.tabView.reloadData()
       let compressData = tempImage.jpegData(compressionQuality: 0.8) //max value is 1.0 and minimum is 0.0
       let compressedImage = UIImage(data: compressData!)
        tempImage = compressedImage
       
//        self.selectedImage = tempImage
//        if tempImage.size.width > 414{
//
//            let factor = tempImage.size.width / 414
//            tempImage =  tempImage.scaleProfileImageToSize(newSize: CGSize(width: 414, height: tempImage.size.height/factor))
//        }else if tempImage.size.height > 812
//        {
//            let factor = tempImage.size.height / 812
//            tempImage =  tempImage.scaleProfileImageToSize(newSize: CGSize(width: tempImage.size.width/factor, height: 812))
//        }
        self.uploadProfileImagesAPI()
        dismiss(animated:true, completion: nil)

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func serviceAPI()
    {
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.Service_List)"
        let parameters = [
           "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in

            ModalClass.stopLoading()
            if success == true {
                self.AgentSERVICE = try! JSONDecoder().decode(AgentService.self, from: resp as! Data )
                self.agentSignUPModal.agentName_CompareCode = ModalController.toString(self.AgentSERVICE?.data?.compare_code as Any) 
                if self.AgentSERVICE!.error! {
                    ModalController.showNegativeCustomAlertWith(title:"Error".localized, msg: "")
                }
                else{
                    self.tabView.reloadData()
                }
            }else{
                if response == nil
                {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error".localized, msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
        }
    }
    
    func getVatInfoAPI() {
        
        vatInformationModal.getAgentVatInfoApi() { (success, response) in
            ModalClass.stopLoading()
            if success{
                self.agentVatInfoDatas = response
                self.agentSignUPModal.vatLength = self.agentVatInfoDatas?.data?.vat_length ?? 0
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "\(self.agentVatInfoDatas?.error_description! ?? "")")
               
            }
            self.tabView.reloadData()
        }
    }
    
    func getIbanLengthAPI(countryCode:String) {
        
        IBANinformationModal.getAgentIbanInfoApi(CountryCode: countryCode ) { (success, response) in
            ModalClass.stopLoading()
            if success{
                self.agentIbanInfoDatas = response
                self.agentSignUPModal.agentIBanLength = self.agentIbanInfoDatas?.data?.bank_number_length ?? 0
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "\(self.agentVatInfoDatas?.error_description! ?? "")")
               
            }
//            self.tabView.reloadData()
        }
    }

    
  
    
    func bankNameApi(identifier:String) {
        let str = "\(Constant.BASE_URL)\(Constant.bankIdentifier_List)"
        let parameters = [
            "identifier":identifier,
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            let ResponseDict : NSDictionary = (response as? NSDictionary)!
            ModalClass.stopLoading()
            if success == true {
                self.bankNameIdentifierList = try! JSONDecoder().decode(bankIdentifier_list.self, from: resp as! Data )
                if self.bankNameIdentifierList!.error! {
                    ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "error_description") as? String)!, msg: "")
                }else{
                    
                    let index = IndexPath(row: 1, section: 3)
                    let cell: CompanyAgentBankDetailsTableViewCell = self.tabView.cellForRow(at: index) as! CompanyAgentBankDetailsTableViewCell
                    
                    if self.bankNameIdentifierList?.data?.count ?? 0 > 0 {
                        let bankIdentifier  = self.bankNameIdentifierList?.data![0]
                        let name = bankIdentifier?.bank_name
                        cell.bankNameTxtFld.text = name
                        self.agentSignUPModal.agentbankName = name ?? ""
                        
                        if let value = bankIdentifier?.id {
                            self.agentSignUPModal.agentbankID = "\(value)"
                        }
                        if cell.bankNameTxtFld.text == "" {
                            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.bankNameView)
                        }else{
                            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.bankNameView)
                        }
                    }else{
                        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.bankNameView)
                        self.agentSignUPModal.agentbankName = ""
                    }
                    //                    self.tabView.reloadRows(at: [IndexPath(row: 1, section: 3)], with: .none)
                }
            }else{
                if response == nil
                {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error".localized, msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
        }
    }
    
    @IBAction func backbtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.delegate?.activeBoAction()
    }
    
    // profileImageUpload
    func uploadProfileImagesAPI(){
        
        ModalClass.startLoading(self.view)
        //    let device_id = UIDevice.current.identifierForVendor!.uuidString
        ServerCalls.fileUploadAPI(Imgtype:"",imagefrom:"user",img: tempImage) { (response, success, resp) in
            ModalClass.stopLoading()
            if success == true {
                self.imageupload = try! JSONDecoder().decode(ImageUpload.self, from: resp as! Data )
                if self.imageupload!.error {
                    ModalController.showNegativeCustomAlertWith(title:"Error".localized, msg: "")
                    
                }else{
                    print("response:-", self.imageupload as Any)
                    self.isImageUploaded = true
                    if let profileImageID = self.imageupload?.data?.image_id  {
                        
                        self.agentSignUPModal.imageID = profileImageID
                    }
                    self.tabView.reloadData()
                }
                
            }else{
                if response == nil
                {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error".localized, msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
        }
        
    }
    
    func selectedCheckBox(_ sender: Any){
    }
    func selectHeader(tag:Int) {
        
    }
    func profileImageSelected(){
        let failVC = ImageSelectPopUpDialogViewController(nibName: "ImageSelectPopUpDialogViewController", bundle: nil)
        let popup = PopupDialog(viewController: failVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .fadeIn,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        failVC.delegate = self
        present(popup, animated: true, completion: nil)
    }
    
    func cameraSelected() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cam = UIImagePickerController()
            cam.delegate = self
            cam.allowsEditing = true
            cam.sourceType = .camera
            self.present(cam, animated: true, completion: nil)
        }else{
            print("no camera")
        }
        
    }
    
    func gallerySelected() {
        let gal = UIImagePickerController()
        gal.delegate = self
        gal.allowsEditing = true
        gal.sourceType = .photoLibrary
        self.present(gal, animated: true, completion: nil)
    }
    
    func selectedCategoryMethod(countryDict : NSMutableDictionary,tag:Int) {
          self.isCountryChangeAgain = false
        if self.selectedAgentCountryDict != countryDict {
            self.selectedCityDict.removeAllObjects()
            tabView.reloadData()
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
            self.isCountryChangeAgain = false
        }
        self.selectedAgentCountryDict = countryDict
        tabView.reloadData()
    }
    
    func selectedCityMethod(cityDict : NSMutableDictionary){
        self.selectedCityDict = cityDict
        tabView.reloadData()
    }
    func selectedEducationMethod(educationDict: NSMutableDictionary) {
    }
    func selectedMajorEducationMethod(educationDict: NSMutableDictionary) {
    }
    func selectedCurrency(currency: NSMutableDictionary) {
    }
 
    func selectedBankMethod(bankDict: NSMutableDictionary) {
        self.selectedBankDict = bankDict
        self.tabView.reloadData()
    }
    
    func selectedCountryCodeMethod(mobileCodeDict: NSMutableDictionary) {
        self.selectedCountryCodeDict = mobileCodeDict
               self.tabView.reloadData()
        
    }
       
    func selectPhoneCodeMethod(phoneCodeDict: NSMutableDictionary) {
        self.selectedPhoneCodeDict = phoneCodeDict
        self.tabView.reloadData()
        
    }
    
    func AgentselectCountry(_ sender: Any){
        
        let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
        vc.delegate = self
        vc.isForCountry = true
        vc.selectedCountryDict = self.selectedAgentCountryDict.mutableCopy() as! NSMutableDictionary
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func AgentselectCity(_ sender: Any) {
        let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
        if self.selectedAgentCountryDict.count == 0 {
            ModalController.showNegativeCustomAlertWith(title: "Please select country first".localized, msg: "")
            return
        }
        vc.isForCity = true
        vc.delegate = self
        vc.selectedOLDCountryDict = self.selectedAgentCountryDict
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func AgentselectBank(_ sender: Any) {
        let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
        vc.delegate = self
        vc.isForBankList = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func selectetCourierCompanyMethod(courierCompanyDict: NSMutableDictionary) {
        
    }
    func showHidePassword(_ sender: Any){
        if(ispassword)
        {
            ispassword = false
        }else{
            ispassword = true
        }
        
        self.tabView.reloadRows(at: [IndexPath(row: 1, section: 2)], with: .none)
    }
    func showHideConfirmPassword(_ sender: Any){
        
        if(isConfirmPassword)
        {
            isConfirmPassword = false
        }else{
            isConfirmPassword = true
        }
        self.tabView.reloadRows(at: [IndexPath(row: 1, section: 2)], with: .none)
    }
    
    func mobileCodeClicked(_ sender: Any) {
        let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
        vc.delegate = self
        vc.isFromCountryMobileCode = true
         vc.selectedCountryDict = self.selectedCountryCodeDict
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func phoneCodeClicked(_ sender: Any) {
        let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
        vc.delegate = self
        vc.isFromCountryPhoneCode = true
         vc.selectedCountryDict = self.selectedPhoneCodeDict
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func AgentselectYesOnVat(_ sender: Any) {
        if(isVatYesClicked)
        {
            isVatYesClicked = false
        }else{
            isVatYesClicked = true
            isVatNoClicked = false
        }
        self.tabView.reloadRows(at: [IndexPath(row: 1, section: 4)], with: .none)
        self.tabView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
        self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
    }
    
    func AgentselectNoOnVat(_ sender: Any) {
//        isFromVatDocument = false
//        self.agentSignUPModal.vatDocumentUrl = nil
        if(isVatNoClicked){
            
            isVatNoClicked = false
        }else{
            isVatNoClicked = true
            isVatYesClicked = false
        }
        self.tabView.reloadRows(at: [IndexPath(row: 1, section: 4)], with: .none)
        self.tabView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
        self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
        
    }
    
    func AddVatDocumentClicked(_ sender: Any) {
        
        let importMenu = UIDocumentPickerViewController(documentTypes: ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String], in: UIDocumentPickerMode.import)
        
        if #available(iOS 11.0, *) {
            importMenu.allowsMultipleSelection = true
        }
        
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        
        present(importMenu, animated: true)
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("document:-", urls.first as Any)

        
        size = 0.0
        let siz = fileSize(forURL:  urls.first!)
        documentImageSize.add(siz)
        if documentImageSize.count > 0
        {
            for i in 0...(documentImageSize.count - 1)
            {
                let si = documentImageSize[i] as! Double
                size = size + si
            }
        }
        print(".......\(size)")
        if size > agentVatInfoDatas?.data?.vat_file_size ?? 0.0
        {
            ModalController.showNegativeCustomAlertWith(title: "File Size is Greater Than \(agentVatInfoDatas?.data?.vat_file_size ?? 0.0) Mb Upload a lower size File.", msg: "")
            return
        }else{
            self.isFromVatDocument = true
            agentSignUPModal.vatDocumentUrl = urls.first
            
             self.tabView.reloadRows(at: [IndexPath(row: 1, section: 4)], with: .none)
        }

    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func fileSize(forURL url: Any) -> Double {
        var fileURL: URL?
        var fileSize: Double = 0.0
        if (url is URL) || (url is String)
        {
            if (url is URL) {
                fileURL = url as? URL
            }
            else {
                fileURL = URL(fileURLWithPath: url as! String)
            }
            var fileSizeValue = 0.0
            try? fileSizeValue = (fileURL?.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).allValues.first?.value as! Double?)!
            if fileSizeValue > 0.0 {
                fileSize = (Double(fileSizeValue) / (1024 * 1024))
            }
        }
        return fileSize
    }
       
    func RemoveVatDocumentClicked(_ sender: Any) {
        isFromVatDocument = false
        self.agentSignUPModal.vatDocumentUrl = nil
        self.tabView.reloadRows(at: [IndexPath(row: 1, section: 4)], with: .none)
        
    }
    func userPolicySelected(_ sender: Any){
        if(isUserPolicySelected){

            isUserPolicySelected = false
        }else{
            isUserPolicySelected = true
        }
        self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
        
    }
    func signUpBtnClicked(_ sender: Any) {
    
        if isVatNoClicked == true {
            agentSignUPModal.agentVatNumber = ""
        }
        if maroofLink == "https://www.maroof.com/".localized {
            agentSignUPModal.agentMaroofLink = ""
        }
//        if ibanPrefix == "SA".localized {
//        agentSignUPModal.agentbankAccountNumber = ""
//        }
        let(isFilled, message) = agentSignUPModal.normalAgentSignUPValidation()
        
        if isFilled{
            ModalClass.startLoading(self.view)
            agentSignUPModal.agentSignUp { (success,response) in
                
                if success{
                    if let value = (response?.object(forKey: "data") as? NSDictionary)?.object(forKey: "mail_status") as? String{
                        ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                        
                        if value == "Email Sent Success".localized{
                            let vc = VerifyAccountViewController(nibName: "VerifyAccountViewController", bundle: nil)
                            vc.mobile = self.agentSignUPModal.agentPhoneNumber
                            vc.emailId = self.agentSignUPModal.agentEmail
                            vc.fynooId = (response!.object(forKey: "data") as? NSDictionary)?.object(forKey: "fynoo_id") as! String
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                }else{
                    if let value = response?.object(forKey: "error_description") as? String{
                        ModalController.showNegativeCustomAlertWith(title: "", msg: value)
                    }
                }
            }
        }else{
            ModalController.showNegativeCustomAlertWith(title: "", msg: message)
        }
    }
    
    var cellHeights = [IndexPath: CGFloat]()
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? UITableView.automaticDimension
    }
}

extension CompanyRegViewController : UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
        if SelectedIndex.contains(section) {
          return 2
         }else{
           return 1
        }
        }else if section == 1 {
         if SelectedIndex.contains(section) {
           return 2
        }else{
            return 1
      }
        }else if section == 2 {
            if SelectedIndex.contains(section) {
                 return 2
              }else{
                  return 1
            }
        }else if section == 3 {
        if SelectedIndex.contains(section) {
           return 2
        }else{
           return 1
        }
    }else if section == 4 {
        if SelectedIndex.contains(section) {
           return 2
        }else{
           return 1
        }
        }else  {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        checkSignUpStatus()
        if indexPath.section == 0 {
            
         return agentProfileChangeCell(index: indexPath)

        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                return headerCell(index: indexPath)
         }else{
               return agentServicesCell(index: indexPath)
            }
        }else if indexPath.section == 2 {
            if indexPath.row == 0 {
                return headerCell(index: indexPath)
            }else{
                
             return agentBasicInformationCell(index: indexPath)
            }
        }else if indexPath.section == 3 {
            if indexPath.row == 0 {
                return headerCell(index: indexPath)
        }else{
             return agentBankDetailCell(index: indexPath)
          }
        }else if indexPath.section == 4 {
            if indexPath.row == 0 {
                return headerCell(index: indexPath)
        }else{
             return agentVatDetailCell(index: indexPath)
          }
        }else {
             return agentUserPolicyCell(index: indexPath)
        }
    }
    func checkSignUpStatus(){
        let companyEmail = ModalController.isValidEmail(testStr: agentSignUPModal.agentEmail)
        let companyConfirmEmail = ModalController.isValidEmail(testStr: agentSignUPModal.agentConfirmEmail)
        let mobileLength  = agentSignUPModal.mobileLength
        let str = agentSignUPModal.agentbankAccountNumber.replacingOccurrences(of: " ", with: "")
        let vatStr = agentSignUPModal.agentVatNumber.replacingOccurrences(of: " ", with: "")
        
        if  agentSignUPModal.imageID != 0 &&
            appDelegate.selectServiceStr != "" && agentSignUPModal.agentBussinessName != ""  && agentSignUPModal.agentEmail != ""  && agentSignUPModal.agentConfirmEmail != ""  &&
            agentSignUPModal.agentCountry != ""  && agentSignUPModal.agentCity != ""  && agentSignUPModal.agentContactNumber != "" &&
            agentSignUPModal.agentPassword != ""  && agentSignUPModal.agentConfirmPassword != "" && (companyEmail && companyConfirmEmail) && (companyEmail == companyConfirmEmail) && mobileLength == mobileNumberWithoutGap.count && (agentSignUPModal.agentPassword == agentSignUPModal.agentConfirmPassword) && (agentSignUPModal.agentPassword.count >= 8 && agentSignUPModal.agentConfirmPassword.count  >= 8) && agentSignUPModal.agentbankName != ""  && agentSignUPModal.agentbankAccountHolderName != ""  && agentSignUPModal.agentbankAccountNumber != "" && str.count >= 24 && ((isVatYesClicked == true && vatStr.count >= 15) || isVatNoClicked) && isUserPolicySelected == true  {
            
            if agentSignUPModal.agentPhoneNumber.count > 0  && (PhoneNumberWithoutGap.count < agentSignUPModal.phoneMinLength) {
                everythingFilled = false
                self.tabView.reloadData()
                 self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
               
            }else {
                everythingFilled = true
               self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
            }
        }else{
            everythingFilled = false
          self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 || indexPath.section == 5 {
            return
        }else if indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4  {
            if indexPath.row == 0 {
                self.view.endEditing(true)
                if SelectedIndex.count > 0 {
                    if SelectedIndex.contains(indexPath.section){
                        SelectedIndex.removeAllObjects()
                    }else{
                        SelectedIndex.removeAllObjects()
                        SelectedIndex.add(indexPath.section)
                  }
                }else{
                    SelectedIndex.add(indexPath.section)
                }
                tabView.reloadData()
            }else {
                return
            }
        }
        print("selectedIndex:-", SelectedIndex)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       var serviceCellHeight = 0
        let serviceCount = (AgentSERVICE?.data?.services_list?.count)
        if serviceCount == 0 || serviceCount == 1 || serviceCount == 2 {
         serviceCellHeight = 40
        }else if serviceCount ==  3 || serviceCount == 4 {
            serviceCellHeight = 70
        }else if serviceCount ==  5 || serviceCount == 6 {
            serviceCellHeight = 100
        }else if serviceCount ==  7 || serviceCount == 8 {
            serviceCellHeight = 130
        }else if serviceCount ==  9 || serviceCount == 10 {
            serviceCellHeight = 160
        }else if serviceCount ==  11 || serviceCount == 12 {
            serviceCellHeight = 190
        }else if serviceCount ==  13 || serviceCount == 14 {
            serviceCellHeight = 220
        }else if serviceCount ==  15 || serviceCount == 16 {
            serviceCellHeight = 230
        }
        
        if indexPath.section == 0 {
          return 205
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
              return 50
            }else {
                return CGFloat(serviceCellHeight + 35 )
            }
        }else if indexPath.section == 2 {
           if indexPath.row == 0 {
              return 50
        }else {
              return 645
         }
        }else if indexPath.section == 3 {
           if indexPath.row == 0 {
              return 50
        }else {
              return 230
         }
        }else if indexPath.section == 4 {
           if indexPath.row == 0 {
              return 50
        }else {
            if isVatYesClicked {
                return 370
            }else{
                return 120
            }
         }
        }else {
            return 130
        }
      }
     func agentProfileChangeCell(index : IndexPath) -> UITableViewCell {
            
            let cell = tabView.dequeueReusableCell(withIdentifier: "AgentProfileImageTableViewCell", for: index) as! AgentProfileImageTableViewCell
            cell.selectionStyle = .none
        cell.headerTxt.text = "Agent Company Registration".localized
        
        cell.agentprofileImageView.layer.borderWidth = 1.0
        cell.agentprofileImageView.layer.masksToBounds = true
        cell.agentprofileImageView.layer.borderColor = UIColor.white.cgColor
        cell.agentprofileImageView.layer.cornerRadius = 50
        cell.agentprofileImageView.clipsToBounds = true
        if isImageUploaded == true {
            cell.agentprofileImageView.image = tempImage
        }else{
            cell.agentprofileImageView.image = UIImage(named: "profile_white")
        }
            cell.tag = index.row
            cell.delegate = self
            return cell
        }
    
    func headerCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tabView.dequeueReusableCell(withIdentifier: "CompanyRegTableViewCell", for: index) as! CompanyRegTableViewCell
        cell.selectionStyle = .none
        cell.headerBackGroundView.layer.cornerRadius = 5
        cell.headerBackGroundView.clipsToBounds = true
        
        if index.section == 1 {
            let serviceStr = appDelegate.selectServiceStr
            if serviceStr.count == 0 {
                cell.editImageView.image = UIImage(named: "edit_red")
            }else {
                cell.editImageView.image = UIImage(named: "section_filled.png")
            }
            
        }else if index.section == 2 {
            let companyEmail = ModalController.isValidEmail(testStr: agentSignUPModal.agentEmail)
            let companyConfirmEmail = ModalController.isValidEmail(testStr: agentSignUPModal.agentConfirmEmail)
            let mobileLength  = agentSignUPModal.mobileLength
            
            if agentSignUPModal.agentBussinessName != ""  && agentSignUPModal.agentEmail != ""  && agentSignUPModal.agentConfirmEmail != ""  &&
                agentSignUPModal.agentCountry != ""  && agentSignUPModal.agentCity != ""  && agentSignUPModal.agentContactNumber != ""  &&
            agentSignUPModal.agentPassword != ""  && agentSignUPModal.agentConfirmPassword != "" && (companyEmail && companyConfirmEmail) && (companyEmail == companyConfirmEmail) && mobileLength == mobileNumberWithoutGap.count && (agentSignUPModal.agentPassword == agentSignUPModal.agentConfirmPassword) && (agentSignUPModal.agentPassword.count >= 8 && agentSignUPModal.agentConfirmPassword.count  >= 8) {
//                print("cellenterBasicInfoFirstMendatoryCondition")
                
                if agentSignUPModal.agentPhoneNumber.count > 0  && (PhoneNumberWithoutGap.count < agentSignUPModal.phoneMinLength) {
                    
//                    print("cellenterBasicInfoFirstOptionalCondition")
                    cell.editImageView.image = UIImage(named: "edit_red")
                }else{
                    
//                    print("cellNotenterBasicInfoFirstOptionalCondition")
                     cell.editImageView.image = UIImage(named: "section_filled.png")
                }
            }else{
//                print("cellNotenterBasicInfoFirstMendatoryCondition")
                cell.editImageView.image = UIImage(named: "edit_red")
            }
        }else if index.section == 3 {
            let str = agentSignUPModal.agentbankAccountNumber.replacingOccurrences(of: " ", with: "")
            if agentSignUPModal.agentbankName != ""  && agentSignUPModal.agentbankAccountHolderName != ""  && agentSignUPModal.agentbankAccountNumber != "" && str.count >= 24 {
                cell.editImageView.image = UIImage(named: "section_filled.png")
            }else{
                cell.editImageView.image = UIImage(named: "edit_red")
            }
        }else if index.section == 4 {
             let str = agentSignUPModal.agentVatNumber.replacingOccurrences(of: " ", with: "")
            if (isVatYesClicked == true && str.count >= 15)  || isVatNoClicked == true {
                 cell.editImageView.image = UIImage(named: "section_filled.png")
            }else{
                cell.editImageView.image = UIImage(named: "edit_red")
            }
        }
        if SelectedIndex.contains(index.section) {
            cell.arrowBtn.isSelected = true
        }else{
            if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
                if value[0]=="ar"
                {
                    let img2 = UIImage(named: "next_new")
                    let image2 = UIImage(cgImage: (img2?.cgImage)!, scale: (img2?.scale)!, orientation: UIImage.Orientation.upMirrored)
                    cell.arrowBtn.setImage(image2, for: .normal)
                }
                else if value[0]=="en"
                {
                    let image12 = UIImage(named: "next_new")
                    cell.arrowBtn.setImage(image12, for: .normal)
                }
            }
            cell.arrowBtn.isSelected = false
        }
        cell.serviceNameLabel.text = sectionHeaderTextArray[index.section - 1]
        
        cell.tag = index.row
        cell.delegate = self
        return cell
    }
    func agentServicesCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tabView.dequeueReusableCell(withIdentifier: "AgentCompanyServicesTableViewCell", for: index) as! AgentCompanyServicesTableViewCell
        cell.selectionStyle = .none
        cell.collectionView.layer.cornerRadius = 5
        cell.collectionView.clipsToBounds = true
        cell.collectionView.layer.borderWidth = 0.5
        cell.collectionView.borderColor =  UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        cell.AgentServicesOnCollection = AgentSERVICE
        
        cell.tag = index.row
//      cell.delegate = self
        return cell
    }
    
    func agentBasicInformationCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tabView.dequeueReusableCell(withIdentifier: "CompanyAgentBasicInformationTableViewCell", for: index) as! CompanyAgentBasicInformationTableViewCell
        cell.selectionStyle = .none
        cell.nameTxtFld.delegate = self
        cell.emailTxtFld.delegate = self
        cell.confirmTxtFld.delegate = self
        cell.confirmPasswordTxtFld.delegate = self
        cell.passwordTxtFld.delegate = self
        cell.phoneNumberTxtFld.delegate = self
        cell.mobileTxtFld.delegate = self
        cell.maroofTxtFld.delegate = self
        
        cell.nameTxtFld.addTarget(self, action: #selector(CompanyRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         cell.emailTxtFld.addTarget(self, action: #selector(CompanyRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         cell.confirmTxtFld.addTarget(self, action: #selector(CompanyRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         cell.confirmPasswordTxtFld.addTarget(self, action: #selector(CompanyRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.passwordTxtFld.addTarget(self, action: #selector(CompanyRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         cell.phoneNumberTxtFld.addTarget(self, action: #selector(CompanyRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         cell.mobileTxtFld.addTarget(self, action: #selector(CompanyRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
         cell.maroofTxtFld.addTarget(self, action: #selector(CompanyRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                
                cell.emailTxtFld.textAlignment = .left
                cell.confirmTxtFld.textAlignment = .left
                cell.maroofTxtFld.textAlignment = .left
                cell.passwordTxtFld.textAlignment = .left
                cell.confirmPasswordTxtFld.textAlignment = .left
                
            }else if value[0]=="en" {
                cell.emailTxtFld.textAlignment = .left
                cell.confirmTxtFld.textAlignment = .left
                cell.maroofTxtFld.textAlignment = .left
                cell.passwordTxtFld.textAlignment = .left
                cell.confirmPasswordTxtFld.textAlignment = .left
            }
        }
        
        if agentSignUPModal.agentPassword != "" && agentSignUPModal.agentPassword.count >= 8 {
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.passwordView)
        }else{
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.passwordView)
        }
        if agentSignUPModal.agentConfirmPassword != "" && agentSignUPModal.agentConfirmPassword.count >= 8 {
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.confirmPasswordView)
        }else{
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmPasswordView)
        }
        cell.confirmTxtFld.autocorrectionType = .no
        cell.mainView.layer.cornerRadius = 5
        cell.mainView.clipsToBounds = true
        cell.mainView.layer.borderWidth = 0.5
        cell.mainView.borderColor =  UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        cell.nameTxtFld.textColor = UIColor(red: 57/255, green: 58/255, blue: 58/255, alpha: 1)
        cell.nameTxtFld.text = agentSignUPModal.agentBussinessName
        cell.emailTxtFld.text = agentSignUPModal.agentEmail
        cell.confirmTxtFld.text = agentSignUPModal.agentConfirmEmail
        cell.mobileTxtFld.text = agentSignUPModal.agentContactNumber
        cell.phoneNumberTxtFld.text = agentSignUPModal.agentPhoneNumber
        
        if agentSignUPModal.agentEmail != "" &&  agentSignUPModal.agentConfirmEmail != ""  {
            let confirmEmail = agentSignUPModal.agentConfirmEmail.lowercased()
            let email = agentSignUPModal.agentEmail.lowercased()
            let companyEmail = ModalController.isValidEmail(testStr: email)
            let companyConfirmEmail = ModalController.isValidEmail(testStr: confirmEmail)
            
            if  (confirmEmail ==  email) && (companyEmail && companyConfirmEmail) {
                           if let imageView = self.view.viewWithTag(203) as? UIImageView{
                               imageView.isHidden = false
                            cell.confirmPasswordGreenTickWIdhtConstant.constant = 22
                               imageView.image = UIImage(named:"greenTick")
                               }
                           }else{
                              if let imageView = self.view.viewWithTag(203) as? UIImageView{
                                cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                                 imageView.isHidden = true
                               }
                          }
                      }else{
                          if let imageView = self.view.viewWithTag(203) as? UIImageView{
                            cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                              imageView.isHidden = true
                          }
                      }
        if agentSignUPModal.agentPassword != "" && agentSignUPModal.agentConfirmPassword  != "" {
            if agentSignUPModal.agentPassword == agentSignUPModal.agentConfirmPassword  && (agentSignUPModal.agentPassword.count == 8 || agentSignUPModal.agentPassword.count > 8) && (cell.passwordTxtFld.text!.containArabicNumber && cell.confirmPasswordTxtFld.text!.containArabicNumber ) {
                
                showConfirmButton.isUserInteractionEnabled = false
                showConfirmButton.setImage(UIImage(named:"greenTick"), for: .normal)
                
            }else{
                showConfirmButton.isUserInteractionEnabled = true
                if ispassword {
                    showConfirmButton.setImage(UIImage(named:"eye_new_hide"), for: .normal)
                    cell.passwordTxtFld.isSecureTextEntry = true
                    cell.hideShowPassword.isSelected = false
                }else{
                    showConfirmButton.setImage(UIImage(named:"eye"), for: .normal)
                    cell.passwordTxtFld.isSecureTextEntry = false
                    cell.hideShowPassword.isSelected = true
                }
            }
        }
        if self.selectedAgentCountryDict.count > 0 {
            cell.countryBtn.setTitle("\(self.selectedAgentCountryDict.object(forKey: "country_name") as! String)", for: .normal)
            
            if cell.countryBtn.currentTitle == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.countyView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.countyView)
            }
            if let value = selectedAgentCountryDict.object(forKey: "country_id") as? Int {
                agentSignUPModal.agentCountry = "\(value)"
            }
            agentSignUPModal.mobileLength = self.selectedAgentCountryDict.object(forKey: "mobile_length") as? Int ?? 0
             agentSignUPModal.phoneMinLength = self.selectedAgentCountryDict.object(forKey: "phone_min_length") as? Int ?? 0
             agentSignUPModal.PhoneMaxLength = self.selectedAgentCountryDict.object(forKey: "phone_max_length") as? Int ?? 0
                    
            agentSignUPModal.mobileCode = "\(self.selectedAgentCountryDict.object(forKey: "mobile_code") as! String)"
            agentSignUPModal.phoneCode = "\(self.selectedAgentCountryDict.object(forKey: "mobile_code") as! String)"
            
            agentSignUPModal.mobileCodeImage = "\(self.selectedAgentCountryDict.object(forKey: "country_flag") as! String)"
            agentSignUPModal.phoneCodeImage = "\(self.selectedAgentCountryDict.object(forKey: "country_flag") as! String)"
            
            cell.mobileCodeTxtFld.text = "\(self.selectedAgentCountryDict.object(forKey: "mobile_code") as! String)"
            cell.phoneCodeTxtFld.text = "\(self.selectedAgentCountryDict.object(forKey: "mobile_code") as! String)"
            
            if let str = self.selectedAgentCountryDict.object(forKey: "country_flag") as? String {
                if str.count > 0{
                    
                    cell.mobileCodeFlagImageView.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "flag_placeholder.png"))
                    
                    cell.phoneCodeImageView.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "flag_placeholder.png"))
                }
            }
        }
        if self.selectedCityDict.count > 0 {
            cell.cityBtn.setTitle("\(self.selectedCityDict.object(forKey: "city_name") as! String)", for: .normal)
            if cell.cityBtn.currentTitle == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.cityView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.cityView)
            }
            if let value = selectedCityDict.object(forKey: "city_id") as? Int{
                agentSignUPModal.agentCity = "\(value)"
            }
        }else{
             ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.cityView)
            cell.cityBtn.setTitle("", for: .normal)
            agentSignUPModal.agentCity = ""
            
            }
        
        if self.selectedCountryCodeDict.count > 0 {
          
            agentSignUPModal.mobileLength = self.selectedCountryCodeDict.object(forKey: "mobile_length") as? Int ?? 0
            agentSignUPModal.mobileCode = "\(self.selectedCountryCodeDict.object(forKey: "mobile_code") as! String)"
            agentSignUPModal.mobileCodeImage = "\(self.selectedCountryCodeDict.object(forKey: "country_flag") as! String)"
            cell.mobileCodeTxtFld.text = "\(self.selectedCountryCodeDict.object(forKey: "mobile_code") as! String)"
            
            if let str = self.selectedCountryCodeDict.object(forKey: "country_flag") as? String {
                if str.count > 0{
                    
                    cell.mobileCodeFlagImageView.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "flag_placeholder.png"))
                    
                }
            }
        }
        
        if self.selectedPhoneCodeDict.count > 0 {
            
             agentSignUPModal.phoneMinLength = self.selectedPhoneCodeDict.object(forKey: "phone_min_length") as? Int ?? 0
             agentSignUPModal.PhoneMaxLength = self.selectedPhoneCodeDict.object(forKey: "phone_max_length") as? Int ?? 0
            agentSignUPModal.phoneCode = "\(self.selectedPhoneCodeDict.object(forKey: "mobile_code") as! String)"
            agentSignUPModal.phoneCodeImage = "\(self.selectedPhoneCodeDict.object(forKey: "country_flag") as! String)"
            cell.phoneCodeTxtFld.text = "\(self.selectedPhoneCodeDict.object(forKey: "mobile_code") as! String)"
            
            if let str = self.selectedPhoneCodeDict.object(forKey: "country_flag") as? String {
                if str.count > 0{
                    
                    cell.phoneCodeImageView.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "flag_placeholder.png"))
                }
            }
        }
        
        cell.maroofTxtFld.text = maroofLink
        cell.passwordTxtFld.text = agentSignUPModal.agentPassword
        cell.confirmPasswordTxtFld.text = agentSignUPModal.agentConfirmPassword
        
        if ispassword {
            cell.passwordTxtFld.isSecureTextEntry = true
            cell.hideShowPassword.isSelected = false
        }else{
            cell.passwordTxtFld.isSecureTextEntry = false
            cell.hideShowPassword.isSelected = true
        }
        
        if isConfirmPassword {
                   cell.confirmPasswordTxtFld.isSecureTextEntry = true
                   cell.confirmPasswordMatchBtn.isSelected = false
               }else{
                   cell.confirmPasswordTxtFld.isSecureTextEntry = false
                   cell.confirmPasswordMatchBtn.isSelected = true
               }
        
        showButton = cell.hideShowPassword
        showConfirmButton = cell.confirmPasswordMatchBtn
        
//        if self.isCountryChangeAgain == false {
//            self.isCountryChangeAgain = true
////            cell.mobileTxtFld.text = ""
////             cell.phoneNumberTxtFld.text = ""
//            self.mobileNumberWithoutGap = ""
//            self.PhoneNumberWithoutGap = ""
////            agentSignUPModal.agentContactNumber = ""
////            agentSignUPModal.agentPhoneNumber = ""
////            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.contactNumberView)
//        }else{
//            cell.mobileTxtFld.text = agentSignUPModal.agentContactNumber
//            cell.phoneNumberTxtFld.text = agentSignUPModal.agentPhoneNumber
//             let str = agentSignUPModal.agentContactNumber.replacingOccurrences(of: " ", with: "")
//             let str1 = agentSignUPModal.agentPhoneNumber.replacingOccurrences(of: " ", with: "")
//            self.mobileNumberWithoutGap = str
//            self.PhoneNumberWithoutGap = str1
//        }
        
        cell.tag = index.row
        cell.delegate = self
        return cell
    }
    
    func agentBankDetailCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tabView.dequeueReusableCell(withIdentifier: "CompanyAgentBankDetailsTableViewCell", for: index) as! CompanyAgentBankDetailsTableViewCell
        cell.selectionStyle = .none
        cell.mainView.layer.cornerRadius = 5
        cell.mainView.clipsToBounds = true
        cell.mainView.layer.borderWidth = 0.5
        cell.mainView.borderColor =  UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        cell.bankNameTxtFld.delegate = self
        cell.accountHolderNameTxtFld.delegate = self
        cell.ibanNumberTxtFld.delegate = self
        //         cell.ibanNumberTxtFld.text = ibanPrefix
        
        cell.accountHolderNameTxtFld.addTarget(self, action: #selector(CompanyRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.ibanNumberTxtFld.addTarget(self, action: #selector(CompanyRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.ibanNumberTxtFld.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)

        
        if self.bankNameIdentifierList?.data?.count ?? 0 > 0 {
            let bankIdentifier  = self.bankNameIdentifierList?.data![0]
            let name = bankIdentifier?.bank_name
            cell.bankNameTxtFld.text = name
            agentSignUPModal.agentbankName = name ?? ""
            
            if let value = bankIdentifier?.id {
                agentSignUPModal.agentbankID = "\(value)"
            }
            if cell.bankNameTxtFld.text == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.bankNameView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.bankNameView)
            }
        }else{
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.bankNameView)
            agentSignUPModal.agentbankName = ""
        }
        
        cell.tag = index.row
        cell.delegate = self
        return cell
    }
       func agentVatDetailCell(index : IndexPath) -> UITableViewCell {
            
            let cell = tabView.dequeueReusableCell(withIdentifier: "CompanyAgentVatDetailTableViewCell", for: index) as! CompanyAgentVatDetailTableViewCell
            cell.selectionStyle = .none
        cell.vatNumberView.isHidden = true
        cell.vatNumberTxtFld.delegate = self
        cell.mainView.layer.cornerRadius = 5
        cell.mainView.clipsToBounds = true
        cell.mainView.layer.borderWidth = 0.5
        cell.mainView.borderColor =  UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
         cell.vatDocumentHeightConstant.constant = 0
         cell.documentMainView.isHidden = true
        cell.deleteDocuementBtn.isHidden = true
        cell.vatDocumentImageView.contentMode = .scaleToFill
        
          cell.vatNumberTxtFld.addTarget(self, action: #selector(CompanyRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.vatNumberTxtFld.text = agentSignUPModal.agentVatNumber
         if isVatYesClicked {
            cell.yesBtn.isSelected = true
             cell.vatNumberView.isHidden = false
             agentSignUPModal.isVatSelected = cell.yesBtn.isSelected
            cell.vatDocumentHeightConstant.constant = 244
            cell.documentMainView.isHidden = false
            
            }else{
            cell.yesBtn.isSelected = false
            cell.vatNumberView.isHidden = true
             agentSignUPModal.isVatSelected = cell.yesBtn.isSelected
             cell.vatDocumentHeightConstant.constant = 0
            cell.documentMainView.isHidden = true
            
          }
        
        if isVatNoClicked {
              cell.noBtn.isSelected = true
             agentSignUPModal.isVatNotSelected = cell.noBtn.isSelected
              
              }else{
            agentSignUPModal.isVatNotSelected = cell.noBtn.isSelected
              cell.noBtn.isSelected = false
            }

        
        if isFromVatDocument == true {
            if self.agentSignUPModal.vatDocumentUrl?.absoluteString != "" {
                cell.vatDocumentImageView.contentMode = .scaleAspectFill
                cell.deleteDocuementBtn.isHidden = false
 cell.vatDocumentImageView.image = drawPDFfromURL(url: self.agentSignUPModal.vatDocumentUrl! )
            }
            else {
                 cell.vatDocumentImageView.contentMode = .scaleToFill
                cell.deleteDocuementBtn.isHidden = true
                cell.vatDocumentImageView.image = UIImage(named: "vatSample_image.png")
            }
        }else{
            cell.vatDocumentImageView.contentMode = .scaleToFill
            cell.deleteDocuementBtn.isHidden = true
            cell.vatDocumentImageView.image = UIImage(named: "vatSample_image.png")
        }

        
        
            cell.tag = index.row
            cell.delegate = self
            return cell
        }

        func agentUserPolicyCell(index : IndexPath) -> UITableViewCell {
            
            let cell = tabView.dequeueReusableCell(withIdentifier: "AgentCompanyUserPolicyTableViewCell", for: index) as! AgentCompanyUserPolicyTableViewCell
            cell.selectionStyle = .none
            if everythingFilled == true {
                cell.signUpBtn.setTitleColor(UIColor(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
                cell.signUpBtn.layer.borderWidth = 0.5
                cell.signUpBtn.borderColor =  UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1)
            }else {
                
                cell.signUpBtn.setTitleColor(UIColor(red: 236/255, green: 74/255, blue: 83/255, alpha: 1), for: .normal)
                cell.signUpBtn.layer.borderWidth = 0.5
                cell.signUpBtn.borderColor =  UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
            }
            
            if isUserPolicySelected {
                cell.checkBoxBtn.isSelected = true
            agentSignUPModal.isPolicySelected = cell.checkBoxBtn.isSelected
                         
               }else{
                cell.checkBoxBtn.isSelected = false
                agentSignUPModal.isPolicySelected = cell.checkBoxBtn.isSelected
            }
            
            
            
            cell.tag = index.row
            cell.delegate = self
            return cell
        }
    
    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }

        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)

            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            ctx.cgContext.drawPDFPage(page)
        }

        return img
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch  textField.tag {
            
            
        case 1000:
             let allowedCharecter = CharacterSet.letters
             let characterSet = CharacterSet(charactersIn: string)
             let allowedCharacter1 = CharacterSet.whitespaces
            return allowedCharecter.isSuperset(of: characterSet) || allowedCharacter1.isSuperset(of: characterSet)
            
            
        case 1003:
            var lenght  = 2
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 2)) as! CompanyAgentBasicInformationTableViewCell
            let str = cell.mobileTxtFld.text
            
            if agentSignUPModal.mobileLength == 0 {
                  ModalController.showNegativeCustomAlertWith(title: "please select country code first.", msg: "")
               return false
            }
            if selectedAgentCountryDict.count > 0 {
                lenght = self.selectedAgentCountryDict.object(forKey: "mobile_length") as! Int
                
            }else if selectedCountryCodeDict.count > 0 {
                 lenght = self.selectedCountryCodeDict.object(forKey: "mobile_length") as! Int
            }
            guard let stringRange = Range(range,in: str!) else {
                return false
            }
            print(stringRange)
            print(str as Any)
            
            let updateText =  str!.replacingCharacters(in: stringRange, with: string)
            return (updateText.count) < lenght+3
            
        case 1004:
            var lenght  = 2
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 2)) as! CompanyAgentBasicInformationTableViewCell
            let str = cell.phoneNumberTxtFld.text
            
            if agentSignUPModal.phoneMinLength == 0 || agentSignUPModal.PhoneMaxLength == 0 {
                ModalController.showNegativeCustomAlertWith(title: "please select country code first.", msg: "")
                return false
            }
            if selectedAgentCountryDict.count > 0 {
                
                lenght = self.selectedAgentCountryDict.object(forKey: "phone_max_length") as! Int
                
            }else if selectedPhoneCodeDict.count > 0 {
                lenght = self.selectedPhoneCodeDict.object(forKey: "phone_max_length") as! Int
            }
            guard let stringRange = Range(range,in: str!) else {
                return false
            }
            print(stringRange)
            print(str as Any)
            
           
            let updateText =  str!.replacingCharacters(in: stringRange, with: string)
            return (updateText.count) < lenght+3
            
            
        case 1005:
            
            var textstr = ""
            if let text = textField.text as NSString? {
                let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                textstr = txtAfterUpdate
            }
            
            let textStr = "https://www.maroof.com/".localized
            if range.location < textStr.count - 1
            {
                return false
            }
            if textField.text == textStr  && range.length == 1 {
                return false
            }
            
            maroofLink = textstr
            agentSignUPModal.agentMaroofLink = textstr
            return true
            
        case 1006:
            var letters = string.map { String($0) }
            for i in 0..<string.count{
                
                if !letters[i].containArabicNumber{
                    ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passArabicNumber)
                    letters[i] = ""
                    return false
                }
            }
            return true
            
        case 1007:
            var letters = string.map { String($0) }
            for i in 0..<string.count{
                
                if !letters[i].containArabicNumber{
                    ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passArabicNumber)
                    letters[i] = ""
                    return false
                }
            }
            return true
            
        case 1009:
             let allowedCharecter = CharacterSet.letters
             let characterSet = CharacterSet(charactersIn: string)
             let allowedCharacter1 = CharacterSet.whitespaces
            return allowedCharecter.isSuperset(of: characterSet) || allowedCharacter1.isSuperset(of: characterSet)
            
       case 1010:
        var textstr = ""
        var lenght = 4
        if agentSignUPModal.agentIBanLength > 0 {
            lenght = agentSignUPModal.agentIBanLength
        }
        
        let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 3)) as! CompanyAgentBankDetailsTableViewCell
        
        // fixed SA
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            textstr = txtAfterUpdate
        }
       
        agentSignUPModal.agentbankAccountNumber = textstr
        
        // block enter char after 24
        let str = cell.ibanNumberTxtFld.text
        
        guard let stringRange = Range(range,in: str!) else {
            return false
        }
        print(stringRange)
        print(str as Any)
        let updateText =  str!.replacingCharacters(in: stringRange, with: string)
        
        ibanPrefix = textstr
        agentSignUPModal.agentbankAccountNumber = textstr
        return (updateText.count) < lenght+1
            
        case 1011:
            let lenght  =  self.agentSignUPModal.vatLength
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 4)) as! CompanyAgentVatDetailTableViewCell
            let str = cell.vatNumberTxtFld.text
            
            guard let stringRange = Range(range,in: str!) else {
                return false
            }
            print(stringRange)
            print(str as Any)
            let updateText =  str!.replacingCharacters(in: stringRange, with: string)
            return (updateText.count) < lenght+5
            
        default:
            print("text")
            
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch  textField.tag {
            
        case 1000:
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
            }else{
                agentSignUPModal.agentBussinessName = textField.text!
            }
//        case 1001:
//            let value = ModalController.isValidEmail(testStr: textField.text!)
//            if !value {
//                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.WrongemailAddress)
//            }else{
//                agentSignUPModal.agentEmail = textField.text!.lowercased()
//                let confirmEmail = agentSignUPModal.agentConfirmEmail.lowercased()
//                let email = agentSignUPModal.agentEmail.lowercased()
//
//                if email != "" && confirmEmail  != "" {
//                    if  email ==  confirmEmail {
//                        if let imageView = self.view.viewWithTag(203) as? UIImageView{
//                            imageView.isHidden = false
//                            imageView.image = UIImage(named:"greenTick")
//                        }
//                    }else{
//                        if let imageView = self.view.viewWithTag(203) as? UIImageView{
//                            imageView.isHidden = true
//                        }
//                    }
//                }
//            }
//        case 1002:
//            let value = ModalController.isValidEmail(testStr: textField.text!)
//            if !value{
//                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.WrongemailAddress)
//            }else{
//                agentSignUPModal.agentConfirmEmail = textField.text!.lowercased()
//                let confirmEmail = agentSignUPModal.agentConfirmEmail.lowercased()
//                let email = agentSignUPModal.agentEmail.lowercased()
//
//                   if email != "" && confirmEmail  != "" {
//                if  email ==  confirmEmail {
//                    if let imageView = self.view.viewWithTag(203) as? UIImageView{
//                        imageView.isHidden = false
//                        imageView.image = UIImage(named:"greenTick")
//                    }
//                }else{
//                    if let imageView = self.view.viewWithTag(203) as? UIImageView{
//                        imageView.isHidden = true
//                    }
//                }
//            }
//            }
            
        case 1003:
            agentSignUPModal.agentContactNumber = textField.text!
            
        case 1004:
            agentSignUPModal.agentPhoneNumber = textField.text!
            
        case 1005:
            agentSignUPModal.agentMaroofLink = textField.text!
            
//        case 1007:
//            if  textField.text!.count < 8 {
//                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passwordCount)
//
//            }else{
//                agentSignUPModal.agentConfirmPassword = textField.text! // confirm
//
//                if agentSignUPModal.agentPassword != "" && agentSignUPModal.agentConfirmPassword  != "" {
//                if agentSignUPModal.agentPassword == agentSignUPModal.agentConfirmPassword {
//
//                    showConfirmButton.isUserInteractionEnabled = true
//                    showConfirmButton.setImage(UIImage(named:"greenTick"), for: .normal)
//
//                }else{
//                    showConfirmButton.isUserInteractionEnabled = true
//                    if ispassword {
//                        showConfirmButton.setImage(UIImage(named:"eye_new_hide"), for: .normal)
//                    }else{
//                        showConfirmButton.setImage(UIImage(named:"eye"), for: .normal)
//                    }
//                    }
//                }
//            }
//        case 1006:
//            if  textField.text!.count < 8 {
//                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passwordCount)
//            }else{
//                agentSignUPModal.agentPassword = textField.text!
//                 if agentSignUPModal.agentPassword != "" && agentSignUPModal.agentConfirmPassword  != "" {
//                if agentSignUPModal.agentPassword == agentSignUPModal.agentConfirmPassword {
//
//                    showConfirmButton.isUserInteractionEnabled = true
//                    showConfirmButton.setImage(UIImage(named:"greenTick"), for: .normal)
//
//                }else{
//                    showConfirmButton.isUserInteractionEnabled = true
//                    if ispassword {
//                        showConfirmButton.setImage(UIImage(named:"eye_new_hide"), for: .normal)
//                    }else{
//                        showConfirmButton.setImage(UIImage(named:"eye"), for: .normal)
//                    }
//                    }
//                }
//            }
            
        case 1009:
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
            }else{
                agentSignUPModal.agentbankAccountHolderName = textField.text!
            }
            
        case 1010:
            agentSignUPModal.agentbankAccountNumber = textField.text!
            
        case 1011:
            agentSignUPModal.agentVatNumber = textField.text!
            
        default:
            print("text")
        }
        if agentSignUPModal.agentbankName != ""  && agentSignUPModal.agentbankAccountHolderName != ""  && agentSignUPModal.agentbankAccountNumber != "" {
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
        }else{
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
        }
        
        if agentSignUPModal.agentBussinessName != ""  && agentSignUPModal.agentEmail != "" && agentSignUPModal.agentConfirmEmail != "" &&
            agentSignUPModal.agentCountry != ""  && agentSignUPModal.agentCity != "" && agentSignUPModal.agentContactNumber != "" &&
            agentSignUPModal.agentPassword != "" && agentSignUPModal.agentConfirmPassword != "" {
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)

        }else{
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
        }
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        
        switch  textField.tag {
            
        case 1000:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 2)) as! CompanyAgentBasicInformationTableViewCell
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.businessNameView)
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
            }else{
                if cell.nameTxtFld.text == "" {
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.businessNameView)
                }else{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.businessNameView)
                }
            }
            agentSignUPModal.agentBussinessName = textField.text!
        case 1001:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 2)) as! CompanyAgentBasicInformationTableViewCell
            agentSignUPModal.agentEmail = textField.text!.lowercased()
            
            let confirmEmail = agentSignUPModal.agentConfirmEmail.lowercased()
            let email = agentSignUPModal.agentEmail.lowercased()
            let companyEmail = ModalController.isValidEmail(testStr: email)
            if companyEmail {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.emailView)
            }else{
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.emailView)
            }
            if email != "" && confirmEmail  != "" {
                let companyEmail = ModalController.isValidEmail(testStr: email)
                let companyConfirmEmail = ModalController.isValidEmail(testStr: confirmEmail)
                
                if companyEmail && companyConfirmEmail {
                    if  confirmEmail ==  email {
                        
                        if let imageView = self.view.viewWithTag(203) as? UIImageView{
                            imageView.isHidden = false
                            imageView.image = UIImage(named:"greenTick")
                            cell.confirmPasswordGreenTickWIdhtConstant.constant = 22
                            if companyConfirmEmail {
                                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.confirmEmailView)
                            }else{
                                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                            }
                        }
                    }else{
                        if let imageView = self.view.viewWithTag(203) as? UIImageView{
                            imageView.isHidden = true
                            cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                        }
                    }
                }else{
                    if let imageView = self.view.viewWithTag(203) as? UIImageView{
                        imageView.isHidden = true
                        cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                    }
                }
            }else{
                if let imageView = self.view.viewWithTag(203) as? UIImageView{
                    imageView.isHidden = true
                    cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                }
            }
//              agentSignUPModal.agentEmail = textField.text!
        case 1002:
            agentSignUPModal.agentConfirmEmail = textField.text!.lowercased()
            let confirmEmail = agentSignUPModal.agentConfirmEmail.lowercased()
            let email = agentSignUPModal.agentEmail.lowercased()
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 2)) as! CompanyAgentBasicInformationTableViewCell
            
            if email != "" && confirmEmail  != "" {
                let companyEmail = ModalController.isValidEmail(testStr: email)
                let companyConfirmEmail = ModalController.isValidEmail(testStr: confirmEmail)
                if companyEmail && companyConfirmEmail {
                    if confirmEmail == email {
                        if let imageView = self.view.viewWithTag(203) as? UIImageView {
                            imageView.isHidden = false
                            cell.confirmPasswordGreenTickWIdhtConstant.constant = 22
                            imageView.image = UIImage(named:"greenTick")
                            if companyConfirmEmail {
                                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.confirmEmailView)
                            }else{
                                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                            }
                        }
                    }else{
                        if let imageView = self.view.viewWithTag(203) as? UIImageView{
                            imageView.isHidden = true
                            cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                        }
                    }
                }else{
                    if let imageView = self.view.viewWithTag(203) as? UIImageView{
                        imageView.isHidden = true
                        cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                    }
                }
            }else{
                if let imageView = self.view.viewWithTag(203) as? UIImageView{
                    imageView.isHidden = true
                    cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                }
            }
//            agentSignUPModal.agentConfirmEmail = textField.text!
        case 1003:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 2)) as! CompanyAgentBasicInformationTableViewCell
            
            if MobileNumber != "" {
                mobileValue = textField.text!
                MobileNumber = mobileValue.replacingOccurrences(of: " ", with: "")
                mobileValue = ModalController.customStringFormatting(of: MobileNumber)
            }else{
                mobileValue =  ModalController.customStringFormatting(of: textField.text!)
                MobileNumber = mobileValue.replacingOccurrences(of: " ", with: "")
            }
            textField.text = mobileValue
            
            if selectedAgentCountryDict.count > 0 || selectedCountryCodeDict.count > 0 {
                var count = 0
                if self.selectedAgentCountryDict.count > 0 {
                    count = self.selectedAgentCountryDict.object(forKey: "mobile_length") as! Int
                }else{
                    count  = self.selectedCountryCodeDict.object(forKey: "mobile_length") as! Int
                }
                let str = cell.mobileTxtFld.text?.replacingOccurrences(of: " ", with: "")
                if str!.count == count {
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.contactNumberView)
                }else{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.contactNumberView)
                }
            }
            if !cell.mobileTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.contactNumberView)
            }
             let str = cell.mobileTxtFld.text?.replacingOccurrences(of: " ", with: "")
            agentSignUPModal.agentContactNumber = textField.text!
            mobileNumberWithoutGap = str!
            
        case 1004:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 2)) as! CompanyAgentBasicInformationTableViewCell
            
            if mobilNoo != "" {
                value = textField.text!
                mobilNoo = value.replacingOccurrences(of: " ", with: "")
                value = ModalController.customStringFormatting(of: mobilNoo)
            }else{
                value =  ModalController.customStringFormatting(of: textField.text!)
                mobilNoo = value.replacingOccurrences(of: " ", with: "")
            }
            textField.text = value
            
            if textField.text!.count > 0 {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.phoneNumberView)
                if selectedAgentCountryDict.count > 0  || selectedPhoneCodeDict.count > 0  {
                    var minCount = 0
                    if self.selectedAgentCountryDict.count > 0 {
                        minCount = self.selectedAgentCountryDict.object(forKey: "phone_min_length") as! Int
                    }else {
                        minCount  = self.selectedPhoneCodeDict.object(forKey: "phone_min_length") as! Int
                    }
                   
                    let str = cell.phoneNumberTxtFld.text?.replacingOccurrences(of: " ", with: "")
                    if str!.count > minCount || str!.count == minCount {
                        ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.phoneNumberView)
                    }else{
                        ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.phoneNumberView)
                    }
                }
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.phoneNumberView)
            }
            
            if !cell.phoneNumberTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.phoneNumberView)
            }
             let str = cell.phoneNumberTxtFld.text?.replacingOccurrences(of: " ", with: "")
            agentSignUPModal.agentPhoneNumber = textField.text!
            PhoneNumberWithoutGap = str!
        case 1005:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 2)) as! CompanyAgentBasicInformationTableViewCell
            
            if cell.maroofTxtFld.text!.count > 0 && !cell.maroofTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.maroofView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.maroofView)
            }
            
        case 1006:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 2)) as! CompanyAgentBasicInformationTableViewCell
            
            agentSignUPModal.agentPassword = textField.text!
            if agentSignUPModal.agentPassword != "" && agentSignUPModal.agentConfirmPassword  != "" {
                if (agentSignUPModal.agentPassword == agentSignUPModal.agentConfirmPassword) && (agentSignUPModal.agentPassword.count >= 8 && agentSignUPModal.agentConfirmPassword.count  >= 8) && cell.passwordTxtFld.text!.containArabicNumber {
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.passwordView)
                    showConfirmButton.isUserInteractionEnabled = true
                    showConfirmButton.setImage(UIImage(named:"greenTick"), for: .normal)
                    
                }else{
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.passwordView)
                    showConfirmButton.isUserInteractionEnabled = true
                    if ispassword {
                        showConfirmButton.setImage(UIImage(named:"eye_new_hide"), for: .normal)
                    }else{
                        showConfirmButton.setImage(UIImage(named:"eye"), for: .normal)
                    }
                }
            }else{
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.passwordView)
                showConfirmButton.isUserInteractionEnabled = true
                if ispassword {
                    showConfirmButton.setImage(UIImage(named:"eye_new_hide"), for: .normal)
                }else{
                    showConfirmButton.setImage(UIImage(named:"eye"), for: .normal)
                }
            }
            
            if agentSignUPModal.agentPassword != "" && agentSignUPModal.agentPassword.count >= 8 {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.passwordView)
            }else{
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.passwordView)
            }
            
            if !cell.passwordTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.passwordView)
            }
            agentSignUPModal.agentPassword = textField.text!
            
        case 1007:
            agentSignUPModal.agentConfirmPassword = textField.text! // confirm
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 2)) as! CompanyAgentBasicInformationTableViewCell
            
            if agentSignUPModal.agentPassword != "" && agentSignUPModal.agentConfirmPassword  != "" {
                if (agentSignUPModal.agentPassword == agentSignUPModal.agentConfirmPassword) && (agentSignUPModal.agentPassword.count >= 8 && agentSignUPModal.agentConfirmPassword.count  >= 8) && cell.confirmPasswordTxtFld.text!.containArabicNumber {
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.passwordView)
                    showConfirmButton.isUserInteractionEnabled = true
                    showConfirmButton.setImage(UIImage(named:"greenTick"), for: .normal)
                }else{
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmPasswordView)
                    showConfirmButton.isUserInteractionEnabled = true
                    if ispassword {
                        showConfirmButton.setImage(UIImage(named:"eye_new_hide"), for: .normal)
                    }else{
                        showConfirmButton.setImage(UIImage(named:"eye"), for: .normal)
                    }
                }
            }else{
                showConfirmButton.isUserInteractionEnabled = true
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmPasswordView)
                if ispassword {
                    showConfirmButton.setImage(UIImage(named:"eye_new_hide"), for: .normal)
                }else{
                    showConfirmButton.setImage(UIImage(named:"eye"), for: .normal)
                }
            }
            if (agentSignUPModal.agentConfirmPassword != "" && agentSignUPModal.agentConfirmPassword.count >= 8) && (agentSignUPModal.agentPassword == agentSignUPModal.agentConfirmPassword) {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.confirmPasswordView)
            }else{
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmPasswordView)
            }
            if !cell.confirmPasswordTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmPasswordView)
            }
            agentSignUPModal.agentConfirmPassword = textField.text!
            
        case 1009:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 3)) as! CompanyAgentBankDetailsTableViewCell
            
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.accountHolderNameView)
            }else{
                if cell.accountHolderNameTxtFld.text == "" {
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.accountHolderNameView)
                    
                } else if (agentSignUPModal.agentName_CompareCode == "YES".uppercased()) && (agentSignUPModal.agentBussinessName != textField.text!) {
                     ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.accountHolderNameView)
                }else{
                    
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.accountHolderNameView)
                }
            }
            agentSignUPModal.agentbankAccountHolderName = textField.text!
            
        case 1010:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 3)) as! CompanyAgentBankDetailsTableViewCell
            
//            if accountNumber != "" {
//                accountValue = textField.text!
//                accountNumber = accountValue.replacingOccurrences(of: " ", with: "")
//                accountValue = ModalController.customStringFormattingForAccountNumber(of: accountNumber)
//            }else{
//                accountValue =  ModalController.customStringFormattingForAccountNumber(of: textField.text!)
//                accountNumber = accountValue.replacingOccurrences(of: " ", with: "")
//            accountNumber = accountValue

//            }
            
//            let str = cell.ibanNumberTxtFld.text?.replacingOccurrences(of: " ", with: "")
            let str = cell.ibanNumberTxtFld.text!.uppercased()
            cell.ibanNumberTxtFld.text = str
            if str.count == agentSignUPModal.agentIBanLength && cell.ibanNumberTxtFld.text != "" &&  cell.ibanNumberTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.ibanNumberView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.ibanNumberView)
            }
            
//            textField.text = accountValue
            agentSignUPModal.agentbankAccountNumber = str
            cell.ibanNumberTxtFld.keyboardType = .asciiCapable
            if agentSignUPModal.agentbankAccountNumber.count == 2 {
               
                let str = agentSignUPModal.agentbankAccountNumber
                let agentCountryCode =  str.substring(from: 0, to: 1)
                print("agentCountryCode:-", agentCountryCode)
                self.getIbanLengthAPI(countryCode: agentCountryCode)
                
            }else if agentSignUPModal.agentbankAccountNumber.count == 4 {
                
            let str = agentSignUPModal.agentbankAccountNumber
           let bankStr =  str.substring(from: 2, to: 3)
               print("bankIdentifier:-", bankStr)
               self.bankNameApi(identifier: bankStr)
            }
            
            if agentSignUPModal.agentbankAccountNumber.count < 4 {
                cell.bankNameTxtFld.text = ""
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.bankNameView)
            }
  
        case 1011:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 4)) as! CompanyAgentVatDetailTableViewCell
            
            if VatNumber != "" {
                vatValue = textField.text!
                VatNumber = vatValue.replacingOccurrences(of: " ", with: "")
                vatValue = ModalController.customStringFormatting(of: VatNumber)
            }else {
                vatValue =  ModalController.customStringFormatting(of: textField.text!)
                VatNumber = vatValue.replacingOccurrences(of: " ", with: "")
            }
            
            textField.text = vatValue
            let str = cell.vatNumberTxtFld.text?.replacingOccurrences(of: " ", with: "")
            agentSignUPModal.agentVatNumber = str!
            
            if str!.count >= agentSignUPModal.vatLength  && cell.vatNumberTxtFld.text != "" &&  cell.vatNumberTxtFld.text!.containArabicNumber{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.vatNumberView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.vatNumberView)
            }
             agentSignUPModal.agentVatNumber = str!
        default:
            print("text")
        }
        
        if (isVatYesClicked == true && agentSignUPModal.agentVatNumber.count >= 15 )  || isVatNoClicked == true {
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
        }else{
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
        }
        
        if agentSignUPModal.agentbankName != ""  && agentSignUPModal.agentbankAccountHolderName != ""  && agentSignUPModal.agentbankAccountNumber != "" && agentSignUPModal.agentbankAccountNumber.count >= 24 {
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
        }else{
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
        }
        
        let companyEmail = ModalController.isValidEmail(testStr: agentSignUPModal.agentEmail)
        let companyConfirmEmail = ModalController.isValidEmail(testStr: agentSignUPModal.agentConfirmEmail)
        let mobileLength  = agentSignUPModal.mobileLength
                
        if agentSignUPModal.agentBussinessName != ""  && agentSignUPModal.agentEmail != ""  && agentSignUPModal.agentConfirmEmail != ""  &&
            agentSignUPModal.agentCountry != ""  && agentSignUPModal.agentCity != ""  && agentSignUPModal.agentContactNumber != ""  &&
            agentSignUPModal.agentPassword != ""  && agentSignUPModal.agentConfirmPassword != "" && companyEmail && companyConfirmEmail && (companyEmail == companyConfirmEmail) && (mobileLength == mobileNumberWithoutGap.count) && (agentSignUPModal.agentPassword == agentSignUPModal.agentConfirmPassword) && (agentSignUPModal.agentPassword.count >= 8 && agentSignUPModal.agentConfirmPassword.count  >= 8) {
//            print("enterDidChangeFirstMendatoryCondition")
            if agentSignUPModal.agentPhoneNumber.count > 0  && (PhoneNumberWithoutGap.count >= agentSignUPModal.phoneMinLength) {
//                 print("EnterDidChangeFirstOptionalCondition")
                self.tabView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
            }else{
//                 print("NotEnterDidChangeFirstOptionalCondition")
                 self.tabView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
            }
            
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
            
        }else{
//            print("NotEnterDidChangeFirstMendatoryCondition")
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
        }
    }
    
    @objc func handleTextChange(_ textField: UITextField) {
        
    if textField.text!.count < 2 {
      textField.keyboardType = .asciiCapable
      textField.reloadInputViews() // need to reload the input view for this to work
    } else if textField.text!.count > 2 || textField.text!.count == 2 {
      textField.keyboardType = .asciiCapableNumberPad
      textField.reloadInputViews()
    }
    }
    
}
extension UIImage {
    
    func scaleProfileImageToSize(newSize: CGSize) -> UIImage {
        
        var scaledImageRect = CGRect.zero
        
        let aspectWidth = newSize.width/size.width
        let aspectheight = newSize.height/size.height
        
        let aspectRatio = max(aspectWidth, aspectheight)
        
        scaledImageRect.size.width = size.width * aspectRatio;
        scaledImageRect.size.height = size.height * aspectRatio;
        scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0;
        scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0;
        
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}
extension String {
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }

        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }

        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }

        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }

        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }

        return String(self[startIndex ..< endIndex])
    }

    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }

    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }

    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }

        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }

        return self.substring(from: from, to: end)
    }

    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }

        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }

        return self.substring(from: start, to: to)
    }
}
