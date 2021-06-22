//
//  NavigationView.swift
//  Fynoo Business
//
//  Created by SENDAN on 02/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import  SideMenu

class NavigationView: UIView {
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var fynooLogoImage: UIImageView!
    @IBOutlet weak var titleHeader: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var curveImageView: UIImageView!
    @IBOutlet weak var bottomDotsImageView: UIImageView!
    
    @IBAction func menuBtnClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("clickMenuFromAnywhere"), object: nil, userInfo: nil)
    }
    
    
    var view: UIView!
    var viewControl = UIViewController()
    
    override init(frame: CGRect)
    {
        // 1. setup any properties here
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
        sideMenuCode()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.viewControl.navigationController?.popViewController(animated: true)
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
               let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
    }
    
    func xibSetup()
    {
        view = loadViewFromNib()
         //let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"
            {
                let img = UIImage(named: "back_new")
                let image = UIImage(cgImage: (img?.cgImage)!, scale: (img?.scale)!, orientation: UIImage.Orientation.upMirrored)
                backButton.setImage(image, for: .normal)
            }
            else if value[0]=="en"
            {
                let image = UIImage(named: "back_new")
                backButton.setImage(image, for: .normal)
                
            }
        }
        
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
    }
    
    func loadViewFromNib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NavigationView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view

        // Assumes UIView is top level and only object in CustomView.xib file
     //   let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }

}
func sideMenuCode()
{
//    let vc = SideMenuViewController(nibName: "SideMenuViewController", bundle: nil)
//    let menuLeftNavigationController = UISideMenuNavigationController.init(rootViewController: vc)
//    
//    if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
//        if value[0]=="ar"{
//            SideMenuManager.default.menuRightNavigationController = menuLeftNavigationController
//        }
//        else {
//            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
//        }
//    }
//    SideMenuManager.default.menuAnimationBackgroundColor = UIColor.black
//
//    SideMenuManager.default.menuPresentMode = .menuDissolveIn
//    SideMenuManager.default.menuFadeStatusBar = false
//    SideMenuManager.default.menuWidth = UIScreen.main.bounds.width
}
