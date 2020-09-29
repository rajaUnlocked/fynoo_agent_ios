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

class UserProfileDetailsViewController: UIViewController ,VatPopupNewViewControllerDelegate{
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
        tableVw.reloadData()
        print("dgd")
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

    var personalDetail = ["Name","Gender","Dob","Education","Major"]
    var basicInfo = ["Business Name","Email","Country","City","Mobile Number","Phone Number","Maroof Link"]
    var bankDetail = ["Bank Name","Card Holder Name","IBAN Number"]
    var sectionHeading = ["","Service","Basic Information","Bank Detail","Vat Information","Password Information","Language Information"]
    var pdfVat = ""

    var selectedCountryDict : NSMutableDictionary = NSMutableDictionary()
    var selectedCityDict : NSMutableDictionary = NSMutableDictionary()

    override func viewDidLoad() {
        
        tableVw.register(UINib(nibName: "ProfileNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileNameTableViewCell");
        tableVw.register(UINib(nibName: "ProfileDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileDetailTableViewCell");
        tableVw.register(UINib(nibName: "ProfileEnteriesTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileEnteriesTableViewCell");
        tableVw.register(UINib(nibName: "ProfileVatTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileVatTableViewCell");
        tableVw.register(UINib(nibName: "ProfileServiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileServiceTableViewCell");
        tableVw.register(UINib(nibName: "TwoButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "TwoButtonsTableViewCell");

        if isPersonal{
            basicInfo = ["Email","Country","City","Mobile Number","Maroof Link"]
            sectionHeading = ["","Service","Personal Information","Basic Information","Bank Detail","Vat Information","Password Information","Language Information"]
        }


        headerView.titleHeader.text = "Profile"
        getProfileData()
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
    @objc func saveChange(){
        
        
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
        if pdfVat != agentInfo.vatCertificate{
            isvatUpload = 1
        }
        agentInfo.vatNo = agentInfo.vatNo.replacingOccurrences(of: " ", with: "")
        
            print(ACTIVATION)
        let mobile = agentInfo.mobileNo.replacingOccurrences(of: " ", with: "")
        let phone = agentInfo.phoneNo.replacingOccurrences(of: " ", with: "")
        let parameter = ["user_id":"1060","lang_code":"EN","user_type":"AI","service_id":ACTIVATION,"name":agentInfo.name,"email":agentInfo.Email,"country_id":agentInfo.countryId,"dob":self.agentInfo.dob,"city_id":agentInfo.cityId,"mobile_code":agentInfo.mobileCode,"mobile_number":mobile,"phone_code":agentInfo.phCode,"phone_number":phone,"maroof_link":last,"bank_details_id":agentInfo.bankId,"bank_id":agentInfo.bankId,"bank_name":agentInfo.bankname,"card_holder_name":agentInfo.cardHolderName,"iban_no":agentInfo.iban,"vat_no":agentInfo.vatNo,"password":"","education_id":agentInfo.educationId,"major_id":agentInfo.majorId,"is_vat_upload":"\(isvatUpload)"] as [String : Any]
        
        print(parameter)
        
        
        ModalClass.startLoading(self.view)
        ServerCalls.PdfFileUpload(inputUrl: Service.updateProfile, parameters: parameter, pdfname: "vat_certificate", pdfurl: pdfVat) { (response, success, resp) in
            ModalClass.stopLoading()
            if success{
                
                self.isEdit = false
                self.tableVw.reloadData()
                print(response)
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
                }
                
            }
            
            
        }
    }
    
    
    
    @objc func selectCityCountry(_ tag: UIButton){
        if isEdit{
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
        
        
    }
    
    func getProfileData(){
        let parameter = ["user_id":"1060",
        "lang_code":"EN"]
        ServerCalls.postRequest(Service.getProfile, withParameters: parameter) { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        
//                        self.agentInfo.serviceArr = (value.object(forKey: "data") as! NSDictionary).object(forKey: "service_list_data") as! NSArray as! NSMutableArray
//
//
                        print(self.agentInfo.serviceArr.count,"services")
                        
                        self.profileInfo  = Mapper<ProfileModal>().map(JSON: body)
                        self.agentInfo.businessName = self.profileInfo?.data?.user_data?.business_name ?? ""
                            let val = self.profileInfo?.data?.service_list_data?.count
                        
                        for i in 0..<val!{
                            self.agentInfo.serviceArr.add( self.profileInfo?.data?.service_list_data?[i].service_id ?? 0)
                        }
                        let lang = self.profileInfo?.data?.language_list?.count
                        for i in 0..<lang!{
                            print(self.profileInfo?.data?.language_list?[i].lang_name ?? 0,"jldkj")
                            self.agentInfo.langArr.add(self.profileInfo?.data?.language_list?[i].lang_name ?? 0)
                        }
                        
                        print(self.agentInfo.langArr)
                                                
                       
                        self.agentInfo.name = self.profileInfo?.data?.user_data?.name ?? ""
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
                        
                        
                        self.agentInfo.phCode = self.profileInfo?.data?.user_data?.phone_code ?? ""
                        self.agentInfo.phFlag = self.profileInfo?.data?.user_data?.phone_flag ?? ""
                        self.agentInfo.maroof = "https://www.maroof.com/"
                        self.agentInfo.maroof +=  self.profileInfo?.data?.user_data?.maroof_link ?? ""
                        self.agentInfo.bankname = self.profileInfo?.data?.user_data?.bank_name ?? ""
                        self.agentInfo.cardHolderName = self.profileInfo?.data?.user_data?.ac_holder_name ?? ""
                        self.agentInfo.ibanLenght = 24
                        self.agentInfo.bankId = self.profileInfo?.data?.user_data?.bank_id ?? 0
                        self.agentInfo.iban = self.profileInfo?.data?.user_data?.iban_no ?? ""
                        print(self.profileInfo?.data?.user_data?.account_iban_nbr ?? "","kjkjkjjkj")
                        let vals = self.profileInfo?.data?.user_data?.vat_no ?? ""
                        self.agentInfo.vatNo =  self.customStringFormatting(of: vals)

                        
                        self.pdfVat = self.profileInfo?.data?.user_data?.vat_certificate ?? ""
                        
                        self.agentInfo.gender = self.profileInfo?.data?.user_data?.gender ?? ""
                        self.agentInfo.dob = self.profileInfo?.data?.user_data?.dob ?? ""

                        self.agentInfo.education = self.profileInfo?.data?.user_data?.education ?? ""
                        self.agentInfo.educationId = self.profileInfo?.data?.user_data?.education_new ?? 0

                        self.agentInfo.major = self.profileInfo?.data?.user_data?.education_major ?? ""
                        self.agentInfo.majorId = self.profileInfo?.data?.user_data?.education_major_id ?? 0

                        self.agentInfo.mobileFlag = self.profileInfo?.data?.user_data?.mobile_flag ?? ""
                        
                        self.agentInfo.mobileLength = self.profileInfo?.data?.user_data?.mobile_length ?? 0
                        
                        self.agentInfo.phoneLength = self.profileInfo?.data?.user_data?.phone_length ?? 0

                        self.agentInfo.dob = self.profileInfo?.data?.user_data?.dob ?? ""
                        
                        if self.pdfVat != ""{
                            let url = URL(string: self.pdfVat)
                            //self.pdfImage = self.pdfThumbnail(url: url!)!
                        }else{
                            self.pdfImage = UIImage(named:"dottedrectangle")!
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

extension UserProfileDetailsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if isPersonal {
            
            if indexPath.section == 2{
                if indexPath.row == 2{
                    let curr_date = Calendar.current.date(byAdding: .year, value: 0, to: Date())
                    
                    
                    
                    
                 
                    DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate: nil, datePickerMode: .dateAndTime) {
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
            }
            
        }
        
        if indexPath.section == 4{
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
        
        
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0{
            return UIView()
        }else{
            let view = SectionHeader()
            view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 40)
            view.sectionText.text = sectionHeading[section]
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
                    return 100
                }else{
                    return 127
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
                cell.profileImage.sd_setImage(with: URL(string:self.profileInfo!.data?.user_data?.profile_image ?? ""), placeholderImage: UIImage(named: "profile_white"))

                return cell
                
            }else{
                let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileDetailTableViewCell",for: indexPath) as! ProfileDetailTableViewCell
                cell.delegate = self
                
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
            cell.save.addTarget(self, action: #selector(saveChange), for: .touchUpInside)
            cell.cancel.addTarget(self, action: #selector(cancel), for: .touchUpInside)
            return cell
        }else{
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileServiceTableViewCell",for: indexPath) as! ProfileServiceTableViewCell
            cell.agentinfo = self.agentInfo

            cell.viewControl = self
            cell.languageList = self.profileInfo?.data?.language_list
            cell.isForLanguage = true
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func passwordCell(indexPath:IndexPath) -> UITableViewCell{
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
        cell.entryLbl.attributedText = ModalController.setStricColor(str: "Password *", str1: "Password", str2:" *" )
        
        cell.headingLbl.text = "* * * * * * * *"
        cell.headingLbl.isUserInteractionEnabled = false
        return cell
    }
    
    func personalCell(indexPath : IndexPath) -> UITableViewCell{
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
       cell.entryLbl.attributedText = ModalController.setStricColor(str: "\(personalDetail[indexPath.row]) *", str1: "\(personalDetail[indexPath.row])", str2:" *" )
        
        
        if indexPath.row == 0{
            cell.headingLbl.text = agentInfo.name
            
        }else if indexPath.row == 1{
            cell.headingLbl.text = agentInfo.gender
        }
        else if indexPath.row == 2 {
            cell.headingLbl.text = agentInfo.dob
            
        }
        else if indexPath.row == 3{
            cell.headingLbl.text = agentInfo.education
        }
        else if indexPath.row == 4{
            cell.headingLbl.text = agentInfo.major
        }
        return cell
        
    }
    func BankDetailCell(indexPath : IndexPath) -> UITableViewCell{
        
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
        cell.entryLbl.attributedText = ModalController.setStricColor(str: "\(bankDetail[indexPath.row]) *", str1: "\(bankDetail[indexPath.row])", str2:" *" )
        cell.headingLbl.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        cell.headingLbl.isHidden = false
        cell.codeBtnWidth.constant = 0
        cell.widthImg.constant = 0
        cell.mobileCodeWidth.constant = 0
        cell.selectBtn.isHidden = true
        cell.headingLbl.isUserInteractionEnabled = true
        
        if indexPath.row == 0{
            
            cell.headingLbl.text = agentInfo.bankname
            cell.headingLbl.tag = 1000
            cell.headingLbl.delegate=self
        }else if indexPath.row == 1{
            cell.headingLbl.tag = 1001
            cell.headingLbl.text = agentInfo.cardHolderName
        }else if indexPath.row == 2{
            cell.headingLbl.tag = 1002
            cell.headingLbl.delegate = self
            cell.headingLbl.text = agentInfo.iban
            cell.headingLbl.delegate = self
            cell.headingLbl.isHidden = false
            cell.codeBtnWidth.constant = 0
            cell.widthImg.constant = 0
            cell.mobileCodeWidth.constant = 0
            cell.selectBtn.isHidden = true
        }
        return cell
    }
    @objc func codeClicked(_ sender : UIButton){
        
        if sender.tag == 1098{
            let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
            vc.delegate = self
            ismobile = false
    //        vc.isForCounrtyCode = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
            vc.delegate = self
            ismobile = true
    //        vc.isForCounrtyCode = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
    }
    func BasicInfoCell(indexPath : IndexPath) -> UITableViewCell{
        
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
        
        cell.headingLbl.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)

        
        cell.contentView.insertSubview(cell.rotateVw, aboveSubview:cell.selectBtn )
        cell.widthImg.constant = 0
        cell.flagImg.isHidden = true
        if isEdit{
            cell.headingLbl.isUserInteractionEnabled = true
        }else{
            cell.headingLbl.isUserInteractionEnabled = false
            
        }
        cell.entryLbl.attributedText = ModalController.setStricColor(str: "\(basicInfo[indexPath.row]) *", str1: "\(basicInfo[indexPath.row])", str2:" *" )
        
        print(basicInfo[indexPath.row],"sd")
        if "Email" == basicInfo[indexPath.row]{
            cell.contentView.insertSubview(cell.rotateVw, aboveSubview:cell.selectBtn )
            cell.headingLbl.tag = 5
            cell.headingLbl.delegate = self
            cell.headingLbl.isHidden = false
            cell.codeBtnWidth.constant = 0
            cell.widthImg.constant = 0
            cell.mobileCodeWidth.constant = 0
            cell.selectBtn.isHidden = true

            
            //            cell.headingLbl.tag = 1
            //            print(agentInfo.Email)
            //            cell.headingLbl.text = agentInfo.Email
            //            cell.headingLbl.isHidden = false
            //            cell.contentView.insertSubview(cell.rotateVw, aboveSubview:cell.selectBtn )
            cell.headingLbl.text = agentInfo.Email

        }
        if "Country" == basicInfo[indexPath.row]{
            cell.contentView.insertSubview(cell.selectBtn, aboveSubview: cell.rotateVw)
            cell.selectBtn.isHidden = false
            cell.selectBtn.tag = 2
            cell.selectBtn.addTarget(self, action: #selector(selectCityCountry(_:)), for: .touchUpInside)
            cell.headingLbl.isUserInteractionEnabled = false
            cell.headingLbl.text = agentInfo.country
        }
        if "City" == basicInfo[indexPath.row]{
            cell.contentView.insertSubview(cell.selectBtn, aboveSubview: cell.rotateVw)
            cell.selectBtn.isHidden = false
            cell.selectBtn.tag = 3
            cell.selectBtn.addTarget(self, action: #selector(selectCityCountry(_:)), for: .touchUpInside)
            cell.headingLbl.isUserInteractionEnabled = false
            cell.headingLbl.text = agentInfo.city
        }
        
        
        if "Mobile Number" == basicInfo[indexPath.row]{
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
        }
        
        if "Maroof Link" ==  basicInfo[indexPath.row]{
            cell.headingLbl.tag = 5
            cell.headingLbl.delegate = self
            cell.headingLbl.text = agentInfo.maroof
            cell.codeBtnWidth.constant = 0
            cell.widthImg.constant = 0
            cell.mobileCodeWidth.constant = 0

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
        }else if indexPath.row == 6{
         
        }
        
        return cell
    }
    func VatCell(indexPath : IndexPath) -> UITableViewCell{
        if indexPath.row == 0{
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
            cell.entryLbl.attributedText = ModalController.setStricColor(str: "VAT Number *", str1: "VAT Number", str2:" *" )
            cell.flagImg.isHidden = true
            cell.mobileCode.isHidden = true
            cell.mobileCodeWidth.constant = 0
            cell.widthImg.constant = 0
            cell.codeBtn.isHidden = true
            cell.codeBtnWidth.constant = 0
            cell.headingLbl.keyboardType = .default
            cell.headingLbl.isHidden = false
            cell.headingLbl.text = agentInfo.vatNo
            cell.headingLbl.isUserInteractionEnabled = false
            return cell
        }else{
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileVatTableViewCell",for: indexPath) as! ProfileVatTableViewCell
            cell.imgView.image = self.pdfImage

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
      
        
    }
    
    func selectedCityMethod(cityDict: NSMutableDictionary) {
        if cityDict.count != 0{
            selectedCityDict = cityDict
            agentInfo.cityId = Int((selectedCityDict.value(forKey: "city_id")! as! NSNumber))
            agentInfo.city=(selectedCityDict.value(forKey: "city_name") as? String)!
            
        }
    }
    
    func selectedEducationMethod(educationDict: NSMutableDictionary) {
        
    }
    
    func selectedMajorEducationMethod(educationDict: NSMutableDictionary) {
        
    }
    
    func selectedCurrency(currency: NSMutableDictionary) {
        
    }
    
    func selectedBankMethod(bankDict: NSMutableDictionary) {
        
    }
    
    func selectetCourierCompanyMethod(courierCompanyDict: NSMutableDictionary) {
        
    }
    
}


extension UserProfileDetailsViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField.tag == 0{
            let allowedCharecter = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            let allowedCharacter1 = CharacterSet.whitespaces
            
            return allowedCharecter.isSuperset(of: characterSet) || allowedCharacter1.isSuperset(of: characterSet)
        }
            
        if textField.tag == 5{
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
            return (updateText.count) < agentInfo.ibanLenght+val+5
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
        
        switch textField.tag  {
        case 0:
            
            agentInfo.businessName = textField.text!
            
            
            
        case 1:
            agentInfo.Email = textField.text!
            
        case 5:
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
extension UserProfileDetailsViewController : ProfileNameTableViewCellDelegate,OpenGalleryDelegate{
    func gallery(img: UIImage, imgtype: String) {
          SectImage = img
              UploadProfileImage_API()
    }
    func UploadProfileImage_API()
     {
     let str = "\(Constant.BASE_URL)\(Constant.UpdateProfile_Image)"
    
    let param = [
     "user_id":"1106"
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
                 AuthorisedUser.shared.user?.data?.profile_image = ((value.object(forKey: "data") as! NSDictionary).object(forKey: "image_url") as! String)
               
                 self.getProfileData()
                 
             }
         }
         else{
             ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
         }
     }
     
     }
    func editImage() {
        OpenGallery.shared.delegate = self
        OpenGallery.shared.viewControl = self
        let alert = UIAlertController(title: "", message: "Choose Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            
            OpenGallery.shared.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Galley", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
            
            OpenGallery.shared.viewControl = self
            OpenGallery.shared.openGallery()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
}