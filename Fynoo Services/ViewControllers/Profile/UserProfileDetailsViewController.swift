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
    
    func cancel() {
        isEdit = false
        tableVw.reloadData()
        print("dgd")
    }
    
  
    
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
        
        print(ACTIVATION)
        let parameter = ["user_id":"1075","lang_code":"EN","user_type":"AC","service_id":ACTIVATION,"name":agentInfo.businessName,"email":agentInfo.Email,"country_id":agentInfo.countryId,"dob":"","city_id":agentInfo.cityId,"mobile_code":agentInfo.mobileCode,"mobile_number":agentInfo.mobileNo,"phone_code":agentInfo.phCode,"phone_number":agentInfo.phoneNo,"maroof_link":agentInfo.maroof,"bank_details_id":agentInfo.bankId,"bank_name":agentInfo.bankname,"card_holder_name":agentInfo.cardHolderName,"iban_no":agentInfo.iban,"vat_no":agentInfo.vatNo,"password":"","education_id":"","major_id":""] as [String : Any]
        
        print(parameter)
        ModalClass.startLoading(self.view)
        let pfurl=URL(string:pdfVat)!
        ServerCalls.PdfFileUpload(inputUrl: Service.updateProfile, parameters: parameter, pdfname: "vat_certificate", pdfurl: pfurl) { (response, success, resp) in
            ModalClass.stopLoading()
            if success{
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
        let parameter = ["user_id":"1075",
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
                                                
                       

                        self.agentInfo.Email = self.profileInfo?.data?.user_data?.email ?? ""
                        self.agentInfo.country = self.profileInfo?.data?.user_data?.country ?? ""
                        self.agentInfo.countryId = self.profileInfo?.data?.user_data?.country_id ?? 0
                        self.agentInfo.city = self.profileInfo?.data?.user_data?.city ?? ""
                        self.agentInfo.cityId = self.profileInfo?.data?.user_data?.city_id ?? 0
                        self.agentInfo.Email = self.profileInfo?.data?.user_data?.email ?? ""
                        self.agentInfo.mobileNo = self.profileInfo?.data?.user_data?.mobile_number ?? ""
                        self.agentInfo.mobileCode = self.profileInfo?.data?.user_data?.mobile_code ?? ""
                        self.agentInfo.phoneNo = self.profileInfo?.data?.user_data?.phone_number ?? ""
                        self.agentInfo.phCode = self.profileInfo?.data?.user_data?.phone_code ?? ""
                        self.agentInfo.maroof = "https://www.maroof.com/"
                        self.agentInfo.maroof +=  self.profileInfo?.data?.user_data?.maroof_link ?? ""
                        self.agentInfo.bankname = self.profileInfo?.data?.user_data?.bank_name ?? ""
                        self.agentInfo.cardHolderName = self.profileInfo?.data?.user_data?.ac_holder_name ?? ""
                        
                        self.agentInfo.bankId = self.profileInfo?.data?.user_data?.bank_id ?? 0
                        self.agentInfo.iban = self.profileInfo?.data?.user_data?.iban_no ?? ""
                        print(self.profileInfo?.data?.user_data?.account_iban_nbr ?? "","kjkjkjjkj")
                        self.agentInfo.vatNo = self.profileInfo?.data?.user_data?.vat_no ?? ""
                        self.pdfVat = self.profileInfo?.data?.user_data?.vat_certificate ?? ""
                        
                        
                        
                        if self.pdfVat != ""{
                            let url = URL(string: self.pdfVat)
                            self.pdfImage = self.pdfThumbnail(url: url!)!
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
        
        
        if indexPath.section == 5{
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
            return cell
        }else{
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileServiceTableViewCell",for: indexPath) as! ProfileServiceTableViewCell

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
        return cell
        
    }
    func BankDetailCell(indexPath : IndexPath) -> UITableViewCell{
        
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
        cell.entryLbl.attributedText = ModalController.setStricColor(str: "\(bankDetail[indexPath.row]) *", str1: "\(bankDetail[indexPath.row])", str2:" *" )
        cell.headingLbl.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
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
        }
        return cell
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
        if indexPath.row == 0{
            cell.headingLbl.tag = 0
            cell.headingLbl.delegate = self
            cell.headingLbl.text = agentInfo.businessName
            
        }else if indexPath.row == 1{
            cell.headingLbl.tag = 1
            cell.headingLbl.text = agentInfo.Email
            
        }else if indexPath.row == 2{
            cell.contentView.insertSubview(cell.selectBtn, aboveSubview: cell.rotateVw)
            cell.selectBtn.isHidden = false
            cell.selectBtn.tag = 2
            cell.selectBtn.addTarget(self, action: #selector(selectCityCountry(_:)), for: .touchUpInside)
            cell.headingLbl.isUserInteractionEnabled = false
            cell.headingLbl.text = agentInfo.country
            
        }else if indexPath.row == 3{
            cell.contentView.insertSubview(cell.selectBtn, aboveSubview: cell.rotateVw)
            cell.selectBtn.isHidden = false
            cell.selectBtn.tag = 3
            cell.selectBtn.addTarget(self, action: #selector(selectCityCountry(_:)), for: .touchUpInside)
            cell.headingLbl.isUserInteractionEnabled = false
            cell.headingLbl.text = agentInfo.city
            
        }else if indexPath.row == 4{
            cell.mobileCode.text = agentInfo.mobileCode
            cell.headingLbl.text = agentInfo.mobileNo
            cell.widthImg.constant = 20
            cell.flagImg.isHidden = false
            cell.codeBtn.isHidden = false
            cell.codeBtnWidth.constant = 22
            cell.mobileCode.text = "+91"
            cell.mobileCode.isHidden = false
            cell.mobileCodeWidth.constant = 30
            
        }else if indexPath.row == 5{
            cell.mobileCode.text = agentInfo.phCode
            cell.headingLbl.text = agentInfo.phoneNo
            cell.widthImg.constant = 20
            cell.flagImg.isHidden = false
            cell.codeBtn.isHidden = false
            cell.codeBtnWidth.constant = 22
            cell.mobileCode.text = "+91"
            cell.mobileCode.isHidden = false
            cell.mobileCodeWidth.constant = 30
        }else if indexPath.row == 6{
            cell.headingLbl.tag = 5
            cell.headingLbl.delegate = self
            cell.headingLbl.text = agentInfo.maroof
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
           
            
            case 1001:
                    agentInfo.cardHolderName = textField.text!
        default:
            print("hhj")
        }
        
    }
}
