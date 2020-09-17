//
//  SideMenuViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 23/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SideMenuSecondTableViewCellDelegate, SideMenuEarningTableViewCellDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var tableVw: UITableView!
    var cellTextArray = ["Home".localized, "Manage Services", "Service Requests", "", "", "Wallet".localized, "User Profile".localized, "Settings".localized, "Change Language".localized, "Sign out".localized]

    override func viewDidLoad() {
        super.viewDidLoad()
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
            nameLbl.text = "\(Hello), \(AuthorisedUser.shared.user!.data!.name)"

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
        return 1
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 4 {
            return dropShippingCell(index: indexPath)
        }
        else if indexPath.row == 3 {
            return earningCell(index: indexPath)
        }
        else{
            return profileCell(index: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
           dismiss(animated: true, completion: nil)
            
        case 1:
            dismiss(animated: true, completion: nil)
             NotificationCenter.default.post(name: Notification.Name("manageServiceClicked"), object: nil, userInfo: nil)
            
        case 2:
            
              dismiss(animated: true, completion: nil)
          NotificationCenter.default.post(name: Notification.Name("serviceRequestClicked"), object: nil, userInfo: nil)

        case 5:
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("walletClicked"), object: nil, userInfo: nil)
            
        case 6:
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("userProfileClicked"), object: nil, userInfo: nil)
            
        case 7:
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("settingsClicked"), object: nil, userInfo: nil)
            
        case 8:
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("changeLanguageClicked"), object: nil, userInfo: nil)
            
        case 9:
            dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("signOutClicked"), object: nil, userInfo: nil)
        default:
            print("hd")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 3 {
            return 130
        }
        if indexPath.row == 4 {
            return 136
        }
        else{
            return 40
        }
    }
    
    // MARK: - TableView Cells Return
    func profileCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell",for: index) as! SideMenuTableViewCell
        cell.selectionStyle = .none
        cell.cellTextLbl.text = "\(cellTextArray[index.row])"
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
