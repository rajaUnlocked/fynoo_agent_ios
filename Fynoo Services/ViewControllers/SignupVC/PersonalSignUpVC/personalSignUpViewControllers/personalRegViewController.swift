//
//  CompanyRegViewController.swift
//  Fynoo Business
//
//  Created by Sendan IT on 15/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import Alamofire
import PopupDialog
import MTPopup
import MobileCoreServices

class PersonalRegViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,CompanyRegTableViewCellDelegate,AgentProfileImageTableViewCellDelegate,ImageSelectPopUpDialogViewControllerDelegate,UITextFieldDelegate,SearchCategoryViewControllerDelegate,CompanyAgentBankDetailsTableViewCellDelegate,CompanyAgentVatDetailTableViewCellDelegate,AgentCompanyUserPolicyTableViewCellDelegate,agentPersonalDetailsTableViewCellDelegate,PersonalAgentBasicInformationTableViewCellDelegate,DiscountTypePopUpViewControllerDelegate, UIDocumentPickerDelegate {
    func selectedCountryCode(countryCode: NSMutableDictionary) {
        
    }
    
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
               if isLoginThere == false{
                   let vc = LoginNewDesignViewController(nibName: "LoginNewDesignViewController", bundle: nil)
                   self.navigationController?.pushViewController(vc, animated: true)
               }
    }
    @IBOutlet var bgImage: UIImageView!
    func selectedCheckBox(_ sender: Any) {
        
    }
    var AgentSERVICE:AgentService?
    var bankNameIdentifierList:bankIdentifier_list?
    
   @IBOutlet var headerView: NavigationView!
   @IBOutlet weak var tabView: UITableView!
  
    var   tempImage: UIImage!
    var selectedImage: UIImage!
    var imageupload:ImageUpload?
    var showButton = UIButton()
    var showConfirmButton = UIButton()
    var selectedArray:NSMutableArray = NSMutableArray()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var SelectedIndex:NSMutableArray = NSMutableArray()
    var selectedAgentCountryDict : NSMutableDictionary = NSMutableDictionary()
    var selectedCityDict : NSMutableDictionary = NSMutableDictionary()
    var selectedBankDict : NSMutableDictionary = NSMutableDictionary()
    var selectedAgentEducationDict : NSDictionary = NSDictionary()
    var selectedAgentMajorEducationDict : NSMutableDictionary = NSMutableDictionary()
    var selectedCountryCodeDict : NSMutableDictionary = NSMutableDictionary()
    var sectionHeaderTextArray = ["Services".localized,"Personal Details".localized,"Basic Information".localized,"Bank Details".localized,"Vat Information".localized]
    var maroofLink = ""
     var ibanPrefix = ""
    var ispassword:Bool = true
    var isConfirmPassword:Bool = true
    
    var isVatYesClicked:Bool = false
    var isVatNoClicked:Bool = false
    var isCountryChangeAgain:Bool = true
    
    var isUserPolicySelected:Bool = false
     var everythingFilled:Bool = false
    var personalAgentGender: String? = ""
    var personalAgentDOB: String? = ""
    var signupDobOnlyToDisplay: String? = ""
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var downImage: UIImageView!
     var isImageUploaded:Bool = false
    
     var personalAgentSignUPModal = PersonalAgentSignUPModal()
    var mobileValue = ""
    var MobileNumber = ""
      
      var vatValue = ""
      var VatNumber = ""
    
    var accountValue = ""
    var accountNumber = ""
    
    var mobileNumberWithoutGap = ""
    
    var isFromVatDocument:Bool = false
        var documentImageSize = NSMutableArray()
       var size = 0.0
        var vatInformationModal = AgentVatInformationModal()
        var agentVatInfoDatas : VatInfoModal?
       
       var IBANinformationModal = AgentIbanLengthModal()
        var agentIbanInfoDatas : IbanLengthInfoModal?
    
    
    override func viewDidLoad() {
        
        ModalController.watermark(self.view)
        super.viewDidLoad()
        appDelegate.selectServiceStr = ""
           self.serviceAPI()
        self.getVatInfoAPI()
        self.tabView.delegate = self
        self.tabView.dataSource = self
//        downImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.view.bringSubviewToFront(headerView)
        maroofLink = "https://www.maroof.com/".localized;
//         ibanPrefix = "SA".localized;
        self.registerAgentNotifications()
      tabView.register(UINib(nibName: "CompanyRegTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyRegTableViewCell")
      tabView.register(UINib(nibName: "AgentCompanyServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "AgentCompanyServicesTableViewCell")
      tabView.register(UINib(nibName: "AgentProfileImageTableViewCell", bundle: nil), forCellReuseIdentifier: "AgentProfileImageTableViewCell")
           tabView.register(UINib(nibName: "PersonalAgentBasicInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonalAgentBasicInformationTableViewCell")
      tabView.register(UINib(nibName: "AgentCompanyUserPolicyTableViewCell", bundle: nil), forCellReuseIdentifier: "AgentCompanyUserPolicyTableViewCell")
      tabView.register(UINib(nibName: "CompanyAgentBankDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyAgentBankDetailsTableViewCell")
      tabView.register(UINib(nibName: "CompanyAgentVatDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "CompanyAgentVatDetailTableViewCell")
        
        tabView.register(UINib(nibName: "agentPersonalDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "agentPersonalDetailsTableViewCell")

          self.showButton.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
              self.showConfirmButton.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
          self.showButton.tag = 1001
          self.showConfirmButton.tag = 1002
          self.tabView.separatorStyle = .none
        self.headerView.titleHeader.text = "Welcome, Let's Create An Account".localized
        headerView.viewControl = self
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
              
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        self.headerView.titleHeader.textColor = Constant.Black_TEXT_COLOR
        

    }
    
    @objc func showPassword(_ sender: UIButton) {
        if sender.tag == 1001{
            if sender.isSelected == true{
                sender.isSelected = false
              }else{
                sender.isSelected = false
              }
        }else{
            if sender.isSelected == true{
                sender.isSelected = false
            }else{
                sender.isSelected = false
            }
        }
      }
    func registerAgentNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationChangeServiceIconClicked(_:)), name: NSNotification.Name(rawValue: "changeServiceIcon"), object: nil)
    }
    @objc func methodOfReceivedNotificationChangeServiceIconClicked(_ notification: NSNotification) {
        self.tabView.reloadData()
      }

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
        
        personalAgentSignUPModal.ProfileImage = compressedImage
        self.isImageUploaded = true
      
//        self.uploadProfileImagesAPI()
        dismiss(animated:true, completion: nil) 
        
        
        self.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //            self.galleryImg.setImage(image, for: .normal)
        } else{
            print("Something went wrong in image".localized)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
   
    func serviceAPI(){
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
                self.personalAgentSignUPModal.personalAgentName_CompareCode = ModalController.toString(self.AgentSERVICE?.data?.compare_code as Any)
                self.personalAgentSignUPModal.PersonalAgentAge_limit = ModalController.toString(self.AgentSERVICE?.data?.age_limit as Any)
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
                self.personalAgentSignUPModal.personalVatLength = self.agentVatInfoDatas?.data?.vat_length ?? 0
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
                self.personalAgentSignUPModal.personalAgentIBanLength = self.agentIbanInfoDatas?.data?.bank_number_length ?? 0
            }else{
                
                self.ibanPrefix = ""
                self.tabView.reloadData()
            }
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
                    
                    let index = IndexPath(row: 1, section: 4)
                    let cell: CompanyAgentBankDetailsTableViewCell = self.tabView.cellForRow(at: index) as! CompanyAgentBankDetailsTableViewCell
                    
                    if self.bankNameIdentifierList?.data?.count ?? 0 > 0 {
                        let bankIdentifier  = self.bankNameIdentifierList?.data![0]
                        let name = bankIdentifier?.bank_name
                        cell.bankNameTxtFld.text = name
                        self.personalAgentSignUPModal.personalAgentbankName = name ?? ""
                        
                        if let value = bankIdentifier?.id {
                            self.personalAgentSignUPModal.personalAgentbankID = "\(value)"
                        }
                        if cell.bankNameTxtFld.text == "" {
                            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.bankNameView)
                        }else{
                            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.bankNameView)
                        }
                    }else{
                        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.bankNameView)
                        self.personalAgentSignUPModal.personalAgentbankName = ""
                    }
                    //                    self.tabView.reloadRows(at: [IndexPath(row: 1, section: 3)], with: .none)
                }
            }else{

                if response == nil
                {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error".localized, msg: "")
                }else{
//                    self.ibanPrefix = ""
//                    self.tabView.reloadData()
                    print ("data not in proper json")
                }
            }
        }
    }

    @IBAction func nextbtnAction(_ sender: UIButton) {
        
        if personalAgentSignUPModal.personalAgentImageID == 0 {
            
            ModalController.showNegativeCustomAlertWith(title: "", msg: "please select logo.".localized)
            
        }
       else if personalAgentSignUPModal.personalAgentImageID == 0 && personalAgentSignUPModal.personalAgentserviceIDstr.count == 0 {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "please select a service.".localized)

        } else if personalAgentSignUPModal.personalAgentserviceIDstr.count == 0 {

            ModalController.showNegativeCustomAlertWith(title: "", msg: "please select minimum one service.".localized)
        }else{
        
//            let view = personalRegNextViewController(nibName: "personalRegNextViewController", bundle: nil)
//            self.navigationController?.pushViewController(view, animated: true)
       }
    }
    // profileImageUpload
func uploadProfileImagesAPI(){
        
  ModalClass.startLoading(self.view)
  ServerCalls.fileUploadAPI(Imgtype:"",imagefrom:"user",img: tempImage) { (response, success, resp) in
    ModalClass.stopLoading()
        if success == true {
        self.imageupload = try! JSONDecoder().decode(ImageUpload.self, from: resp as! Data )
        if self.imageupload!.error {
            ModalController.showNegativeCustomAlertWith(title:" Error", msg: "")
                    
            }else{
                    print("response:-", self.imageupload)
            self.isImageUploaded = true
                    if let profileImageID = self.imageupload?.data?.image_id  {
                        self.personalAgentSignUPModal.personalAgentImageID = profileImageID
                    }
            self.tabView.reloadData()
                }
            }else{
                if response == nil{
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error".localized, msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
        }
    }
    
    func selectHeader(tag:Int) {
            
        }
    
    func profileImageSelected(){
        let vc = DiscountTypePopUpViewController(nibName: "DiscountTypePopUpViewController", bundle: nil)
        vc.delegate = self
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
        
        //        let failVC = ImageSelectPopUpDialogViewController(nibName: "ImageSelectPopUpDialogViewController", bundle: nil)
        //        let popup = PopupDialog(viewController: failVC,
        //                                buttonAlignment: .horizontal,
        //                                transitionStyle: .fadeIn,
        //                                tapGestureDismissal: true,
        //                                panGestureDismissal: false)
        //        failVC.delegate = self
        //        present(popup, animated: true, completion: nil)
    }
    func selectedDiscountOption(str: String) {
        if str == "Camera".localized {
            self.cameraSelected()
        }else if str == "Device Gallery".localized {
            self.gallerySelected()
        }
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
    
    func AgentselectDOB(_ sender: Any){
        let calendar = Calendar(identifier: .gregorian)
                let currentDate = Date()
                var components = DateComponents()
                components.calendar = calendar
//               components.year = -18
        components.year = -(Int(personalAgentSignUPModal.PersonalAgentAge_limit) ?? 18)
                components.month = 12
                let maxDate = calendar.date(byAdding: components, to: currentDate)!

                let minDate = Calendar.current.date(from: DateComponents(year: 1900 , month: 1, day: 1))
                
                print(minDate as Any)
                 print(maxDate as Any)
                        
        DatePickerDialog().show("Select - Date of Birth".localized, doneButtonTitle: "Done".localized, cancelButtonTitle: "Cancel".localized,  minimumDate: minDate, maximumDate: maxDate,  datePickerMode: .date){
            (date) -> Void in
         
            
//            let RFC3339DateFormatter = DateFormatter()
//            RFC3339DateFormatter.locale = Locale(localeIdentifier: "en_US_POSIX")
//            RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//            RFC3339DateFormatter.timeZone = TimeZone(forSecondsFromGMT: 0)
//
//            let date = Date()
//            let string = RFC3339DateFormatter.stringFromDate(date)
//            
            if let dt = date {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy/MM/dd"
                print(formatter.string(from: dt))
                self.personalAgentDOB = formatter.string(from: dt)
                
                formatter.dateFormat = "yyyy-MM-dd"
                print(formatter.string(from: dt))
                self.signupDobOnlyToDisplay = formatter.string(from: dt)
                self.personalAgentSignUPModal.personalAgentDob =  self.signupDobOnlyToDisplay ?? ""
                
                self.tabView.reloadSections(NSIndexSet(index: 2) as IndexSet, with: .none)
            }
        }
    }
    func AgentselectGender(_ sender: Any){
        let cell = self.tabView.cellForRow(at: IndexPath(row: 1, section: 2)) as! agentPersonalDetailsTableViewCell
        cell.genderDropDown.showList()
        cell.genderDropDown.didSelect{(selectedText , index ,id) in
            cell.genderDropDown.text = "\(selectedText)"
            
            self.personalAgentGender = cell.genderDropDown.text
            if cell.genderDropDown.text == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.genderView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.genderView)
            }
            self.personalAgentSignUPModal.personalAgentGender =  self.personalAgentGender ?? ""
            print("gender-", self.personalAgentGender)
        }
        self.tabView.reloadData()
    }
    func agentEducationClicked(_ sender: Any){
    let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
    vc.delegate = self
    vc.isForEducationList = true
     self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func agentMajorEductionClicked(_ sender: Any){
        let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
        if self.selectedAgentEducationDict.count == 0 {
            ModalController.showNegativeCustomAlertWith(title: "Please select education first".localized, msg: "")
            return
        }
        vc.delegate = self
        vc.isForMajorEducationList = true
        vc.selectedOLDCountryDict = self.selectedAgentEducationDict
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func selectedCategoryMethod(countryDict : NSMutableDictionary,tag:Int){
        
        self.isCountryChangeAgain = false
        if self.selectedAgentCountryDict != countryDict {
            self.selectedCityDict.removeAllObjects()
            if let value = selectedAgentCountryDict.object(forKey: "country_id") as? Int {
                personalAgentSignUPModal.personalAgentCountry = "\(value)"
            };
            personalAgentSignUPModal.personalAgentCountryName = ModalController.toString(self.selectedAgentCountryDict.object(forKey: "country_name") as Any)
            personalAgentSignUPModal.personalAgentmobileLength = self.selectedAgentCountryDict.object(forKey: "mobile_length") as? Int ?? 0
            
            personalAgentSignUPModal.personalAgentmobileCode = ModalController.toString(self.selectedAgentCountryDict.object(forKey: "mobile_code") as Any)
            
            personalAgentSignUPModal.personalmobileCodeImage = ModalController.toString(self.selectedAgentCountryDict.object(forKey: "country_flag") as Any)
            tabView.reloadData()
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
            self.isCountryChangeAgain = false
            //        self.tabView.reloadSections(NSIndexSet(index: 3) as IndexSet, with: .none)
        }
        
        self.selectedAgentCountryDict = countryDict
        
        if let value = selectedAgentCountryDict.object(forKey: "country_id") as? Int {
            personalAgentSignUPModal.personalAgentCountry = "\(value)"
        }
        personalAgentSignUPModal.personalAgentCountryName = ModalController.toString(self.selectedAgentCountryDict.object(forKey: "country_name") as Any)
        
        personalAgentSignUPModal.personalAgentmobileLength = self.selectedAgentCountryDict.object(forKey: "mobile_length") as? Int ?? 0
        
        personalAgentSignUPModal.personalAgentmobileCode = ModalController.toString(self.selectedAgentCountryDict.object(forKey: "mobile_code") as Any)
        
        personalAgentSignUPModal.personalmobileCodeImage = ModalController.toString(self.selectedAgentCountryDict.object(forKey: "country_flag") as Any)
        tabView.reloadData()
    }
        
        func selectedCityMethod(cityDict : NSMutableDictionary){
            self.selectedCityDict = cityDict
        if let value = selectedCityDict.object(forKey: "city_id") as? Int{
        personalAgentSignUPModal.personalAgentCity = "\(value)"
            personalAgentSignUPModal.personalAgentCityName = ModalController.toString(selectedCityDict.object(forKey: "city_name") as Any)
        }
        self.tabView.reloadSections(NSIndexSet(index: 3) as IndexSet, with: .none)
        }

        func selectedEducationMethod(educationDict: NSMutableDictionary) {
            if self.selectedAgentEducationDict != educationDict {
            self.selectedAgentMajorEducationDict.removeAllObjects()
            self.personalAgentSignUPModal.personalAgentMajorEducation = ""
            if let value =  selectedAgentEducationDict.object(forKey: "education_id") as? Int{
            personalAgentSignUPModal.personalAgentEducation = "\(value)"
              }

            self.tabView.reloadSections(NSIndexSet(index: 2) as IndexSet, with: .none)
        }
        self.selectedAgentEducationDict = educationDict
        if let value =  selectedAgentEducationDict.object(forKey: "education_id") as? Int{
            personalAgentSignUPModal.personalAgentEducation = "\(value)"
        }
             self.tabView.reloadSections(NSIndexSet(index: 2) as IndexSet, with: .none)
        }
        func selectedMajorEducationMethod(educationDict: NSMutableDictionary) {
            self.selectedAgentMajorEducationDict = educationDict
            if let value =  selectedAgentMajorEducationDict.object(forKey: "education_major_id") as? Int{
            personalAgentSignUPModal.personalAgentMajorEducation = "\(value)"
                
               self.tabView.reloadSections(NSIndexSet(index: 2) as IndexSet, with: .none)
            }
    }
        func selectedCurrency(currency: NSMutableDictionary) {
            
        }
    func selectetCourierCompanyMethod(courierCompanyDict: NSMutableDictionary) {
        
    }
    func selectedBankMethod(bankDict: NSMutableDictionary) {
        self.selectedBankDict = bankDict
        personalAgentSignUPModal.personalAgentbankName = "\(self.selectedBankDict.object(forKey: "bank_name") as! String)"
        
        if let value =  selectedBankDict.object(forKey: "id") as? Int{
            personalAgentSignUPModal.personalAgentbankID = "\(value)"
        }
        self.tabView.reloadSections(NSIndexSet(index: 4) as IndexSet, with: .none)
        
    }
    
    func selectedCountryCodeMethod(mobileCodeDict: NSMutableDictionary) {
        
        self.selectedCountryCodeDict = mobileCodeDict
        personalAgentSignUPModal.personalAgentmobileLength = self.selectedCountryCodeDict.object(forKey: "mobile_length") as? Int ?? 0
        
        personalAgentSignUPModal.personalAgentmobileCode = ModalController.toString(self.selectedCountryCodeDict.object(forKey: "mobile_code") as Any)
        
        personalAgentSignUPModal.personalmobileCodeImage = ModalController.toString(self.selectedCountryCodeDict.object(forKey: "country_flag") as Any)
        
        self.tabView.reloadData()
        
    }
       
    func selectPhoneCodeMethod(phoneCodeDict: NSMutableDictionary) {
       
        
    }
    func selectetBranchMethod(BranchDict : NSMutableDictionary){
        
    }

    
    func AgentselectCountry(_ sender: Any){
        print("fhjgdgk3fhvhjhjf\((sender as AnyObject).tag)")
        let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
        vc.delegate = self
        vc.isForCountry = true
        if (sender as AnyObject).tag  == 10
        {
            vc.isForCountry = false
            vc.isFromCountryMobileCode = true
        }
        
    
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func AgentselectCity(_ sender: Any){
        let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
        if self.selectedAgentCountryDict.count == 0{
            ModalController.showNegativeCustomAlertWith(title: "Please select country first".localized, msg: "")
            return
        }
        vc.isForCity = true
        vc.delegate = self
        vc.selectedOLDCountryDict = self.selectedAgentCountryDict
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func AgentselectBank(_ sender: Any){
        let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
        vc.delegate = self
        vc.isForBankList = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
        func showHidePassword(_ sender: Any){
                   if(ispassword)
                  {
                    ispassword = false
                  }else{
                       ispassword = true
                  }
                  self.tabView.reloadRows(at: [IndexPath(row: 1, section: 3)], with: .none)
        }
func showHideConfirmPassword(_ sender: Any){

            if(isConfirmPassword)
            {
              isConfirmPassword = false
            }else{
                 isConfirmPassword = true
            }
            self.tabView.reloadRows(at: [IndexPath(row: 1, section: 3)], with: .none)
        }
        
    func mobileCodeClicked(_ sender: Any) {
        
         let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
         vc.delegate = self
         vc.isFromCountryMobileCode = true
          vc.selectedCountryDict = self.selectedCountryCodeDict
         self.navigationController?.pushViewController(vc, animated: true)
         
         
     }
     func phoneCodeClicked(_ sender: Any) {
        
     }

    func AgentselectYesOnVat(_ sender: Any) {
        
        if(isVatYesClicked) {
            isVatYesClicked = false
        }else{
            isVatYesClicked = true
            isVatNoClicked = false
        }
        
        self.tabView.reloadRows(at: [IndexPath(row: 1, section: 5)], with: .none)
        self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
        self.tabView.reloadRows(at: [IndexPath(row: 0, section: 6)], with: .none)
    }
           
    func AgentselectNoOnVat(_ sender: Any) {
        
        isFromVatDocument = false
        self.personalAgentSignUPModal.personalVatDocumentUrl = nil
        self.personalAgentSignUPModal.personalAgentVatNumber = ""
        if(isVatNoClicked){
            isVatNoClicked = false
        }else{
            isVatNoClicked = true
            isVatYesClicked = false
        }
        
        self.tabView.reloadRows(at: [IndexPath(row: 1, section: 5)], with: .none)
        self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
        self.tabView.reloadRows(at: [IndexPath(row: 0, section: 6)], with: .none)
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
              personalAgentSignUPModal.personalVatDocumentUrl = urls.first
               self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
               self.tabView.reloadRows(at: [IndexPath(row: 1, section: 5)], with: .none)
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
        self.personalAgentSignUPModal.personalVatDocumentUrl = nil
        self.tabView.reloadRows(at: [IndexPath(row: 1, section: 5)], with: .none)
    }
       
    func userPolicySelected(_ sender: Any) {
        if(isUserPolicySelected){
            isUserPolicySelected = false
        }else{
            isUserPolicySelected = true
        }
        self.tabView.reloadRows(at: [IndexPath(row: 0, section: 6)], with: .none)
    }
    
    func userPolicyClicked(_ sender: Any){
        
      let vc = UserPolicyWebViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func signUpBtnClicked(_ sender: Any) {
        self.view.endEditing(true)
        
        if isVatNoClicked == true {
            personalAgentSignUPModal.personalAgentVatNumber = ""
        }
        if maroofLink == "https://www.maroof.com/".localized {
            personalAgentSignUPModal.personalAgentMaroofLink = ""
        }
     
        let(isFilled, message) = personalAgentSignUPModal.personalAgentValidation()
        
        if isFilled{
            ModalClass.startLoading(self.view)
            personalAgentSignUPModal.personalAgentSignUp { (success,response) in
                
                if success{
                    if let value = (response?.object(forKey: "data") as? NSDictionary)?.object(forKey: "mail_status") as? String{
                        ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                        if value == "Email Sent Success".localized{
                            let vc = VerifyAccountViewController(nibName: "VerifyAccountViewController", bundle: nil)
                            vc.mobile = self.personalAgentSignUPModal.personalAgentContactNbr
                            vc.emailId = self.personalAgentSignUPModal.personalAgentEmail
                            vc.isFromAgent = true
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
extension PersonalRegViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
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
        }else if section == 5 {
            if SelectedIndex.contains(section) {
                return 2
            }else{
                return 1
            }
        }else  {
            if SelectedIndex.contains(section) {
                return 2
            }else{
                return 1
            }
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
                return agentPersonalDetailCell(index: indexPath)
            }
        }else if indexPath.section == 3 {
            if indexPath.row == 0 {
                return headerCell(index: indexPath)
            }else{
                
                return agentBasicInformationCell(index: indexPath)
            }
        }else if indexPath.section == 4 {
            if indexPath.row == 0 {
                return headerCell(index: indexPath)
            }else{
                return agentBankDetailCell(index: indexPath)
            }
        }else if indexPath.section == 5 {
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
        let companyEmail = ModalController.isValidEmail(testStr: personalAgentSignUPModal.personalAgentEmail)
        let companyConfirmEmail = ModalController.isValidEmail(testStr: personalAgentSignUPModal.personalAgentConfirmEmail)
        let mobileLength  = personalAgentSignUPModal.personalAgentmobileLength
        let str = personalAgentSignUPModal.personalAgentAccountNbr.replacingOccurrences(of: " ", with: "")
        let vatStr = personalAgentSignUPModal.personalAgentVatNumber.replacingOccurrences(of: " ", with: "")
        
        if   appDelegate.selectServiceStr != ""  && personalAgentSignUPModal.personalAgentName != ""  &&
            personalAgentSignUPModal.personalAgentGender != ""  &&
            personalAgentSignUPModal.personalAgentDob != ""  && personalAgentSignUPModal.personalAgentEducation != ""  &&  personalAgentSignUPModal.personalAgentMajorEducation != "" && personalAgentSignUPModal.personalAgentEmail != ""  && personalAgentSignUPModal.personalAgentConfirmEmail != ""  &&
            personalAgentSignUPModal.personalAgentCountry != ""  && personalAgentSignUPModal.personalAgentCity != ""  && personalAgentSignUPModal.personalAgentContactNbr != "" &&
            personalAgentSignUPModal.personalAgentPassword != ""  && personalAgentSignUPModal.personalAgentConfirmPswd != "" && personalAgentSignUPModal.personalAgentbankName != ""  && personalAgentSignUPModal.personalAgentbankAccountHolderName != ""  && personalAgentSignUPModal.personalAgentAccountNbr != "" && str.count >= personalAgentSignUPModal.personalAgentIBanLength && ((isVatYesClicked == true && vatStr.count >= personalAgentSignUPModal.personalVatLength  && personalAgentSignUPModal.personalAgentVatNumber.containArabicNumber && personalAgentSignUPModal.personalVatDocumentUrl != nil)  || isVatNoClicked == true) && isUserPolicySelected == true && companyEmail && companyConfirmEmail && (companyEmail == companyConfirmEmail) && (mobileLength == mobileNumberWithoutGap.count) && (personalAgentSignUPModal.personalAgentPassword == personalAgentSignUPModal.personalAgentConfirmPswd) && (personalAgentSignUPModal.personalAgentPassword.count >= 8 && personalAgentSignUPModal.personalAgentConfirmPswd.count  >= 8)  {
            everythingFilled = true
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 6)], with: .none)
        }else{
            everythingFilled = false
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 6)], with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 || indexPath.section == 6 {
            return
        }else if indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == 5 {
            if indexPath.row == 0 {
                self.view.endEditing(true)
                if SelectedIndex.count > 0
                {
                    if SelectedIndex.contains(indexPath.section){
                        SelectedIndex.remove(indexPath.section)
                    }else{
                      
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
            serviceCellHeight = 75
        }else if serviceCount ==  5 || serviceCount == 6 {
            serviceCellHeight = 110
        }else if serviceCount ==  7 || serviceCount == 8 {
            serviceCellHeight = 145
        }else if serviceCount ==  9 || serviceCount == 10 {
            serviceCellHeight = 180
        }else if serviceCount ==  11 || serviceCount == 12 {
            serviceCellHeight = 215
        }else if serviceCount ==  13 || serviceCount == 14 {
            serviceCellHeight = 250
        }else if serviceCount ==  15 || serviceCount == 16 {
            serviceCellHeight = 285
        }
        
        if indexPath.section == 0 {
            return 220
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
                return 370
            }
        }else if indexPath.section == 3 {
            if indexPath.row == 0 {
                return 50
            }else {
                return 508
            }
        }else if indexPath.section == 4 {
            if indexPath.row == 0 {
                return 50
            }else {
                return 230
            }
        }else if indexPath.section == 5 {
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
        if isImageUploaded == true {
            cell.agentprofileImageView.image = tempImage
        }else{
            cell.agentprofileImageView.image = UIImage(named: "profile_white")
        }
        cell.headerTxt.text = "Agent Personal Registration".localized
        
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
            
            //Add below cooment line if gender and dob required in if condition
            
//            personalAgentSignUPModal.personalAgentGender != ""  &&
//            personalAgentSignUPModal.personalAgentDob != ""  &&
            
            if personalAgentSignUPModal.personalAgentName != ""  &&
                 personalAgentSignUPModal.personalAgentEducation != ""  &&  personalAgentSignUPModal.personalAgentMajorEducation != "" &&  personalAgentSignUPModal.personalAgentName.containArabicNumber  {
                cell.editImageView.image = UIImage(named: "section_filled.png")
            }else {
                cell.editImageView.image = UIImage(named: "edit_red")
            }
        }else if index.section == 3 {
            
            let companyEmail = ModalController.isValidEmail(testStr: personalAgentSignUPModal.personalAgentEmail)
            let companyConfirmEmail = ModalController.isValidEmail(testStr: personalAgentSignUPModal.personalAgentConfirmEmail)
            let mobileLength  = personalAgentSignUPModal.personalAgentmobileLength
            
            if  personalAgentSignUPModal.personalAgentEmail != "" && personalAgentSignUPModal.personalAgentConfirmEmail != "" &&
                personalAgentSignUPModal.personalAgentCountry != ""  && personalAgentSignUPModal.personalAgentCity != "" && personalAgentSignUPModal.personalAgentContactNbr != "" &&
                personalAgentSignUPModal.personalAgentPassword != "" && personalAgentSignUPModal.personalAgentConfirmPswd != "" && companyEmail && companyConfirmEmail && (companyEmail == companyConfirmEmail) && (mobileLength == mobileNumberWithoutGap.count) && (personalAgentSignUPModal.personalAgentPassword == personalAgentSignUPModal.personalAgentConfirmPswd) && (personalAgentSignUPModal.personalAgentPassword.count >= 8 && personalAgentSignUPModal.personalAgentConfirmPswd.count  >= 8)   {
                
                cell.editImageView.image = UIImage(named: "section_filled.png")
            }else{
                cell.editImageView.image = UIImage(named: "edit_red")
            }
        }else if index.section == 4 {
             let str = personalAgentSignUPModal.personalAgentAccountNbr.replacingOccurrences(of: " ", with: "")
            if personalAgentSignUPModal.personalAgentbankName != ""  && personalAgentSignUPModal.personalAgentbankAccountHolderName != ""  && personalAgentSignUPModal.personalAgentAccountNbr != "" && str.count >= personalAgentSignUPModal.personalAgentIBanLength {
            
                    cell.editImageView.image = UIImage(named: "section_filled.png")
                
            }else{
                cell.editImageView.image = UIImage(named: "edit_red")
            }
        }else if index.section == 5 {
             let str = personalAgentSignUPModal.personalAgentVatNumber.replacingOccurrences(of: " ", with: "")
            if (isVatYesClicked == true && str.count >= personalAgentSignUPModal.personalVatLength  && personalAgentSignUPModal.personalAgentVatNumber.containArabicNumber && personalAgentSignUPModal.personalVatDocumentUrl != nil)  || isVatNoClicked == true {
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
    
    func agentPersonalDetailCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tabView.dequeueReusableCell(withIdentifier: "agentPersonalDetailsTableViewCell", for: index) as! agentPersonalDetailsTableViewCell
        cell.selectionStyle = .none
        cell.nametxtFld.delegate = self
        cell.mainView.layer.cornerRadius = 5
        cell.mainView.clipsToBounds = true
        cell.mainView.layer.borderWidth = 0.5
        cell.mainView.borderColor =  UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        cell.nametxtFld.addTarget(self, action: #selector(PersonalRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        cell.nametxtFld.text = personalAgentSignUPModal.personalAgentName
        cell.genderDropDown.text = personalAgentGender
        cell.dobTxtFld.text = signupDobOnlyToDisplay
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.nameView)
          ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.genderView)
          ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.dobView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.educationView)
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.educationView)
       
        if cell.nametxtFld.text == ""  {
                  ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.nameView)
              }else{
            if  ModalController.isValidName(title: cell.nametxtFld.text!) == false {
                 ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.nameView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.nameView)
            }
              }
        
       if cell.genderDropDown.text == "" {
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.genderView)
        }else{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.genderView)
        }
        if cell.dobTxtFld.text == "" {
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.dobView)
        }else{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.dobView)
        }
        
        if selectedAgentEducationDict.count > 0 {
            cell.educationTxtFld.text = "\(self.selectedAgentEducationDict.object(forKey: "education_type") as! String)"
            if cell.educationTxtFld.text == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.educationView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.educationView)
            }
        }
        if self.selectedAgentMajorEducationDict.count > 0 {
            cell.majorEducationTxtFld.text = "\(self.selectedAgentMajorEducationDict.object(forKey: "education_major") as! String)"
            if cell.majorEducationTxtFld.text == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.majorView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.majorView)
            }
        }else{
             ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.majorView)
            cell.majorEducationTxtFld.text = ""
        }
        cell.tag = index.row
        cell.delegate = self
        return cell
    }
    
    func agentBasicInformationCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tabView.dequeueReusableCell(withIdentifier: "PersonalAgentBasicInformationTableViewCell", for: index) as! PersonalAgentBasicInformationTableViewCell
        cell.selectionStyle = .none
        cell.emailTxtFld.delegate = self
        cell.confirmTxtFld.delegate = self
        cell.confirmPasswordTxtFld.delegate = self
        cell.passwordTxtFld.delegate = self
        cell.mobileTxtFld.delegate = self
        cell.maroofTxtFld.delegate = self
        cell.mainView.layer.cornerRadius = 5
        cell.mainView.clipsToBounds = true
        cell.mainView.layer.borderWidth = 0.5
        cell.mainView.borderColor =  UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        cell.confirmTxtFld.autocorrectionType = .no
        
        cell.emailTxtFld.addTarget(self, action: #selector(PersonalRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.confirmTxtFld.addTarget(self, action: #selector(PersonalRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.confirmPasswordTxtFld.addTarget(self, action: #selector(PersonalRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.passwordTxtFld.addTarget(self, action: #selector(PersonalRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.mobileTxtFld.addTarget(self, action: #selector(PersonalRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.maroofTxtFld.addTarget(self, action: #selector(PersonalRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        cell.emailTxtFld.text = personalAgentSignUPModal.personalAgentEmail
        cell.confirmTxtFld.text = personalAgentSignUPModal.personalAgentConfirmEmail
        cell.mobileTxtFld.text = personalAgentSignUPModal.personalAgentContactNbr
        
        
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                print("arabic langugage")
                cell.emailTxtFld.textAlignment = .left
                cell.confirmTxtFld.textAlignment = .left
                cell.confirmPasswordTxtFld.textAlignment = .left
                cell.passwordTxtFld.textAlignment = .left
                cell.maroofTxtFld.textAlignment = .left
                cell.mobileTxtFld.textAlignment = .left
                cell.rotateView.semanticContentAttribute = .forceLeftToRight
                cell.mobileCodeTxtFld.semanticContentAttribute = .forceLeftToRight
                cell.mobileCodeFlagImageView.semanticContentAttribute = .forceLeftToRight
            }else if value[0]=="en"{
                cell.emailTxtFld.textAlignment = .left
                cell.confirmTxtFld.textAlignment = .left
                cell.confirmPasswordTxtFld.textAlignment = .left
                cell.passwordTxtFld.textAlignment = .left
                cell.maroofTxtFld.textAlignment = .left
                cell.mobileTxtFld.textAlignment = .left
                cell.rotateView.semanticContentAttribute = .forceLeftToRight
                cell.mobileCodeTxtFld.semanticContentAttribute = .forceLeftToRight
                cell.mobileCodeFlagImageView.semanticContentAttribute = .forceLeftToRight
//                cell.paymentmodeLbl.textAlignment = .left
            }
        }
        
        if personalAgentSignUPModal.personalAgentPassword != "" && personalAgentSignUPModal.personalAgentPassword.count >= 8 {
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.passwordView)
        }else{
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.passwordView)
        }
            
        if personalAgentSignUPModal.personalAgentConfirmPswd != "" && personalAgentSignUPModal.personalAgentConfirmPswd.count >= 8 {
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.confirmPasswordView)
        }else{
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmPasswordView)
        }
        if personalAgentSignUPModal.personalAgentEmail != "" &&  personalAgentSignUPModal.personalAgentConfirmEmail != ""  {
        let confirmEmail = personalAgentSignUPModal.personalAgentConfirmEmail.lowercased()
        let email = personalAgentSignUPModal.personalAgentEmail.lowercased()
        let companyEmail = ModalController.isValidEmail(testStr: email)
        let companyConfirmEmail = ModalController.isValidEmail(testStr: confirmEmail)
            
            if  (email ==  confirmEmail) && (companyEmail && companyConfirmEmail) {
                if let imageView = self.view.viewWithTag(203) as? UIImageView{
                    imageView.isHidden = false
                     cell.confirmPasswordGreenTickWIdhtConstant.constant = 22
                    cell.confirmTxtFldTrailingConstant.constant = 8
                    imageView.image = UIImage(named:"greenTick")
                     ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.emailView)
                     ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.confirmEmailView)
                }
            }else{
                if let imageView = self.view.viewWithTag(203) as? UIImageView{
                    imageView.isHidden = true
                     cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                    cell.confirmTxtFldTrailingConstant.constant = 0
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.emailView)
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                }
            }
        }else{
            if let imageView = self.view.viewWithTag(203) as? UIImageView{
                cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                cell.confirmTxtFldTrailingConstant.constant = 0
                imageView.isHidden = true
            }
        }
        
        let count  = personalAgentSignUPModal.personalAgentmobileLength
                let str = cell.mobileTxtFld.text?.replacingOccurrences(of: " ", with: "")
                if str!.count == count && count != 0 {
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.mobileNumberView)
                }else{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.mobileNumberView)
                }
           
            if !cell.mobileTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.mobileNumberView)
            }
        
        
        if personalAgentSignUPModal.personalAgentPassword != "" && personalAgentSignUPModal.personalAgentConfirmPswd  != "" {
            
            if personalAgentSignUPModal.personalAgentPassword == personalAgentSignUPModal.personalAgentConfirmPswd && (personalAgentSignUPModal.personalAgentPassword.count == 8 || personalAgentSignUPModal.personalAgentPassword.count > 8) && (cell.passwordTxtFld.text!.containArabicNumber && cell.confirmPasswordTxtFld.text!.containArabicNumber ) {
                
                showConfirmButton.isUserInteractionEnabled = true
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
            cell.countryBtn.setTitle("\(personalAgentSignUPModal.personalAgentCountryName)", for: .normal)
            if cell.countryBtn.currentTitle == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.countryView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.countryView)
            }
            cell.mobileCodeTxtFld.text = "\(personalAgentSignUPModal.personalAgentmobileCode)"
            
            let str = personalAgentSignUPModal.personalmobileCodeImage
            if str.count > 0{
                cell.mobileCodeFlagImageView.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "flag_placeholder.png"))
            }
            
        }
        if self.selectedCityDict.count > 0 {
            cell.cityBtn.setTitle("\(self.selectedCityDict.object(forKey: "city_name") as! String)", for: .normal)
            if cell.cityBtn.currentTitle == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.cityView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.cityView)
            }
        }else{
             ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.cityView)
            cell.cityBtn.setTitle("", for: .normal)
            personalAgentSignUPModal.personalAgentCityName = ""
            personalAgentSignUPModal.personalAgentCity = ""
        }
        cell.maroofTxtFld.text = maroofLink
        cell.passwordTxtFld.text = personalAgentSignUPModal.personalAgentPassword
        cell.confirmPasswordTxtFld.text = personalAgentSignUPModal.personalAgentConfirmPswd
        
        if self.selectedCountryCodeDict.count > 0 {
            
            personalAgentSignUPModal.personalAgentmobileLength = self.selectedCountryCodeDict.object(forKey: "mobile_length") as? Int ?? 0
            personalAgentSignUPModal.personalAgentmobileCode = "\(self.selectedCountryCodeDict.object(forKey: "mobile_code") as! String)"
            personalAgentSignUPModal.personalmobileCodeImage = "\(self.selectedCountryCodeDict.object(forKey: "country_flag") as! String)"
            cell.mobileCodeTxtFld.text = "\(self.selectedCountryCodeDict.object(forKey: "mobile_code") as! String)"
            
            if let str = self.selectedCountryCodeDict.object(forKey: "country_flag") as? String {
                if str.count > 0{
                    
                    cell.mobileCodeFlagImageView.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "flag_placeholder.png"))
                    
                }
            }
        }
             
        
        
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
//            cell.mobileTxtFld.text = ""
//            self.mobileNumberWithoutGap = ""
//            personalAgentSignUPModal.personalAgentContactNbr = ""
//            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.mobileNumberView)
//        }else{
//            cell.mobileTxtFld.text = personalAgentSignUPModal.personalAgentContactNbr
//            let str = personalAgentSignUPModal.personalAgentContactNbr.replacingOccurrences(of: " ", with: "")
//            self.mobileNumberWithoutGap = str
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
        
        cell.ibanNumberTxtFld.text = ibanPrefix
        cell.accountHolderNameTxtFld.addTarget(self, action: #selector(PersonalRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.ibanNumberTxtFld.addTarget(self, action: #selector(PersonalRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.ibanNumberTxtFld.keyboardType = .asciiCapable
         cell.ibanNumberTxtFld.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        if self.bankNameIdentifierList?.data?.count ?? 0 > 0 {
            let bankIdentifier  = self.bankNameIdentifierList?.data![0]
            let name = bankIdentifier?.bank_name
            cell.bankNameTxtFld.text = name
            personalAgentSignUPModal.personalAgentbankName = name ?? ""
            
            if let value = bankIdentifier?.id {
                personalAgentSignUPModal.personalAgentbankID = "\(value)"
            }
            if cell.bankNameTxtFld.text == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.bankNameView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.bankNameView)
            }
        }else{
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.bankNameView)
            personalAgentSignUPModal.personalAgentbankName = ""
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
        
         cell.vatNumberTxtFld.text = personalAgentSignUPModal.personalAgentVatNumber
        cell.vatNumberTxtFld.addTarget(self, action: #selector(PersonalRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        if isVatYesClicked {
            cell.yesBtn.isSelected = true
            cell.vatNumberView.isHidden = false
            personalAgentSignUPModal.isVatSelected = cell.yesBtn.isSelected
            cell.vatDocumentHeightConstant.constant = 244
            cell.documentMainView.isHidden = false
            
        }else{
            cell.yesBtn.isSelected = false
            cell.vatNumberView.isHidden = true
            personalAgentSignUPModal.isVatSelected = cell.yesBtn.isSelected
            cell.vatDocumentHeightConstant.constant = 0
            cell.documentMainView.isHidden = true
            
        }
        
        if isVatNoClicked {
            cell.noBtn.isSelected = true
            personalAgentSignUPModal.isVatNotSelected = cell.noBtn.isSelected
            
        }else{
            personalAgentSignUPModal.isVatNotSelected = cell.noBtn.isSelected
            cell.noBtn.isSelected = false
        }
        
        
        if isFromVatDocument == true {
            if self.personalAgentSignUPModal.personalVatDocumentUrl?.absoluteString != "" {
                cell.vatDocumentImageView.contentMode = .scaleAspectFill
                cell.deleteDocuementBtn.isHidden = false
                cell.vatDocumentImageView.image = drawPDFfromURL(url: self.personalAgentSignUPModal.personalVatDocumentUrl! )
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
        
        let str = cell.vatNumberTxtFld.text?.replacingOccurrences(of: " ", with: "")
        personalAgentSignUPModal.personalAgentVatNumber = str!
        
        if str!.count >= personalAgentSignUPModal.personalVatLength  && cell.vatNumberTxtFld.text != "" &&  cell.vatNumberTxtFld.text!.containArabicNumber {
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.vatNumberView)
        }else{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.vatNumberView)
        }
        
        
        cell.tag = index.row
        cell.delegate = self
        return cell
    }
    
    func agentUserPolicyCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tabView.dequeueReusableCell(withIdentifier: "AgentCompanyUserPolicyTableViewCell", for: index) as! AgentCompanyUserPolicyTableViewCell
        cell.selectionStyle = .none
        
        if everythingFilled == true {
            cell.signUpBtn.setTitleColor(Constant.Green_TEXT_COLOR, for: .normal)
            cell.signUpBtn.layer.borderWidth = 0.5
            cell.signUpBtn.borderColor =  Constant.Green_TEXT_COLOR
        }else {
            
            cell.signUpBtn.setTitleColor(Constant.Red_TEXT_COLOR, for: .normal)
            cell.signUpBtn.layer.borderWidth = 0.5
            cell.signUpBtn.borderColor =  Constant.Red_TEXT_COLOR
            
        }
        
        if isUserPolicySelected {
            cell.checkBoxBtn.isSelected = true
            personalAgentSignUPModal.personalAgentPolicySelected = cell.checkBoxBtn.isSelected
        }else{
            cell.checkBoxBtn.isSelected = false
            personalAgentSignUPModal.personalAgentPolicySelected = cell.checkBoxBtn.isSelected
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
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 3)) as! PersonalAgentBasicInformationTableViewCell
            let str = cell.mobileTxtFld.text
            
            if personalAgentSignUPModal.personalAgentmobileLength == 0 {
                  ModalController.showNegativeCustomAlertWith(title: "please select country code first.", msg: "")
               return false
            }

            lenght = personalAgentSignUPModal.personalAgentmobileLength
            guard let stringRange = Range(range,in: str!) else {
                return false
            }
            print(stringRange)
            print(str)
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
            personalAgentSignUPModal.personalAgentMaroofLink = textstr
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
                 if personalAgentSignUPModal.personalAgentIBanLength > 0 {
                     lenght = personalAgentSignUPModal.personalAgentIBanLength
                 }
                 
                 let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 4)) as! CompanyAgentBankDetailsTableViewCell
                 
                 // fixed SA
                 if let text = textField.text as NSString? {
                     let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                     textstr = txtAfterUpdate
                 }
                
                 personalAgentSignUPModal.personalAgentAccountNbr = textstr
                 
                 // block enter char after 24
                 let str = cell.ibanNumberTxtFld.text
                 
                 guard let stringRange = Range(range,in: str!) else {
                     return false
                 }
                 print(stringRange)
                 print(str as Any)
                 let updateText =  str!.replacingCharacters(in: stringRange, with: string)
                 
                 ibanPrefix = textstr
                 personalAgentSignUPModal.personalAgentAccountNbr = textstr
                 return (updateText.count) < lenght+1
            
        case 1011:
            let lenght  = self.personalAgentSignUPModal.personalVatLength
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 5)) as! CompanyAgentVatDetailTableViewCell
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
                personalAgentSignUPModal.personalAgentName = textField.text!
            }
        case 1003:
            personalAgentSignUPModal.personalAgentContactNbr = textField.text!
            
        case 1005:
            personalAgentSignUPModal.personalAgentMaroofLink = textField.text!
        case 1009:
            personalAgentSignUPModal.personalAgentbankAccountHolderName = textField.text!
            
        case 1010:
            
            personalAgentSignUPModal.personalAgentAccountNbr = textField.text!
            
        case 1011:
            personalAgentSignUPModal.personalAgentVatNumber = textField.text!
            
        default:
            print("text")
        }
        if personalAgentSignUPModal.personalAgentName != ""{
            
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
        }else {
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
        }
        if  personalAgentSignUPModal.personalAgentEmail != "" && personalAgentSignUPModal.personalAgentConfirmEmail != "" &&
            personalAgentSignUPModal.personalAgentCountry != ""  && personalAgentSignUPModal.personalAgentCity != "" && personalAgentSignUPModal.personalAgentContactNbr != "" &&
            personalAgentSignUPModal.personalAgentPassword != "" && personalAgentSignUPModal.personalAgentConfirmPswd != "" {
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
            
        }else{
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
        }
        if personalAgentSignUPModal.personalAgentbankName != ""  && personalAgentSignUPModal.personalAgentbankAccountHolderName != ""  && personalAgentSignUPModal.personalAgentAccountNbr != "" {
            
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
        }else{
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
        }
    }    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        textField.textAlignment =  ("\(textField.text!.first)".isArabic ? .right:.left)
        switch  textField.tag {
        case 1000:
          
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 2)) as! agentPersonalDetailsTableViewCell
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.nameView)
            }else{
                if cell.nametxtFld.text == "" {
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.nameView)
                }else{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.nameView)
                }
            }
            personalAgentSignUPModal.personalAgentName = textField.text!
            
        case 1001:
            personalAgentSignUPModal.personalAgentEmail = textField.text!.lowercased()
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 3)) as! PersonalAgentBasicInformationTableViewCell
            cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
            cell.confirmTxtFldTrailingConstant.constant = 0
            personalAgentSignUPModal.personalAgentEmail = textField.text!.lowercased()
            let confirmEmail = personalAgentSignUPModal.personalAgentConfirmEmail.lowercased()
            let email = personalAgentSignUPModal.personalAgentEmail.lowercased()
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
                    if  email ==  confirmEmail{
                        if let imageView = self.view.viewWithTag(203) as? UIImageView{
                            imageView.isHidden = false
                            imageView.image = UIImage(named:"greenTick")
                            cell.confirmPasswordGreenTickWIdhtConstant.constant = 22
                            cell.confirmTxtFldTrailingConstant.constant = 8
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
                            cell.confirmTxtFldTrailingConstant.constant = 0
                            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                        }
                    }
                }else{
                    if let imageView = self.view.viewWithTag(203) as? UIImageView{
                        imageView.isHidden = true
                        cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                        cell.confirmTxtFldTrailingConstant.constant = 0
                        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                    }
                }
            }else{
                if let imageView = self.view.viewWithTag(203) as? UIImageView{
                    imageView.isHidden = true
                    cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                    cell.confirmTxtFldTrailingConstant.constant = 0
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                }
            }
        //            personalAgentSignUPModal.personalAgentEmail = textField.text!
        
        case 1002:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 3)) as! PersonalAgentBasicInformationTableViewCell
            personalAgentSignUPModal.personalAgentConfirmEmail = textField.text!.lowercased()
            personalAgentSignUPModal.personalAgentConfirmEmail = textField.text!.lowercased()
            let confirmEmail = personalAgentSignUPModal.personalAgentConfirmEmail.lowercased()
            let email = personalAgentSignUPModal.personalAgentEmail.lowercased()
            
            if email != "" && confirmEmail  != "" {
                let companyEmail = ModalController.isValidEmail(testStr: email)
                let companyConfirmEmail = ModalController.isValidEmail(testStr: confirmEmail)
                if companyEmail && companyConfirmEmail {
                    if  email ==  confirmEmail {
                        if let imageView = self.view.viewWithTag(203) as? UIImageView{
                            imageView.isHidden = false
                            cell.confirmPasswordGreenTickWIdhtConstant.constant = 22
                            cell.confirmTxtFldTrailingConstant.constant = 8
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
                            cell.confirmTxtFldTrailingConstant.constant = 0
                            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                        }
                    }
                }else{
                    if let imageView = self.view.viewWithTag(203) as? UIImageView{
                        imageView.isHidden = true
                        cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                        cell.confirmTxtFldTrailingConstant.constant = 0
                        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                    }
                }
            }else{
                if let imageView = self.view.viewWithTag(203) as? UIImageView{
                    imageView.isHidden = true
                    cell.confirmPasswordGreenTickWIdhtConstant.constant = 0
                    cell.confirmTxtFldTrailingConstant.constant = 0
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                }
            }
        //            personalAgentSignUPModal.personalAgentConfirmEmail = textField.text!
        case 1003:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 3)) as! PersonalAgentBasicInformationTableViewCell
            
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
                
                count = personalAgentSignUPModal.personalAgentmobileLength
                
                let str = cell.mobileTxtFld.text?.replacingOccurrences(of: " ", with: "")
                if str!.count == count && count != 0 {
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.mobileNumberView)
                }else{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.mobileNumberView)
                }
            }
            
            if !cell.mobileTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.mobileNumberView)
            }
            
            let str = cell.mobileTxtFld.text?.replacingOccurrences(of: " ", with: "")
            personalAgentSignUPModal.personalmobileCodeImage = textField.text!
            mobileNumberWithoutGap = str!
            
        //            }
        case 1005:
            
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 3)) as! PersonalAgentBasicInformationTableViewCell
            
            if cell.maroofTxtFld.text!.count > 0 && !cell.maroofTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.maroofView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.maroofView)
            }
            
        case 1006:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 3)) as! PersonalAgentBasicInformationTableViewCell
            personalAgentSignUPModal.personalAgentPassword = textField.text!
            
            if  personalAgentSignUPModal.personalAgentPassword != "" && personalAgentSignUPModal.personalAgentConfirmPswd  != "" {
                if (personalAgentSignUPModal.personalAgentPassword == personalAgentSignUPModal.personalAgentConfirmPswd) && (personalAgentSignUPModal.personalAgentPassword.count >= 8 && personalAgentSignUPModal.personalAgentConfirmPswd.count  >= 8) && cell.passwordTxtFld.text!.containArabicNumber   {
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
            if personalAgentSignUPModal.personalAgentPassword != "" && personalAgentSignUPModal.personalAgentPassword.count >= 8 {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.passwordView)
            }else{
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.passwordView)
            }
            if !cell.passwordTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.passwordView)
            }
            personalAgentSignUPModal.personalAgentPassword = textField.text!
        case 1007:
            // confirm
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 3)) as! PersonalAgentBasicInformationTableViewCell
            personalAgentSignUPModal.personalAgentConfirmPswd = textField.text!
            
            if  personalAgentSignUPModal.personalAgentPassword != "" && personalAgentSignUPModal.personalAgentConfirmPswd  != "" {
                if (personalAgentSignUPModal.personalAgentPassword == personalAgentSignUPModal.personalAgentConfirmPswd) && (personalAgentSignUPModal.personalAgentPassword.count >= 8 && personalAgentSignUPModal.personalAgentConfirmPswd.count  >= 8) && cell.confirmPasswordTxtFld.text!.containArabicNumber {
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
            if (personalAgentSignUPModal.personalAgentConfirmPswd != "" && personalAgentSignUPModal.personalAgentConfirmPswd.count >= 8) && (personalAgentSignUPModal.personalAgentPassword == personalAgentSignUPModal.personalAgentConfirmPswd) {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.confirmPasswordView)
            }else{
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmPasswordView)
            }
            if !cell.confirmPasswordTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmPasswordView)
            }
            personalAgentSignUPModal.personalAgentConfirmPswd = textField.text!
        case 1009:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 4)) as! CompanyAgentBankDetailsTableViewCell
            
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.accountHolderNameView)
            }else{
                if cell.accountHolderNameTxtFld.text == "" {
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.accountHolderNameView)
                    
                } else if (personalAgentSignUPModal.personalAgentName_CompareCode == "YES".uppercased()) && (personalAgentSignUPModal.personalAgentName != textField.text!) {
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.accountHolderNameView)
                }else{
                    
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.accountHolderNameView)
                }
            }
            personalAgentSignUPModal.personalAgentbankAccountHolderName = textField.text!
            
            
        case 1010:
            
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 4)) as! CompanyAgentBankDetailsTableViewCell
            
            let str = cell.ibanNumberTxtFld.text!.uppercased()
            cell.ibanNumberTxtFld.text = str
            if str.count == personalAgentSignUPModal.personalAgentIBanLength && cell.ibanNumberTxtFld.text != "" &&  cell.ibanNumberTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.ibanNumberView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.ibanNumberView)
            }
            
            //            textField.text = accountValue
            personalAgentSignUPModal.personalAgentAccountNbr = str
            cell.ibanNumberTxtFld.keyboardType = .asciiCapable
            if personalAgentSignUPModal.personalAgentAccountNbr.count == 2 {
                
                let str = personalAgentSignUPModal.personalAgentAccountNbr
                let agentCountryCode =  str.substring(from: 0, to: 1)
                print("agentCountryCode:-", agentCountryCode)
                self.getIbanLengthAPI(countryCode: agentCountryCode)
                
            }else if personalAgentSignUPModal.personalAgentAccountNbr.count == 6 {
                
                let str = personalAgentSignUPModal.personalAgentAccountNbr
                let bankStr =  str.substring(from: 4, to: 5)
                print("bankIdentifier:-", bankStr)
                self.bankNameApi(identifier: bankStr)
            }
            
            if personalAgentSignUPModal.personalAgentAccountNbr.count < 6 {
                cell.bankNameTxtFld.text = ""
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.bankNameView)
            }
            
            
        case 1011:
            
            let  cell = tabView.cellForRow(at: IndexPath(row:1 , section: 5)) as! CompanyAgentVatDetailTableViewCell
            
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
            personalAgentSignUPModal.personalAgentVatNumber = str!
            
            if str!.count >= personalAgentSignUPModal.personalVatLength  && cell.vatNumberTxtFld.text != "" &&  cell.vatNumberTxtFld.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.vatNumberView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.vatNumberView)
            }
            personalAgentSignUPModal.personalAgentVatNumber = str!
            
            
        default:
            print("text")
        }
        
        if personalAgentSignUPModal.personalAgentName != "" {
            
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
        }else {
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
        }
        
        let companyEmail = ModalController.isValidEmail(testStr: personalAgentSignUPModal.personalAgentEmail)
        let companyConfirmEmail = ModalController.isValidEmail(testStr: personalAgentSignUPModal.personalAgentConfirmEmail)
        let mobileLength  = personalAgentSignUPModal.personalAgentmobileLength
        
        if  personalAgentSignUPModal.personalAgentEmail != "" && personalAgentSignUPModal.personalAgentConfirmEmail != "" &&
                personalAgentSignUPModal.personalAgentCountry != ""  && personalAgentSignUPModal.personalAgentCity != "" && personalAgentSignUPModal.personalAgentContactNbr != "" &&
                personalAgentSignUPModal.personalAgentPassword != "" && personalAgentSignUPModal.personalAgentConfirmPswd != "" && companyEmail && companyConfirmEmail && (companyEmail == companyConfirmEmail) && (mobileLength == mobileNumberWithoutGap.count) && (personalAgentSignUPModal.personalAgentPassword == personalAgentSignUPModal.personalAgentConfirmPswd) && (personalAgentSignUPModal.personalAgentPassword.count >= 8 && personalAgentSignUPModal.personalAgentConfirmPswd.count  >= 8)   {
            
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
            
        }else{
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .none)
        }
        
        
        if personalAgentSignUPModal.personalAgentbankName != ""  && personalAgentSignUPModal.personalAgentbankAccountHolderName != ""  && personalAgentSignUPModal.personalAgentAccountNbr != "" && personalAgentSignUPModal.personalAgentAccountNbr.count >= personalAgentSignUPModal.personalAgentIBanLength {
            
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
        }else{
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
        }
        
        
        if (isVatYesClicked == true && personalAgentSignUPModal.personalAgentVatNumber.count >= personalAgentSignUPModal.personalVatLength && personalAgentSignUPModal.personalVatDocumentUrl != nil )  || isVatNoClicked == true {
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
        }else{
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
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
