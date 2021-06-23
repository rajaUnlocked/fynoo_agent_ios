//
//  ViewInvoiceViewController.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 23/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

class ViewInvoiceViewController: UIViewController {
    
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var imgInvoice: UIImageView!
    
    var imgurl = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "View Images".localized
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
        SetFont()
        
        imgInvoice.sd_setImage(with: URL(string: imgurl), placeholderImage: UIImage(named: "profile_white.png"))
        
    }
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        
        
    }



}
