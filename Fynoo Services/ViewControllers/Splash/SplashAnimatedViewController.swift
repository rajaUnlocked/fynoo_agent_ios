//
//  SplashAnimatedViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-049 on 07/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import SwiftyGif
import StoreKit

class SplashAnimatedViewController: UIViewController, VersionPopupViewControllerDelegate, SKStoreProductViewControllerDelegate {

    @IBOutlet weak var bgImage: UIImageView!
    let logoAnimationView = LogoAnimationView()
    var userTypeStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         if  HeaderHeightSingleton.shared.LanguageSelected == "AR" {
            print("ar")
        }else{
          
              UserDefaults.standard.set(["en","ar"], forKey: "AppleLanguages")
              HeaderHeightSingleton.shared.LanguageSelected = "EN"
    //          HeaderHeightSingleton.shared.Currency = "SAR".localized
        }
        
        
        rotateImagesOnLanguage()
        headerHeightMethod()
    }
    
    func configureSwipe(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
        self.view.bringSubviewToFront(bgImage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            logoAnimationView.logoGifImageView.startAnimatingGif()
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                print("Swiped right")
            case .down:
                print("Swiped down")
                appVersionAPI()
            case .left:
                print("Swiped left")
            case .up:
                print("Swiped up")
            default:
                break
            }
        }
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
    
    func headerHeightMethod(){
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            let myIntValue = Int(topPadding!)
            
            if myIntValue > 0{
                let glblHeight = HeaderHeightSingleton.shared
                glblHeight.headerHeight = 120
            }
            
        }
        if #available(iOS 12.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            let myIntValue = Int(topPadding!)
            
            if myIntValue > 0{
                if myIntValue == 44{
                    let glblHeight = HeaderHeightSingleton.shared
                    glblHeight.headerHeight = 120
                }else{
                    let glblHeight = HeaderHeightSingleton.shared
                    glblHeight.headerHeight = 105
                }
            }
        }
    }
    
    // MARK: - APP VERSION API
      func appVersionAPI()
      {
          ModalClass.startLoading(self.view)
          let str = "\(Constant.BASE_URL)\(Constant.getAppVersion)"
          let parameters = [
              "device_type": "ios",
              "application_type": "Agent"
          ]
          print("request -",parameters)
          ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
              if success == true {
                  let ResponseDict : NSDictionary = (response as? NSDictionary)!
                  print("ResponseDictionary %@",ResponseDict)
                  let x = ResponseDict.object(forKey: "error") as! Bool
                  if x {
                  }
                  else{
                    if let text = Bundle.main.infoDictionary?["CFBundleVersion"] as? NSString {
                        let results = ResponseDict.object(forKey: "data") as! NSDictionary
                        let phoneAppVersion = (text).floatValue
                        let current_version = (results.object(forKey: "current_version") as! NSString).floatValue
                        let forcefully_update_version = (results.object(forKey: "forcefully_update_version") as! NSString).floatValue
                        
                        if phoneAppVersion < current_version {
                            
                            if current_version <  forcefully_update_version {
                            let vc = VersionPopupViewController(nibName:
                                "VersionPopupViewController", bundle: nil)
                                vc.isForForceUpdate = true
                            vc.modalPresentationStyle = .overFullScreen
                            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                            vc.delegate =  self
                            self.present(vc, animated: true, completion: nil)
                            }else{
                                let vc = VersionPopupViewController(nibName: "VersionPopupViewController", bundle: nil)
                                vc.modalPresentationStyle = .overFullScreen
                                vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                                vc.delegate =  self
                                self.present(vc, animated: true, completion: nil)
                            }
                        }else{
                            self.setupNav()
                        }
                    }else{
                        self.setupNav()
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
      }
    
    func updateLaterClicked() {
        setupNav()
    }
    
    func updateNowClicked() {
        openStoreProductWithiTunesItemIdentifier(identifier: "1531299470")
    }
    
    func openStoreProductWithiTunesItemIdentifier(identifier: String) {
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self
        
        let parameters = [ SKStoreProductParameterITunesItemIdentifier : identifier]
        storeViewController.loadProduct(withParameters: parameters) { [weak self] (loaded, error) -> Void in
            if loaded {
                // Parent class of self is UIViewContorller
                self?.present(storeViewController, animated: true, completion: nil)
            }
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
        appVersionAPI()
    }
    
    func setupNav() {
        
        
        if AuthorisedUser.shared.isAuthorised{
                        let userData:UserData = AuthorisedUser.shared.getAuthorisedUser()
                        
                        Singleton.shared.setUserId(UserId: "\(userData.data!.id)")
                        Singleton.shared.setLoggedInUserType(UserType: "\(userData.data!.user_type)")
                        let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
                              userTypeStr = userid.data!.user_type
                        
                         var isNewUser = ""
                         if userTypeStr == "AI" || userTypeStr == "AC" {
                            isNewUser = ModalController.toString(userid.data!.is_new_user as AnyObject)
                              if isNewUser == "1" {
                                
                                if userData.error_description == "Verification Pending" {
                                    let vc = VerifyAccountViewController(nibName: "VerifyAccountViewController", bundle: nil)

                                    vc.mobile = userData.data!.mobile_number
                                    vc.emailId = userData.data!.email
                                    vc.fynooId = userData.data!.fynoo_id
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }else{

                                    if userid.data!.is_language_added == true {
                                        let vc = AgentDashboardViewController(nibName: "AgentDashboardViewController", bundle: nil)
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }else{
                                        let vc = LanguageSelectionViewController(nibName: "LanguageSelectionViewController", bundle: nil)
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                }
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
if userid.data!.is_language_added == true {
    let vc = AgentDashboardViewController(nibName: "AgentDashboardViewController", bundle: nil)
    self.navigationController?.pushViewController(vc, animated: true)
}else{
    let vc = LanguageSelectionViewController(nibName: "LanguageSelectionViewController", bundle: nil)
    self.navigationController?.pushViewController(vc, animated: true)
}
                    }
            }else{
                        let vc = LoginNewDesignViewController(nibName: "LoginNewDesignViewController", bundle: nil)
                        self.navigationController?.pushViewController(vc, animated: false)
            }
        }
}

extension SplashAnimatedViewController: SwiftyGifDelegate {
        func gifDidStop(sender: UIImageView) {
            logoAnimationView.isHidden = true
            configureSwipe()
            appVersionAPI()
        }
}
