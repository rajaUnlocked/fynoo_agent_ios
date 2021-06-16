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
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Product Details"
        self.headerView.menuBtn.isHidden = true
        self.headerView.backButton.isHidden = true
        self.headerView.viewControl = self
        SetFont()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let vc = OrderSuccessViewC()
//                    vc.orderId = self.orderId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        self.lblMsg.font = UIFont(name:"\(fontNameLight)",size:24)!
        
    }

}
