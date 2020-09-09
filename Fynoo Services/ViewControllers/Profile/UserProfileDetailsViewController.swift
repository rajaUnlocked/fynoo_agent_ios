//
//  UserProfileDetailsViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 23/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
class UserProfileDetailsViewController: UIViewController {
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var tableVw: UITableView!
    var isEdit = false
    var isPersonal = false
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
        tableVw.delegate = self
        tableVw.dataSource = self
        tableVw.reloadData()
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
            return 120
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
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
            cell.entryLbl.attributedText = ModalController.setStricColor(str: "Password *", str1: "Password", str2:" *" )
            
            cell.headingLbl.text = "* * * * * * * *"
            cell.headingLbl.isUserInteractionEnabled = false
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
      //  cell.entryLbl.attributedText = ModalController.setStricColor(str: "\(personalDetail[indexPath.row]) *", str1: "\(personalDetail[indexPath.row])", str2:" *" )
        return cell
        
    }
    func BankDetailCell(indexPath : IndexPath) -> UITableViewCell{
        
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
        cell.entryLbl.attributedText = ModalController.setStricColor(str: "\(bankDetail[indexPath.row]) *", str1: "\(bankDetail[indexPath.row])", str2:" *" )
        
        if indexPath.row == 0{
            
        }else if indexPath.row == 1{
            
        }else if indexPath.row == 2{
            
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
            
            
        }else if indexPath.row == 1{
            
        }else if indexPath.row == 2{
            
        }else if indexPath.row == 3{
            
        }else if indexPath.row == 4{
            cell.widthImg.constant = 20
            cell.flagImg.isHidden = false
            cell.codeBtn.isHidden = false
            cell.codeBtnWidth.constant = 22
            cell.mobileCode.text = "+91"
            cell.mobileCode.isHidden = false
            cell.mobileCodeWidth.constant = 30
            
        }else if indexPath.row == 5{
            cell.widthImg.constant = 20
            cell.flagImg.isHidden = false
            cell.codeBtn.isHidden = false
            cell.codeBtnWidth.constant = 22
            cell.mobileCode.text = "+91"
            cell.mobileCode.isHidden = false
            cell.mobileCodeWidth.constant = 30
        }else if indexPath.row == 6{
            
        }
        
        return cell
    }
    func VatCell(indexPath : IndexPath) -> UITableViewCell{
        if indexPath.row == 0{
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
            cell.entryLbl.attributedText = ModalController.setStricColor(str: "VAT Number *", str1: "VAT Number", str2:" *" )
            
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
