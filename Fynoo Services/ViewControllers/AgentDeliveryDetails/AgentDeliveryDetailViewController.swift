//
//  AgentDeliveryDetailViewController.swift
//  Fynoo Services
//
//  Created by Apple on 19/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import GoogleMaps
import ObjectMapper
class AgentDeliveryDetailViewController: UIViewController {
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var mapVw: GMSMapView!
    
    var acceptedtripDetail : deliveryTripDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Product Details"
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
        SetFont()
        getAcceptedTripDetail()
    }

    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        
        
        }
    
    
    func getAcceptedTripDetail(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["trip_id": "437",
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.acceptedTripDetail)
        ServerCalls.postRequest(Service.gettripDetail, withParameters: param) { [self] (response, success) in
            if success{
                
                if let body = response as? [String: Any] {
                    self.acceptedtripDetail  = Mapper<deliveryTripDetail>().map(JSON: body)
                    print(self.acceptedtripDetail?.data)
                    print(self.acceptedtripDetail?.data?.trip_details?.purchase_price)
                    
//                    self.lblSize.text = acceptedtripDetail?.data?.trip_details?.size
//                  self.tableView.reloadData()
                    
                }
            }
        }
    }
    
}
