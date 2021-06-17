//
//  AddNewBankViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 31/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class AddNewBankViewController: UIViewController, UITextFieldDelegate{
        
    @IBOutlet weak var sendmoneylbl: UILabel!
    @IBOutlet weak var bankView: UIView!
    @IBOutlet weak var ibanView: UIView!
    @IBOutlet weak var reIbanView: UIView!
    @IBOutlet weak var nickNameView: UIView!
    @IBOutlet weak var accountView: UIView!
    
    @IBOutlet weak var validIbanTick: UIImageView!
    @IBOutlet weak var headerVieww: NavigationView!
    @IBOutlet weak var widthConstant: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
//    var selectedBankDict : NSMutableDictionary = NSMutableDictionary()
    var selectedBankDict = NSDictionary()
    var currencyDict : NSMutableDictionary = NSMutableDictionary()
    @IBOutlet weak var bgImage: UIImageView!
    var isForEdit = false
    @IBOutlet weak var currency: UITextField!
    @IBOutlet weak var ibanNo: UITextField!
    @IBOutlet weak var reIban: UITextField!
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var accountName: UITextField!
    @IBOutlet weak var bankName: UITextField!
    
    @IBOutlet weak var accountinfo: UILabel!
    @IBOutlet weak var infoFilled: UIImageView!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var cancel: UIButton!
//    var bankDetail : NSMutableDictionary = NSMutableDictionary()
    var bankDetail = NSDictionary()
    
    var selectedID = 0
    
    @IBOutlet weak var banknamelbl: UILabel!
    @IBOutlet weak var reenterbanlbl: UILabel!
    
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var nameofacclbl: UILabel!
    @IBOutlet weak var rebaninfo: UILabel!
    @IBOutlet weak var ibanlbl: UILabel!
    var bankIds = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
    sendmoneylbl.font = UIFont(name:"\(fontNameLight)",size:12)
        accountinfo.font = UIFont(name:"\(fontNameLight)",size:12)
        ibanlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        ibanNo.font = UIFont(name:"\(fontNameLight)",size:12)
        reenterbanlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        reIban.font = UIFont(name:"\(fontNameLight)",size:12)
        rebaninfo.font = UIFont(name:"\(fontNameLight)",size:8)
        banknamelbl.font = UIFont(name:"\(fontNameLight)",size:12)
        bankName.font = UIFont(name:"\(fontNameLight)",size:12)
        nameofacclbl.font = UIFont(name:"\(fontNameLight)",size:12)
        accountName.font = UIFont(name:"\(fontNameLight)",size:12)
        currencylbl.font = UIFont(name:"\(fontNameLight)",size:12)
        currencylbl.font = UIFont(name:"\(fontNameLight)",size:12)
        cancel.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        save.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        if HeaderHeightSingleton.shared.LanguageSelected == "AR"
        {
            bankName.textAlignment = .right
             ibanNo.textAlignment = .right
             reIban.textAlignment = .right
            nickName.textAlignment = .right
            accountName.textAlignment = .right
        }
        else{
           bankName.textAlignment = .left
             ibanNo.textAlignment = .left
             reIban.textAlignment = .left
            nickName.textAlignment = .left
            accountName.textAlignment = .left
        }
        self.ibanNo.delegate = self
          self.reIban.delegate = self
        self.accountName.tag = 1000
        self.nickName.tag = 1001
        self.ibanNo.tag = 1002
        self.reIban.tag = 1003
  //      self.ibanNo.text = "SA"
 //         self.reIban.text = "SA"
        self.bankName.isUserInteractionEnabled = false
        self.ibanNo.addTarget(self, action: #selector(AddNewBankViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.ibanNo.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        self.reIban.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        self.reIban.addTarget(self, action: #selector(AddNewBankViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.nickName.addTarget(self, action: #selector(AddNewBankViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.accountName.addTarget(self, action: #selector(AddNewBankViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        self.headerVieww.titleHeader.text = "Manage Your Wallet".localized
        self.headerVieww.viewControl = self
        self.widthConstant.constant = UIScreen.main.bounds.size.width
        bgImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        validIbanTick.isHidden = true
         self.save.setAllSideShadow(shadowShowSize: 3.0)
         self.cancel.setAllSideShadow(shadowShowSize: 3.0)
        print(currencyDict)
        
        if isForEdit{
            accountName.text =  bankDetail.object(forKey: "full_name") as? String
            nickName.text = "SAR"
            ibanNo.text = (bankDetail.object(forKey: "account_iban_nbr") as! String)
            reIban.text = (bankDetail.object(forKey: "account_iban_nbr") as! String)
            bankName.text = (bankDetail.object(forKey: "bank_name") as! String)
     //       currency.text = "SAR"
            save.borderColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
            save.setTitleColor(#colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1), for: .normal)
            save.isUserInteractionEnabled = true
            infoFilled.image = UIImage(named:"greenTick")
            validIbanTick.isHidden = false
    //        self.ibanNo.keyboardType = .asciiCapableNumberPad
            self.ibanNo.keyboardType = .asciiCapable
        }else{
            bankView.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            accountView.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
   //         nickNameView.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            ibanView.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            reIbanView.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            self.ibanNo.keyboardType = .asciiCapable
        }
        self.accountName.keyboardType = .asciiCapable
        self.nickName.keyboardType = .asciiCapable
        
        self.reIban.keyboardType = .asciiCapable
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField.tag == 1002{
            let lenght  = 24
               
            if textField.text!.count < 3 {
                self.ibanNo.keyboardType = .asciiCapable
            }else{
                self.ibanNo.keyboardType = .asciiCapable
            }
            
               // fixed SA
               var textstr = ""
               if let text = textField.text as NSString? {
                   let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                   textstr = txtAfterUpdate
               }
               
//               let textStr = "SA".localized
            let textStr = ""
               if range.location <= textStr.count - 1
               {
                   return false
               }
               if textField.text == textStr  && range.length == 1 {
                   return false
               }
               
               // block enter char after 24
            let str = ibanNo.text
               
               guard let stringRange = Range(range,in: str!) else {
                   return false
               }
               print(stringRange)
               print(str as Any)
               let updateText =  str!.replacingCharacters(in: stringRange, with: string)
               
            
            
               return (updateText.count) < lenght+6
        }
        
        else if textField.tag == 1003{
                   let lenght  = 24
                      
                      // fixed SA
                      var textstr = ""
                      if let text = textField.text as NSString? {
                          let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                          textstr = txtAfterUpdate
                      }
                      
//                      let textStr = "SA".localized
            let textStr = ""
                      if range.location <= textStr.count - 1
                      {
                          return false
                      }
                      if textField.text == textStr  && range.length == 1 {
                          return false
                      }
                      
                      // block enter char after 24
                   let str = reIban.text
                      
                      guard let stringRange = Range(range,in: str!) else {
                          return false
                      }
                      print(stringRange)
                      print(str as Any)
                      let updateText =  str!.replacingCharacters(in: stringRange, with: string)
                      
                      return (updateText.count) < lenght+6
            
            
        }
        else{
            return true
        }
    }
    
    var accountNumber = ""
    var accountValue = ""
    var accountNumbers = ""
    var accountValues = ""
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
        case 1000:
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
                
                var str = textField.text!
                let choppedString = String(str.dropLast())
           //     str.dropLast()
                accountName.text = choppedString
                
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: accountView)
            }else{
                if textField.text == ""{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: accountView)
                }else{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: accountView)
                    // signUpBoModal.name = textField.text!
                }
            }
            
        case 1001:
            if ModalController.isValidName(title: textField.text!) == false {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: nickNameView)
            }else{
                if textField.text == ""{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: nickNameView)
                }else{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: nickNameView)
                    // signUpBoModal.name = textField.text!
                }
            }
            
            
        case 1002:
            if accountNumber != "" {
                accountValue = textField.text!
                accountNumber = accountValue.replacingOccurrences(of: " ", with: "")
                accountValue = ModalController.customStringFormattingForAccountNumber(of: accountNumber)
            }else{
                accountValue =  ModalController.customStringFormattingForAccountNumber(of: textField.text!)
                accountNumber = accountValue.replacingOccurrences(of: " ", with: "")
            }
            
            let str = self.ibanNo.text?.replacingOccurrences(of: " ", with: "")
            
            if str!.count >= 24 && self.ibanNo.text != "" && self.ibanNo.text != "SA" && self.ibanNo.text!.containArabicNumber {
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: self.ibanView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: self.ibanView)
            }
            
            textField.text = accountValue
            if str!.count == 6 {
                
                let bankStr =  str!.substring(from: 4, to: 5)
                print("bankIdentifier:-", bankStr)
                self.bankNameApi(identifier: bankStr)
            }
            if str!.count < 6 {
                self.bankName.text = ""
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: bankView)
            }
            
            if ibanNo.text != reIban.text! || ibanNo.text!.count != 29 {
                validIbanTick.isHidden = true
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: reIbanView)

            }else{
                validIbanTick.isHidden = false
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), view: reIbanView)


            }
            
            
        case 1003:
            
            if accountNumbers != "" {
                accountValues = textField.text!
                accountNumbers = accountValues.replacingOccurrences(of: " ", with: "")
                accountValues = ModalController.customStringFormattingForAccountNumber(of: accountNumbers)
            }else{
                accountValues =  ModalController.customStringFormattingForAccountNumber(of: textField.text!)
                accountNumbers = accountValues.replacingOccurrences(of: " ", with: "")
            }
            
            textField.text = accountValues

            
            let str = self.reIban.text?.replacingOccurrences(of: " ", with: "")
            
            if str!.count >= 24 && self.ibanNo.text != "" && self.reIban.text != "SA" && self.reIban.text!.containArabicNumber && self.reIban.text == self.ibanNo.text{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: self.reIbanView)
                validIbanTick.isHidden = false

            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: self.reIbanView)
                validIbanTick.isHidden = true

            }
            
            
        default:
            print("ishs")
        }

        print(ibanNo.text!.count,"dsd")
        if  nickName.text!.isEmpty || bankName.text!.isEmpty || ibanNo.text!.count != 29 ||  reIban.text!.isEmpty ||  accountName.text!.isEmpty ||  validIbanTick.isHidden == true{
            save.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            save.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
            infoFilled.image = UIImage(named:"edit-new")
            
        }
        else{
            save.borderColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
            save.setTitleColor(#colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1), for: .normal)
            infoFilled.image = UIImage(named:"greenTick")
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
                let bankNameIdentifierList = try! JSONDecoder().decode(bankIdentifier_list.self, from: resp as! Data )
                if bankNameIdentifierList.error! {
                    ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "error_description") as? String)!, msg: "")
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: self.bankView)
                    self.bankName.text = ""
                }else{
                    
                    let arr = ResponseDict.object(forKey: "data") as! NSArray
                    
                    
                    let index = IndexPath(row: 1, section: 3)
                    if bankNameIdentifierList.data?.count ?? 0 > 0 {
                        let bankIdentifier  = bankNameIdentifierList.data![0]
                        let name = bankIdentifier.bank_name
                        self.bankName.text = name ?? ""
                        
                        self.selectedBankDict = arr.object(at: 0) as! NSDictionary
                    
                        if self.bankName.text == "" {
                            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: self.bankView)
                        }else{
                            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: self.bankView)
                        }
                    }else{
                        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: self.bankView)
                        self.bankName.text = ""
                    }
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
    
    @IBAction func bankListClicked(_ sender: Any) {
    
        if ibanNo.text == "SA" {
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.BankName)
            return
        }
    }
    

    
    @IBAction func saveBtn(_ sender: Any) {
        if ibanNo.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "Please enter iban number".localized, msg: "")
             return
         }
        if reIban.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "Please Re-enter iban number".localized, msg: "")
             return
         }
        if ibanNo.text != reIban.text {
            ModalController.showNegativeCustomAlertWith(title: "IBAN and Re-IBAN number does not match".localized, msg:"")
            return
        }
        if bankName.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "Please select your bank name", msg: "")
            return
        }
        if accountName.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "Please enter name on account".localized, msg: "")
            return
        }
               
  
        
        
        
        if isForEdit{
            updateBankNewAPI()
        }else{
            addNewAPI()
        }
        
    }
    
    func addBankDetail(){
        
        let obj = BankViewModal()
        let bankId = selectedBankDict.object(forKey:"id") as! Int
        let currencyId = currencyDict.object(forKey: "currency_id") as! Int
        
        obj.AddToBank(BankId: bankId, fullName: accountName.text!, short_name: nickName.text!, currency_id: currencyId, account_iban_nbr: ibanNo.text!, confirm_account_iban_nbr: reIban.text!) { (success, response) in
            
            if success{
                if let value = response?.object(forKey: "error_description") as? String{
                    ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                    self.navigationController?.popViewController(animated: true)
                    
                }
            }
        }
    }
    
       func updateBankDetail(){
           
           let obj = BankViewModal()
           let bankId = selectedBankDict.object(forKey:"id") as! Int
           let currencyId = currencyDict.object(forKey: "currency_id") as! Int
          
        obj.UpdateToBank(bankIdd:bankIds,BankId: bankId, fullName: accountName.text!, short_name: nickName.text!, currency_id: currencyId, account_iban_nbr: ibanNo.text!, confirm_account_iban_nbr: reIban.text!) { (success, response) in
               
               if success{
                   if let value = response?.object(forKey: "error_description") as? String{
                       ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                       self.navigationController?.popViewController(animated: true)
                       
                   }
               }
           }
       }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addNewAPI(){
        
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.addNewBankAPI)"
        let parameters = [
            "user_id":Singleton.shared.getUserId(),
            "bank_id":"\(selectedBankDict.object(forKey:"id") as! Int)",
            "name_on_account":self.accountName.text!,
            "iban_number":self.ibanNo.text!,
            "c_iban_number":self.ibanNo.text!,
            "currency":"2",
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
                }else{
                    ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func updateBankNewAPI(){
        
        var banID = 0
        if selectedBankDict.count == 0 {
            banID = selectedID
        }else{
            banID = selectedBankDict.object(forKey:"id") as! Int
        }
        
        
        
        ModalClass.startLoading(self.view)
               let str = "\(Constant.BASE_URL)\(Constant.updateBankAPI)"
               let parameters = [
                   "user_id":Singleton.shared.getUserId(),
                   "bank_id":"\(bankDetail.object(forKey: "bank_id") as! NSNumber)",
                   "name_on_account":self.accountName.text!,
                   "iban_number":self.ibanNo.text!,
                   "c_iban_number":self.ibanNo.text!,
                   "currency":"2",
                   "user_bank_pk":"\(banID)",
                   "lang_code":HeaderHeightSingleton.shared.LanguageSelected
               ]
               print("request -",parameters)
               ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
                   ModalClass.stopLoading()
                   if let value = response as? NSDictionary{
                       let msg = value.object(forKey: "error_description") as! String
                       let error = value.object(forKey: "error_code") as! Int
                       if error == 100{
                           ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
                       }else{
                           ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                           self.navigationController?.popViewController(animated: true)
                       }
                   }
               }
    }
}


