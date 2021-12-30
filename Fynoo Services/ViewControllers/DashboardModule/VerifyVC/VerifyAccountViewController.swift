//
//  VerifyAccountViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 21/06/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import KWVerificationCodeView
class VerifyAccountViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var backNewOutlet: UIButton!
    @IBOutlet weak var counterrText: UILabel!
    @IBOutlet weak var text4: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var downImage: UIImageView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var verifyLbl: UILabel!
    @IBOutlet weak var otpView: UIView!
    
    @IBOutlet weak var counterTime: UILabel!
    @IBOutlet weak var resendView: UIView!
    @IBOutlet weak var resendOtp: UIButton!
    @IBOutlet weak var email: UILabel!
    var isFromAgent : Bool = true
    var verifyAccountModal = VerifyAccountModal()
    var timer: Timer?
    var counter = 60
    var fynooId = ""
    var mobile = ""
    var emailId = ""
    var mobileCode = ""
    
    @IBOutlet weak var otp: UILabel!
    @IBAction func backbutton(_ sender: UIButton) {
    }
    @IBAction func backNew(_ sender: Any) {
        var isLoginThere = false
        
        AuthorisedUser.shared.removeAuthorisedUser()
        ModalController.removeTheContentForKey("AgentDashboardData")
        
        if var viewControllers = self.navigationController?.viewControllers {
            for controller in viewControllers {
                if controller is LoginNewDesignViewController {
                    isLoginThere = true
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: LoginNewDesignViewController.self) {
                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    }
                }
            }
        }
        
        if isLoginThere == false {
            let vc = LoginNewDesignViewController(nibName: "LoginNewDesignViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBOutlet var resentOTPBtn: UIButton!
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        
        let redTapImage = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"back_new")!)
        backNewOutlet.setImage(redTapImage, for: .normal)
        
//        downImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        headerView.titleHeader.text = "Verification".localized
        self.headerView.viewControl = self
        self.headerView.backButton.isHidden = true
       
        
        let intLetterss = emailId.prefix(3)
        let endLetterss = emailId.suffix(3)
        let newStrings = intLetterss + "*****" + endLetterss
        print(newStrings)
        email.text = "\(newStrings)"
       
        resendOtp.setTitleColor(#colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1), for: .normal)
        resendView.borderColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
        if let imageView = self.view.viewWithTag(1009) as? UIImageView{
            imageView.tintColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
        }
        resendOtp.isUserInteractionEnabled = false
        text1.delegate = self
        text2.delegate = self
        text3.delegate = self
        text4.delegate = self
        text4.tag=1009
        text3.tag = 10009
        text2.tag = 10008
        text1.tag = 100010
        text1.textAlignment = .center
        text2.textAlignment = .center
        text3.textAlignment = .center
        text4.textAlignment = .center
        
        text1.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
        text1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        text2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        text3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        text4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        if HeaderHeightSingleton.shared.LanguageSelected == "AR"{
            
            otpView.semanticContentAttribute = .forceLeftToRight
        }
        self.resendView.setAllSideShadow(shadowShowSize: 2.0)
        self.otpTime()
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")

        verifyLbl.font = UIFont(name:"\(fontNameBold)",size:16)
        email.font = UIFont(name:"\(fontNameLight)",size:12)
        otp.font = UIFont(name:"\(fontNameLight)",size:12)
        counterrText.font = UIFont(name:"\(fontNameLight)",size:12)
        resendOtp.titleLabel?.font=UIFont(name:"\(fontNameLight)",size:12)
       
        resendOtps()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//        resendOtps()
//    }
//
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
   
    
    }
    
    func otpTime(){
        
        let url = "\(Authentication.otpExpireTime)"
        let param = ["user_type":"BO","lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        ServerCalls.postRequest(url, withParameters: param) { (response,success) in
            if success{
                if let value = response as? NSDictionary{
                    let time = value.object(forKey: "otp_time") as! String
                    self.counter = Int(time)!
                    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.action), userInfo: nil, repeats: true)
        
                }
            }
                
            else{
                
                if response == nil{
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                }else{
                    print ("data not in proper json")
                }
                
            }
        }
    }
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        
        if text1.text!.isEmpty{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: text1)
        }else{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: text1)
        }
        if text2.text!.isEmpty{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: text2)
        }else{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: text2)
        }
        
        if text3.text!.isEmpty{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: text3)
        }else{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: text3)
        }
        if text4.text!.isEmpty{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: text4)
        }else{
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: text4)
        }
        
        
        
        if  text?.count == 1 {
            switch textField{
            case text1:
                
                text2.becomeFirstResponder()
            case text2:
                
                text3.becomeFirstResponder()
            case text3:
                
                text4.becomeFirstResponder()
            case text4:
                
                text4.becomeFirstResponder()
            default:
                break
            }
        }else if text?.count == 0{
                switch textField{
                case text1:
                    text1.becomeFirstResponder()
                case text2:
                    text1.becomeFirstResponder()
                case text3:
                    text2.becomeFirstResponder()
                case text4:
                    text3.becomeFirstResponder()
                default:
                    break
                }
            }
            else{
                
        }
        
        
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
//        if textField.tag == 1009 || textField.tag == 10009 || textField.tag == 10008 || textField.tag == 100010{
//
//            var letters = string.map { String($0) }
//            for i in 0..<string.count{
//
//                if !letters[i].containArabicNumber{
//                    ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.otpArabic)
//                    letters[i] = ""
//                    return false
//                }
//
//            }
//            return true
//
//        }
        
        
          let maxLength = 1
          let currentString: NSString = textField.text as! NSString
          let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
          return newString.length <= maxLength
      }
    
   
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.tag == 1009{
            saveClicked()
        }else{
            if text1.text != "" && text2.text != "" && text3.text != "" && text4.text != ""{
                saveClicked()
            }
        }
    }
    
    func saveClicked(){
        if text1.text!.isEmpty || text2.text!.isEmpty || text3.text!.isEmpty || text4.text!.isEmpty {
                   return
               }
               

        let codeEntered = "\(text1.text!)" + "\(text2.text!)" + "\(text3.text!)" + "\(text4.text!)"
               if codeEntered.count == 0 || codeEntered == " "{
                   return
               }
               verifyAccountModal.verificationCode = codeEntered
               verifyAccountModal.fynoo_id = fynooId
               let(isFilled, message) = verifyAccountModal.normalOPTVarificationValidation()
               if isFilled{
                   ModalClass.startLoading(self.view)
                   verifyAccountModal.verifyOtp { (success, msg) in
                       ModalClass.stopLoading()
                       if success{
                           print("userData-",AuthorisedUser.shared.getAuthorisedUser())
                           let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
                           var userType = ""
                           var isNewUser = ""
                           if let fynooUserType = userid.data?.user_type {
                               userType = fynooUserType
                           }
                           isNewUser = ModalController.toString(userid.data?.is_new_user)
                           print("userType:-", userType)
                           print("isNewUser:-", isNewUser)
                           if isNewUser == "1" {
                               //                         {
                               let vc = SuccesssViewController(nibName: "SuccesssViewController", bundle: nil)
                               vc.newUser = isNewUser
                           
                            vc.isFromAgentSignUp = self.isFromAgent
                               self.navigationController?.pushViewController(vc, animated: false)
                             
                           }else {
                               
                            if userid.data!.is_language_added == true {
                                let vc = AgentDashboardViewController(nibName: "AgentDashboardViewController", bundle: nil)
                                self.navigationController?.pushViewController(vc, animated: true)
                            }else{
                                let vc = LanguageSelectionViewController(nibName: "LanguageSelectionViewController", bundle: nil)
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                              
                               
                           }
                           
                       }else{
                           ModalController.showNegativeCustomAlertWith(title: "", msg: msg!)
                       }
                   }
               }else{
                   ModalController.showNegativeCustomAlertWith(title: "", msg: message)
               }
               
    }
    @IBAction func submit(_ sender: UIButton) {
        self.view.endEditing(true)
       
        
        
        
    }
    func resendOtps(){
        
        ModalClass.startLoading(self.view)
        let str = "\(Authentication.resentVerifyOtp)"
        
   //     let parameters = ["fynoo_id":fynooId] as [String : Any]
        
        let parameters = ["fynoo_id":fynooId,"lang_code":HeaderHeightSingleton.shared.LanguageSelected] as [String : Any]
        
        print("request -",parameters)
        
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            
            ModalClass.stopLoading()
            
                        if success == true {
                        
                            self.otpTime()
                            ModalController.showSuccessCustomAlertWith(title: "", msg: "\(response?.object(forKey: "error_description") as! String)")
            }
            else{
                if response == nil{
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
        }
    }
    
    
    @IBAction func resendOtp(_ sender: Any) {
        
        resendOtp.setTitleColor(#colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1), for: .normal)
        if let imageView = self.view.viewWithTag(1009) as? UIImageView{
            imageView.tintColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
        }
        resendView.borderColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
        resendOtps()
        
       
        resendOtp.isUserInteractionEnabled = false
       // timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
        
    }
    
    @objc func action () {
        
        counter -= 1
        let minutes = Int(counter) / 60 % 60
         let seconds = Int(counter) % 60
        
         let str = (String(format:"%02i:%02i", minutes, seconds))
        
        let please = "Please wait".localized
        let before  = "before requesting\nanother Email Code".localized
        
        
         counterrText.text="\(please) \(str) \(before)"
          counterTime.text = "\(str)"
        if counter == 0{
            timer?.invalidate()
            resendOtp.setTitleColor(#colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1), for: .normal)
            if let imageView = self.view.viewWithTag(1009) as? UIImageView{
                imageView.tintColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
            }
            resendOtp.isUserInteractionEnabled = true
            resendView.borderColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        
    }
}
extension UITextField {
    
    
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(x: 10, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        
    }
}
