//
//  AgentDashboardViewController.swift
//  Fynoo Services
//
//  Created by Aishwarya on 03/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import SideMenu
import CoreLocation
import MTPopup


class AgentDashboardViewController: UIViewController, signOutDelegate, UITableViewDelegate, UITableViewDataSource, ServicesDashboardTableViewCellDelegate, CommonPopupViewControllerDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, OpenGalleryDelegate, CLLocationManagerDelegate, UITabBarControllerDelegate {
    var isOpen = true
    @IBOutlet weak var progresslbl: UILabel!
    @IBOutlet weak var holdingamtlbl: UILabel!
    
    @IBOutlet weak var walletballbl: UILabel!
    @IBOutlet weak var walletbaltop: UILabel!
    @IBOutlet weak var sar: UILabel!
    @IBOutlet weak var sar1: UILabel!
    
    @IBOutlet weak var sar2: UILabel!
    @IBOutlet weak var sar3: UILabel!
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var walletHeightConst: NSLayoutConstraint!
    @IBOutlet weak var walletvw: UIView!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var holdingLBl: UILabel!
    @IBOutlet weak var inprocessLbl: UILabel!
    @IBOutlet weak var arrow1: UIImageView!
    @IBOutlet weak var arrow2: UIImageView!
    @IBOutlet weak var arrow3: UIImageView!
    
    
    @IBOutlet weak var availamount: UILabel!
    var branchmodel = branchsmodel()
    @IBOutlet weak var tableVw: UITableView!
    @IBOutlet weak var topVwHeightCons: NSLayoutConstraint!
    @IBOutlet weak var qrcode: UIButton!
    @IBOutlet weak var notifyLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet var userDetails: UILabel!
    @IBOutlet weak var availableBalanceLbl: UILabel!
    var showWallet = false
    @IBOutlet weak var arrowImg: UIImageView!
    var productmodel = AddProductModel()
    var agentInfoArray = NSMutableArray()
    var bannerArray = NSMutableArray()
    var servicesArray = NSMutableArray()
    var mandatoryArray = NSMutableArray()
    var dataDict = NSDictionary()
    var imageId = ""
    
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    var userAddressStr = ""
    var isNewLogin : Bool = false
    let application = UIApplication.shared
    var ResponseDict : NSDictionary = NSDictionary()
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    //    var lati : Double?
    //    var longi : Double?
    var apiTimer: Timer?
    let fontNameLight = NSLocalizedString("LightFontName", comment: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walletLbl.textColor = UIColor.AppThemeGreenTextColor()
        holdingLBl.textColor = UIColor.AppThemeGreenTextColor()
        inprocessLbl.textColor = UIColor.AppThemeGreenTextColor()
        
        print("hjgjkkgjjjg\(self.navigationController?.viewControllers)")
        sar1.font = UIFont(name:"\(fontNameLight)",size:8)
        sar2.font = UIFont(name:"\(fontNameLight)",size:8)
        sar3.font = UIFont(name:"\(fontNameLight)",size:8)
        sar.font = UIFont(name:"\(fontNameLight)",size:12)
        walletbaltop.font = UIFont(name:"\(fontNameLight)",size:16)
        walletballbl.font = UIFont(name:"\(fontNameLight)",size:12)
        holdingamtlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        progresslbl.font = UIFont(name:"\(fontNameLight)",size:12)
        walletbaltop.text = "Wallet Balance".localized
        holdingamtlbl.text = "Holding Amount".localized
        walletballbl.text = "Wallet Balance".localized
        progresslbl.text = "Payment in progress".localized
        //        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapWalletView(_:)))
        //        walletvw.addGestureRecognizer(tapGestureRecognizer)
        getUserLocation()
        registerNotifications()
        sideMenuCode()
        configureHeaderUI()
        registerCellNibs()
        addUIRefreshToTable()
        showWallet = true
        self.arrowImg.image = UIImage(named: "down-arrow-3")
        walletHeightConst.constant = 0
        walletvw.isHidden = true
        saveFcmTokenToServer_API()
        NotificationCenter.default.addObserver(self, selector: #selector(getNotification(_:)), name: NSNotification.Name(Constant.GET_NOTIFICATION), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNotificationARV(_:)), name: NSNotification.Name(Constant.GET_NOTIFICATIONARV), object: nil)
        tabBarController?.delegate = self
        
        doBackgroundTask()
        getVersion()
    }
    @objc func getVersion()
    {
        let appVersion = appUpdateAvailable()
        if appVersion.0 {
            alertController(controller: self, title: "New Update", message: "New version \(appVersion.1 ?? "") is available")
        }
        
        func  alertController(controller:UIViewController,title: String,message: String){
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Update", style: .default, handler: { alert in
                
                guard let url = URL(string: "https://apps.apple.com/sa/app/fynoo-agent/id1531299470") else { return }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }))
            DispatchQueue.main.async {
                controller.present(alertController, animated: true)
            }
        }
        
    }
    func appUpdateAvailable() -> (Bool,String?) {
        
        guard let info = Bundle.main.infoDictionary,
              let identifier = info["CFBundleIdentifier"] as? String else {
                  return (false,nil)
              }
        
        //        let storeInfoURL: String = "http://itunes.apple.com/lookupbundleId=\(identifier)&country=IN"
        let storeInfoURL:String = "https://itunes.apple.com/IN/lookup?bundleId=\(identifier)"
        var upgradeAvailable = false
        var versionAvailable = ""
        // Get the main bundle of the app so that we can determine the app's
        //version number
        let bundle = Bundle.main
        if let infoDictionary = bundle.infoDictionary {
            // The URL for this app on the iTunes store uses the Apple ID
            //for the  This never changes, so it is a constant
            let urlOnAppStore = NSURL(string: storeInfoURL)
            if let dataInJSON = NSData(contentsOf: urlOnAppStore! as URL) {
                // Try to deserialize the JSON that we got
                if let dict: NSDictionary = try?
                    JSONSerialization.jsonObject(with: dataInJSON as Data, options:
                                                    JSONSerialization.ReadingOptions.allowFragments) as! [String:
                                                                                                            AnyObject] as NSDictionary? {
                    if let results:NSArray = dict["results"] as? NSArray {
                        if let version = (results[0] as! [String:Any])["version"] as? String {
                            // Get the version number of the current version
                            // installed on device
                            if let currentVersion =
                                infoDictionary["CFBundleShortVersionString"] as? String {
                                // Check if they are the same. If not, an
                                // upgrade is available.
                                print("\(version)")
                                let appversion = version.components(separatedBy: ".")
                                let currversion = currentVersion.components(separatedBy: ".")
                                for i in 0..<appversion.count
                                {
                                    if appversion[i] > currversion[i]
                                    {
                                        upgradeAvailable = true
                                        versionAvailable = version
                                        return (upgradeAvailable,versionAvailable)
                                    }
                                    else{
                                        upgradeAvailable = false
                                        versionAvailable = version
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return (upgradeAvailable,versionAvailable)
    }
    @IBAction func walletBalanceClicked(_ sender: UIButton) {
        
        let vc = BankAllListViewController(nibName: "BankAllListViewController", bundle: nil)
        vc.selectedVl = Int("100\(sender.tag)")!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //    @objc private func didTapWalletView(_ sender: UITapGestureRecognizer) {
    //        if sender.isEnabled
    //        {
    //
    //        }
    //    }
    override func viewWillAppear(_ animated: Bool) {
        //registerNotifications()
        self.dashboardAPI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        //NotificationCenter.default.removeObserver(self)
    }
    func addUIRefreshToTable() {
        refreshControl = UIRefreshControl()
        tableVw.addSubview(refreshControl)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }
    @objc func refreshTable() {
        let x = ResponseDict.object(forKey: "error") as! Bool
        if x{
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }else{
            
            dashboardAPI()
        }
    }
    
    
    // Mark : - update location
    
    func doBackgroundTask() {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.apiTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.callUpdateLocation), userInfo: nil, repeats: true)
            
            RunLoop.current.add(self.apiTimer!, forMode: .common)
            RunLoop.current.run()
        }
    }
    
    
    
    @objc func callUpdateLocation(){
        
        
        let parameters = [
            "user_id":Singleton.shared.getUserId(),
            "lat":Double.getDouble(delegate.latitudeStr),
            "long":Double.getDouble(delegate.longitudeStr),
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ] as [String : Any]
        
//        print("request -",parameters)
        ServerCalls.postRequest(Service.agentSetLatLong, withParameters: parameters) { (response, success, resp) in
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    // print(msg)
                }else{
                    //print(msg)
                }
            }
        }
        
    }
    
    // MARK: - save fcm Token
    
    func saveFcmTokenToServer_API()
    {
        let device_id = UIDevice.current.identifierForVendor!.uuidString
        let str = "\(Constant.BASE_URL)\(Constant.firebase_token)"
        let parameters = [
            "user_id":Singleton.shared.getUserId(),
            "device_id":device_id,
            "device_type":"ios",
            "firebase_token":"\(ModalController.getTheContentForKey("fcmtoken")!)",
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                }else{
                    self.isNewLogin = false
                }
            }
        }
    }
    
    
    // MARK: - get location
    func getUserLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: - Location Delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //        print("locations = \(locValue.latitude) \(locValue.longitude)")
        latitude = locValue.latitude
        longitude = locValue.longitude
        
        HeaderHeightSingleton.shared.longitude = longitude
        HeaderHeightSingleton.shared.latitude = latitude
        
        getAddressFromLatLon(pdblLatitude: "\(latitude)", withLongitude: "\(longitude)")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        ModalController.showNegativeCustomAlertWith(title: "Please turn on your location services", msg: "")
        
        HeaderHeightSingleton.shared.longitude = 0.0
        HeaderHeightSingleton.shared.latitude = 0.0
        HeaderHeightSingleton.shared.address = ""
        
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        let lon: Double = Double("\(pdblLongitude)")!
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                return
            }
            
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                
                var addressString : String = ""
                if pm.name != nil {
                    addressString = addressString + pm.name! + ", "
                }
                if pm.subAdministrativeArea != nil {
                    addressString = addressString + pm.subAdministrativeArea! + ", "
                }
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                    //      self.country = pm.country!
                    //     HeaderHeightSingleton.shared.countrySingleton = pm.country!
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                
                
                //               self.addressField.text = addressString
                
                HeaderHeightSingleton.shared.address = addressString
                
                //                    self.currentLocation.setTitle(addressString, for: .normal)
                print(addressString)
            }
        })
        
    }
    
    // MARK: - registerNotifications
    func registerNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenumanageServiceClicked(_:)), name: NSNotification.Name(rawValue: "manageServiceClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenuserviceRequestClicked), name: NSNotification.Name(rawValue: "serviceRequestClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenucommissionClicked), name: NSNotification.Name(rawValue: "commissionClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenutargetClicked), name: NSNotification.Name(rawValue: "targetClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenudropShippingBtnClicked), name: NSNotification.Name(rawValue: "dropShippingBtnClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationIssued(_:)), name: NSNotification.Name(rawValue: "issued"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationReceived(_:)), name: NSNotification.Name(rawValue: "received"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationFynooReciept(_:)), name: NSNotification.Name(rawValue: "fynoo_reciept"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenuaddProductDataForSaleBtnClicked), name: NSNotification.Name(rawValue: "addProductDataForSaleBtnClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenuwalletClicked), name: NSNotification.Name(rawValue: "walletClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenuuserProfileClicked), name: NSNotification.Name(rawValue: "userProfileClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenusettingsClicked), name: NSNotification.Name(rawValue: "settingsClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenuChangeLanguageClicked), name: NSNotification.Name(rawValue: "changeLanguageClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.sideMenusignOutClicked), name: NSNotification.Name(rawValue: "signOutClicked"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationclickMenuClicked(_:)), name: NSNotification.Name(rawValue: "clickMenuFromAnywhere"), object: nil)
    }
    //    func applicationWillResign(notification : NSNotification) {
    //        NotificationCenter.default.removeObserver(self)
    //     }
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
        availamount.font = UIFont(name:"\(fontNameLight)",size:14)
        availamount.text = "Available Amount".localized
        arrow1.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"rightArrow_dash")!)
        arrow2.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"rightArrow_dash")!)
        arrow3.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"rightArrow_dash")!)
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
        let vc = CommisionsViewController(nibName: "CommisionsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sideMenutargetClicked(_ notification: NSNotification) {
        let vc = TargetViewController(nibName: "TargetViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sideMenuwalletClicked(_ notification: NSNotification) {
//        if isOpen
//        {
            let vc = BankAllListViewController(nibName: "BankAllListViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
//            isOpen = false
//        }
    }
    
    @objc func sideMenuuserProfileClicked(_ notification: NSNotification) {
        let vc = UserProfileDetailsViewController(nibName: "UserProfileDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sideMenusettingsClicked(_ notification: NSNotification) {
        
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
        load_app()
    }
    
    func load_app(){
        let rootviewcontroller: UIWindow = (SceneDelegate.shared?.window)!
        let appDelegate = SceneDelegate()
        
        let obj = AgentDashboardViewController()
        
        appDelegate.nav = UINavigationController.init(rootViewController: obj)
        appDelegate.nav.navigationBar.isHidden = true
        rootviewcontroller.rootViewController = appDelegate.nav
        rootviewcontroller.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: rootviewcontroller, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
        }) { (finished) -> Void in
        }
    }
    
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
    @objc func methodOfReceivedNotificationIssued(_ notification: NSNotification) {
        let vc = InvoiceNewViewController(nibName: "InvoiceNewViewController", bundle: nil)
        //        vc.tabID = 1
        vc.invoiceType = "issued"
        self.navigationController?.pushViewController(vc, animated: true)
        //        let vc = UnderDevelopmentViewController(nibName: "UnderDevelopmentViewController", bundle: nil)
        //        vc.showBack = true
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func methodOfReceivedNotificationReceived(_ notification: NSNotification) {
        let vc = InvoiceNewViewController(nibName: "InvoiceNewViewController", bundle: nil)
        vc.invoiceType = "received"
        //        vc.tabID = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func methodOfReceivedNotificationFynooReciept(_ notification: NSNotification) {
        let vc = InvoiceNewViewController(nibName: "InvoiceNewViewController", bundle: nil)
        vc.invoiceType = "fynooreceipts"
        //        vc.tabID = 3
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func sideMenuaddProductDataForSaleBtnClicked(_ notification: NSNotification) {
        let vc = ProductListNewViewController(nibName: "ProductListNewViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        //
        //            let vc = UnderDevelopmentViewController(nibName: "UnderDevelopmentViewController", bundle: nil)
        //            self.navigationController?.pushViewController(vc, animated: true)
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
        if section == 0 {
            return 1
        }
        else if section == 3 {
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
        
        if indexPath.section == 1
        {
            let vc = TargetViewController(nibName: "TargetViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            //            if showWallet
            //            {
            //                return 170
            //            }
            return 0
            
        }else if indexPath.section == 1{
            if dataDict.object(forKey: "target_end_date") as! String == ""
            {
                return 0
            }
            return 120
        }else if indexPath.section == 2{
            
            let coo = self.servicesArray.count
            let coo1 = coo/2
            let coo2 = coo%2
            let total = coo1+coo2
            return (CGFloat((total*150) + 10))
            
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
        self.walletLbl.text = ModalController.convertInString(str: self.dataDict.object(forKey: "wallet_balance") as AnyObject)
        self.holdingLBl.text = ModalController.convertInString(str: self.dataDict.object(forKey: "holding_amount") as AnyObject)
        self.inprocessLbl.text = ModalController.convertInString(str: self.dataDict.object(forKey: "payment_in_progress") as AnyObject)
        return cell
    }
    
    func ProgressDashboardCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProgressDashboardTableViewCell",for: index) as! ProgressDashboardTableViewCell
        cell.selectionStyle = .none
        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        cell.progressVW.transform = transform
        
        let startStr = ModalController.convertInString(str: self.dataDict.object(forKey: "target_achived") as AnyObject)
        let endStr = ModalController.convertInString(str: self.dataDict.object(forKey: "target_to_be_achive") as AnyObject)
        
        let start =  (startStr as NSString).floatValue
        let end = (endStr as NSString).floatValue
        
        let per = (start*100)/end
        let perToSet = per/100
        
        cell.progressVW.setProgress(perToSet, animated: true)
        cell.targetStartLbl.text = "\(ModalController.convertInString(str: self.dataDict.object(forKey: "target_achived") as AnyObject))/"
        if HeaderHeightSingleton.shared.LanguageSelected == "AR"
        {
            cell.targetStartLbl.text = "/\(ModalController.convertInString(str: self.dataDict.object(forKey: "target_achived") as AnyObject))"
        }
        cell.targetEndLbl.text = "\(ModalController.convertInString(str: self.dataDict.object(forKey: "target_to_be_achive") as AnyObject))"
        cell.endDate.text = "\("Target End Date".localized): \(dataDict.object(forKey: "target_end_date") as! String)"
        
        return cell
    }
    
    func ServicesDashboardCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ServicesDashboardTableViewCell",for: index) as! ServicesDashboardTableViewCell
        cell.selectionStyle = .none
        cell.dsid = (self.ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "dsd_id") as! Int
        cell.delegate = self
        cell.parent = self
        cell.serviceArr = self.servicesArray
        cell.setupCollectionVw()
        cell.collectionVw.reloadData()
        return cell
    }
    
    func DropShipDashboardCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "DropShipDashboardTableViewCell",for: index) as! DropShipDashboardTableViewCell
        cell.selectionStyle = .none
        cell.titleLbl.text = (mandatoryArray.object(at: index.item) as! NSDictionary).object(forKey: "service_name") as? String
        cell.img.sd_setImage(with: URL(string: "\((mandatoryArray.object(at: index.item) as! NSDictionary).object(forKey: "service_icon") as! String)"), placeholderImage: UIImage(named: ""))
        let mandatoryservicelist = (mandatoryArray.object(at: index.item) as! NSDictionary).object(forKey: "mandatory_service_list") as! NSArray
        cell.productlbl.text = (mandatoryservicelist.object(at: 0) as! NSDictionary).object(forKey: "text") as? String
        cell.soldproductlbl.text = (mandatoryservicelist.object(at: 1) as! NSDictionary).object(forKey: "text") as? String
        cell.commisionlbl.text = (mandatoryservicelist.object(at: 2) as! NSDictionary).object(forKey: "text") as? String
        cell.proprice.text = (mandatoryservicelist.object(at: 0) as! NSDictionary).object(forKey: "values") as? String
        cell.soldprice.text = (mandatoryservicelist.object(at: 1) as! NSDictionary).object(forKey: "values") as? String
        cell.commisionprice.text = (mandatoryservicelist.object(at: 2) as! NSDictionary).object(forKey: "values") as? String
        cell.currencycode.text = (mandatoryservicelist.object(at: 2) as! NSDictionary).object(forKey: "currency_code") as? String
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
        let vc = UnderDevelopmentViewController(nibName: "UnderDevelopmentViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func notificationBtnClicked(_ sender: Any) {
        
        let vc = UnderDevelopmentViewController(nibName: "UnderDevelopmentViewController", bundle: nil)
        //vc.showBack = true
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @IBAction func cameraClicked(_ sender: Any) {
        let vc = GalleryPopUpViewController(nibName: "GalleryPopUpViewController", bundle: nil)
        
        vc.choosenOption = { (str) in
            OpenGallery.shared.delegate = self
            OpenGallery.shared.viewControl = self
            
            if str == "Camera".localized{
                OpenGallery.shared.delegate = self
                OpenGallery.shared.viewControl = self
                OpenGallery.shared.openCamera()
            }else{
                OpenGallery.shared.delegate = self
                OpenGallery.shared.viewControl = self
                OpenGallery.shared.openGallery()
                //self.imgaes()
            }
        }
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
    
    func openCamera(){
        let imagePicker = UIImagePickerController()
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func  openGallery()
    {
        let imagePicker = UIImagePickerController()
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        
        let selectedImageNew = selectedImage.resizeWithWidth(width: 700)!
        let compressData = selectedImageNew.jpegData(compressionQuality: 0.8) //max value is 1.0 and minimum is 0.0
        let compressedImage = UIImage(data: compressData!)
        
        self.profileImg.image = compressedImage
        UploadProfileImage_API()
        
        //        self.profileImg.image = selectedImage
        //        UploadProfileImage_API(img: selectedImage)
    }
    
    func gallery(img: UIImage, imgtype: String) {
        self.profileImg.image = img
        UploadProfileImage_API()
    }
    
    func UploadProfileImage_API()
    {
        let str = "\(Constant.BASE_URL)\(Constant.UpdateProfile_Image)"
        
        let param = [
            "user_id":Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"image_id":imageId
        ]
        
        
        ModalClass.startLoading(self.view)
        
        ServerCalls.fileUploadAPINew(inputUrl: str, parameters: param, imageName: "image", imageFile: self.profileImg.image!) { (response, success, resp) in
            
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    ModalController.showNegativeCustomAlertWith(title:msg, msg: "")
                }else{
                    self.imageId = ""
                    ModalController.showSuccessCustomAlertWith(title:msg, msg: "")
                    AuthorisedUser.shared.user?.data?.profile_image = value.object(forKey: "user_photo") as! String
                    
                    let strIMage = value.object(forKey: "user_photo") as! String
                    //              let strIMage = value.object(forKey: "user_photo") as! String
                    self.profileImg.sd_setImage(with: URL(string: strIMage), placeholderImage: UIImage(named: "profile_white"))
                    
                    ModalController.saveTheContent(strIMage as AnyObject, WithKey: "profile_img")
                }
            }
            else{
                ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
            }
        }
        
    }
    
    // MARK: - AGENT DASHBOARD API
    func dashboardAPI()
    {
        let user_id:UserData = AuthorisedUser.shared.getAuthorisedUser()
        let userID = "\(user_id.data!.id)"
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.agent_dashboard)"
        let parameters = [
            "user_id": Singleton.shared.getUserId(),
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        print("request -",parameters,str)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoadingAllLoaders(self.view)
            if success == true {
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
                self.ResponseDict = (response as? NSDictionary)!
                print("ResponseDictionary %@",self.ResponseDict)
                let x = self.ResponseDict.object(forKey: "error") as! Bool
                if x {
                    ModalController.showNegativeCustomAlertWith(title:(self.ResponseDict.object(forKey: "error_description") as? String)!, msg: "")
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
                    
                    let results1 = (self.ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "agent_information") as! NSArray
                    for var i in (0..<results1.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results1.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.agentInfoArray.add(dict)
                    }
                    
                    let results2 = (self.ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "banner_list") as! NSArray
                    for var i in (0..<results2.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results2.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.bannerArray.add(dict)
                    }
                    
                    let results3 = (self.ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "services") as! NSArray
                    for var i in (0..<results3.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results3.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.servicesArray.add(dict)
                    }
                    
                    let results5 = (self.ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "manadatory_services") as! NSArray
                    for var i in (0..<results5.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results5.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.mandatoryArray.add(dict)
                    }
                    
                    let results4 = (self.ResponseDict.object(forKey: "data") as! NSDictionary)
                    let dict : NSDictionary = NSDictionary(dictionary: results4).RemoveNullValueFromDic()
                    self.dataDict = dict
                    
                    self.availableBalanceLbl.text =  ModalController.convertInString(str: self.dataDict.object(forKey: "available_amount") as AnyObject)
                    self.availableBalanceLbl.font = UIFont(name:"\(self.fontNameLight)",size:16)
                    self.sar.font = UIFont(name:"\(self.fontNameLight)",size:12)
                    let image =  ((self.dataDict.object(forKey: "agent_information") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "user_img") as! NSString
                    
                    self.profileImg.sd_setImage(with: URL(string: "\(image)"), placeholderImage: UIImage(named: "profile_white"))
                    
                    ModalController.saveTheContent(image, WithKey: "profile_img")
                    
                    let nameStr =  ((self.dataDict.object(forKey: "agent_information") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "name") as! NSString
                    let idStr =  ((self.dataDict.object(forKey: "agent_information") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "fynoo_id") as! NSString
                    let val1 = "Hello".localized
                    let val2 = "ID".localized
                    self.userDetails.text = "\(val1) \(nameStr)\n \(val2): \(idStr)"
                    self.userDetails.font = UIFont(name:"\(self.fontNameLight)",size:13)
                    
                    self.walletLbl.text = ModalController.convertInString(str: self.dataDict.object(forKey: "wallet_balance") as AnyObject)
                    self.holdingLBl.text = ModalController.convertInString(str: self.dataDict.object(forKey: "holding_amount") as AnyObject)
                    self.inprocessLbl.text = ModalController.convertInString(str: self.dataDict.object(forKey: "payment_in_progress") as AnyObject)
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
    
    @IBAction func walletDetailsBtn(_ sender: Any) {
        if showWallet {
            showWallet = false
            self.arrowImg.image = UIImage(named: "up-arrow-3")
            walletHeightConst.constant = 150
            walletvw.isHidden = false
        }else{
            showWallet = true
            self.arrowImg.image = UIImage(named: "down-arrow-3")
            walletHeightConst.constant = 0
            walletvw.isHidden = true
        }
        self.tableVw.reloadData()
    }
    
    func addServiceClickedHome(id : Int, name : String, index : Int) {
        
        let vc = CommonPopupViewController(nibName: "CommonPopupViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        vc.delegate =  self
        vc.name = name
        vc.serviceID = id
        vc.imgURL = "\((self.servicesArray.object(at: index) as! NSDictionary).object(forKey: "service_icon") as! String)"
        vc.setUI()
        self.present(vc, animated: true, completion: nil)
    }
    
    func activateServiceClickedHome(id : Int, name : String, index : Int) {
        let vc = CommonPopupViewController(nibName: "CommonPopupViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        vc.delegate =  self
        vc.showActive = true
        
        let act = "\((self.servicesArray.object(at: index) as! NSDictionary).object(forKey: "is_active") as! NSNumber)"
        
        if Int(act) == 1 {
            vc.isForActivate = false
            vc.name = "Are you sure you want to deactivate this service?".localized
        }else{
            vc.isForActivate = true
            vc.name = "Are you sure you want to activate this service?".localized
        }
        
        vc.serviceID = id
        vc.setUI()
        self.present(vc, animated: true, completion: nil)
    }
    
    func yesBtnClicked(name : String , id : Int) {
        addServiceAPI(serviceID: id,name : name)
    }
    
    func yesBtnForActivate(name : String , id : Int , forActivate : Bool) {
        if forActivate {
            let user_id:UserData = AuthorisedUser.shared.getAuthorisedUser()
            var userID = "\(user_id.data!.id)"
            ModalClass.startLoading(self.view)
            let str = "\(Constant.BASE_URL)\(Constant.activate_services)"
            let parameters = [
                "user_id": userID,
                "services": "\(id)",
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
                    }
                    else{
                        ModalController.showSuccessCustomAlertWith(title: "", msg: (ResponseDict.object(forKey: "error_description") as? String)!)
                        self.dashboardAPI()
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
            let user_id:UserData = AuthorisedUser.shared.getAuthorisedUser()
            var userID = "\(user_id.data!.id)"
            ModalClass.startLoading(self.view)
            let str = "\(Constant.BASE_URL)\(Constant.deactivate_services)"
            let parameters = [
                "user_id": userID,
                "services": "\(id)",
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
                    }
                    else{
                        ModalController.showSuccessCustomAlertWith(title: "", msg: (ResponseDict.object(forKey: "error_description") as? String)!)
                        self.dashboardAPI()
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
    
    
    // MARK: - ADD SERVICE API
    func addServiceAPI(serviceID : Int,name : String){
        
        let user_id:UserData = AuthorisedUser.shared.getAuthorisedUser()
        var userID = "\(user_id.data!.id)"
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.add_services)"
        let parameters = [
            "user_id": userID,
            "services": "\(serviceID)",
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
                }
                else{
                    ModalController.showSuccessCustomAlertWith(title: "", msg: (ResponseDict.object(forKey: "error_description") as? String)!)
                    
                    if name == "DELIVERY"
                    {
                        let vc = DeliveryDocumentViewController(nibName: "DeliveryDocumentViewController", bundle: nil)
                        vc.primaryid = (self.ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "dsd_id") as! Int
                        self.navigationController?.pushViewController(vc, animated: true)
                        return
                    }
                    
                    self.dashboardAPI()
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
    
    
    @objc func getNotification( _ userInfo:NSNotification)  {
        
        print(userInfo)
        var nf_type = ""
        if let pushMessage = userInfo.object as? Dictionary<String,Any>{
            if let nftype = pushMessage["nf_type"] as? String{
                nf_type = nftype
            }
            switch (nf_type) {
            case "1": //An agent accept new request {'nf_type': 2,'agent_id': 1205,'order_id': OD94031610329279}/
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                let vc = SearchedProductDeatailViewC()
                let searchId = pushMessage["search_id"] as? String
                vc.searchId = searchId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
                
                break;
            case "4": //When No agent found for customer delivery request. when close the searching popup and open the no data found {'nf_type': 3}/
                
                if(application.applicationState == .active){
                    let vc = CommonPopViewC(nibName: "CommonPopViewC", bundle: nil)
                    //          vc.delegate = self
                    let orderId = pushMessage["order_id"] as? String
                    vc.orderId = orderId ?? ""
                    vc.modalPresentationStyle = .overFullScreen
                    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                    self.present(vc, animated: true, completion: nil)
                    
                }
                if(application.applicationState == .inactive)
                {
                    NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                    let vc = ProductDetailsViewC()
                    let orderId = pushMessage["order_id"] as? String
                    vc.orderId = orderId ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                break;
            case "8": //An agent accept your product item individual need to refresh the details page {'nf_type': 5,'agent_id': 1205,'order_id': OD94031610329279}/
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                let vc = ProductDetailsViewC()
                let orderId = pushMessage["order_id"] as? String
                vc.orderId = orderId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                break;
            case "13": //An agent cancel your individual product  need to refresh the details page {'nf_type': 6,'agent_id': 1205,'order_id': OD94031610329279}
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                
                let vc = ProductDetailsViewC()
                let orderId = pushMessage["order_id"] as? String
                vc.orderId = orderId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                //
                break;
            case "15":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                let vc = ProductDetailsViewC()
                let orderId = pushMessage["order_id"] as? String
                vc.orderId = orderId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
                break;
            case "16":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                let vc = ProductDetailsViewC()
                let orderId = pushMessage["order_id"] as? String
                vc.orderId = orderId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                break;
                
            case "17":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                let vc = ProductDetailsViewC()
                let orderId = pushMessage["order_id"] as? String
                vc.orderId = orderId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                break;
                
            case "20":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                let vc = ProductDetailsViewC()
                let orderId = pushMessage["order_id"] as? String
                vc.orderId = orderId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
                break;
            case "26":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                let vc = ProductDetailsViewC()
                let orderId = pushMessage["order_id"] as? String
                vc.orderId = orderId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                break;
            case "28":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                let vc = ProductDetailsViewC()
                let orderId = pushMessage["order_id"] as? String
                vc.orderId = orderId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
                break;
                
            case "29":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                let vc = ProductDetailsViewC()
                let orderId = pushMessage["order_id"] as? String
                vc.orderId = orderId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                break;
            case "31":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                let vc = ProductDetailsViewC()
                let orderId = pushMessage["order_id"] as? String
                vc.orderId = orderId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                break;
                
                
                break;
            default:
                print("")
            }
            
        }
        
        
    }
    
    
    @objc func getNotificationARV( _ userInfo:NSNotification)  {
        
        print(userInfo)
        var nf_type = ""
        if let pushMessage = userInfo.object as? Dictionary<String,Any>{
            if let nftype = pushMessage["nf_type"] as? String{
                nf_type = nftype
            }
            switch (nf_type) {
            case "1": //An agent accept new request {'nf_type': 2,'agent_id': 1205,'order_id': OD94031610329279}/
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                
                
                
                break;
            case "4": //When No agent found for customer delivery request. when close the searching popup and open the no data found {'nf_type': 3}/
                
                if(application.applicationState == .active){
                    let vc = CommonPopViewC(nibName: "CommonPopViewC", bundle: nil)
                    //          vc.delegate = self
                    let orderId = pushMessage["order_id"] as? String
                    vc.orderId = orderId ?? ""
                    vc.modalPresentationStyle = .overFullScreen
                    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                    self.present(vc, animated: true, completion: nil)
                    
                }
                if(application.applicationState == .inactive)
                {
                    NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                    //                                            let vc = ProductDetailsViewC()
                    //                                            let orderId = pushMessage["order_id"] as? String
                    //                                            vc.orderId = orderId ?? ""
                    //                                            self.navigationController?.pushViewController(vc, animated: true)
                }
                break;
            case "8": //An agent accept your product item individual need to refresh the details page {'nf_type': 5,'agent_id': 1205,'order_id': OD94031610329279}/
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                //                                        let vc = ProductDetailsViewC()
                //                                        let orderId = pushMessage["order_id"] as? String
                //                                        vc.orderId = orderId ?? ""
                //                                        self.navigationController?.pushViewController(vc, animated: true)
                break;
            case "13": //An agent cancel your individual product  need to refresh the details page {'nf_type': 6,'agent_id': 1205,'order_id': OD94031610329279}
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                
                //                                        let vc = ProductDetailsViewC()
                //                                        let orderId = pushMessage["order_id"] as? String
                //                                        vc.orderId = orderId ?? ""
                //                                        self.navigationController?.pushViewController(vc, animated: true)
                //
                break;
            case "15":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                //                                        let vc = ProductDetailsViewC()
                //                                        let orderId = pushMessage["order_id"] as? String
                //                                        vc.orderId = orderId ?? ""
                //                                        self.navigationController?.pushViewController(vc, animated: true)
                
                break;
            case "16":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                //                                        let vc = ProductDetailsViewC()
                //                                        let orderId = pushMessage["order_id"] as? String
                //                                        vc.orderId = orderId ?? ""
                //                                        self.navigationController?.pushViewController(vc, animated: true)
                break;
                
            case "17":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                //                                        let vc = ProductDetailsViewC()
                //                                        let orderId = pushMessage["order_id"] as? String
                //                                        vc.orderId = orderId ?? ""
                //                                        self.navigationController?.pushViewController(vc, animated: true)
                break;
                
            case "20":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                //                                        let vc = ProductDetailsViewC()
                //                                        let orderId = pushMessage["order_id"] as? String
                //                                        vc.orderId = orderId ?? ""
                //                                        self.navigationController?.pushViewController(vc, animated: true)
                
                break;
            case "26":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                //                                        let vc = ProductDetailsViewC()
                //                                        let orderId = pushMessage["order_id"] as? String
                //                                        vc.orderId = orderId ?? ""
                //                                        self.navigationController?.pushViewController(vc, animated: true)
                break;
            case "28":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                //                                        let vc = ProductDetailsViewC()
                //                                        let orderId = pushMessage["order_id"] as? String
                //                                        vc.orderId = orderId ?? ""
                //                                        self.navigationController?.pushViewController(vc, animated: true)
                
                break;
                
            case "29":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                //                                        let vc = ProductDetailsViewC()
                //                                        let orderId = pushMessage["order_id"] as? String
                //                                        vc.orderId = orderId ?? ""
                //                                        self.navigationController?.pushViewController(vc, animated: true)
                break;
            case "31":
                NotificationCenter.default.post(name: Notification.Name(Constant.SEARCH_AGENT_NOTIFICATION), object: pushMessage)
                //                                        let vc = ProductDetailsViewC()
                //                                        let orderId = pushMessage["order_id"] as? String
                //                                        vc.orderId = orderId ?? ""
                //                                        self.navigationController?.pushViewController(vc, animated: true)
                break;
                
                
                break;
            default:
                print("")
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
