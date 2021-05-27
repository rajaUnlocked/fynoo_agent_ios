//
//  AgentDeliveryDetailViewController.swift
//  Fynoo Services
//
//  Created by Apple on 19/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

class AgentDeliveryDetailViewController: UIViewController {
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Product Details"
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
    }

}
