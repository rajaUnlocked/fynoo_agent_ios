//
//  UserProfileDetailsViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 23/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import ObjectMapper
class UserProfileDetailsViewController: UIViewController {
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var tableVw: UITableView!
    var isEdit = false
    var isPersonal = false
    var profileInfo : ProfileModal?
    var agentInfo = AgentProfile()
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!

    var personalDetail = ["Name","Gender","Dob","Education","Major"]
    var basicInfo = ["Business Name","Email","Country","City","Mobile Number","Phone Number","Maroof Link"]
    var bankDetail = ["Bank Name","Card Holder Name","IBAN Number"]
    var sectionHeading = ["","Service","Basic Information","Bank Detail","Vat Information","Password Information","Language Information"]
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
    
    func getProfileData(){
        let parameter = ["user_id":"1079",
        "lang_code":"EN"]
        ServerCalls.postRequest(Service.getProfile, withParameters: parameter) { (response, success) in
            if let value = response as? NSDictionary{
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        self.profileInfo  = Mapper<ProfileModal>().map(JSON: body)
                        self.agentInfo.businessName = self.profileInfo?.data?.basic_information?[0].business_name ?? ""
                        self.agentInfo.Email = self.profileInfo?.data?.basic_information?[0].email ?? ""
                        self.agentInfo.country = self.profileInfo?.data?.basic_information?[0].country ?? ""
                        self.agentInfo.countryId = self.profileInfo?.data?.basic_information?[0].country_id ?? 0
                        self.agentInfo.city = self.profileInfo?.data?.basic_information?[0].city ?? ""
                        self.agentInfo.cityId = self.profileInfo?.data?.basic_information?[0].city_id ?? 0
                        self.agentInfo.Email = self.profileInfo?.data?.basic_information?[0].email ?? ""
                        self.agentInfo.mobileNo = self.profileInfo?.data?.basic_information?[0].mobile_number ?? ""
                        self.agentInfo.mobileCode = self.profileInfo?.data?.basic_information?[0].mobile_code ?? ""
                        self.agentInfo.phoneNo = self.profileInfo?.data?.basic_information?[0].phone_number ?? ""
                        self.agentInfo.phCode = self.profileInfo?.data?.basic_information?[0].phone_code ?? ""
                        self.agentInfo.maroof = self.profileInfo?.data?.basic_information?[0].maroof_link ?? ""
                        self.agentInfo.bankname = self.profileInfo?.data?.bank_information?[0].bank_name ?? ""
                         // self.agentInfo.cardHolderName = self.profileInfo?.data?.bank_information?[0]. ?? ""
                        
                        self.agentInfo.bankId = self.profileInfo?.data?.bank_information?[0].bank_id ?? 0
                       self.agentInfo.iban = self.profileInfo?.data?.bank_information?[0].account_iban_nbr ?? ""
                        self.agentInfo.vatNo = self.profileInfo?.data?.vat_no ?? ""
                        
        
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
            
            if ((profileInfo?.data?.service_list_data!.count)) != nil{
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
            case 0,4,6:
                return 2
            case 2:
                return basicInfo.count
                
            case 3:
                return bankDetail.count
            default:
                return 1
            }
        }else{
            switch section {
            case 0,5,7:
                return 2
            case 2:
                return personalDetail.count
                
            case 3:
                return basicInfo.count
            case 4:
                return bankDetail.count
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
            cell.serviceList = profileInfo?.data?.service_list_data
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
            
            return cell
        }else{
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileServiceTableViewCell",for: indexPath) as! ProfileServiceTableViewCell

            cell.isForLanguage = true
           
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
        
        if indexPath.row == 0{
            cell.headingLbl.text = agentInfo.bankname
        }else if indexPath.row == 1{
            
        }else if indexPath.row == 2{
            cell.headingLbl.text = agentInfo.iban
        }
        return cell
    }
    func BasicInfoCell(indexPath : IndexPath) -> UITableViewCell{
        
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
        
        
        cell.headingLbl.tag = indexPath.row
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
            cell.headingLbl.text = agentInfo.businessName
            
        }else if indexPath.row == 1{
            cell.headingLbl.text = agentInfo.Email
            
        }else if indexPath.row == 2{
            cell.headingLbl.text = agentInfo.country
        }else if indexPath.row == 3{
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
            return cell
        }else{
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileVatTableViewCell",for: indexPath) as! ProfileVatTableViewCell
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
