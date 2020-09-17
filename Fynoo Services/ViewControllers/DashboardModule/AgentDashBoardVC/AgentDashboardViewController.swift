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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotifications()
        sideMenuCode()
        configureHeaderUI()
        registerCellNibs()
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
        return 3
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return DashboardWalletCell(index: indexPath)
        }else if indexPath.section == 1 {
            return ProgressDashboardCell(index: indexPath)
        }else{
            return ServicesDashboardCell(index: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            return 170
        }else if indexPath.section == 1{
            return 120
        }else{
            return 500
        }
    }
    
    // MARK: - TableView Cells Return
    func DashboardWalletCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "DashboardWalletTableViewCell",for: index) as! DashboardWalletTableViewCell
        cell.selectionStyle = .none
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
