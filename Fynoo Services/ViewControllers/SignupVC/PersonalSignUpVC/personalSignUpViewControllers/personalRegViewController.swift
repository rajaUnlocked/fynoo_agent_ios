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

class PersonalRegViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate ,CompanyRegTableViewCellDelegate,AgentProfileImageTableViewCellDelegate,ImageSelectPopUpDialogViewControllerDelegate,UITextFieldDelegate,SearchCategoryViewControllerDelegate,CompanyAgentBankDetailsTableViewCellDelegate,CompanyAgentVatDetailTableViewCellDelegate,AgentCompanyUserPolicyTableViewCellDelegate,agentPersonalDetailsTableViewCellDelegate,PersonalAgentBasicInformationTableViewCellDelegate {
    
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
    var selectedAgentCountryDict : NSDictionary = NSDictionary()
    var selectedCityDict : NSMutableDictionary = NSMutableDictionary()
    var selectedBankDict : NSMutableDictionary = NSMutableDictionary()
    var selectedAgentEducationDict : NSDictionary = NSDictionary()
    var selectedAgentMajorEducationDict : NSMutableDictionary = NSMutableDictionary()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.selectServiceStr = ""
           self.serviceAPI()
        self.tabView.delegate = self
        self.tabView.dataSource = self
        downImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.view.bringSubviewToFront(headerView)
        maroofLink = "https://www.maroof.com/".localized;
         ibanPrefix = "SA".localized;
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
        
        
        //         tempImage = image
        //              self.tabView.reloadData()
        //              self.selectedImage = tempImage
        //
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
   
    func serviceAPI()
    {
    ModalClass.startLoading(self.view)
    let device_id = UIDevice.current.identifierForVendor!.uuidString
    let str = "\(Constant.BASE_URL)\(Constant.Service_List)"
    let parameters = [
    "lang_code":HeaderHeightSingleton.shared.LanguageSelected
    ]
    print("request -",parameters)
    ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
    ModalClass.stopLoading()
    if success == true {
    self.AgentSERVICE = try! JSONDecoder().decode(AgentService.self, from: resp as! Data )
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
    
    func AgentselectDOB(_ sender: Any){
        let calendar = Calendar(identifier: .gregorian)
                let currentDate = Date()
                var components = DateComponents()
                components.calendar = calendar
                components.year = -18
                components.month = 12
                let maxDate = calendar.date(byAdding: components, to: currentDate)!

                let minDate = Calendar.current.date(from: DateComponents(year: 1900 , month: 1, day: 1))
                
                print(minDate as Any)
                        
        DatePickerDialog().show("Select - Date of Birth".localized, doneButtonTitle: "Done".localized, cancelButtonTitle: "Cancel".localized,  minimumDate: minDate, maximumDate: maxDate,  datePickerMode: .date){
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                print(formatter.string(from: dt))
                self.personalAgentDOB = formatter.string(from: dt)
                
                formatter.dateFormat = "dd/MM/yyyy"
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
func AgentselectCountry(_ sender: Any){
            
      let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
      vc.delegate = self
      vc.isForCountry = true
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
    
    func userPolicySelected(_ sender: Any) {
        if(isUserPolicySelected){
            isUserPolicySelected = false
        }else{
            isUserPolicySelected = true
        }
        self.tabView.reloadRows(at: [IndexPath(row: 0, section: 6)], with: .none)
    }
    func signUpBtnClicked(_ sender: Any) {
        self.view.endEditing(true)
        
        if isVatNoClicked == true {
            personalAgentSignUPModal.personalAgentVatNumber = ""
        }
        if maroofLink == "https://www.maroof.com/".localized {
            personalAgentSignUPModal.personalAgentMaroofLink = ""
        }
        if ibanPrefix == "SA".localized {
              personalAgentSignUPModal.personalAgentAccountNbr = ""
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
        
        if  personalAgentSignUPModal.personalAgentImageID != 0 &&
            appDelegate.selectServiceStr != ""  && personalAgentSignUPModal.personalAgentName != ""  &&
            personalAgentSignUPModal.personalAgentGender != ""  &&
            personalAgentSignUPModal.personalAgentDob != ""  && personalAgentSignUPModal.personalAgentEducation != ""  &&  personalAgentSignUPModal.personalAgentMajorEducation != "" && personalAgentSignUPModal.personalAgentEmail != ""  && personalAgentSignUPModal.personalAgentConfirmEmail != ""  &&
            personalAgentSignUPModal.personalAgentCountry != ""  && personalAgentSignUPModal.personalAgentCity != ""  && personalAgentSignUPModal.personalAgentContactNbr != "" &&
            personalAgentSignUPModal.personalAgentPassword != ""  && personalAgentSignUPModal.personalAgentConfirmPswd != "" && personalAgentSignUPModal.personalAgentbankName != ""  && personalAgentSignUPModal.personalAgentbankAccountHolderName != ""  && personalAgentSignUPModal.personalAgentAccountNbr != "" && ((isVatYesClicked == true && vatStr.count >= 15  && personalAgentSignUPModal.personalAgentVatNumber.containArabicNumber )  || isVatNoClicked == true) && isUserPolicySelected == true && companyEmail && companyConfirmEmail && (companyEmail == companyConfirmEmail) && (mobileLength == mobileNumberWithoutGap.count) && (personalAgentSignUPModal.personalAgentPassword == personalAgentSignUPModal.personalAgentConfirmPswd) && (personalAgentSignUPModal.personalAgentPassword.count >= 8 && personalAgentSignUPModal.personalAgentConfirmPswd.count  >= 8) && str.count >= 24 {
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
                return 120
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
            
            if personalAgentSignUPModal.personalAgentName != ""  &&
                personalAgentSignUPModal.personalAgentGender != ""  &&
                personalAgentSignUPModal.personalAgentDob != ""  && personalAgentSignUPModal.personalAgentEducation != ""  &&  personalAgentSignUPModal.personalAgentMajorEducation != "" &&  personalAgentSignUPModal.personalAgentName.containArabicNumber  {
                cell.editImageView.image = UIImage(named: "section_filled.png")
            }else {
                cell.editImageView.image = UIImage(named: "edit_red")
            }
        }else if index.section == 3 {
            
            
            //            if  personalAgentSignUPModal.personalAgentEmail != ""  && personalAgentSignUPModal.personalAgentConfirmEmail != ""  &&
            //                personalAgentSignUPModal.personalAgentCountry != ""  && personalAgentSignUPModal.personalAgentCity != ""  && personalAgentSignUPModal.personalAgentContactNbr != ""  &&
            //                personalAgentSignUPModal.personalAgentPassword != ""  && personalAgentSignUPModal.personalAgentConfirmPswd != ""  {
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
            if personalAgentSignUPModal.personalAgentbankName != ""  && personalAgentSignUPModal.personalAgentbankAccountHolderName != ""  && personalAgentSignUPModal.personalAgentAccountNbr != "" && str.count >= 24 {
            
                    cell.editImageView.image = UIImage(named: "section_filled.png")
                
            }else{
                cell.editImageView.image = UIImage(named: "edit_red")
            }
        }else if index.section == 5 {
             let str = personalAgentSignUPModal.personalAgentVatNumber.replacingOccurrences(of: " ", with: "")
            if (isVatYesClicked == true && str.count >= 15  && personalAgentSignUPModal.personalAgentVatNumber.containArabicNumber )  || isVatNoClicked == true {
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
          ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.genderView)
          ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.dobView)
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
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.genderView)
        }else{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.genderView)
        }
        if cell.dobTxtFld.text == "" {
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.dobView)
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
                    imageView.image = UIImage(named:"greenTick")
                     ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.emailView)
                     ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.confirmEmailView)
                }
            }else{
                if let imageView = self.view.viewWithTag(203) as? UIImageView{
                    imageView.isHidden = true
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.emailView)
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                }
            }
        }
        
        if selectedAgentCountryDict.count > 0 {
                let count  = self.selectedAgentCountryDict.object(forKey: "mobile_length") as! Int
                let str = cell.mobileTxtFld.text?.replacingOccurrences(of: " ", with: "")
                if str!.count == count {
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.mobileNumberView)
                }else{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.mobileNumberView)
                }
            }else{
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
        
        if self.isCountryChangeAgain == false {
            self.isCountryChangeAgain = true
            cell.mobileTxtFld.text = ""
            self.mobileNumberWithoutGap = ""
            personalAgentSignUPModal.personalAgentContactNbr = ""
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.mobileNumberView)
        }else{
            cell.mobileTxtFld.text = personalAgentSignUPModal.personalAgentContactNbr
            let str = personalAgentSignUPModal.personalAgentContactNbr.replacingOccurrences(of: " ", with: "")
            self.mobileNumberWithoutGap = str
        }
        
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
        
        cell.vatNumberTxtFld.addTarget(self, action: #selector(PersonalRegViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        if isVatYesClicked {
            cell.yesBtn.isSelected = true
            cell.vatNumberView.isHidden = false
            personalAgentSignUPModal.isVatSelected = cell.yesBtn.isSelected
            
        }else{
            cell.yesBtn.isSelected = false
            cell.vatNumberView.isHidden = true
            personalAgentSignUPModal.isVatSelected = cell.yesBtn.isSelected
        }
        
        if isVatNoClicked {
            cell.noBtn.isSelected = true
            personalAgentSignUPModal.isVatNotSelected = cell.noBtn.isSelected
            
        }else{
            personalAgentSignUPModal.isVatNotSelected = cell.noBtn.isSelected
            cell.noBtn.isSelected = false
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
//            cell.signUpBtn.isUserInteractionEnabled = true
        }else {
            
            cell.signUpBtn.setTitleColor(UIColor(red: 236/255, green: 74/255, blue: 83/255, alpha: 1), for: .normal)
            cell.signUpBtn.layer.borderWidth = 0.5
            cell.signUpBtn.borderColor =  UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
//             cell.signUpBtn.isUserInteractionEnabled = false
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
            
            if selectedAgentCountryDict.count > 0{
                lenght = self.selectedAgentCountryDict.object(forKey: "mobile_length") as! Int
            }
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
            let lenght  = 24
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 4)) as! CompanyAgentBankDetailsTableViewCell
            
            // fixed SA
            if let text = textField.text as NSString? {
                let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                textstr = txtAfterUpdate
            }
            
            let textStr = "SA".localized
            if range.location <= textStr.count - 1
            {
                return false
            }
            if textField.text == textStr  && range.length == 1 {
                return false
            }
            ibanPrefix = textstr
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
            return (updateText.count) < lenght+6
            
        case 1011:
            let lenght  = 15
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
    func textFieldDidEndEditing(_ textField: UITextField){
        
        switch  textField.tag {
            
        case 1000:
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
            }else{
                personalAgentSignUPModal.personalAgentName = textField.text!
            }
//        case 1001:
//            let value = ModalController.isValidEmail(testStr: textField.text!)
//            if !value{
//                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.WrongemailAddress)
//            }else{
//                personalAgentSignUPModal.personalAgentEmail = textField.text!.lowercased()
//                let confirmEmail = personalAgentSignUPModal.personalAgentEmail.lowercased()
//                let email = personalAgentSignUPModal.personalAgentConfirmEmail.lowercased()
//
//                if email != "" && confirmEmail  != "" {
//                    if  email ==  confirmEmail{
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
//                personalAgentSignUPModal.personalAgentConfirmEmail = textField.text!.lowercased()
//                let confirmEmail = personalAgentSignUPModal.personalAgentEmail.lowercased()
//                let email = personalAgentSignUPModal.personalAgentConfirmEmail.lowercased()
//                if email != "" && confirmEmail  != "" {
//                    if  email ==  confirmEmail{
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
        case 1003:
            personalAgentSignUPModal.personalAgentContactNbr = textField.text!
            
        case 1005:
            personalAgentSignUPModal.personalAgentMaroofLink = textField.text!
            
//        case 1007:
//            if  textField.text!.count < 8 {
//                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passwordCount)
//
//            }else{
//                personalAgentSignUPModal.personalAgentConfirmPswd = textField.text! // confirm
//
//                if  personalAgentSignUPModal.personalAgentPassword != "" && personalAgentSignUPModal.personalAgentConfirmPswd  != "" {
//                    if personalAgentSignUPModal.personalAgentPassword == personalAgentSignUPModal.personalAgentConfirmPswd{
//
//                        showConfirmButton.isUserInteractionEnabled = true
//                        showConfirmButton.setImage(UIImage(named:"greenTick"), for: .normal)
//                    }else{
//                        showConfirmButton.isUserInteractionEnabled = true
//                        if ispassword {
//                            showConfirmButton.setImage(UIImage(named:"eye_new_hide"), for: .normal)
//                        }else{
//                            showConfirmButton.setImage(UIImage(named:"eye"), for: .normal)
//                        }
//
//                    }
//                }
//            }
//        case 1006:
//            if  textField.text!.count < 8 {
//                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passwordCount)
//            }else{
//                personalAgentSignUPModal.personalAgentPassword = textField.text!
//
//                if  personalAgentSignUPModal.personalAgentPassword != "" && personalAgentSignUPModal.personalAgentConfirmPswd  != "" {
//                    if personalAgentSignUPModal.personalAgentPassword == personalAgentSignUPModal.personalAgentConfirmPswd {
//
//                        showConfirmButton.isUserInteractionEnabled = true
//                        showConfirmButton.setImage(UIImage(named:"greenTick"), for: .normal)
//                    }else{
//                        showConfirmButton.isUserInteractionEnabled = true
//                        if ispassword {
//                            showConfirmButton.setImage(UIImage(named:"eye_new_hide"), for: .normal)
//                        }else{
//                            showConfirmButton.setImage(UIImage(named:"eye"), for: .normal)
//                        }
//
//                    }
//                }
//            }
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
                            if companyConfirmEmail {
                                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.confirmEmailView)
                            }else{
                                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                            }
                        }
                    }else{
                        if let imageView = self.view.viewWithTag(203) as? UIImageView{
                            imageView.isHidden = true
                            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                        }
                    }
                }else{
                    if let imageView = self.view.viewWithTag(203) as? UIImageView{
                        imageView.isHidden = true
                        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                    }
                }
            }else{
                if let imageView = self.view.viewWithTag(203) as? UIImageView{
                    imageView.isHidden = true
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
                            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                        }
                    }
                }else{
                    if let imageView = self.view.viewWithTag(203) as? UIImageView{
                        imageView.isHidden = true
                        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.confirmEmailView)
                    }
                }
            }else{
                if let imageView = self.view.viewWithTag(203) as? UIImageView{
                    imageView.isHidden = true
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
            if selectedAgentCountryDict.count > 0 {
                let count  = self.selectedAgentCountryDict.object(forKey: "mobile_length") as! Int
                let str = cell.mobileTxtFld.text?.replacingOccurrences(of: " ", with: "")
                if str!.count == count {
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.mobileNumberView)
                }else{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.mobileNumberView)
                }
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Select Country First")
                return
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
                }else{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.accountHolderNameView)
                }
            }
            personalAgentSignUPModal.personalAgentbankAccountHolderName = textField.text!
        case 1010:
            let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 4)) as! CompanyAgentBankDetailsTableViewCell
            if accountNumber != "" {
                accountValue = textField.text!
                accountNumber = accountValue.replacingOccurrences(of: " ", with: "")
                accountValue = ModalController.customStringFormattingForAccountNumber(of: accountNumber)
            }else{
                accountValue =  ModalController.customStringFormattingForAccountNumber(of: textField.text!)
                accountNumber = accountValue.replacingOccurrences(of: " ", with: "")
            }
             textField.text = accountValue
            
            let str = cell.ibanNumberTxtFld.text?.replacingOccurrences(of: " ", with: "")
            if str!.count >= 24 && cell.ibanNumberTxtFld.text != "" && cell.ibanNumberTxtFld.text != "SA" && cell.ibanNumberTxtFld.text!.containArabicNumber {
                 ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.ibanNumberView)
            }else{
               ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.ibanNumberView)
            }
            
           personalAgentSignUPModal.personalAgentAccountNbr = str!
            
            if personalAgentSignUPModal.personalAgentAccountNbr.count == 6 {
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
             let   cell = tabView.cellForRow(at: IndexPath(row:1 , section: 5)) as! CompanyAgentVatDetailTableViewCell
            
            if VatNumber != "" {
                vatValue = textField.text!
                VatNumber = vatValue.replacingOccurrences(of: " ", with: "")
                vatValue = ModalController.customStringFormatting(of: VatNumber)
            }else{
                vatValue =  ModalController.customStringFormatting(of: textField.text!)
                VatNumber = vatValue.replacingOccurrences(of: " ", with: "")
            }
            textField.text = vatValue
             let str = cell.vatNumberTxtFld.text?.replacingOccurrences(of: " ", with: "")
            
             if str!.count >= 15  && cell.vatNumberTxtFld.text != "" &&  cell.vatNumberTxtFld.text!.containArabicNumber{
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
        
        if personalAgentSignUPModal.personalAgentbankName != ""  && personalAgentSignUPModal.personalAgentbankAccountHolderName != ""  && personalAgentSignUPModal.personalAgentAccountNbr != "" {
            
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
        }else{
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
        }
        
       if (isVatYesClicked == true && personalAgentSignUPModal.personalAgentVatNumber.count >= 15 )  || isVatNoClicked == true {
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
        }else{
            self.tabView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .none)
        }
        
    }
}
