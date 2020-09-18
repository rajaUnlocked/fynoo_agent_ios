//
//  AgentDashboardViewController.swift
//  Fynoo Services
//
//  Created by Aishwarya on 03/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import SideMenu

class AgentDashboardViewController: UIViewController, signOutDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableVw: UITableView!
    @IBOutlet weak var topVwHeightCons: NSLayoutConstraint!
    @IBOutlet weak var qrcode: UIButton!
    @IBOutlet weak var notifyLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet var userDetails: UILabel!
//    let val1 = "Hello".localized
//    let val2 = "ID".localized
//    self.userDetails.text = "\(val1) \(self.homeGraph?.data?.user_details?.user_name ?? "")\n \(val2): \(self.homeGraph?.data?.user_details?.fynoo_id ?? "")"
    @IBOutlet weak var availableBalanceLbl: UILabel!
    
    var agentInfoArray = NSMutableArray()
    var bannerArray = NSMutableArray()
    var servicesArray = NSMutableArray()
    var mandatoryArray = NSMutableArray()
    var dataDict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotifications()
        sideMenuCode()
        configureHeaderUI()
        registerCellNibs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dashboardAPI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    // MARK: - registerNotifications
    func registerNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenumanageServiceClicked(_:)), name: NSNotification.Name(rawValue: "manageServiceClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenuserviceRequestClicked), name: NSNotification.Name(rawValue: "serviceRequestClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenucommissionClicked), name: NSNotification.Name(rawValue: "commissionClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenutargetClicked), name: NSNotification.Name(rawValue: "targetClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenudropShippingBtnClicked), name: NSNotification.Name(rawValue: "dropShippingBtnClicked"), object: nil)
                
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenuaddProductDataForSaleBtnClicked), name: NSNotification.Name(rawValue: "addProductDataForSaleBtnClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenuwalletClicked), name: NSNotification.Name(rawValue: "walletClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenuuserProfileClicked), name: NSNotification.Name(rawValue: "userProfileClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenusettingsClicked), name: NSNotification.Name(rawValue: "settingsClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenuChangeLanguageClicked), name: NSNotification.Name(rawValue: "changeLanguageClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenusignOutClicked), name: NSNotification.Name(rawValue: "signOutClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationclickMenuClicked(_:)), name: NSNotification.Name(rawValue: "clickMenuFromAnywhere"), object: nil)
    }
    
    // MARK: - SIDE MENU
    func sideMenuCode()
    {
        let vc = SideMenuViewController(nibName: "SideMenuViewController", bundle: nil)
        let menuLeftNavigationController = UISideMenuNavigationController.init(rootViewController: vc)
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                SideMenuManager.default.menuRightNavigationController = menuLeftNavigationController
            }
            else {
                SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
            }
            
        }
        
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.black
        // YourSideMenuNavigationController.presentationStyle.onTopShadowOpacity = 0.5
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuWidth = UIScreen.main.bounds.width
    }
    
    func configureHeaderUI() {
 //       self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        var heightCon = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        if heightCon < 106 {
            self.topVwHeightCons.constant = 185
        }
    }
    
    func registerCellNibs(){
        tableVw.register(UINib(nibName: "DashboardWalletTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardWalletTableViewCell");
        tableVw.register(UINib(nibName: "ProgressDashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "ProgressDashboardTableViewCell");
        tableVw.register(UINib(nibName: "ServicesDashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesDashboardTableViewCell");
        tableVw.register(UINib(nibName: "DropShipDashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DropShipDashboardTableViewCell");
        tableVw.register(UINib(nibName: "MultiBannerTableViewCell", bundle: nil), forCellReuseIdentifier: "MultiBannerTableViewCell");
    }
    
    @IBAction func sideMenuBtn(_ sender: Any) {
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
            }
            else {
                present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
            }
        }else{
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }
    }
    
    // MARK: - Notifications Actions
        
        @objc func sideMenumanageServiceClicked(_ notification: NSNotification) {
        }
        
        @objc func sideMenuserviceRequestClicked(_ notification: NSNotification) {
        }
        
        @objc func sideMenucommissionClicked(_ notification: NSNotification) {
        }
        
        @objc func sideMenutargetClicked(_ notification: NSNotification) {
        }
        
        @objc func sideMenuwalletClicked(_ notification: NSNotification) {
        }
        
        @objc func sideMenuuserProfileClicked(_ notification: NSNotification) {
        }
        
        @objc func sideMenusettingsClicked(_ notification: NSNotification) {
            let vc = UnderDevelopmentViewController(nibName: "UnderDevelopmentViewController", bundle: nil)
            vc.showBack = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        @objc func sideMenuChangeLanguageClicked(_ notification: NSNotification) {
            let alert = UIAlertController(title: "Language", message: "Please Select Your Language", preferredStyle: .actionSheet)
              alert.addAction(UIAlertAction(title: "English", style: .default , handler:{ (UIAlertAction)in
                  print("User click Approve button")
                  self.selectStore(store: "english")
              }))
              alert.addAction(UIAlertAction(title: "Arabic", style: .default , handler:{ (UIAlertAction)in
                  print("User click Edit button")
                  self.selectStore(store: "arabic")
              }))
            
              alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler:{ (UIAlertAction)in
                  print("User click Dismiss button")
              }))
              self.present(alert, animated: true, completion: {
                  print("completion block")
              })
        }
        
        
        func selectStore(store:String?){
            return
            if store=="arabic"
            {
                UserDefaults.standard.set(["ar","en"], forKey: "AppleLanguages")
                HeaderHeightSingleton.shared.LanguageSelected = "AR"
                //        HeaderHeightSingleton.shared.Currency="SAR".localized
                self.view.reloadInputViews()
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }
            else
            {
                UserDefaults.standard.set(["en","ar"], forKey: "AppleLanguages")
                self.view.reloadInputViews()
                HeaderHeightSingleton.shared.LanguageSelected = "EN"
                //           HeaderHeightSingleton.shared.Currency="SAR".localized
                
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
      //      load_app()
        }
        
        //   var window: UIWindow?
//        func load_app(){
//            let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
//            let appDelegate = UIApplication.shared.delegate as! SceneDelegate
//            appDelegate.nav = UINavigationController.init(rootViewController: appDelegate.createTabBarMethod())
//            appDelegate.nav.navigationBar.isHidden = true
//            rootviewcontroller.rootViewController = appDelegate.nav
//            rootviewcontroller.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
//            UIView.transition(with: rootviewcontroller, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
//            }) { (finished) -> Void in
//                }
//    }
        
        @objc func sideMenusignOutClicked(_ notification: NSNotification) {
                let vc = SignOutViewController(nibName: "SignOutViewController", bundle: nil)
                vc.modalPresentationStyle = .overFullScreen
                vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                vc.delegate =  self
                self.present(vc, animated: true, completion: nil)
        }
            
            @objc func methodOfReceivedNotificationclickMenuClicked(_ notification: NSNotification) {
              //  self.view.alpha = 0.4

                if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
                    if value[0]=="ar"{
                        
                        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
                    }
                    else {
                        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
                    }
                }else{
                    present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
                }
        }
        
        @objc func sideMenudropShippingBtnClicked(_ notification: NSNotification) {
        }
        
        @objc func sideMenuaddProductDataForSaleBtnClicked(_ notification: NSNotification) {
        }
   
    // MARK: - LOGOUT DELEGATE
    func popViewController() {
        let vc = LoginNewDesignViewController(nibName: "LoginNewDesignViewController", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:-- TABLE DATA SOURCE DELEGATES
    func numberOfSections(in tableView: UITableView) -> Int{
        if dataDict.count == 0 {
         return 0
        }else{
        return 5
        }
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return mandatoryArray.count
        }else if section == 4 {
            if bannerArray.count > 0 {
                return 1
            }else{
                return 0
            }
        }
        else{
        return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return DashboardWalletCell(index: indexPath)
        }else if indexPath.section == 1 {
            return ProgressDashboardCell(index: indexPath)
        }else if indexPath.section == 2 {
            return ServicesDashboardCell(index: indexPath)
        }else if indexPath.section == 3 {
            return DropShipDashboardCell(index: indexPath)
        }else{
            return multiBannerCell(index: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 170
        }else if indexPath.section == 1{
            return 120
        }else if indexPath.section == 2{
            return 450 + 10
        }else if indexPath.section == 3{
            return 175
        }else{
            return getHeightDynamicForMultipleBanner(index: indexPath)
        }
    }
    
    // MARK: - TableView Cells Return
    func DashboardWalletCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "DashboardWalletTableViewCell",for: index) as! DashboardWalletTableViewCell
        cell.selectionStyle = .none
        cell.walletLbl.text = "\(dataDict.object(forKey: "wallet_balance") as! NSNumber)"
        cell.holdingLBl.text = "\(dataDict.object(forKey: "holding_amount") as! NSNumber)"
        cell.inprocessLbl.text = "\(dataDict.object(forKey: "payment_in_progress") as! NSNumber)"
        return cell
    }
    
    func ProgressDashboardCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProgressDashboardTableViewCell",for: index) as! ProgressDashboardTableViewCell
        cell.selectionStyle = .none
        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        cell.progressVW.transform = transform
        return cell
    }
    
    func ServicesDashboardCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ServicesDashboardTableViewCell",for: index) as! ServicesDashboardTableViewCell
        cell.selectionStyle = .none
        cell.setupCollectionVw()
        cell.collectionVw.reloadData()
        return cell
    }
    
    func DropShipDashboardCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "DropShipDashboardTableViewCell",for: index) as! DropShipDashboardTableViewCell
        cell.selectionStyle = .none
        cell.titleLbl.text = (mandatoryArray.object(at: index.item) as! NSDictionary).object(forKey: "service_name") as! String
        cell.img.sd_setImage(with: URL(string: "\((mandatoryArray.object(at: index.item) as! NSDictionary).object(forKey: "service_icon") as! String)"), placeholderImage: UIImage(named: ""))
        return cell
    }
    
    func multiBannerCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "MultiBannerTableViewCell",for: index) as! MultiBannerTableViewCell
        cell.selectionStyle = .none
        cell.multiBannerArray = bannerArray
        cell.setBanner()
        return cell
    }
    
    func getHeightDynamicForMultipleBanner(index : IndexPath) -> CGFloat {
        if bannerArray.count > 0 {
            let width = UIScreen.main.bounds.size.width - 20
            let widthEsti = 835 / width
            let height = 500 / widthEsti
            return height + 50
        }else{
            return 0
        }
    }
    
    @IBAction func qrcodeBtn(_ sender: Any) {
//        let vc = BranchQrCodePopupViewController(nibName: "BranchQrCodePopupViewController", bundle: nil)
//        vc.isType = true
//        vc.url = homeGraph?.data?.bo_qr_code ?? ""
//        vc.urlPass =  homeGraph?.data?.main_branch_url ?? ""
//        vc.businessName = homeGraph?.data?.main_branch_name ?? ""
//        let popup = PopupDialog(viewController: vc,
//                                buttonAlignment: .horizontal,
//                                transitionStyle: .bounceDown,
//                                tapGestureDismissal: true,
//                                panGestureDismissal: false)
//
//        self.present(popup, animated: true, completion: nil)
    }
    
    @IBAction func notificationBtnClicked(_ sender: Any) {
//        let vc = NotificationNewViewController(nibName: "NotificationNewViewController", bundle: nil)
//        //vc.showBack = true
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cameraClicked(_ sender: Any) {
        
//        let vc = BranchBottomPopUpController(nibName: "BranchBottomPopUpController", bundle: nil)
//        vc.choosenOption = { (string) in
//            OpenGallery.shared.delegate = self
//            OpenGallery.shared.viewControl = self
//            if string == "Take Photo"{
//
//                OpenGallery.shared.openCamera()
//
//            }else if string == "Device Gallery"{
//                OpenGallery.shared.viewControl = self
//                OpenGallery.shared.openGallery()
//
//            }
//            if string == "Fynoo Gallery"{
//                let vc = BussinessGalleryViewController(nibName: "BussinessGalleryViewController", bundle: nil)
//                vc.isTypeFrom = "Profile"
//                vc.delegate = self
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//
//        let popupController = MTPopupController(rootViewController: vc)
//        popupController.autoAdjustKeyboardEvent = false
//        popupController.style = .bottomSheet
//        popupController.navigationBarHidden = true
//        popupController.hidesCloseButton = false
//        let blurEffect = UIBlurEffect(style: .dark)
//        popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
//        popupController.backgroundView?.alpha = 0.6
//        popupController.backgroundView?.onClick {
//            popupController.dismiss()
//        }
//        popupController.present(in: self)
        
        //        let alert = UIAlertController(title: "Message", message: "", preferredStyle: .actionSheet)
        //        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
        //            self.accessCamera()
        //        }))
        //        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (action) in
        //            self.accessGallery()
        //        }))
        //        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - AGENT DASHBOARD API
    func dashboardAPI()
    {
        let user_id:UserData = AuthorisedUser.shared.getAuthorisedUser()
        var userID = "\(user_id.data!.id)"
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.agent_dashboard)"
        let parameters = [
            "user_id": userID,
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if success == true {
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
                    ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "error_description") as? String)!, msg: "")
                    self.agentInfoArray.removeAllObjects()
                    self.bannerArray.removeAllObjects()
                    self.servicesArray.removeAllObjects()
                    self.mandatoryArray.removeAllObjects()
                    self.dataDict = NSDictionary()
                    self.tableVw.reloadData()
                }
                else{
                    
                    self.agentInfoArray.removeAllObjects()
                    self.bannerArray.removeAllObjects()
                    self.servicesArray.removeAllObjects()
                    self.mandatoryArray.removeAllObjects()
                    self.dataDict = NSDictionary()
                    
                    let results1 = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "agent_information") as! NSArray
                    for var i in (0..<results1.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results1.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.agentInfoArray.add(dict)
                    }

                    let results2 = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "banner_list") as! NSArray
                    for var i in (0..<results2.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results2.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.bannerArray.add(dict)
                    }

                    let results3 = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "services") as! NSArray
                    for var i in (0..<results3.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results3.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.servicesArray.add(dict)
                    }
                    
                    let results5 = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "manadatory_services") as! NSArray
                    for var i in (0..<results5.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results3.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.mandatoryArray.add(dict)
                    }
                    
                    let results4 = (ResponseDict.object(forKey: "data") as! NSDictionary)
                    let dict : NSDictionary = NSDictionary(dictionary: results4).RemoveNullValueFromDic()
                    self.dataDict = dict
                    
                    self.availableBalanceLbl.text = "\(self.dataDict.object(forKey: "available_amount") as! NSNumber)"
                    
                    self.tableVw.reloadData()
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
    }
}

extension UIImage {
func resizeWithPercent(percentage: CGFloat) -> UIImage? {
    let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
    imageView.contentMode = .scaleAspectFit
    imageView.image = self
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    imageView.layer.render(in: context)
    guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
    UIGraphicsEndImageContext()
    return result
}
func resizeWithWidth(width: CGFloat) -> UIImage? {
    let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
    imageView.contentMode = .scaleAspectFit
    imageView.image = self
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    imageView.layer.render(in: context)
    guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
    UIGraphicsEndImageContext()
    return result
}
}

extension Collection {
    public func chunk(n: IndexDistance) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
