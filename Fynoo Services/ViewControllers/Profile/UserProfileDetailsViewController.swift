//
//  UserProfileDetailsViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 23/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import ObjectMapper
import MTPopup
import PDFKit
protocol VatPopupNewViewControllerDelegate {
    func save(Str:String,vat: String)
     func cancel()
}

class UserProfileDetailsViewController: UIViewController ,VatPopupNewViewControllerDelegate,LanguageSelectionViewControllerDelegate{
    func reloadPage() {
        getProfileData()
    }
    
    func selectLanguageMethod(languageDict: NSMutableDictionary) {
        
    }
    
    func save(Str: String, vat: String) {
        self.agentInfo.vatNo = vat
              self.pdfVat = Str
              
              let url = URL(string: self.pdfVat)
              self.pdfImage = self.pdfThumbnail(url: url!)!
              print( self.pdfVat,"hsdhj")
              tableVw.reloadData()
              print(Str,vat)
    }
    var SectImage:UIImage?

   @objc func cancel() {
        isEdit = false
       getProfileData()
    }
    
  
    var ismobile = true

    var mobilNoo = ""
    var value = ""
    
    var phNoo = ""
    var phVAL = ""
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var tableVw: UITableView!
    var isEdit = false
    var isPersonal = false
    var profileInfo : ProfileModal?
    var agentInfo = AgentProfile()
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    var pdfImage =  UIImage()
    var myString = ""
    var personalDetail = ["First Name","Middle Name","Last Name","Gender","Dob","Education","Major"]
    var basicInfo = ["Business Name","Email","Country","City","Mobile Number","Phone Number","Maroof Link"]
    var bankDetail = ["IBAN Number","Bank Name","Card Holder Name"]
    var sectionHeading = ["","Services ","Basic Information","Bank Detail","Vat Information","Password Information","Language Information"]
    var pdfVat = ""
    var userType = ""

    var selectedCountryDict : NSMutableDictionary = NSMutableDictionary()
    var selectedCityDict : NSMutableDictionary = NSMutableDictionary()
     var selectedEducation : NSMutableDictionary = NSMutableDictionary()
    var selectedMajorEducation : NSMutableDictionary = NSMutableDictionary()

    override func viewDidLoad() {
        
        ModalController.watermark(self.view)
        
        tableVw.register(UINib(nibName: "ProfileNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileNameTableViewCell");
        tableVw.register(UINib(nibName: "ProfileDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileDetailTableViewCell");
        tableVw.register(UINib(nibName: "ProfileEnteriesTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileEnteriesTableViewCell");
        tableVw.register(UINib(nibName: "ProfileVatTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileVatTableViewCell");
        tableVw.register(UINib(nibName: "ProfileServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileServiceTableViewCell");
        tableVw.register(UINib(nibName: "TwoButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "TwoButtonsTableViewCell");

     //agentInfo.langArr.removeAllObjects()
            getProfileData()

        headerView.viewControl = self

        headerView.titleHeader.text = "Profile".localized
        
    }
    func profileImageSelected(){
        
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
       
    }
    func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
        guard let data = try? Data(contentsOf: url),
            
            let page = PDFDocument(data: data)?.page(at: 0) else {
                return nil
        }
        let pageSize = page.bounds(for: .mediaBox)
        let pdfScale = width / pageSize.width
        
        // Apply if you're displaying the thumbnail on screen
        let scale = UIScreen.main.scale * pdfScale
        let screenSize = CGSize(width: pageSize.width * scale,
                                height: pageSize.height * scale)
        
        return page.thumbnail(of: screenSize, for: .mediaBox)
    }
    @objc func saveChange() {
        
        if agentInfo.serviceArr.count == 0
        {
            ModalController.showNegativeCustomAlertWith(title: "Please select at least one service", msg: "")
            return
        }
            
            var ACTIVATION = ""
            if agentInfo.serviceArr.count > 0
            {
                ACTIVATION.removeAll()
                for item in agentInfo.serviceArr{
                    ACTIVATION = "\(item),\(ACTIVATION)"
                }
                ACTIVATION.removeLast()
            }
            let split = agentInfo.maroof.split(separator: "/")
                 print(split)
                 var last  = String(split.suffix(1).joined(separator: [" "]))
                 print(last)
                
            var isvatUpload = 0
            if pdfVat != agentInfo.vatCertificate {
                isvatUpload = 1
            }
            agentInfo.vatNo = agentInfo.vatNo.replacingOccurrences(of: " ", with: "")
            
                print(ACTIVATION)
            let mobile = agentInfo.mobileNo.replacingOccurrences(of: " ", with: "")
            let phone = agentInfo.phoneNo.replacingOccurrences(of: " ", with: "")
            
        if (agentInfo.name == "") || ModalController.isValidName(title: agentInfo.name) == false{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Enter Name")
            return
        }
        if (agentInfo.last_name == "") || ModalController.isValidName(title: agentInfo.last_name) == false{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Enter Last Name")
            return
        }
        
        
        
        
        
            if agentInfo.dob != ""{
                print(agentInfo.dob,"date")
                
                let inputFormatter = DateFormatter()
                inputFormatter.dateFormat = "MMM dd,yyyy"

                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "YYYY-MM-dd"

                let showDate = inputFormatter.date(from: agentInfo.dob)
                if showDate != nil{
                agentInfo.dob = outputFormatter.string(from: showDate!)
                }
                
                print(agentInfo.dob,"vhdfbjh")
    //            let dateFormatter = DateFormatter()
    //            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    //            dateFormatter.dateFormat = "yyyy-MM-dd"
    //            let date = dateFormatter.date(from:agentInfo.dob)!
                
            }
            var name = ""
        var last_name = ""
        var middle_name = ""
            if userType == "AC"{
                name = agentInfo.businessName
            }else{
                name = agentInfo.name
                middle_name = agentInfo.middle_name
                last_name = agentInfo.last_name
            }
        let parameter = ["user_id":"\(Singleton.shared.getUserId())",
                         "lang_code":"EN",
                         "user_type":"\(userType)",
                         "service_id":ACTIVATION,
                         "name":name,
                         "middle_name":middle_name,
                         "last_name":last_name,
                         "email":agentInfo.Email,
                         "country_id":agentInfo.countryId,
                         "dob":self.agentInfo.dob,
                         "city_id":agentInfo.cityId,
                         "mobile_code":agentInfo.mobileCode,
                         "mobile_number":mobile,
                         "phone_code":agentInfo.phCode,
                         "phone_number":phone,
                         "maroof_link":last,
                         "bank_details_id":agentInfo.bankId,
                         "bank_id":agentInfo.bankId,
                         "bank_name":agentInfo.bankname,
                         "card_holder_name":agentInfo.cardHolderName,
                         "iban_no":agentInfo.iban,
                         "vat_no":agentInfo.vatNo,
                         "password":"",
                         "education_id":agentInfo.educationId,
                         "major_id":agentInfo.majorId,
                         "is_vat_upload":"\(isvatUpload)",
                         "gender":agentInfo.gender] as [String : Any]
            
            print(parameter)
            
            
            ModalClass.startLoading(self.view)
            ServerCalls.PdfFileUpload(inputUrl: Service.updateProfile, parameters: parameter, pdfname: "vat_certificate", pdfurl: pdfVat) { (response, success, resp) in
                ModalClass.stopLoading()
                if success{
                    if let responses  = response as? NSDictionary{
                        let msg = responses.object(forKey: "error_description") as! String
                        ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                    }
                    self.isEdit = false
                    self.tableVw.reloadData()
                    print(response)
                }else{
                    if let responses  = response as? NSDictionary{
                        let msg = responses.object(forKey: "error_description") as! String
                        ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
                    }
                }
            }
        }
    
    func getIbanLength(str:String){
        
        let parameter = ["country_code":"\(str.uppercased())",
                                "lang_code":"EN"]
               print(parameter)
        
        let url = Service.getIbanLength
        ServerCalls.postRequest(url, withParameters: parameter) { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                
                if error == 0{
                    self.agentInfo.ibanLenght = (value.object(forKey: "data") as! NSDictionary).object(forKey: "bank_number_length") as! Int
                  
                    
                }else{
                    self.agentInfo.bankname = ""
                    self.tableVw.reloadRows(at: [IndexPath(row: 1, section: 4)], with: .none)
                }
                
            }
        }

    }
    
    func getBankDetail(str:String){
        
        let sty = str.prefix(2)
        let identifier = str.suffix(2)
        
        print(sty)
        let parameter = ["country_code":"\(sty.uppercased())",
                         "lang_code":"EN","identifier":identifier]
        print(parameter)
        let url = Service.getBankDetail
        ServerCalls.postRequest(url, withParameters: parameter) { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int

                if error == 0{
                    self.agentInfo.bankname = (value.object(forKey: "data") as! NSDictionary).object(forKey: "bank_name") as! String
                    self.agentInfo.bankId = (value.object(forKey: "data") as! NSDictionary).object(forKey: "id") as! Int
                    self.tableVw.reloadData()
                    
                }else{
                    self.agentInfo.bankname = ""
                    self.tableVw.reloadRows(at: [IndexPath(row: 1, section: 4)], with: .none)
                }
                
            }
            
            
        }
    }
    
    
    
    @objc func selectCityCountry(_ tag: UIButton){
  
            let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
            vc.delegate = self
            if tag.tag == 2 {
                vc.isForCountry = true
            }else{
                
                if selectedCountryDict.count > 0{
                    vc.selectedOLDCountryDict = self.selectedCountryDict
                    
                }else{
                    vc.selectedCountryID = "\(agentInfo.countryId)"
                }
                vc.isForCountry = false
                vc.isForCity = true
            }
            self.navigationController?.pushViewController(vc, animated: true)
       
        
    }
    
    func getProfileData(){
        let parameter = ["user_id":"\(Singleton.shared.getUserId())",
                         "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        ServerCalls.postRequest(Service.getProfile, withParameters: parameter) { [self] (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        
                        //                        self.agentInfo.serviceArr = (value.object(forKey: "data") as! NSDictionary).object(forKey: "service_list_data") as! NSArray as! NSMutableArray
                        //
                        //
                        agentInfo.langArr.removeAllObjects()
                        print(self.agentInfo.serviceArr.count,"services")
                        
                        self.profileInfo  = Mapper<ProfileModal>().map(JSON: body)
                        self.agentInfo.businessName = self.profileInfo?.data?.user_data?.business_name ?? ""
                        let val = self.profileInfo?.data?.service_list_data?.count
                        
                        for i in 0..<val!{
                            if self.profileInfo?.data?.service_list_data?[i].is_opt ?? 0 == 1
                            {
                                self.agentInfo.serviceArr.add( self.profileInfo?.data?.service_list_data?[i].service_id ?? 0)  } }
                        let lang = self.profileInfo?.data?.language_list?.count
                        for i in 0..<lang!{
                            print(self.profileInfo?.data?.language_list?[i].lang_id ?? 0,"jldkj")
                            self.agentInfo.langArr.add("\(self.profileInfo?.data?.language_list?[i].lang_id ?? 0)")
                        }
                        
                        print(self.agentInfo.langArr,"jnff")
                        
                        self.userType = self.profileInfo?.data?.user_data?.user_type ?? ""
                        
                        if self.userType == "AC"{
                            self.isPersonal = false
                        }else{
                            self.isPersonal = true
                        }
                        
                        if self.isPersonal{
                            self.basicInfo = ["Email","Country","City","Mobile Number","Maroof Link"]
                            self.sectionHeading = ["","Services ","Personal Information","Basic Information","Bank Detail","Vat Information","Password Information","Language Information"]
                        }
                        
                        self.agentInfo.name = self.profileInfo?.data?.user_data?.name ?? ""
                        self.agentInfo.middle_name = self.profileInfo?.data?.user_data?.middle_name ?? ""
                        self.agentInfo.last_name = self.profileInfo?.data?.user_data?.last_name ?? ""
                        print(self.agentInfo.name,"-:nameddd")
                        print(self.agentInfo.middle_name,"-:middlename")
                        print(self.agentInfo.last_name,"-:lastnameddd")
                        self.agentInfo.Email = self.profileInfo?.data?.user_data?.email ?? ""
                        self.agentInfo.country = self.profileInfo?.data?.user_data?.country ?? ""
                        self.agentInfo.countryId = self.profileInfo?.data?.user_data?.country_id ?? 0
                        self.agentInfo.city = self.profileInfo?.data?.user_data?.city ?? ""
                        self.agentInfo.cityId = self.profileInfo?.data?.user_data?.city_id ?? 0
                        self.agentInfo.Email = self.profileInfo?.data?.user_data?.email ?? ""
                        let mobile  = self.profileInfo?.data?.user_data?.mobile_number ?? ""
                        self.agentInfo.mobileNo = self.customStringFormatting(of: mobile)
                        self.agentInfo.mobileCode = self.profileInfo?.data?.user_data?.mobile_code ?? ""
                        let phone = self.profileInfo?.data?.user_data?.phone_number ?? ""
                        self.agentInfo.phoneNo =  self.customStringFormatting(of: phone)
                        self.agentInfo.businessName = self.profileInfo?.data?.user_data?.company_name ?? ""
                        
                        
                        self.agentInfo.phCode = self.profileInfo?.data?.user_data?.phone_code ?? ""
                        self.agentInfo.phFlag = self.profileInfo?.data?.user_data?.phone_flag ?? ""
                        self.agentInfo.maroof = "https://www.maroof.com/"
                        self.agentInfo.maroof +=  self.profileInfo?.data?.user_data?.maroof_link ?? ""
                        self.agentInfo.bankname = self.profileInfo?.data?.user_data?.bank_name ?? ""
                        self.agentInfo.cardHolderName = self.profileInfo?.data?.user_data?.ac_holder_name ?? ""
                        self.agentInfo.ibanLenght = 24
                        self.agentInfo.bankId = self.profileInfo?.data?.user_data?.bank ?? 0
                        self.agentInfo.iban = self.profileInfo?.data?.user_data?.iban_no ?? ""
                        print(self.profileInfo?.data?.user_data?.account_iban_nbr ?? "","kjkjkjjkj")
                        let vals = self.profileInfo?.data?.user_data?.vat_no ?? ""
                        self.agentInfo.vatNo =  self.customStringFormatting(of: vals)
                        
                        
                        self.pdfVat = self.profileInfo?.data?.user_data?.vat_certificate ?? ""
                        
                        self.agentInfo.gender = self.profileInfo?.data?.user_data?.gender ?? ""
                        
                        self.agentInfo.dob = self.profileInfo?.data?.user_data?.dob ?? ""
                        
                        let dateString = self.agentInfo.dob
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                        dateFormatter.dateFormat = "MM-dd-yyyy"
                        let date = dateFormatter.date(from: dateString)!
                        dateFormatter.dateFormat = "YYYY-MM-dd"
                        self.agentInfo.dob = dateFormatter.string(from:date)
                        
                        self.agentInfo.education = self.profileInfo?.data?.user_data?.education ?? ""
                        self.agentInfo.educationId = self.profileInfo?.data?.user_data?.education_new ?? 0
                        
                        self.agentInfo.major = self.profileInfo?.data?.user_data?.education_major ?? ""
                        self.agentInfo.majorId = self.profileInfo?.data?.user_data?.education_major_id ?? 0
                        
                        self.agentInfo.mobileFlag = self.profileInfo?.data?.user_data?.mobile_flag ?? ""
                        
                        self.agentInfo.mobileLength = self.profileInfo?.data?.user_data?.mobile_length ?? 0
                        
                        self.agentInfo.phoneLength = self.profileInfo?.data?.user_data?.phone_length ?? 0
                        
                        
                        if self.pdfVat != ""{
                            let url = URL(string: self.pdfVat)
                            self.pdfImage = self.pdfThumbnail(url: url!)!
                        }else{
                            self.pdfImage = UIImage(named:"vatSample_image")!
                        }
                        
                        self.tableVw.delegate = self
                        self.tableVw.dataSource = self
                        self.tableVw.reloadData()
                    }
                }else{
                    let msg =  value.object(forKey: "error_description") as! String
                    ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
                    
                }
                
            }
        }
        
    }
    
    
}

extension UserProfileDetailsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if isPersonal == true && isEdit == true {
            
            if indexPath.section == 2{
                if indexPath.row == 2{
                    let calendar = Calendar(identifier: .gregorian)
                            let currentDate = Date()
                            var components = DateComponents()
                            components.calendar = calendar
                          components.year = -18
                   // components.year = -(Int(personalAgentSignUPModal.PersonalAgentAge_limit) ?? 18)
                            components.month = 12
                            let maxDate = calendar.date(byAdding: components, to: currentDate)!

                            let minDate = Calendar.current.date(from: DateComponents(year: 1900 , month: 1, day: 1))
                            
                            print(minDate as Any)
                             print(maxDate as Any)
                                    
                    DatePickerDialog().show("Select - Date of Birth".localized, doneButtonTitle: "Done".localized, cancelButtonTitle: "Cancel".localized,  minimumDate: minDate, maximumDate: maxDate,  datePickerMode: .date){
                        (date) -> Void in
                        if let dt = date {
                            
                            let formatter = DateFormatter()
                            formatter.locale = Locale(identifier: "en_US_POSIX")
                            formatter.dateFormat = "MMM dd,yyyy"
                            let date = formatter.string(from: dt)
                            
                            self.agentInfo.dob = date
                            self.tableVw.reloadData()
                           // let date1 = formatter.date(from:date)
                         
                            
                            
                        }
                    }
                    
                    
                }
                if indexPath.row == 3{
                    let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
                  
                    vc.delegate = self
                    vc.isForEducationList = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                if indexPath.row == 4{
                    let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
//                    if self.selectedEducation.count == 0 {
//                        ModalController.showNegativeCustomAlertWith(title: "Please select education first".localized, msg: "")
//                        return
//                    }
                    vc.delegate = self
                    vc.isForMajorEducationList = true
                    vc.selectedOLDCountryDict = self.selectedEducation
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            
            
            
        }
        
        if "Vat Information" == sectionHeading[indexPath.section]{
            let vc = VatpopnewchangeViewController(nibName: "VatpopnewchangeViewController", bundle: nil)
            vc.delegate = self
            if self.agentInfo.vatNo != ""{
                
                vc.vatNo = self.agentInfo.vatNo
                vc.pfurl = URL(string:pdfVat)
                vc.pdfImage = pdfImage
            }
            vc.delegate = self
            vc.modalPresentationStyle = .overFullScreen
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.present(vc, animated: true, completion: nil)
        }
        
        if "Password Information" == sectionHeading[indexPath.section]{
          
            let vc = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: nil)
            vc.userInfo  = profileInfo
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0{
            return UIView()
        }else{
            let view = SectionHeader()
            view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 40)
            view.sectionText.text = sectionHeading[section].localized
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            view.sectionText.font = UIFont(name: "\(fontNameLight)", size: 13)
            return view
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 210
            }else{
                if isEdit{
                    return 60
                }else{
                    return 90
                }
            }
        case 1:
            
            if (profileInfo?.data?.service_list_data!.count) != nil{
                let count = profileInfo?.data?.service_list_data?.count
                if count! % 2 == 0{
                    let val = (count!/2)
                    return (CGFloat(60 * val))
                   
                }else{
                    let val = (count!-1)/2
                    return (CGFloat((60*val)+60))
                }
            }else{
                return 0
            }
           // return 120
        case 4:
            
            if isPersonal{
                    return 50
            }else{
                if indexPath.row == 0{
                    return 50
                }else{
                    return 243
                }
            }
           
        case 5:
            if isPersonal{
                if indexPath.row == 0{
                    return 50
                }else{
                    return 243
                }
            }else{
                return 50
            }
        default:
            
            return 50
        }
    }
}

extension UserProfileDetailsViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeading.count
      
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !isPersonal {
            switch section {
            case 0,4:
                return 2
            case 2:
                return basicInfo.count
                
            case 3:
                return bankDetail.count
                
            case 6:
                if isEdit{
                    return 2
                }else{
                    return 1
                }
            default:
                return 1
            }
        }else{
            switch section {
            case 0,5:
                
                return 2
            case 2:
                return personalDetail.count
                
            case 3:
                return basicInfo.count
            case 4:
                return bankDetail.count
                
            case 7:
                if isEdit{
                    return 2
                }else{
                    return 1
                }
            default:
                return 1
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section{
        case 0:
            if indexPath.row == 0{
                let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileNameTableViewCell",for: indexPath) as! ProfileNameTableViewCell
                cell.delegate = self
                           cell.selectionStyle = .none

                cell.profileImage.sd_setImage(with: URL(string:self.profileInfo!.data?.user_data?.profile_image ?? ""), placeholderImage: UIImage(named: "profile_white"))
                let val1 = "ID".localized
                let val2 = "Hello".localized
                cell.fynooIdLbl.text = "\(val1) \(self.profileInfo?.data?.user_data?.fynoo_id ?? "")"
                cell.nameLbl.text = "\(val2) \(self.profileInfo?.data?.user_data?.name ?? "")"

                return cell
                
            }else{
                let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileDetailTableViewCell",for: indexPath) as! ProfileDetailTableViewCell
               
                cell.agentimg.image = UIImage(named: "agent_indivdual")
                cell.delegate = self
                cell.selectionStyle = .none
              
                if isPersonal{
                    cell.titleLbl.text = "Agent Personal".localized
                }else{
                    cell.titleLbl.text = "Agent Company".localized

                }
                if isEdit{
                    
                    cell.editHeight.constant = 0
                    cell.editBtn.isHidden = true
                    cell.editProfileTitle.isHidden = true
                    cell.imageButton.isHidden = true
                }else{
                   
                    cell.editHeight.constant = 34
                    cell.editBtn.isHidden = false
                    cell.editProfileTitle.isHidden = false
                    cell.imageButton.isHidden = false
                }
                return cell
                
            }
            
        case 1:
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileServiceTableViewCell",for: indexPath) as! ProfileServiceTableViewCell
            cell.isForLanguage = false
            cell.isUserInteractionEnabled = false
            if isEdit
            {
                cell.isUserInteractionEnabled = true
            }
            print(self.agentInfo.serviceArr.count,"services")
            cell.agentinfo = self.agentInfo
            cell.serviceList = profileInfo?.data?.service_list_data
            cell.collectionView.reloadData()
            return cell
            
        case 2:
            if isPersonal{
                return personalCell(indexPath: indexPath)
            }else{
                return BasicInfoCell(indexPath: indexPath)
            }
            
            
        case 3:
            if isPersonal{
                return BasicInfoCell(indexPath: indexPath)
            }else{
                return BankDetailCell(indexPath: indexPath)
            }
            
            
            
        case 4:
            if isPersonal{
                return BankDetailCell(indexPath: indexPath)
            }else{
                return VatCell(indexPath: indexPath)
            }
            
        case 5:
            if isPersonal{
                return VatCell(indexPath: indexPath)
            }else{
                return passwordCell(indexPath: indexPath)
            }
            
            
        case 6:
            if isPersonal{
                return passwordCell(indexPath: indexPath)
            }else{
                return LanguageCell(indexPath: indexPath)
            }
            
        case 7:
            return LanguageCell(indexPath: indexPath)
            
            
        default:
            return LanguageCell(indexPath: indexPath)
            
            
            
        }
    }
    
    
    func LanguageCell(indexPath:IndexPath) -> UITableViewCell{
        if indexPath.row == 1{
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "TwoButtonsTableViewCell",for: indexPath) as! TwoButtonsTableViewCell
            
            cell.isUserInteractionEnabled = false
                       if isEdit
                       {
                           cell.isUserInteractionEnabled = true
                       }
            if agentInfo.serviceArr.count == 0{
                cell.save.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
                cell.save.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            }else{
                cell.save.setTitleColor(#colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1), for: .normal)
                cell.save.borderColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
                
            }
            if agentInfo.name != "" && ModalController.isValidName(title: agentInfo.name) == true && agentInfo.last_name != "" && ModalController.isValidName(title: agentInfo.last_name) == true{
                
                cell.save.borderColor =  #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                cell.save.setTitleColor( #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
            }else{
                cell.save.borderColor =  #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
                cell.save.setTitleColor( #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), for: .normal)
            }
            cell.save.addTarget(self, action: #selector(saveChange), for: .touchUpInside)
            cell.cancel.addTarget(self, action: #selector(cancel), for: .touchUpInside)
            cell.selectionStyle = .none

            return cell
        }else{
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileServiceTableViewCell",for: indexPath) as! ProfileServiceTableViewCell
            cell.isUserInteractionEnabled = false
                       if isEdit
                       {
                           cell.isUserInteractionEnabled = true
                       }
            cell.agentinfo = self.agentInfo
            cell.selectionStyle = .none

            cell.delegate = self
            cell.viewControl = self
            cell.languageList = self.profileInfo?.data?.language_list
            cell.isEdit = isEdit
            cell.isForLanguage = true
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func passwordCell(indexPath:IndexPath) -> UITableViewCell{
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
        cell.isUserInteractionEnabled = false
                   if isEdit
                   {
                       cell.isUserInteractionEnabled = true
                   }
        cell.entryLbl.attributedText = ModalController.setprofileStricColor(str: "\("Password".localized) *", str1: "\("Password".localized)", str2:" *" )
        cell.selectionStyle = .none
        cell.widthImg.constant = 0
        cell.codeBtn.isHidden = true
        cell.codeBtnWidth.constant = 0
        cell.genderView.arrowSize = 0.0
        cell.genderWidth.constant = 0
        cell.mobileCodeWidth.constant = 0
        cell.genderHorizantal.constant = 0
        cell.genderWidth.constant = 0
        cell.genderHorizantal.constant = 0
        cell.selectBtn.isHidden = true
        cell.headingLbl.text = "* * * * * * * *"
        cell.headingLbl.isUserInteractionEnabled = false
        cell.selectionStyle = .none

        return cell
    }
    
    func personalCell(indexPath : IndexPath) -> UITableViewCell{
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        cell.headingLbl.font = UIFont(name: "\(fontNameLight)", size: 11)!
        cell.headingLbl.isHidden = true
        cell.genderView.isHidden = true
        cell.isUserInteractionEnabled = false
                   if isEdit
                   {
                       cell.isUserInteractionEnabled = true
                   }
  
       
       cell.entryLbl.attributedText = ModalController.setprofileStricColor(str: "\("\(personalDetail[indexPath.row])".localized) *", str1: "\(personalDetail[indexPath.row])".localized, str2:" *" )
        cell.headingLbl.isUserInteractionEnabled = true
        cell.headingLbl.isHidden = false
        cell.selectionStyle = .none
               cell.codeBtnWidth.constant = 0
               cell.widthImg.constant = 0
               cell.mobileCodeWidth.constant = 0
               cell.genderWidth.constant = 0
               cell.genderHorizantal.constant = 0
               cell.selectBtn.isHidden = true
               cell.headingLbl.isUserInteractionEnabled = true

        cell.genderWidth.constant = 0
        cell.genderHorizantal.constant = 0
        if isEdit{
                  cell.headingLbl.isUserInteractionEnabled = true
              }else{
                  cell.headingLbl.isUserInteractionEnabled = false
                  
              }
        if indexPath.row == 0{
            cell.headingLbl.isHidden = false
            cell.headingLbl.text = agentInfo.name
            cell.headingLbl.tag = 9997
            cell.headingLbl.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        }else if indexPath.row == 1{
            cell.entryLbl.attributedText = ModalController.setprofileStricColor(str: "\("\(personalDetail[indexPath.row])".localized)", str1: "\(personalDetail[indexPath.row])".localized, str2:"" )
            cell.headingLbl.isHidden = false
            cell.headingLbl.text = agentInfo.middle_name
            cell.headingLbl.tag = 9998
            cell.headingLbl.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        }
        else if indexPath.row == 2{
            cell.headingLbl.isHidden = false
            cell.headingLbl.tag = 9999
            cell.headingLbl.text = agentInfo.last_name
            cell.headingLbl.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        }
        else if indexPath.row == 3{
            cell.genderWidth.constant = (self.tableVw.frame.width)/2 + 10
            cell.genderHorizantal.constant = 0
            if isEdit{
                cell.genderView.isUserInteractionEnabled = true
            }else{
                cell.genderView.isUserInteractionEnabled = false

            }
            cell.genderView.isSearchEnable = false
            cell.headingLbl.isHidden = true
            cell.genderView.isHidden = false
            cell.headingLbl.isUserInteractionEnabled = false
            cell.genderView.text = agentInfo.gender
            cell.genderView.optionArray = ["Male".localized,"Female".localized]
            cell.genderView.rowHeight = 30
            cell.genderView.arrowSize = 0.0
            cell.genderView.arrowColor = UIColor.white
            cell.genderView.didSelect{(selectedText , index ,id) in
                cell.genderView.text = "\(selectedText)"
                self.agentInfo.gender = "\(selectedText)"
            }
        }
        else if indexPath.row == 4 {
            cell.headingLbl.isHidden = false
            cell.headingLbl.isUserInteractionEnabled = false
            cell.headingLbl.text = agentInfo.dob
            
        }
        else if indexPath.row == 5{
            cell.headingLbl.isHidden = false
            cell.headingLbl.text = agentInfo.education
            cell.headingLbl.isUserInteractionEnabled = false
        }
        else if indexPath.row == 6{
            cell.headingLbl.isHidden = false
            cell.headingLbl.text = agentInfo.major
            cell.headingLbl.isUserInteractionEnabled = false

        }
        return cell
        
    }
    func BankDetailCell(indexPath : IndexPath) -> UITableViewCell{
        
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
        cell.headingLbl.isHidden = true
        cell.genderView.isHidden = true
        cell.isUserInteractionEnabled = false
                   if isEdit
                   {
                       cell.isUserInteractionEnabled = true
                   }
        cell.entryLbl.attributedText = ModalController.setprofileStricColor(str: "\(bankDetail[indexPath.row].localized) *", str1: "\(bankDetail[indexPath.row].localized)", str2:" *" )
        cell.headingLbl.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        cell.selectionStyle = .none

        if isEdit{
            cell.headingLbl.isUserInteractionEnabled = true
        }else{
            cell.headingLbl.isUserInteractionEnabled = false
            
        }
        cell.headingLbl.isHidden = false
        cell.codeBtnWidth.constant = 0
        cell.widthImg.constant = 0
        cell.mobileCodeWidth.constant = 0
        cell.genderWidth.constant = 0
        cell.genderHorizantal.constant = 0
        cell.selectBtn.isHidden = true
        
        if indexPath.row == 1{
            cell.headingLbl.isUserInteractionEnabled = false
            cell.headingLbl.text = agentInfo.bankname
            cell.headingLbl.tag = 1000
            cell.headingLbl.delegate=self
        }else if indexPath.row == 2{
           
            cell.headingLbl.tag = 1001
            cell.headingLbl.text = agentInfo.cardHolderName
        }else if indexPath.row == 0{
            cell.headingLbl.autocapitalizationType = .allCharacters
            cell.headingLbl.tag = 1002
            cell.headingLbl.delegate = self
            cell.headingLbl.text = agentInfo.iban
            
            cell.headingLbl.delegate = self
            cell.headingLbl.isHidden = false
            cell.codeBtnWidth.constant = 0
            cell.widthImg.constant = 0
            cell.mobileCodeWidth.constant = 0
            cell.selectBtn.isHidden = true
            cell.headingLbl.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        }
        return cell
    }
//    let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
//          vc.delegate = self
//          vc.isFromCountryMobileCode = true
//           vc.selectedCountryDict = self.selectedCountryCodeDict
//          self.navigationController?.pushViewController(vc, animated: true)
    @objc func handleTextChange(_ textField: UITextField) {
        if textField.tag == 1002
        {
        if textField.text!.count < 2 {
      textField.keyboardType = .asciiCapable
      textField.reloadInputViews() // need to reload the input view for this to work
    } else if textField.text!.count > 2 || textField.text!.count == 2 {
      textField.keyboardType = .asciiCapableNumberPad
      textField.reloadInputViews()
    }
        }
    }
    @objc func codeClicked(_ sender : UIButton){
        
        if sender.tag == 1098{
            let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
            vc.delegate = self
            ismobile = false
            vc.isFromCountryMobileCode = true

    //        vc.isForCounrtyCode = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
            vc.delegate = self
            ismobile = true
              vc.isFromCountryMobileCode = true
    //        vc.isForCounrtyCode = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
    }
    
    func BasicInfoCell(indexPath : IndexPath) -> UITableViewCell{
        
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        cell.headingLbl.font = UIFont(name: "\(fontNameLight)", size: 11)!
        cell.genderView.isHidden = true
        cell.selectBtn.isHidden = true
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = false
                   if isEdit
                   {
                       cell.isUserInteractionEnabled = true
                   }
        cell.headingLbl.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        cell.genderWidth.constant = 0
        cell.genderHorizantal.constant = 0
        cell.genderView.arrowSize = 0.0
        
        cell.contentView.insertSubview(cell.rotateVw, aboveSubview:cell.selectBtn )
        cell.widthImg.constant = 0
        cell.flagImg.isHidden = true
        cell.headingLbl.keyboardType = .default
        if isEdit{
            cell.headingLbl.isUserInteractionEnabled = true
        }else{
            cell.headingLbl.isUserInteractionEnabled = false
            
        }
        cell.entryLbl.attributedText = ModalController.setprofileStricColor(str: " \(basicInfo[indexPath.row].localized) *", str1: "\(basicInfo[indexPath.row].localized)", str2:" *" )
        
        print(basicInfo[indexPath.row],"sd")
        cell.codeBtn.isHidden = true
        if "Country" == basicInfo[indexPath.row]{
            
            cell.contentView.insertSubview(cell.selectBtn, aboveSubview: cell.rotateVw)
            cell.selectBtn.isHidden = false
            cell.selectBtn.tag = 2
            cell.codeBtnWidth.constant = 0
            cell.widthImg.constant = 0
            cell.mobileCodeWidth.constant = 0
            cell.genderHorizantal.constant = 0
            cell.genderWidth.constant = 0
            cell.selectBtn.addTarget(self, action: #selector(selectCityCountry(_:)), for: .touchUpInside)
            cell.headingLbl.isUserInteractionEnabled = false
            cell.headingLbl.text = agentInfo.country
        }
        if "City" == basicInfo[indexPath.row]{
            cell.contentView.insertSubview(cell.selectBtn, aboveSubview: cell.rotateVw)
            cell.selectBtn.isHidden = false
            cell.selectBtn.tag = 3
            cell.genderHorizantal.constant = 0
            cell.codeBtnWidth.constant = 0
            cell.widthImg.constant = 0
            cell.mobileCodeWidth.constant = 0
            cell.genderWidth.constant = 0
            cell.selectBtn.addTarget(self, action: #selector(selectCityCountry(_:)), for: .touchUpInside)
            cell.headingLbl.isUserInteractionEnabled = false
            cell.headingLbl.text = agentInfo.city
        }
        
        
        if "Mobile Number" == basicInfo[indexPath.row]{
            cell.genderView.isHidden = true
            cell.selectBtn.isHidden = true
            cell.mobileCode.text = agentInfo.mobileCode
            cell.headingLbl.text = agentInfo.mobileNo
            cell.codeBtn.tag = 1099
            cell.codeBtn.addTarget(self, action: #selector(codeClicked(_:)), for: .touchUpInside)
            cell.headingLbl.delegate = self
            cell.flagImg.sd_setImage(with: URL(string: agentInfo.mobileFlag), placeholderImage: UIImage(named: "productplaceholder"))
            cell.widthImg.constant = 20
            cell.flagImg.isHidden = false
            cell.codeBtn.isHidden = false
            cell.codeBtnWidth.constant = 22
            cell.mobileCode.isHidden = false
            cell.mobileCodeWidth.constant = 30
            cell.headingLbl.delegate = self
            cell.headingLbl.tag = 3000
            cell.codeBtn.isHidden = false
            
            cell.headingLbl.keyboardType = .phonePad
            
        }
        
        if "Maroof Link" ==  basicInfo[indexPath.row]{
            
            cell.headingLbl.tag = 500
            cell.headingLbl.delegate = self
            cell.headingLbl.text = agentInfo.maroof
            cell.codeBtnWidth.constant = 0
            cell.widthImg.constant = 0
            cell.mobileCodeWidth.constant = 0
            cell.headingLbl.keyboardType = .asciiCapableNumberPad
           
        }
        if "Business Name" == basicInfo[indexPath.row]{
            cell.headingLbl.tag = 0
            cell.headingLbl.delegate = self
            cell.headingLbl.text = agentInfo.businessName
        }
        if indexPath.row == 0{
            
            
        }else if indexPath.row == 2{
            
            
        }else if indexPath.row == 3{
            
            
        }else if indexPath.row == 4{
            
            
        }else if indexPath.row == 5{
            cell.mobileCode.text = agentInfo.phCode
            cell.headingLbl.text = agentInfo.phoneNo
            cell.codeBtn.tag = 1098
            cell.codeBtn.addTarget(self, action: #selector(codeClicked(_:)), for: .touchUpInside)
            cell.flagImg.sd_setImage(with: URL(string: agentInfo.phFlag), placeholderImage: UIImage(named: "productplaceholder"))
            cell.headingLbl.delegate = self
            cell.widthImg.constant = 20
            cell.flagImg.isHidden = false
            cell.codeBtn.isHidden = false
            cell.codeBtnWidth.constant = 22
            cell.mobileCode.isHidden = false
            cell.mobileCodeWidth.constant = 30
            cell.headingLbl.tag = 3001
            cell.codeBtn.isHidden = false
            
            cell.headingLbl.keyboardType = .phonePad
            
        }else if indexPath.row == 6{
            
        }
        
        if "Email" == basicInfo[indexPath.row]{
            
            //  cell.contentView.insertSubview(cell.rotateVw, aboveSubview:cell.selectBtn )
            cell.headingLbl.tag = 100
            cell.headingLbl.isHidden = false
            cell.codeBtnWidth.constant = 0
            cell.widthImg.constant = 0
            cell.mobileCodeWidth.constant = 0
            cell.selectBtn.isHidden = true
            
            cell.headingLbl.delegate = self
            //            cell.headingLbl.tag = 1
            //            print(agentInfo.Email)
            //            cell.headingLbl.text = agentInfo.Email
            //            cell.headingLbl.isHidden = false
            //            cell.contentView.insertSubview(cell.rotateVw, aboveSubview:cell.selectBtn )
            cell.headingLbl.text = agentInfo.Email
            
        }
        return cell
    }
    func VatCell(indexPath : IndexPath) -> UITableViewCell{
        if indexPath.row == 0{
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
            cell.genderView.isHidden = true
            cell.isUserInteractionEnabled = false
                       if isEdit
                       {
                           cell.isUserInteractionEnabled = true
                       }
            let vt = "VAT Number".localized;
            cell.entryLbl.attributedText = ModalController.setprofileStricColor(str: "\(vt) *", str1: vt, str2:" *" )
            cell.flagImg.isHidden = true
            cell.mobileCode.isHidden = true
            cell.mobileCodeWidth.constant = 0
            cell.widthImg.constant = 0
            cell.codeBtn.isHidden = true
            cell.codeBtnWidth.constant = 0
            cell.headingLbl.keyboardType = .default
            cell.headingLbl.isHidden = false
            cell.headingLbl.text = agentInfo.vatNo
            cell.genderWidth.constant = 0
            cell.genderHorizantal.constant = 0
            cell.headingLbl.isUserInteractionEnabled = false
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileVatTableViewCell",for: indexPath) as! ProfileVatTableViewCell
            cell.imgView.image = self.pdfImage
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.vatcertlbl.text = "Vat Certificate".localized
            if isEdit
            {
            cell.isUserInteractionEnabled = true
             }
            if pdfVat != "" {
                cell.addIon.isHidden = true
                cell.addText.isHidden = true
                
            }else{
                cell.addIon.isHidden = false
                cell.addText.isHidden = false
            }
            return cell
        }
    }
}

extension UserProfileDetailsViewController : ProfileDetailTableViewCellDelegate{
    func edit() {
        isEdit = !isEdit

        tableVw.reloadData()
    }
    
    func followersClicked() {
        
    }
    
    func branchesClicked() {
        
    }
    
    func productsClicked() {
        
    }
    
    func likesClicked() {
        
    }
        
}

extension UserProfileDetailsViewController:SearchCategoryViewControllerDelegate{
    func selectedCountryCodeMethod(mobileCodeDict: NSMutableDictionary) {
        if ismobile {
            print(mobileCodeDict)
            agentInfo.mobileNo = ""
            agentInfo.mobileCode = mobileCodeDict.value(forKey: "mobile_code") as! String
            agentInfo.mobileFlag = mobileCodeDict.value(forKey: "country_flag") as! String
            agentInfo.mobileLength = mobileCodeDict.value(forKey: "mobile_length") as! Int
        }else{
            agentInfo.phoneNo = ""
            agentInfo.phCode = mobileCodeDict.value(forKey: "mobile_code") as! String
            agentInfo.phFlag = mobileCodeDict.value(forKey: "country_flag") as! String
            agentInfo.phoneLength = mobileCodeDict.value(forKey: "mobile_length") as! Int
        }
        tableVw.reloadData()
    }
    
    func selectPhoneCodeMethod(phoneCodeDict: NSMutableDictionary) {
    }
    
    func selectedCountryCode(countryCode: NSMutableDictionary) {
        if ismobile {
            print(countryCode)
            agentInfo.mobileNo = ""
            agentInfo.mobileCode = countryCode.value(forKey: "mobile_code") as! String
            agentInfo.mobileFlag = countryCode.value(forKey: "country_flag") as! String
            agentInfo.mobileLength = countryCode.value(forKey: "mobile_length") as! Int
        }else{
            agentInfo.phoneNo = ""
            agentInfo.phCode = countryCode.value(forKey: "mobile_code") as! String
            agentInfo.phFlag = countryCode.value(forKey: "country_flag") as! String
            agentInfo.phoneLength = countryCode.value(forKey: "mobile_length") as! Int
        }
        tableVw.reloadData()

    }
    
    func selectedCategoryMethod(countryDict: NSMutableDictionary, tag: Int) {
        
        if countryDict.count != 0{
            selectedCityDict.removeAllObjects()
            selectedCountryDict = countryDict
            agentInfo.country = selectedCountryDict.value(forKey: "country_name") as! String
            agentInfo.countryId = Int(selectedCountryDict.value(forKey: "country_id")! as! NSNumber)
            agentInfo.city = ""
            
        }
        print("countryDict",countryDict)
        print(selectedCountryDict)
      
        tableVw.reloadData()
    }
    
    func selectedCityMethod(cityDict: NSMutableDictionary) {
        if cityDict.count != 0{
            selectedCityDict = cityDict
            agentInfo.cityId = Int((selectedCityDict.value(forKey: "city_id")! as! NSNumber))
            agentInfo.city=(selectedCityDict.value(forKey: "city_name") as? String)!
            
        }
        tableVw.reloadData()
    }
    
    func selectedEducationMethod(educationDict: NSMutableDictionary) {
       print(educationDict)
        
        selectedEducation = educationDict
        agentInfo.education = educationDict.object(forKey: "education_type") as! String
        agentInfo.educationId = educationDict.object(forKey: "education_id") as! Int
       // agentInfo.major = ""
        tableVw.reloadData()
        
        
    }
    
    func selectedMajorEducationMethod(educationDict: NSMutableDictionary) {
        agentInfo.major =  educationDict.object(forKey: "education_major") as! String
        agentInfo.majorId =  educationDict.object(forKey: "education_major_id") as! Int
        tableVw.reloadData()
    }
    
    func selectedCurrency(currency: NSMutableDictionary) {
        
        
    }
    
    func selectedBankMethod(bankDict: NSMutableDictionary) {
        
    }
    
    func selectetCourierCompanyMethod(courierCompanyDict: NSMutableDictionary) {
        
    }
    func selectetBranchMethod(BranchDict : NSMutableDictionary){
        
    }
    
}


extension UserProfileDetailsViewController : UITextFieldDelegate{

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        
        if textField.tag == 0 || textField.tag == 1 || textField.tag == 2{
            let allowedCharecter = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            let allowedCharacter1 = CharacterSet.whitespaces
            
            return allowedCharecter.isSuperset(of: characterSet) || allowedCharacter1.isSuperset(of: characterSet)
        }
        if textField.tag == 100{
            return false
        }
            
        if textField.tag == 500{
            let textStr = "https://www.maroof.com/"
            
            if range.location < textStr.count
            {
                return false
            }
            if textField.text == textStr  && range.length == 1 {
                return false
            }
            return true
        }
            
        
        if textField.tag == 1000{
            if agentInfo.bankname == ""{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Enter Iban No First...")
                return false
            }else{
                return true
            }
        }
            
      if textField.tag == 1002{
            let currentCount =  textField.text!.count
            let textCount = textField.text?.replacingOccurrences(of: " ", with: "").count
            let val = currentCount-textCount!
            
            
            let str = textField.text
            
       
            
            guard let stringRange = Range(range,in: str!) else{
                return false
            }
            let updateText =  str!.replacingCharacters(in: stringRange, with: string)
            return (updateText.count) <= agentInfo.ibanLenght
        }
            
        if textField.tag == 3000{
            let currentCount =  textField.text!.count
            print(currentCount,"currentCount")
            let textCount = textField.text?.replacingOccurrences(of: " ", with: "").count
            let val = currentCount-textCount!
            print(val,"val")
            
            let str = textField.text
            
            print(agentInfo.mobileLength)
            
            guard let stringRange = Range(range,in: str!) else{
                return false
            }
            let updateText =  str!.replacingCharacters(in: stringRange, with: string)
            return (updateText.count) < agentInfo.mobileLength+val+1
        }
        
        if textField.tag == 3001{
            let currentCount =  textField.text!.count
            let textCount = textField.text?.replacingOccurrences(of: " ", with: "").count
            let val = currentCount-textCount!
            
            
            let str = textField.text
            
            
            
            guard let stringRange = Range(range,in: str!) else{
                return false
            }
            let updateText =  str!.replacingCharacters(in: stringRange, with: string)
            return (updateText.count) < agentInfo.phoneLength+val+1
        }
              
            
        if textField.tag == 3001{
            return true
        }
        else{
            return true
        }
        
    }
    
    @objc func textFieldDidChange(textField: UITextField){
//        textField.textAlignment =  ("\(textField.text!.first)".isArabic ? .right:.left)
        switch textField.tag  {
        case 9997:
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
                return
            }else{
                 myString = textField.text!
                agentInfo.name = myString.trimmingCharacters(in: .whitespacesAndNewlines)
                print("name",agentInfo.name)
            }
            //agentInfo.businessName = textField.text!
//            agentInfo.name = textField.text!
            
        case 9998:
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validMiddleName)
                return
            }else{
                 myString = textField.text!
                agentInfo.middle_name = myString.trimmingCharacters(in: .whitespacesAndNewlines)
                print("middlename",agentInfo.middle_name)
            }
//            agentInfo.middle_name = textField.text!
        case 9999   :
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
                return
            }else{
                 myString = textField.text!
                agentInfo.last_name = myString.trimmingCharacters(in: .whitespacesAndNewlines)
                print("lastname",agentInfo.last_name)
            }
//            agentInfo.last_name = textField.text!
        case 100:
            agentInfo.Email = textField.text!
        case 500:
            agentInfo.maroof = textField.text!
            
        case 1002:
            agentInfo.iban = textField.text!
            
            if textField.text!.count == 2{
                getIbanLength(str: textField.text!)
            }
            
            if textField.text!.count == 4{
                getBankDetail(str: textField.text!)
                
            }
            
        case 1000:
            
            agentInfo.bankname = textField.text!
           
            
        case 3000:
            if mobilNoo != ""{
                value = textField.text!
                mobilNoo = value.replacingOccurrences(of: " ", with: "")
                value = customStringFormatting(of: mobilNoo)
                
            }else{
                
                value = customStringFormatting(of: textField.text!)
                mobilNoo = value.replacingOccurrences(of: " ", with: "")
                
            }
                       
                       agentInfo.mobileNo = value
               
            textField.text = value
            
            
        case 3001:
            if  phNoo != ""{
                phVAL = textField.text!
                phNoo = phVAL.replacingOccurrences(of: " ", with: "")
                phVAL = customStringFormatting(of: phNoo)
                
            }else{
                
                phVAL = customStringFormatting(of: textField.text!)
                phNoo = phVAL.replacingOccurrences(of: " ", with: "")
                
            }
                       
                       agentInfo.phoneNo = phVAL
               
            textField.text = phVAL
            case 1001:
                    agentInfo.cardHolderName = textField.text!
        default:
            print("hhj")
        }
        
    }
    func customStringFormatting(of str: String) -> String {
           return str.chunk(n: 3)
               .map{ String($0) }.joined(separator: " ")
       }
}
extension UserProfileDetailsViewController : ProfileNameTableViewCellDelegate,OpenGalleryDelegate,DiscountTypePopUpViewControllerDelegate{
    func gallery(img: UIImage, imgtype: String) {
          SectImage = img
              UploadProfileImage_API()
    }
    func UploadProfileImage_API()
     {
     let str = "\(Constant.BASE_URL)\(Constant.UpdateProfile_Image)"
    
    let param = [
     "user_id":"\(Singleton.shared.getUserId())",
        "lang_code":HeaderHeightSingleton.shared.LanguageSelected
     ]
     
     
     ModalClass.startLoading(self.view)
     ServerCalls.fileUploadAPINew(inputUrl: str, parameters: param, imageName: "image", imageFile: SectImage!) { (response, success, resp) in
     
     ModalClass.stopLoading()
         if let value = response as? NSDictionary{
             let msg = value.object(forKey: "error_description") as! String
             let error = value.object(forKey: "error_code") as! Int
            if error == 100{
                ModalController.showNegativeCustomAlertWith(title:" Error", msg: msg)
            }else{
                ModalController.showSuccessCustomAlertWith(title:"", msg: msg)
                AuthorisedUser.shared.user?.data?.profile_image = value.object(forKey: "user_photo")  as! String
                self.getProfileData()
                
            }
         }
         else{
             ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
         }
     }
     
     }
    func editImage() {
        
        
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

    }
    
    func selectedDiscountOption(str: String) {
        OpenGallery.shared.delegate = self
        OpenGallery.shared.viewControl = self
        if str == "Camera".localized {
            OpenGallery.shared.openCamera()
            
        }else if str == "Device Gallery".localized {
            OpenGallery.shared.openGallery()
            
        }
    }
}
