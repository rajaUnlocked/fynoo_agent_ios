//
//  ResetPasswordViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-049 on 17/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import KWVerificationCodeView

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var confirmPswdTxtFld: UITextField!
    var fyId:String?
    
    @IBOutlet weak var descri: UILabel!
    @IBOutlet weak var resetTitle: UILabel!
    @IBOutlet weak var otpTitle: UILabel!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var counterText: UILabel!
    @IBOutlet weak var confirmLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var headerVw: NavigationView!
    @IBOutlet weak var newPswdTxtFld: UITextField!
    @IBOutlet weak var saveBtnOutlet: UIButton!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var confirmVw: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var keyImage: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var counterTime: UILabel!
    @IBOutlet weak var resendView: UIView!
    @IBOutlet weak var resendOtp: UIButton!
    @IBOutlet weak var showPassword: UIButton!
    @IBOutlet weak var counterrText: UILabel!
    @IBOutlet weak var showCnfPassword: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text4: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text2: UITextField!
    var type = ""
    var email = ""
    var timer: Timer?
    var counter = 60
    var  Reset_Password:ResetPassword?
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        
        setupUIMEthod()
        rotateImagesOnLanguage()
        
        self.saveBtnOutlet.setAllSideShadow(shadowShowSize: 3.0)
        self.resendView.setAllSideShadow(shadowShowSize: 3.0)
        self.passView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 40)
        self.confirmVw.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 40)
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        confirmPswdTxtFld.delegate = self
        confirmPswdTxtFld.tag = 1002
        newPswdTxtFld.tag = 1000
        newPswdTxtFld.delegate = self
        showPassword.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        showCnfPassword.addTarget(self, action: #selector(showPassword(_:)), for: .touchUpInside)
        self.navigationController?.isNavigationBarHidden = true
        self.headerVw.titleHeader.text = "Reset Password".localized
        self.headerVw.viewControl = self
      
        resendOtp.setTitleColor(#colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1), for: .normal)
        resendView.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        if let imageView = self.view.viewWithTag(1009) as? UIImageView{
            imageView.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
        
        if HeaderHeightSingleton.shared.LanguageSelected == "AR"{
            
            otpView.semanticContentAttribute = .forceLeftToRight
        }
        resendOtp.isUserInteractionEnabled = false
        
        text1.delegate = self
        text2.delegate = self
        text3.delegate = self
        text4.delegate = self
        
        text4.tag = 10000
        text1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        text2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        text3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        text4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        
        text1.textAlignment = .center
        text2.textAlignment = .center
        text3.textAlignment = .center
        text4.textAlignment = .center
        
        self.newPswdTxtFld.keyboardType = .asciiCapable
        self.confirmPswdTxtFld.keyboardType = .asciiCapable
        self.confirmPswdTxtFld.autocorrectionType = .no
        otpTime()
        self.newPswdTxtFld.textAlignment = .left
        self.confirmPswdTxtFld.textAlignment = .left
        
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        newPswdTxtFld.font = UIFont(name:"\(fontNameLight)",size:13)
        confirmPswdTxtFld.font = UIFont(name:"\(fontNameLight)",size:13)
        resetTitle.font = UIFont(name:"\(fontNameBold)",size:16)
        descri.font = UIFont(name:"\(fontNameLight)",size:14)
        passwordLbl.font = UIFont(name:"\(fontNameLight)",size:13)
        confirmLbl.font = UIFont(name:"\(fontNameLight)",size:13)
        counterrText.font = UIFont(name:"\(fontNameLight)",size:13)
        otpTitle.font = UIFont(name:"\(fontNameLight)",size:12)
        saveBtnOutlet.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:13)
        resendOtp.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:13)
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
                        //print
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
    
    func setupUIMEthod(){

        self.newPswdTxtFld.tag = 1000
        self.confirmPswdTxtFld.tag = 1002
        self.newPswdTxtFld.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        self.confirmPswdTxtFld.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
     var isPassMatch = false
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
            
            if text?.count == 1 {
                switch textField{
                case text1:
                    text2.becomeFirstResponder()
                case text2:
                    text3.becomeFirstResponder()
                case text3:
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
        
        if textField.tag == 1000{
            if textField.text!.validPassword{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: passView)
                comparePassword(passString: newPswdTxtFld.text!, compare: confirmPswdTxtFld.text!)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: passView)
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: confirmVw)
                showCnfPassword.setImage(UIImage(named:"eye_new_hide"), for: .normal)
                showCnfPassword.isUserInteractionEnabled = true
            }
        }
        else if textField.tag == 1002{
            
            if textField.text!.validPassword{
              comparePassword(passString: newPswdTxtFld.text!, compare: confirmPswdTxtFld.text!)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: confirmVw)
                showCnfPassword.setImage(UIImage(named:"eye_new_hide"), for: .normal)
                showCnfPassword.isUserInteractionEnabled = true
            }
            
        }
        let image = UIImage(named:"greenTick")
        let currentImage = showCnfPassword.currentImage
        
        if text1.text != "" && text2.text != "" && text3.text != "" && text4.text != "" && currentImage == image && newPswdTxtFld.text?.containArabicNumber == true {
            saveBtnOutlet.borderColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
            saveBtnOutlet.setTitleColor(#colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1), for: .normal)
        }else{
            saveBtnOutlet.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
            saveBtnOutlet.setTitleColor(#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), for: .normal)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if text4.text!.count == 0{
            text3.resignFirstResponder()

        }
        return true
    }
    
    func comparePassword(passString:String,compare:String){
        if  passString == compare {
            ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: confirmVw)
            showCnfPassword.setImage(UIImage(named:"greenTick"), for: .normal)
            showCnfPassword.isUserInteractionEnabled = false
        }else{
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: confirmVw)
            showCnfPassword.setImage(UIImage(named:"eye_new_hide"), for: .normal)
            showCnfPassword.isUserInteractionEnabled = true
        }
    }
    
    
    
    func rotateImagesOnLanguage(){
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
//                let img = UIImage(named: "backgroundImage")
//                let image = UIImage(cgImage: (img?.cgImage)!, scale: (img?.scale)!, orientation: UIImage.Orientation.upMirrored)
//                bgImage.image = image
                
                let img1 = UIImage(named: "resetpass_icon")
                let image1 = UIImage(cgImage: (img1?.cgImage)!, scale: (img1?.scale)!, orientation: UIImage.Orientation.upMirrored)
                keyImage.image = image1
            }
            else if value[0]=="en"{
//                let image = UIImage(named: "backgroundImage")
//                bgImage.image = image
                
                let image1 = UIImage(named: "resetpass_icon")
                keyImage.image = image1
            }
        }
    }
    
    @objc  func showPassword(_ sender : UIButton){
        
        if sender.tag == 100{
            if newPswdTxtFld.isSecureTextEntry == true{
                newPswdTxtFld.isSecureTextEntry = false
                showPassword.setImage(UIImage(named:"eye"), for: .normal)
            }else{
                newPswdTxtFld.isSecureTextEntry = true
                showPassword.setImage(UIImage(named:"eye_new_hide"), for: .normal)
            }
        }
        else{
            if confirmPswdTxtFld.isSecureTextEntry == true{
                confirmPswdTxtFld.isSecureTextEntry = false
                showCnfPassword.setImage(UIImage(named:"eye"), for: .normal)
            }else{
                confirmPswdTxtFld.isSecureTextEntry = true
                showCnfPassword.setImage(UIImage(named:"eye_new_hide"), for: .normal)
            }
        }
    }
    
    func resendOtps(){
        
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.ForgotPswd)"
        
        let parameters = [
            "email":email,
            "user_type":"\(type)","lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ] as [String : Any]
        
        print("request -",parameters)
        
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            
            ModalClass.stopLoading()
            
            if success == true {
                self.otpTime()
                
            }
                
            else{
                
                if response == nil
            {                    print ("connection error")
                    
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
            imageView.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
        resendView.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        resendOtps()
        
        resendOtp.isUserInteractionEnabled = false
        
        
    }
    
    @objc func action () {
    
        counter -= 1
        let minutes = Int(counter) / 60 % 60
        let seconds = Int(counter) % 60
        let please = "Please wait".localized
        let before  = "before requesting\nanother Email Code".localized
        let str = (String(format:"%02i:%02i", minutes, seconds))
        counterrText.text="\(please) \(str) \(before)"
         counterTime.text = "\(str)"
        if counter == 0{
            timer?.invalidate()
            resendOtp.setTitleColor(#colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1), for: .normal)
            if let imageView = self.view.viewWithTag(1009) as? UIImageView{
                imageView.tintColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
            }
         //   counter = 60
            resendOtp.isUserInteractionEnabled = true
            resendView.borderColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        
    
        print("print")
        if textField.tag == 1002 || textField.tag == 1000{
            
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
           
        
        else{
            let maxLength = 1
                       let currentString: NSString = textField.text as! NSString
                       let newString: NSString =
                           currentString.replacingCharacters(in: range, with: string) as NSString
                       return newString.length <= maxLength
        }
        
    }
    
    
//
//    func textFieldDidEndEditing(_ textField: UITextField){
//
//    var isPassMatch = false
//
//                  if textField.tag == 1000{
//                       if textField.text == newPswdTxtFld.text {
//
//                        if  textField.text!.count > 8  ||  textField.text!.count == 8{
//                            showCnfPassword.isUserInteractionEnabled = false
//                            showCnfPassword.setImage(UIImage(named:"greenTick"), for: .normal)                            saveBtnOutlet.borderColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
//                            saveBtnOutlet.setTitleColor(#colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1), for: .normal)
//                            saveBtnOutlet.isUserInteractionEnabled = true
//                            isPassMatch = true
//                        }else{
//                            showCnfPassword.isUserInteractionEnabled = true
//                            showCnfPassword.setImage(UIImage(named:"eye_new_hide"), for: .normal)
//                            saveBtnOutlet.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
//                            saveBtnOutlet.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
//                            saveBtnOutlet.isUserInteractionEnabled = false
//                            isPassMatch = false
//                        }
//                       }else{
//                           showCnfPassword.isUserInteractionEnabled = true
//                           showCnfPassword.setImage(UIImage(named:"eye_new_hide"), for: .normal)
//                           saveBtnOutlet.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
//                           saveBtnOutlet.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
//                           saveBtnOutlet.isUserInteractionEnabled = false
//                        isPassMatch = false
//                       }
//                   }else if textField.tag == 1002{
//                       if textField.text == confirmPswdTxtFld.text && (textField.text!.count > 8  ||  textField.text!.count == 8){
//
//                           showCnfPassword.isUserInteractionEnabled = false
//                           showCnfPassword.setImage(UIImage(named:"greenTick"), for: .normal)
//                           saveBtnOutlet.borderColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
//                           saveBtnOutlet.setTitleColor(#colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1), for: .normal)
//                           saveBtnOutlet.isUserInteractionEnabled = true
//                         isPassMatch = true
//                       }else{
//                           showCnfPassword.isUserInteractionEnabled = true
//                           showCnfPassword.setImage(UIImage(named:"eye_new_hide"), for: .normal)
//                           saveBtnOutlet.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
//                           saveBtnOutlet.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
//                           saveBtnOutlet.isUserInteractionEnabled = false
//                         isPassMatch = false
//                       }
//                   }
//
//
//        if newPswdTxtFld.text!.isEmpty || confirmPswdTxtFld.text!.isEmpty || text1.text!.isEmpty || text2.text!.isEmpty || text3.text!.isEmpty || text4.text!.isEmpty {
//            saveBtnOutlet.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
//            saveBtnOutlet.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
//            saveBtnOutlet.isUserInteractionEnabled = false
//            if isPassMatch {
//
//            }else{
//                showCnfPassword.setImage(UIImage(named:"eye_new_hide"), for: .normal)
//
//            }
//
//        }else{
//            if textField.tag == 10000{
//                showCnfPassword.isUserInteractionEnabled = false
//                showCnfPassword.setImage(UIImage(named:"greenTick"), for: .normal)
//                saveBtnOutlet.borderColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
//                saveBtnOutlet.setTitleColor(#colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1), for: .normal)
//                saveBtnOutlet.isUserInteractionEnabled = true
//            }
//        }
//
//    }
//
    @IBAction func save(_ sender: Any) {
        self.view.endEditing(true)
        
        if text1.text == "" || text2.text == "" || text3.text == "" || text4.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.verifyOTP.localized)
            return
        }
        
        if newPswdTxtFld.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.password.localized)
            return
        }
        
        if newPswdTxtFld.text!.count < 8 {
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passwordCount.localized)
            return
        }
        if !newPswdTxtFld.text!.containArabicNumber{
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passArabicNumber)
            return
            
        }
        if confirmPswdTxtFld.text == ""{
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.confPassss.localized)
            return
        }
        if newPswdTxtFld.text != confirmPswdTxtFld.text {
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.confirmPassword.localized)
            return
        }
        
        
        //        if text1.text!.isEmpty || text2.text!.isEmpty || text3.text!.isEmpty || text4.text!.isEmpty {
        //            return
        //        }
        //
        //        if newPswdTxtFld.text?.count ?? 0 < 8
        //        {
        //            ModalController.showNegativeCustomAlertWith(title:ValidationMessages.passwordCount, msg: "")
        //            return
        //        }
        //        if newPswdTxtFld.text == confirmPswdTxtFld.text{
        //
        //            //            for controller in self.navigationController!.viewControllers as Array {
        //            //                if controller.isKind(of: LoginViewController.self) {
        //            //                    self.navigationController!.popToViewController(controller, animated: true)
        //            //
        //            //
        //            //
        //            //                    break
        //            //                }
        //            // }
        //
        //        }
        //        else{
        //            ModalController.showNegativeCustomAlertWith(title: "The passwords does not match", msg: "")
        //        }
        
        
        ResetPasswordAPI()
        
    }

    func ResetPasswordAPI(){
        ModalClass.startLoading(self.view)
        
        let device_id = UIDevice.current.identifierForVendor!.uuidString
        
        let str = "\(Constant.BASE_URL)\(Constant.ResetPswd)"
        
        let parameters = [
            
            "fynoo_id":fyId!,
            "verification_code":"\(text1.text!)" + "\(text2.text!)" + "\(text3.text!)" + "\(text4.text!)",
            "new_pwd":newPswdTxtFld.text!,"lang_code":HeaderHeightSingleton.shared.LanguageSelected
            
            
            ] as [String : Any]
        
        print("request -",parameters)
        
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            
            ModalClass.stopLoading()
            
            if success == true {
                
                self.Reset_Password = try! JSONDecoder().decode(ResetPassword.self, from: resp as! Data)
                                    
                    if self.Reset_Password?.error == false
                    {
                        ModalController.showSuccessCustomAlertWithoutImage(title: "", msg: (self.Reset_Password?.error_description)!)
                        for controller in self.navigationController!.viewControllers as Array {
                            if controller.isKind(of: LoginNewDesignViewController.self) {
                                self.navigationController!.popToViewController(controller, animated: true)
                                
                                break
                            }
                        }
                    }
                    else{
                        ModalController.showNegativeCustomAlertWith(title: "", msg: (self.Reset_Password?.error_description)!)
                    }
                
            }else{
                if response == nil                {
                    
                    print ("connection error")
                    
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                    
                }else{
                    
                    print ("data not in proper json")
                    
                }
                
            }
            
        }
    }
}
