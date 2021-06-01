//
//  SearchedProductDeatailViewC.swift
//  Fynoo Services
//
//  Created by Apple on 24/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import GoogleMaps
import ObjectMapper
import Cosmos
class SearchedProductDeatailViewC: UIViewController {
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var mapVw: GMSMapView!
    
    @IBOutlet weak var lblDistanceAgentToBo: UILabel!
    @IBOutlet weak var lblDistanceBoToCustomer: UILabel!
    @IBOutlet weak var lblpickupTime: UILabel!
    @IBOutlet weak var lblCreatedBy: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblAlmostPurchasePrice: UILabel!
    @IBOutlet weak var lblDeliveryPrice: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var lblavgRating: UILabel!
    @IBOutlet weak var lblAlmostTotalPrice: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgCod: UIImageView!

    var tripDetail : deliveryTripDetail?
    
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    let marker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Product Details"
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
        SetFont()
        getTripDetail()
    }

    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        
        
        }
        
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lblWeight.text = tripDetail?.data?.trip_details?.weight ?? ""
        
//        lblQty.text = tripDetail?.data?.trip_details?.qty
        
//        lblSize.text = tripDetail?.data?.trip_details?.size
        lblDeliveryPrice.text = tripDetail?.data?.trip_details?.delivery_price
//        lblTime.text = tripDetail?.data?.trip_details?.otp_time
        lblpickupTime.text = tripDetail?.data?.trip_details?.pick_up_time
        lblCreatedBy.text = tripDetail?.data?.trip_details?.created_by
        lblAlmostPurchasePrice.text = self.tripDetail?.data?.trip_details?.purchase_price
        
        
        
        //OPEN MAP
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")!)
        }
        else {
            print("Can't use comgooglemaps://");
            ModalController.showNegativeCustomAlertWith(title: "Please install Google Maps to start navigation", msg: "")
        }
    }
    
    
    func getTripDetail(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["search_id": "437",
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.gettripDetail)
        ServerCalls.postRequest(Service.gettripDetail, withParameters: param) { [self] (response, success) in
            if success{
                
                if let body = response as? [String: Any] {
                    self.tripDetail  = Mapper<deliveryTripDetail>().map(JSON: body)
                    print(self.tripDetail?.data)
                    print(self.tripDetail?.data?.trip_details?.purchase_price)
                    
                    self.lblSize.text = tripDetail?.data?.trip_details?.size
//                  self.tableView.reloadData()
                    
                }
            }
        }
    }
}
