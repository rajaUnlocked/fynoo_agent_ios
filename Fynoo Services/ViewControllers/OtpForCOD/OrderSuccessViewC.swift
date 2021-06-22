//
//  OrderSuccessViewC.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 16/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

class OrderSuccessViewC: UIViewController {
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var lblMsg: UILabel!
    
    var confirmDeliveryData : Dictionary<String,Any> = ["":""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Product Details"
        self.headerView.menuBtn.isHidden = true
        self.headerView.backButton.isHidden = true
        self.headerView.viewControl = self
        SetFont()
        
        print(confirmDeliveryData)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let vc = AgentDeliveryViewController()
            vc.orderSuccessData = self.confirmDeliveryData
            self.navigationController?.pushViewController(vc, animated: true)
            
            var dictPass = [String:Any]()
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: Constant.NF_KEY_FOR_PASS_DATA_TO_DELIVERYDASHBOARD), object: nil, userInfo: dictPass)
            
        }
    }
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        self.lblMsg.font = UIFont(name:"\(fontNameLight)",size:24)!
        
    }

}
