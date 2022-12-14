//
//  SideMenuViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 23/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SideMenuSecondTableViewCellDelegate, SideMenuEarningTableViewCellDelegate {
//    func dropShippingBtnClicked() {
//        <#code#>
//    }
//
//    func addProductDataForSaleBtnClicked() {
//        <#code#>
//    }
//
//    func commissionBtnClicked() {
//        <#code#>
//    }
//
//    func targetBtnClicked() {
//        <#code#>
//    }
//
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var tableVw: UITableView!
    var cellTextArray = ["Home".localized, "Manage Services".localized, "Service Requests".localized,"Notification".localized, "", "", "Wallet".localized]
    var cellTextArray1 = ["Invoices".localized,"Issued".localized, "Received".localized ,"Fynoo Receipts".localized]
    var cellTextArray2 = ["User Profile".localized,  "Change Language".localized, "Sign out".localized]
    var isOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        nameLbl.font = UIFont(name:"\(fontNameLight)",size:20)
        self.navigationController?.navigationBar.isHidden = true
        registerCellNibs()
        profileImage.layer.cornerRadius = profileImage.layer.frame.width*0.5
        profileImage.layer.borderColor = UIColor.lightGray.cgColor
        profileImage.layer.borderWidth = 0
        profileImage.layer.masksToBounds = true

        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let Hello = "Hello".localized
        if AuthorisedUser.shared.isAuthorised{

            if  let str = ModalController.getTheContentForKey("profile_img") as? String{
                profileImage.setImageSDWebImage(imgURL: str, placeholder: "profile_white")
            }
            
            let user_id:UserData = AuthorisedUser.shared.getAuthorisedUser()
            var nameStr = "\(user_id.data!.name)"
            
            nameLbl.text = "\(Hello), \(nameStr)"

        }else{
            nameLbl.text = "\(Hello), Guest"
            profileImage.image = UIImage(named: "profile_white")
        }
        self.tableVw.reloadData()
    }
    
    func registerCellNibs(){
        tableVw.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell");
        tableVw.register(UINib(nibName: "SideMenuSecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuSecondTableViewCell");
        tableVw.register(UINib(nibName: "SideMenuEarningTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuEarningTableViewCell");
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:-- TABLE DATA SOURCE DELEGATES
    func numberOfSections(in tableView: UITableView) -> Int{
        return 3
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cellTextArray.count
        case 1:
            if isOpen
            {
                return cellTextArray1.count
            }
            return 1
        default:
            return cellTextArray2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if indexPath.row == 5 {
                return dropShippingCell(index: indexPath)
            }
            else if indexPath.row == 4 {
                return earningCell(index: indexPath)
            }
            else{
                return profileCell(index: indexPath)
            }
        }
        else{
            return profileCell(index: indexPath)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.section{
        case 0:
            if indexPath.row == 0{
           dismiss(animated: true, completion: nil)
            }
            
            if indexPath.row == 1{
            dismiss(animated: true, completion: nil)
             NotificationCenter.default.post(name: Notification.Name("manageServiceClicked"), object: nil, userInfo: nil)
            }
            
            if indexPath.row == 2{
            
              dismiss(animated: true, completion: nil)
          NotificationCenter.default.post(name: Notification.Name("serviceRequestClicked"), object: nil, userInfo: nil)
            }
            if indexPath.row == 3{
            
              dismiss(animated: true, completion: nil)
          NotificationCenter.default.post(name: Notification.Name("notificationRequestClicked"), object: nil, userInfo: nil)
            }
            if indexPath.row == 6{
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("walletClicked"), object: nil, userInfo: nil)
            }
        case 1:
            if indexPath.row == 0
            {
                isOpen = !isOpen
                tableView.reloadData()
              
            }
           else if indexPath.row == 1
            {
                dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: Notification.Name("issued"), object: nil, userInfo: nil)
            }
            else if indexPath.row == 2
             {
                 dismiss(animated: true, completion: nil)
                 NotificationCenter.default.post(name: Notification.Name("received"), object: nil, userInfo: nil)
             }
            else
             {
                 dismiss(animated: true, completion: nil)
                 NotificationCenter.default.post(name: Notification.Name("fynoo_reciept"), object: nil, userInfo: nil)
             }
        case 2:
            if indexPath.row == 0{
                dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: Notification.Name("userProfileClicked"), object: nil, userInfo: nil)
            }
            
//        if indexPath.row == 0:
//            dismiss(animated: true, completion: nil)
//            NotificationCenter.default.post(name: Notification.Name("settingsClicked"), object: nil, userInfo: nil)
            
            if indexPath.row == 1{
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("changeLanguageClicked"), object: nil, userInfo: nil)
            }
            if indexPath.row == 2{
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("signOutClicked"), object: nil, userInfo: nil)
            }
        default:
            print("hd")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 && (indexPath.row == 4 || indexPath.row == 5){
            return 135
        }
        else{
            return 40
        }
    }
    
    // MARK: - TableView Cells Return
    func profileCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell",for: index) as! SideMenuTableViewCell
        cell.leadingConst.constant = 38
        cell.selectionStyle = .none
        cell.arrowImage.isHidden = true
        if index.section == 0{
            cell.cellTextLbl.text = "\(cellTextArray[index.row])"
        }

         else if index.section == 1 {
            if index.row != 0
            {
               // cell.arrowImage.image = image
                cell.leadingConst.constant = 48
            }
            else{
                cell.arrowImage.isHidden = false
                cell.arrowImage.image = (isOpen ? UIImage(named: "up-arrow-3"):UIImage(named: "down-arrow-2"))
                cell.leadingConst.constant = 38
        }
             cell.cellTextLbl.text = "\(cellTextArray1[index.row])"
        }
        else{
            cell.cellTextLbl.text = "\(cellTextArray2[index.row])"
        }
       
        return cell
    }
    
    func dropShippingCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "SideMenuSecondTableViewCell",for: index) as! SideMenuSecondTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func earningCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "SideMenuEarningTableViewCell",for: index) as! SideMenuEarningTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func dropShippingBtnClicked() {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("dropShippingBtnClicked"), object: nil, userInfo: nil)
    }
    
    func addProductDataForSaleBtnClicked() {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("addProductDataForSaleBtnClicked"), object: nil, userInfo: nil)
    }
    
    func commissionBtnClicked() {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("commissionClicked"), object: nil, userInfo: nil)
    }
    
    func targetBtnClicked() {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("targetClicked"), object: nil, userInfo: nil)
    }
}
