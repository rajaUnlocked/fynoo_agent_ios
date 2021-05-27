//
//  SearchedProductDeatailViewC.swift
//  Fynoo Services
//
//  Created by Apple on 24/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import GoogleMaps

class SearchedProductDeatailViewC: UIViewController {
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var mapVw: GMSMapView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Product Details"
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
        
        SetFont()
    }

    
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }
    
    
    func getAgentData(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["service_id":self.serviceID,
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.deliveryDashboard)
        ServerCalls.postRequest(Service.deliveryDashboard, withParameters: param) { (response, success) in
            if success{
                
                if let body = response as? [String: Any] {
                    self.deliverData  = Mapper<deliveryDashboard>().map(JSON: body)
                    
                    print(self.deliverData?.data?.agent_information?.del_service_document ?? "","del_service_document")
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
}
