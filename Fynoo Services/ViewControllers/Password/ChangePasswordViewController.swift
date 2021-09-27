//
//  ChangePasswordViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 29/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, ProfileDetailTableViewCellDelegate, UITextFieldDelegate
{
    
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    var titleArray = ["Current Password","New Password","Confirm Password"]
    var userInfo  : ProfileModal?

    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        
        navigationView.viewControl = self
        navigationView.titleHeader.text = "Change Password".localized
        tableView.delegate = self
        tableView.dataSource = self
        let image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"back_new")!)
        navigationView.backButton.setImage(image, for: .normal)
        tableView.reloadData()
        tableView.register(UINib(nibName: "ProfileNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileNameTableViewCell");
        tableView.register(UINib(nibName: "ProfileDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileDetailTableViewCell");
        tableView.register(UINib(nibName: "ProfileEnteriesTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileEnteriesTableViewCell");
        tableView.register(UINib(nibName: "TwoButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "TwoButtonsTableViewCell");
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @objc func cancelClicked(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
   
    
    @objc func saveClicked(_ sender:UIButton){
        let currentPass = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! ProfileEnteriesTableViewCell
        let newPass = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! ProfileEnteriesTableViewCell
        let confirmPass = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! ProfileEnteriesTableViewCell
        
        
        if !currentPass.headingLbl.text!.validPassword {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Current Password is not valid")
            return
        }
        if currentPass.headingLbl.text! == newPass.headingLbl.text! {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "New password should not be the current password")
            return
        }
        if newPass.headingLbl.text!.count < 8 {
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passwordCount)
            return
        }
        if !newPass.headingLbl.text!.containArabicNumber{
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passArabicNumber)
            return
            
        }
        if newPass.headingLbl.text! != newPass.headingLbl.text! {
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.confirmPassword)
            return
        }
        
//        let val = newPass.headingLbl.text!.isValidPassword()
//        print(val,"dds")
//        if !val {
//            ModalController.showNegativeCustomAlertWith(title: "", msg: "Password is not valid")
//            return
//        }
        
        
        
        
        if newPass.headingLbl.text?.count ?? 0 < 8
        {
            ModalController.showNegativeCustomAlertWith(title:ValidationMessages.passwordCount, msg: "")
            return
        }
        if newPass.headingLbl.text == confirmPass.headingLbl.text
        {
            
            
            ModalClass.startLoading(self.view)
            let str = "\(Authentication.changePassword)"
            let parameters = [
                "old_pwd": currentPass.headingLbl.text!,
                "new_pwd":newPass.headingLbl.text!,
                "user_id":Singleton.shared.getUserId(),
                "lang_code":"en"
            ]
            print("request -",parameters)
            ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
                ModalClass.stopLoading()
                if let value = response as? NSDictionary{
                    let msg = value.object(forKey: "error_description") as! String
                    let error = value.object(forKey: "error_code") as! Int
                    if error == 100{
                        ModalController.showNegativeCustomAlertWith(title:" Error", msg: msg)
                    }else{
                        
                        ModalController.showSuccessCustomAlertWith(title:" Success", msg: msg)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        else
        {
            ModalController.showNegativeCustomAlertWith(title:" Error", msg: "Mismatch Password")
        }
        
    }
    func edit() {
    }
    
    func followersClicked() {
//        let vc = FollowersViewController(nibName: "FollowersViewController", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func branchesClicked() {
//        let vc = BranchListNewViewController(nibName: "BranchListNewViewController", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func productsClicked() {
//        let vc = ProductListNewViewController(nibName: "ProductListNewViewController", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func likesClicked() {
//        let vc = LikesViewController(nibName: "LikesViewController", bundle: nil)
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func eyeClicked(_ sender:UIButton){
        if sender.tag == 2{
            if sender.isSelected{
                sender.isSelected = false
            }else{
                sender.isSelected = true
            }
            
        }else if sender.tag == 3{
            if sender.isSelected{
                sender.isSelected = false
            }else{
                sender.isSelected = true
            }
        }else{
            if sender.isSelected{
                sender.isSelected = false
            }else{
                sender.isSelected = true
            }
        }
        tableView.reloadData()
    }
    
    var currentPassword = ""
    var newPassword = ""
    var confirmPassword = ""
    var isMatch = false
    var isEdit = false
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("text",textField.tag)
        
        switch textField.tag {
        case 2:
            currentPassword = textField.text!
        case 3:
            newPassword = textField.text!
        case 4:
            confirmPassword = textField.text!
        default:
            print("ggh")
        }
        
        
        
        
        if newPassword == confirmPassword && newPassword != "" && (newPassword.count == 8 || newPassword.count > 8){
        
            isMatch = true
            isEdit = true
            self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .none)

        }else{
           if isEdit{
                isMatch =  false
                isEdit = false
                
                self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .none)
                
            }
            
        }

        self.tableView.reloadRows(at: [IndexPath(row: 5, section: 0)], with: .none)

        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var letters = string.map { String($0) }
        for i in 0..<string.count{
            
            if !letters[i].containArabicNumber{
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passArabicNumber)
                letters[i] = ""
                return false
            }
            
        }
        return true
    }
}


extension ChangePasswordViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 210
        }else if indexPath.row == 1{
            return 0
        }else{
            return 54
        }
    }
  
}

extension ChangePasswordViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileNameTableViewCell",for: indexPath) as! ProfileNameTableViewCell
            cell.profileImage.sd_setImage(with: URL(string:self.userInfo?.data?.user_data?.profile_image ?? ""), placeholderImage: UIImage(named: "profile_white"))
            cell.editImageOutlet.isHidden = true
        
       
            cell.cameraIcon.isHidden = true
            let val1 = "ID".localized
            let val2 = "Hello".localized
            cell.fynooIdLbl.text = "\(val1) \(self.userInfo?.data?.user_data?.fynoo_id ?? "")"
            cell.nameLbl.text = "\(val2) \(self.userInfo?.data?.user_data?.name ?? "")"
            cell.editImageOutlet.isHidden = true
            
            return cell
            
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileDetailTableViewCell",for: indexPath) as! ProfileDetailTableViewCell
            cell.titleView.isHidden = true
//            cell.branches.text = "\(self.userInfo?.data?.user_data?.total_branches ?? 0)"
//            cell.products.text = "\(self.userInfo?.data?.user_data?.total_products ?? 0)"
//            cell.followers.text = "\(self.userData?.data?.total_follower ?? 0)"
//            cell.branches.text = "\(self.userData?.data?.total_branch ?? 0)"
//            cell.products.text = "\(self.userData?.data?.total_product ?? 0)"
//            cell.likes.text = "\(self.userData?.data?.total_likes ?? 0)"
            cell.editProfileTitle.isHidden = true
            cell.imageButton.isHidden = true
           
            cell.delegate = self
            return cell
        }
        else if indexPath.row == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoButtonsTableViewCell",for: indexPath) as! TwoButtonsTableViewCell
            cell.selectionStyle = .none
            cell.cancel.addTarget(self, action: #selector(cancelClicked(_:)), for: .touchUpInside)
            cell.save.addTarget(self, action: #selector(saveClicked(_:)), for: .touchUpInside)
            cell.cancel.isUserInteractionEnabled = true
            if currentPassword == "" || newPassword == "" || confirmPassword == "" || isMatch == false  {
                cell.save.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
                cell.save.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
            }else{
                if  currentPassword.validPassword == false || confirmPassword.validPassword == false || newPassword.validPassword == false{
                    cell.save.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
                    cell.save.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
                }else{
                    cell.save.borderColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
                    cell.save.setTitleColor(#colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1), for: .normal)
                }
                
            }
            

            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileEnteriesTableViewCell",for: indexPath) as! ProfileEnteriesTableViewCell
              cell.flagImg.isHidden = true
            cell.eyeButton.tag = indexPath.row
            cell.eyeButton.isHidden = false
            cell.eyeButton.addTarget(self, action: #selector(eyeClicked(_:)), for: .touchUpInside)
            cell.mobileCode.isHidden = true
            
            cell.headingLbl.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            cell.headingLbl.tag = indexPath.row
            cell.mobileCodeWidth.constant = 0
            if  cell.eyeButton.tag == 2{
                if  cell.eyeButton.isSelected{
                    cell.headingLbl.isSecureTextEntry = false
                }else{
                    cell.headingLbl.isSecureTextEntry = true
                }
                
            }else if cell.eyeButton.tag == 3{
                if cell.eyeButton.isSelected{
                    cell.headingLbl.isSecureTextEntry = false
                }else{
                    cell.headingLbl.isSecureTextEntry = true
                }
            }else{
                cell.headingLbl.text = confirmPassword
                if cell.eyeButton.isSelected{
                    cell.headingLbl.isSecureTextEntry = false
                }else{
                    cell.headingLbl.isSecureTextEntry = true
                }
                if isMatch{
                    let image = UIImage(named:"greenTick")
                    cell.eyeButton.setImage(image, for: .normal)//named: "")
                    
                }else{
                    let image = UIImage(named:"eye_new_hide")
                    cell.eyeButton.setImage(image, for: .normal)
                }
            }
            
            cell.headingLbl.delegate = self
            cell.headingLbl.isUserInteractionEnabled = true
            cell.selectBtn.isHidden = true
            
            cell.headingLbl.keyboardType = .asciiCapable
            cell.entryLbl.text = titleArray[indexPath.row-2].localized
            
            
            return cell
        }
    }
}
extension String{
    func isValidPassword() -> Bool {
              let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
              return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
          }
}
