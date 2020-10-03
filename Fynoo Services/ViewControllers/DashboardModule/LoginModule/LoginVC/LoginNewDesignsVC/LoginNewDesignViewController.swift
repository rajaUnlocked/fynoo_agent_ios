//
//  LoginNewDesignViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-049 on 02/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import iOSDropDown
import MTPopup


class LoginNewDesignViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LoginNewSecondTableViewCellDelegate,UITextFieldDelegate {

    let scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width,height: (UIScreen.main.bounds.height/2) - 40))
        var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
     var timer = Timer()
    @IBOutlet weak var pageCntrl: UIPageControl!
     @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var languageBtnOutlet: UIButton!
    @IBOutlet weak var tableVw: UITableView!
    var isPasswordSecure = true
    var firstType = "Business Owner".localized
    var isRememberSelected = false
    var email = ""
    var password = ""
    var logInViewModal = LoginModal()
    var selectedType = "Business Owner".localized
//    var selectedType = ""
    var typeImageIndex = 0
    @IBOutlet weak var centreArabic: NSLayoutConstraint!
    @IBOutlet weak var arabicText: UILabel!
    @IBOutlet weak var centers: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollUI()
        
        setupUI()
        registerCellNibs()
        rotateImagesOnLanguage()
        checkForRememberUser()
    }
    override func viewWillAppear(_ animated: Bool) {
        AuthorisedUser.shared.removeAuthorisedUser()
        ModalController.removeTheContentForKey("AgentDashboardData")
        ModalController.removeTheContentForKey("profile_img")
        
        if  HeaderHeightSingleton.shared.LanguageSelected == "AR"{
            arabicText.font = UIFont(name: "KFGQPC Uthmanic Script HAFS", size: 25)
            centers.constant = 40
            centreArabic.constant = 40
        }else{
           
        }
    }

    func setupScrollUI(){
     //   timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
               configurePageControl()
               
               scrollView.delegate = self
               scrollView.isPagingEnabled = true
               scrollView.showsHorizontalScrollIndicator = false
     //          self.infoView.addSubview(scrollView)
               for index in 0..<5 {
                   
                   frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
                   frame.size = self.scrollView.frame.size
                   if index == 0 {
                       let setView = Bundle.main.loadNibNamed("LoginIntroFirst", owner: nil, options: nil)?[0] as? LoginIntroFirst
                       setView?.frame = frame
                   
                       if let setView = setView {
                       scrollView.addSubview(setView)
                       }
                   }
                   else if index == 1 {
                       let setView = Bundle.main.loadNibNamed("LoginIntroSecond", owner: nil, options: nil)?[0] as? LoginIntroSecond
                       setView?.frame = frame
                       
                       if let setView = setView {
                           scrollView.addSubview(setView)
                       }
                   }
                    else if index == 2 {
                        let setView = Bundle.main.loadNibNamed("LoginIntroThird", owner: nil, options: nil)?[0] as? LoginIntroThird
                        setView?.frame = frame
                        
                        if let setView = setView {
                            scrollView.addSubview(setView)
                        }
                    }
                    else if index == 3 {
                        let setView = Bundle.main.loadNibNamed("LoginIntroFourth", owner: nil, options: nil)?[0] as? LoginIntroFourth
                        setView?.frame = frame
                        
                        if let setView = setView {
                            scrollView.addSubview(setView)
                        }
                    }
                   else{
                       let setView = Bundle.main.loadNibNamed("LoginIntroFifth", owner: nil, options: nil)?[0] as? LoginIntroFifth
                       setView?.frame = frame
                       
                       if let setView = setView {
                           scrollView.addSubview(setView)
                       }
                   }
               }
               self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 5,height: self.scrollView.frame.size.height)
               pageCntrl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
    }
    func rotateImagesOnLanguage(){
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"
            {
                let img = UIImage(named: "semicircle_new")
                let image = UIImage(cgImage: (img?.cgImage)!, scale: (img?.scale)!, orientation: UIImage.Orientation.upMirrored)
                languageBtnOutlet.setImage(image, for: .normal)
                
                let img1 = UIImage(named: "backgroundImage")
                let image1 = UIImage(cgImage: (img1?.cgImage)!, scale: (img1?.scale)!, orientation: UIImage.Orientation.upMirrored)
                bgImage.image = image1
            }
            else if value[0]=="en"
            {
                let image = UIImage(named: "semicircle_new")
                languageBtnOutlet.setImage(image, for: .normal)
                
                let image1 = UIImage(named: "backgroundImage")
                bgImage.image = image1
            }
        }
    }
    
    func setupUI() {
        
        self.selectedType = "Business Owner".localized
        let  userType = ModalController.getTheContentForKey("rememberType") as? String
        if let user = userType {
            firstType = user
            
            if firstType == "Business Owner".localized {
                typeImageIndex = 0
                selectedType = "Business Owner".localized
            }else if firstType == "Agent Company".localized {
                typeImageIndex = 2
                selectedType = "Agent Company".localized
            }else if firstType == "Agent Individual".localized {
                typeImageIndex = 1
                selectedType = "Agent Individual".localized
            }
        }else{
//            firstType = "Business Owner".localized
 //           firstType = ""
  //          selectedType = ""
  //              typeImageIndex = 5
        }
    }
    
    @IBAction func languageChange(_ sender: Any) {
        
        print(HeaderHeightSingleton.shared.LanguageSelected)
        if  HeaderHeightSingleton.shared.LanguageSelected == "EN"{
            
              self.selectStore(store: "arabic")
            
        }else{
           self.selectStore(store: "english")
        }
    }
//        let alert = UIAlertController(title: "Language", message: "Please Select Your Language", preferredStyle: .actionSheet)
//
//        alert.addAction(UIAlertAction(title: "English", style: .default , handler:{ (UIAlertAction)in
//            print("User click Approve button")
//
//
//        }))
//
//        alert.addAction(UIAlertAction(title: "Arabic", style: .default , handler:{ (UIAlertAction)in
//            print("User click Edit button")
//
//
//        }))
//
//
//
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler:{ (UIAlertAction)in
//            print("User click Dismiss button")
//        }))
//
//        self.present(alert, animated: true, completion: {
//            print("completion block")
//        })
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 1000{
            email = textField.text!
        }else{
            password = textField.text!
        }
        let index = IndexPath(row: 0, section: 1)
        let cell1: LoginNewSecondTableViewCell = self.tableVw.cellForRow(at: index) as! LoginNewSecondTableViewCell
        let typeStr = cell1.userTypeField.text!
        if typeStr == "" {
            cell1.loginBtnOutlet.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
            cell1.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), for: .normal)
           
        }
        let value = ModalController.isValidEmail(testStr: email)
        if value{
            cell1.emailView.borderColor = #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1)
        }else{
            cell1.emailView.borderColor = #colorLiteral(red: 0.9490196078, green: 0.3882352941, blue: 0.3960784314, alpha: 1)
        }
        if password.validPassword{
            cell1.passwordView.borderColor = #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1)
        }else{
            cell1.passwordView.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
        }
        if selectedType != "" &&  value == true && email != "" && password != "" && password.validPassword == true{
            cell1.loginBtnOutlet.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
            cell1.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
        }else{
            cell1.loginBtnOutlet.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
            cell1.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), for: .normal)
        }
        if !password.containArabicNumber{
            password = String(password.dropLast())
            cell1.passwordField.text = password
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passArabicNumber)
        }
    }
    
//    private func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
//
//        let   cell = tableVw.cellForRow(at: IndexPath(row:0 , section: 1)) as! LoginNewSecondTableViewCell
//        let str = cell.passwordField.text
//
//        guard let stringRange = Range(range,in: str!) else {
//            return false
//        }
//        print(stringRange)
//        print(str)
//        let updateText =  str!.replacingCharacters(in: stringRange, with: string)
//        return true
//
        
        
//        if let text = passwordField.text as NSString? {
//            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
//            if !txtAfterUpdate.containArabicNumber{
//                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passArabicNumber)
//                return true
//            }
//        }
//        return true
 //   }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField.tag == 1000{
//            email = textField.text!
//        }else{
//            password = textField.text!
//        }
//        let index = IndexPath(row: 0, section: 1)
//        let cell1: LoginNewSecondTableViewCell = self.tableVw.cellForRow(at: index) as! LoginNewSecondTableViewCell
//        let typeStr = cell1.userTypeField.text!
//        if typeStr == "" {
//            cell1.loginBtnOutlet.isUserInteractionEnabled = false
//            cell1.loginBtnOutlet.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
//             cell1.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), for: .normal)
//            return
//        }
//
//        if email != "" && password != ""{
//             let cell = tableVw.cellForRow(at: IndexPath(row: 0, section: 1)) as! LoginNewSecondTableViewCell
//            cell.loginBtnOutlet.isUserInteractionEnabled = true
//            cell.loginBtnOutlet.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
//            cell.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
//        }else{
//            let cell = tableVw.cellForRow(at: IndexPath(row: 0, section: 1)) as! LoginNewSecondTableViewCell
//            cell.loginBtnOutlet.isUserInteractionEnabled = false
//            cell.loginBtnOutlet.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
//             cell.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), for: .normal)
//
//        }
//    }
    func selectStore(store:String?){
           if store=="arabic"{
               UserDefaults.standard.set(["ar","en"], forKey: "AppleLanguages")
            HeaderHeightSingleton.shared.LanguageSelected = "AR"
            HeaderHeightSingleton.shared.Currency = "SAR".localized
               self.view.reloadInputViews()
               UIView.appearance().semanticContentAttribute = .forceRightToLeft
           }else{
               UserDefaults.standard.set(["en","ar"], forKey: "AppleLanguages")
               self.view.reloadInputViews()
                HeaderHeightSingleton.shared.LanguageSelected = "EN"
            HeaderHeightSingleton.shared.Currency = "SAR".localized
               UIView.appearance().semanticContentAttribute = .forceLeftToRight
           }
           load_app()
       }
       
       var window: UIWindow?
    func load_app(){
        
   //     let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
  //      let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let rootviewcontroller: UIWindow = self.view.window!
        let appDelegate = SceneDelegate()
        
        let obj = LoginNewDesignViewController()
        appDelegate.nav = UINavigationController.init(rootViewController:obj)
        appDelegate.nav.navigationBar.isHidden = true
        rootviewcontroller.rootViewController = appDelegate.nav
        rootviewcontroller.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: rootviewcontroller, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
            
        }) { (finished) -> Void in
            
        }
    }
    func registerCellNibs(){
        tableVw.register(UINib(nibName: "LoginNewFirstTableViewCell", bundle: nil), forCellReuseIdentifier: "LoginNewFirstTableViewCell");
        tableVw.register(UINib(nibName: "LoginNewSecondTableViewCell", bundle: nil), forCellReuseIdentifier: "LoginNewSecondTableViewCell");
    }
    
    func checkForRememberUser(){
        var remember = ModalController.getTheContentForKey("rememberEmail")
        if !(remember is NSNull){
            email = ModalController.getTheContentForKey("rememberEmail") as! String
            password = ModalController.getTheContentForKey("rememberPassword") as! String
            isRememberSelected = true
            
            
        }
        else{
            isRememberSelected = false
        }
        self.tableVw.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    // MARK: - TableView DataSource Delegates
    func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
        return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return sliderCell(index: indexPath)
        }else{
            return entryCell(index: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        return screenHeight/2
        }else{
            return 400
        }
    }
    
    var cellHeights = [IndexPath: CGFloat]()

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? UITableView.automaticDimension
    }
    
    // MARK: - TableView Cells Return
    func sliderCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "LoginNewFirstTableViewCell",for: index) as! LoginNewFirstTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func entryCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "LoginNewSecondTableViewCell",for: index) as! LoginNewSecondTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.emailField.isUserInteractionEnabled = false
        cell.emailField.keyboardType = .asciiCapable
        cell.passwordField.keyboardType = .asciiCapable
        
        cell.emailField.addTarget(self, action: #selector(LoginNewDesignViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.passwordField.addTarget(self, action: #selector(LoginNewDesignViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
//        if firstType != "" {
//            cell.userTypeField.text = firstType
//            selectedType = firstType
//            firstType = ""
//        }else{
        cell.userTypeField.text = "Business Owner".localized
            cell.userTypeField.text = selectedType
        
        if selectedType != ""{
            cell.userTypeView.borderColor = #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1)
        }
        
        
        cell.emailField.text = email
               cell.passwordField.text = password
        if isPasswordSecure {
            
            cell.passwordField.isSecureTextEntry = true
            cell.eyeBtnOutlet.isSelected = false
        }else{
            cell.passwordField.isSecureTextEntry = false
            cell.eyeBtnOutlet.isSelected = true
        }
        let value = ModalController.isValidEmail(testStr:email)
                   if !value || email == ""{
                       cell.emailView.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
                   }else{
                       cell.emailView.borderColor = #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1)
                   }
                   if password.validPassword{
                       cell.passwordView.borderColor = #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1)
                   }else{
                       cell.passwordView.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
                   }
        if isRememberSelected {
  
            cell.loginBtnOutlet.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
            cell.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
            cell.rememberMeBtnOutlet.isSelected = true
        }else{
            cell.rememberMeBtnOutlet.isSelected = false
            cell.loginBtnOutlet.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
            cell.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), for: .normal)
        }
        
        
        let valuess = ModalController.isValidEmail(testStr: email)
        if selectedType != "" &&  valuess == true && email != "" && password != "" && password.validPassword == true{
                  cell.loginBtnOutlet.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                  cell.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
              }else{
                  cell.loginBtnOutlet.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
                  cell.loginBtnOutlet.setTitleColor(#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), for: .normal)
              }
        
        cell.emailField.isUserInteractionEnabled = true
        cell.emailField.tag = 1000
        cell.emailField.delegate = self
        cell.passwordField.delegate = self
       
     //   cell.checkLoginColor()
        
        
        let typeStr = cell.userTypeField.text!
               if typeStr == "Business Owner".localized {
                      typeImageIndex = 0
               }else if typeStr == "Agent Company".localized {
                      typeImageIndex = 2
               }else if typeStr == "Agent Individual".localized {
                      typeImageIndex = 1
                  }
        
        switch typeImageIndex {
        case 0:
            cell.userTypeImage.image = UIImage(named: "BO_NEW")
            case 1:
            cell.userTypeImage.image = UIImage(named: "agentIN_NEW")
            case 2:
            cell.userTypeImage.image = UIImage(named: "agentCom_NEW")
        default:
            cell.userTypeImage.image = UIImage(named: "userTypeNEW")
        }
        cell.makeShadowMethod()
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"
            {
                cell.emailField.textAlignment = .left
                cell.passwordField.textAlignment = .left
            }
            else if value[0]=="en"
            {
                cell.emailField.textAlignment = .left
                cell.passwordField.textAlignment = .left
            }
        }
        
        return cell
    }
    
    func userTypeBtnClicked(){
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
    
    func eyeBtnClicked(){
        let index = IndexPath(row: 0, section: 1)
        let cell: LoginNewSecondTableViewCell = self.tableVw.cellForRow(at: index) as! LoginNewSecondTableViewCell
        email = cell.emailField.text!
        password = cell.passwordField.text!
        if(isPasswordSecure)
               {
                 isPasswordSecure = false
               }
               else
               {
                    isPasswordSecure = true
               }
               tableVw.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .none)
    }
    func rememberMeBtnClicked(){
        let index = IndexPath(row: 0, section: 1)
        let cell: LoginNewSecondTableViewCell = self.tableVw.cellForRow(at: index) as! LoginNewSecondTableViewCell
        email = cell.emailField.text!
        password = cell.passwordField.text!
       if(isRememberSelected)
       {
         isRememberSelected = false
       }
       else
       {
            isRememberSelected = true
       }
       tableVw.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .none)
    }
    
    func loginBtnClicked(){
        
        
        if selectedType == ""{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please select User Type")
            return
        }
        let value = ModalController.isValidEmail(testStr:email)
        if !value || email == ""{
            if email == "" {
                ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter Email".localized)
            }else{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter valid Email".localized)
            }
            return
        }
        
        if password.count < 8 {
            if password.count == 0 {
                ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter password".localized)
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passwordCount)
            }
            
            return
        }
        if !password.containArabicNumber{
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.passArabicNumber)
            return
            
        }
        
        self.view.endEditing(true)
        let index = IndexPath(row: 0, section: 1)
        let cell: LoginNewSecondTableViewCell = self.tableVw.cellForRow(at: index) as! LoginNewSecondTableViewCell
        let typeStr = cell.userTypeField.text!
        let emailStr = cell.emailField.text!
        let passwordStr = cell.passwordField.text!
        
//        if typeStr == "Business Owner".localized {
//            logInViewModal.selectUserType = "BO"
//        }else if typeStr == "Agent Company".localized {
//            logInViewModal.selectUserType = "AC"
//        }else if typeStr == "Agent Individual".localized {
//            logInViewModal.selectUserType = "AI"
//        }
        logInViewModal.selectUserType = "AGENT"
        logInViewModal.email = emailStr
        logInViewModal.password = passwordStr
        
        let(isEmail, message) = logInViewModal.normalLoginValidation()
                
        if isEmail {
            print(isEmail)
            ModalClass.startLoading(self.view)
   
    var apiType = ""
            
            let str = "\(Constant.BASE_URL)\(Constant.get_user_type)"
            let parameters = [
                "email": emailStr,
                "lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ]
            print("request -",parameters)
            ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
        //        ModalClass.stopLoading()
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
                        apiType = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "user_type") as! String
                        
                        self.logInViewModal.selectUserType = apiType
                        
                        
                        
                        self.logInViewModal.loginOtp { (success, response) in
                            print("response:-",response)
                            ModalClass.stopLoading()
                            if success{
                                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                                if let value = response?.object(forKey: "error_description") as? String{
                                    
                                    if(self.isRememberSelected)
                                    {
                                        ModalController.saveTheContent(emailStr as AnyObject, WithKey: "rememberEmail")
                                        ModalController.saveTheContent(passwordStr as AnyObject, WithKey: "rememberPassword")
                                        ModalController.saveTheContent(typeStr as AnyObject, WithKey: "rememberType")
                                    }
                                    else{
                                        ModalController.removeTheContentForKey("rememberEmail")
                                        ModalController.removeTheContentForKey("rememberPassword")
                                        ModalController.removeTheContentForKey("rememberType")
                                    }
                                    
                                    ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                                    let results = (ResponseDict.object(forKey: "data") as! NSDictionary)
                                    AuthorisedUser.shared.setAuthorisedUser(with:response as Any)
                                    
                                    let userID:String = ModalController.toString(results.object(forKey: "id") as AnyObject)
                                    Singleton.shared.setUserId(UserId: "\(userID)")
                                    
                                    var userType = ""
                                    var isNewUser = ""
                                    
                                    if let fynooUserType = results.object(forKey: "user_type") as? String {
                                        userType = fynooUserType
                                    }
                                    isNewUser = ModalController.toString(results.object(forKey: "is_new_user") as AnyObject)
                                    
                                    print("userType:-", userType)
                                    print("isNewUser:-", isNewUser)
                                    
                                    if (userType == "AI" || userType == "AC") &&  value == "Verification Pending"{
                                        let vc = VerifyAccountViewController(nibName: "VerifyAccountViewController", bundle: nil)
                                        
                                        vc.mobile = (response?.object(forKey: "data") as! NSDictionary).object(forKey: "mobile_number") as! String
                                        vc.emailId = (response?.object(forKey: "data") as! NSDictionary).object(forKey: "email") as! String
                                        vc.fynooId = (response!.object(forKey: "data") as? NSDictionary)?.object(forKey: "fynoo_id") as! String
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }else{
                                    if userType == "AI" || userType == "AC" {
                                        if isNewUser == "1" {
                                            
                                            let vc = AgentDashboardViewController(nibName: "AgentDashboardViewController", bundle: nil)
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        }else {
                                            let vc = AgentDashboardViewController(nibName: "AgentDashboardViewController", bundle: nil)
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        }
                                    }else {
                                        let vc = AgentDashboardViewController(nibName: "AgentDashboardViewController", bundle: nil)
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                    }
                                }
                            }else{
                                if let value = response?.object(forKey: "error_description") as? String{
                                    ModalController.showNegativeCustomAlertWith(title: "", msg: value)
                                    if value == "Verification Pending"{
                                        let vc = VerifyAccountViewController(nibName: "VerifyAccountViewController", bundle: nil)
                                        
                                        vc.mobile = (response?.object(forKey: "data") as! NSDictionary).object(forKey: "mobile_number") as! String
                                        vc.emailId = (response?.object(forKey: "data") as! NSDictionary).object(forKey: "email") as! String
                                        vc.fynooId = (response!.object(forKey: "data") as? NSDictionary)?.object(forKey: "fynoo_id") as! String
                                        self.navigationController?.pushViewController(vc, animated: true)
                                        //self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                }
                            }
                        }
                    }
                }else{
                    if response == nil {
                        print ("connection error")
                        ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                    }else{
                        print ("data not in proper json")
                    }
                }
            }
            
            
        }else{
            
            ModalController.showNegativeCustomAlertWith(title: "", msg: message)
        }
    }
    
    func signupBtnClicked(){
        
        let viewController = popupViewController()
//              viewController.delegate = self
              self.navigationController?.pushViewController(viewController, animated: true)
        
//        let vc = SignUPViewController(nibName: "SignUPViewController", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func forgotPasswordBtnClicked(){
        let vc = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func timerAction() {
           var pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
           if pageNumber == 4 {
               pageNumber = -1
           }
           pageNumber =  pageNumber + 1
           let x = CGFloat(pageNumber) * scrollView.frame.size.width
           scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
           
           switch pageNumber {
           case 0:
               pageImage.image = UIImage(named: "dot1")
               case 1:
               pageImage.image = UIImage(named: "dot2")
               case 2:
               pageImage.image = UIImage(named: "dot3")
               case 3:
               pageImage.image = UIImage(named: "dot4")
           default:
               pageImage.image = UIImage(named: "dot5")
           }
       }
       
      func configurePageControl() {
             // The total number of pages that are available is based on how many available colors we have.
             self.pageCntrl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
             self.pageCntrl.numberOfPages = 5
             self.pageCntrl.currentPage = 0
             self.pageCntrl.tintColor = UIColor.red
             self.pageCntrl.pageIndicatorTintColor = UIColor.lightGray
             self.pageCntrl.currentPageIndicatorTintColor = UIColor.darkGray
    //         self.view.addSubview(pageCntrl)
         }
         
         // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
         @objc func changePage(sender: AnyObject) -> () {
             let x = CGFloat(pageCntrl.currentPage) * scrollView.frame.size.width
             scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
         }
         
         func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
             let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
             pageCntrl.currentPage = Int(pageNumber)
           switch pageCntrl.currentPage {
           case 0:
               pageImage.image = UIImage(named: "dot1")
               case 1:
               pageImage.image = UIImage(named: "dot2")
               case 2:
               pageImage.image = UIImage(named: "dot3")
               case 3:
               pageImage.image = UIImage(named: "dot4")
           default:
               pageImage.image = UIImage(named: "dot5")
           }
         }
    
}

extension LoginNewDesignViewController : PopupSelectedVal{
    func selectedOption(str: String) {
        print(str)
        self.selectedType = str
        self.tableVw.reloadData()
    }
}

extension UIView {
    private struct OnClickHolder {
        static var _closure:()->() = {}
    }

    private var onClickClosure: () -> () {
        get { return OnClickHolder._closure }
        set { OnClickHolder._closure = newValue }
    }

    func onClick(target: Any, _ selector: Selector) {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: selector)
        addGestureRecognizer(tap)
    }

    func onClick(closure: @escaping ()->()) {
        self.onClickClosure = closure

        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickAction))
        addGestureRecognizer(tap)
    }

    @objc private func onClickAction() {
        onClickClosure()
    }
}
