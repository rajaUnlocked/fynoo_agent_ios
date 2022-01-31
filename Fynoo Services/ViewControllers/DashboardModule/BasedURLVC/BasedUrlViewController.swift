//
//  BasedUrlViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 01/06/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import iOSDropDown

class BasedUrlViewController: UIViewController {
 
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var selectUrlView: UIView!
    @IBOutlet weak var selectedUrlTxtFld: DropDown!
    @IBOutlet weak var selectUrlBtn: UIButton!
    @IBOutlet weak var localUrlView: UIView!
    @IBOutlet weak var LocalUrlHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var localUrlEntryTxtFld: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var otherUrlHeaderLbl: UILabel!
    @IBOutlet weak var otherUrlView: UIView!
    @IBOutlet weak var versionLbl: UILabel!
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        let buildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        versionLbl.text = "Dev Build Version: \(buildNumber)"
        
        self.LocalUrlHeightConstant.constant = 0
        self.otherUrlHeaderLbl.isHidden = true
        self.localUrlEntryTxtFld.isHidden = true
        self.otherUrlView.isHidden = true
        
<<<<<<< HEAD
        self.selectedUrlTxtFld.optionArray = ["https://dev.fynoo.com/","http://uat.sendan.com.sa:9003/","https://fynoo.com/","Local Pointing"]
=======
        self.selectedUrlTxtFld.optionArray = ["https://dev.fynoo.com/","https://www.fynoo.com/","http://uat.sendan.com.sa:9003/","Local Pointing"]
>>>>>>> a2abc3cf1bc5b4a69895bcd96363308a6966ecd2
        //Its Id Values and its optional
        self.selectedUrlTxtFld.optionIds = [1,2,3,4]
        self.selectedUrlTxtFld.isSearchEnable = false
        self.selectedUrlTxtFld.listHeight = 190
        self.selectedUrlTxtFld.rowHeight = 40
        self.selectedUrlTxtFld.arrowColor = .white
        self.selectedUrlTxtFld.selectedRowColor = .lightGray
        
         self.submitBtn.setTitleColor(UIColor(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
        self.submitBtn.layer.borderWidth = 0.5
        self.submitBtn.borderColor =  #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
               super.viewDidAppear(animated)
    }
    
    @IBAction func selectUrlClicked(_ sender: Any) {
          self.selectedUrlTxtFld.showList()  // To show the Drop Down Menu
        
        self.selectedUrlTxtFld.didSelect{(selectedText , index ,id) in
            self.selectedUrlTxtFld.text = "\(selectedText)"
            if self.selectedUrlTxtFld.text == "Local Pointing" {
                self.LocalUrlHeightConstant.constant = 64
                self.otherUrlHeaderLbl.isHidden = false
                self.localUrlEntryTxtFld.isHidden = false
                 self.otherUrlView.isHidden = false
            }else{
                self.LocalUrlHeightConstant.constant = 0
                self.otherUrlHeaderLbl.isHidden = true
                self.localUrlEntryTxtFld.isHidden = true
                 self.otherUrlView.isHidden = true
            }
            print("Url-", self.selectedUrlTxtFld.text as Any)
        }
    }
    
    @IBAction func submitBtnClicked(_ sender: Any) {
        
        if selectedUrlTxtFld.text == "" {
            ModalController.showNegativeCustomAlertWith(title: "Please select pointing URL to proceed.", msg: "")
        } else if selectedUrlTxtFld.text == "Local Pointing" &&  localUrlEntryTxtFld.text?.count == 0 {
             ModalController.showNegativeCustomAlertWith(title: "Please enter your local pointing URL.", msg: "")
            
        }else if localUrlEntryTxtFld.text?.count != 0 && !(ModalController.isValidURL(url: self.localUrlEntryTxtFld.text!)) {
            ModalController.showNegativeCustomAlertWith(title: "Please select valid pointing URL to proceed.", msg: "")
        }
                
        else{
            if selectedUrlTxtFld.text == "Local Pointing" {
                 Constant.BASE_URL = "\(localUrlEntryTxtFld.text!)"
            }else{
                  Constant.BASE_URL = "\(selectedUrlTxtFld.text!)"
            }
            print("BaseUrl:-", Constant.BASE_URL)
            
            let vc = SplashAnimatedViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
