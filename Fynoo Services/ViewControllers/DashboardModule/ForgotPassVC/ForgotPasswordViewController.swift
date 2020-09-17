//
//  ForgotPasswordViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-049 on 17/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import iOSDropDown
import MTPopup

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var forgetTitle: UILabel!
    @IBOutlet weak var emailVieww: UIView!
    @IBOutlet weak var userTypee: UIImageView!
    @IBOutlet weak var usertypeVw: UIView!
    @IBOutlet weak var emailVw: UIButton!
    @IBOutlet weak var emalView: UIView!
    @IBOutlet weak var usertypeView: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var emailtxtFld: UITextField!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    var Forgot_Password: ForgotPassword?
    var fynoo_ID: String?
    @IBOutlet var userTypeDropDown: DropDown!
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var headerVw: NavigationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUiMethod()
        rotateImagesOnLanguage()
        headerVw.titleHeader.text = "Forget Password".localized
        emailtxtFld.addTarget(self, action: #selector(ForgotPasswordViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        headerVw.viewControl = self
        emailtxtFld.delegate = self
        self.emailtxtFld.keyboardType = .asciiCapable
        
        self.sendBtn.isUserInteractionEnabled = true
        self.emailVieww.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 32)
        self.emailtxtFld.autocorrectionType = .no
        self.emailtxtFld.textAlignment = .left
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        descrip.font = UIFont(name:"\(fontNameLight)",size:15)
        emailLbl.font = UIFont(name:"\(fontNameLight)",size:13)
        forgetTitle.font = UIFont(name:"\(fontNameBold)",size:16)
        emailtxtFld.font = UIFont(name:"\(fontNameLight)",size:14)
        sendBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:13)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let value = ModalController.isValidEmail(testStr: emailtxtFld.text!)

        if value{
            emailVieww.borderColor = #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1)
        }else{
            emailVieww.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
        }
        
        requiredFields(email: emailtxtFld.text!, user: userTypeDropDown.text!)
    }
    @IBAction func userTypeCLicked(_ sender: UIButton) {
        let vc = PopUpBelowViewController(nibName: "PopUpBelowViewController", bundle: nil)
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
    func rotateImagesOnLanguage(){
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"
            {
                let img = UIImage(named: "backgroundImage")
                let image = UIImage(cgImage: (img?.cgImage)!, scale: (img?.scale)!, orientation: UIImage.Orientation.upMirrored)
                bgImage.image = image
            }
            else if value[0]=="en"
            {
                let image = UIImage(named: "backgroundImage")
                bgImage.image = image
            }
        }
    }
    
    
    func setupUiMethod(){
        userTypeDropDown.text = "Business Owner".localized
        self.sendBtn.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 110)
         self.usertypeVw.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 32)
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
            if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
             if value[0]=="ar"
             {
                userTypeDropDown.semanticContentAttribute = .forceRightToLeft
                  userTypeDropDown.rightViewMode = .always
             }
             else if value[0]=="en"
             {
               
                  userTypeDropDown.semanticContentAttribute = .forceLeftToRight
                  userTypeDropDown.leftViewMode = .always
             }
         }
              //  userTypeDropDown.leftViewMode = .always
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    
    func requiredFields(email:String,user:String){
        let value = ModalController.isValidEmail(testStr: emailtxtFld.text!)
        if !value || user == ""{
            
            self.sendBtn.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            self.sendBtn.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
            
        }else{
            self.sendBtn.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
            self.sendBtn.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
        }
    }
    
 
    
    
    
    @IBAction func sendBtn(_ sender: Any) {
        
        
        if userTypeDropDown.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please select User Type")
            return
        }
        
        let value = ModalController.isValidEmail(testStr: emailtxtFld.text!)
        if  emailtxtFld.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.emailAddress.localized)
            return
        }
        if !value{
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.WrongemailAddress.localized)
            return
        }
        
        
        
        
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.get_user_type)"
        let parameters = [
            "email": emailtxtFld.text!,
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
      //      ModalClass.stopLoading()
            if success == true {
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
                    ModalController.showNegativeCustomAlertWith(title: "", msg: (ResponseDict.object(forKey: "error_description") as? String)!)
                    ModalClass.stopLoading()
                    return
                }
                else{
                   var apiType = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "user_type") as! String
                    self.forgotPasswordAPI(type: apiType)
                    
                        }
                    }
        }
    }
    
    
    
    
    func forgotPasswordAPI(type : String){

        
//        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.ForgotPswd)"
        
//        var type = ""
//        if userTypeDropDown.text! == "Business Owner".localized {
//            type = "BO"
//        }else if userTypeDropDown.text! == "Agent Company".localized {
//            type = "AC"
//        }else if userTypeDropDown.text! == "Agent Individual".localized {
//            type = "AI"
//        }
        
        
        let parameters = [
            "email":emailtxtFld.text!,
            "user_type":"\(type)","lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ] as [String : Any]
        
        print("request -",parameters)
        
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            
            ModalClass.stopLoading()
            
            if success == true {
                
                self.Forgot_Password = try! JSONDecoder().decode(ForgotPassword.self, from: resp as! Data)
                
                if self.Forgot_Password!.error! {
                    
                    ModalController.showNegativeCustomAlertWith(title:(self.Forgot_Password?.error_description)!, msg: "")
                    
                }
                    
                else{
                    
                    
                    let vc = ResetPasswordViewController(nibName: "ResetPasswordViewController", bundle: nil)
                    vc.fyId = self.Forgot_Password?.data?.fynoo_id
                    vc.email = self.emailtxtFld.text!
                    vc.type = type
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                    
                    
                }
                
            }
                
            else{
                
                if response == nil
                    
                {
                    
                    print ("connection error")
                    
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                    
                }else{
                    
                    print ("data not in proper json")
                    
                }
                
            }
            
        }
        
        
    }
}

extension ForgotPasswordViewController : PopupSelectedVal{
    func selectedOption(str: String) {
        print(str)
        self.usertypeVw.borderColor = #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1)
        self.userTypeDropDown.text = str
        if str == "Agent Individual".localized {
            userTypee.image = #imageLiteral(resourceName: "user")
        }else if str == "Agent Company".localized {
            userTypee.image = #imageLiteral(resourceName: "businessCompnayLogo")
        }else if str == "Business Owner".localized {
     //       userTypee.image = #imageLiteral(resourceName: "inStore_inactive")
           userTypee.image = UIImage(named: "BO_NEW")
        }
        
        requiredFields(email: emailtxtFld.text!, user: self.userTypeDropDown.text!)
        
        
       
    }
}
