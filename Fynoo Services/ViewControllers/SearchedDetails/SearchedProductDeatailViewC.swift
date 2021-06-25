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
import MapKit
import CoreLocation
import Alamofire

class SearchedProductDeatailViewC: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate,PopUpAcceptProductDelegate,PopDeclineProductDelegate{
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
   
    @IBOutlet weak var containerMapView: UIView!
    
    @IBOutlet weak var lblDistanceAgentToBo: UILabel!
    @IBOutlet weak var lblDistanceBoToCustomer: UILabel!
    @IBOutlet weak var lblpickupTime: UILabel!
    @IBOutlet weak var lblStpickupTime: UILabel!
    
    @IBOutlet weak var lblCreatedBy: UILabel!
    @IBOutlet weak var lblStCreatedBy: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblAlmostPurchasePrice: UILabel!
    @IBOutlet weak var lblStAlmostPurchasePrice: UILabel!
    @IBOutlet weak var lblDeliveryPrice: UILabel!
    @IBOutlet weak var lblStDeliveryPrice: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var lblavgRating: UILabel!
    @IBOutlet weak var lblAlmostTotalPrice: UILabel!
    
    @IBOutlet weak var lblStAlmostTotalPrice: UILabel!
    
    @IBOutlet weak var btnAcceptTxt: UIButton!
    
    @IBOutlet weak var btnDeclineTxt: UIButton!
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgCod: UIImageView!

    var tripDetail : newOrderTripData?
    var agentViewModel = AgentModel()
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    let marker = GMSMarker()
    var currentLocation : CLLocationCoordinate2D!
    var markers = [GMSMarker]()
    var mapVw:GMSMapView?
    var searchId = ""
    var serviceId = ""
    var customerType = ""
    var seconds = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Product Details".localized
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
//        var timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: true)
//        mapVw.delegate = self
       


        SetFont()
        getTripDetail()
    }

    
    
    func SetFont() {

            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")

            let fontNameLight = NSLocalizedString("LightFontName", comment: "")

        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)

            self.lblDistanceAgentToBo.font = UIFont(name:"\(fontNameLight)",size:10)

            self.lblDistanceBoToCustomer.font = UIFont(name:"\(fontNameLight)",size:10)
        
        self.lblStAlmostTotalPrice.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblAlmostPurchasePrice.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblStpickupTime.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblStCreatedBy.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblStDeliveryPrice.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblStDeliveryPrice.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblpickupTime.font = UIFont(name:"\(fontNameLight)",size:10)
        
        self.lblCreatedBy.font = UIFont(name:"\(fontNameLight)",size:10)
        self.lblRating.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblQty.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblWeight.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblSize.font = UIFont(name:"\(fontNameLight)",size:12)
       
        self.lblRating.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblQty.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblWeight.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblSize.font = UIFont(name:"\(fontNameLight)",size:12)
        
        self.lblStAlmostPurchasePrice.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblDeliveryPrice.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblavgRating.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblAlmostTotalPrice.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblTime.font = UIFont(name:"\(fontNameLight)",size:25)
        self.btnAcceptTxt.titleLabel?.font =  UIFont(name:"\(fontNameLight)",size:16)
        self.btnDeclineTxt.titleLabel?.font =  UIFont(name:"\(fontNameLight)",size:16)
       
       
        }
        
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//
//        self.locationManager.requestWhenInUseAuthorization()
//              if CLLocationManager.locationServicesEnabled() {
//                  locationManager.delegate = self
//                  locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//
//                  locationManager.startUpdatingLocation()
//              }
//
//    if HeaderHeightSingleton.shared.longitude == 0.0 {
//                ModalController.showNegativeCustomAlertWith(title: "Please turn on your location services for navigation", msg: "")
//            }else{
//
//                //OPEN MAP
//                if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
//                    UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")!)
//                }
//                else {
//                    print("Can't use comgooglemaps://");
//                    ModalController.showNegativeCustomAlertWith(title: "Please install Google Maps to start navigation", msg: "")
//                }
//            }
//
        
//
//
//        //OPEN MAP
//        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
//            UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")!)
//        }
//        else {
//            print("Can't use comgooglemaps://");
//            ModalController.showNegativeCustomAlertWith(title: "Please install Google Maps to start navigation", msg: "")
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
  
    }
    override func viewDidAppear(_ animated: Bool) {
             self.loadMapViewa()

    }
    
    func reloadPage() {
      
        callRequestAccept()
    }
    func declineOrder() {
        callRequestReject()
    }
    
    
    
    func loadMapViewa() {
        
//        if let location = self.orderResponse["location_name"] as? String{
//            lblAddress.text = location
//        }
//        var cust_lat = 0.0, cust_long = 0.0, branch_lat = 0.0, branch_long = 0.0
//        if let location = self.orderResponse["cus_lat"] as? NSNumber{
//            cust_lat = location.doubleValue
//        }
//        if let location = self.orderResponse["cus_long"] as? NSNumber{
//           cust_long = location.doubleValue
//         }
//        if let location = self.orderResponse["branch_lat"] as? NSNumber{
//                branch_lat = location.doubleValue
//              }
//        if let location = self.orderResponse["branch_long"] as? NSNumber{
//                branch_long = location.doubleValue
//        }
//        let agentLat : Double = 25.5321195
//        let agentLng : Double = 83.2748956
//        var cust_lat:Double = 28.8309593
//        var cust_long : Double = 78.7619664
//        var branch_lat : Double = 28.570751
//        var branch_long : Double = 77.326188
        
        let agentLat : Double = Double.getDouble(tripDetail?.data?.trip_details?.agent_lat)
        let agentLng : Double = Double.getDouble(tripDetail?.data?.trip_details?.agent_long)
        var cust_lat:Double = Double.getDouble(tripDetail?.data?.trip_details?.cust_lat)
        var cust_long : Double = Double.getDouble(tripDetail?.data?.trip_details?.cust_long)
        var branch_lat : Double = Double.getDouble(tripDetail?.data?.trip_details?.bo_lat)
        var branch_long : Double = Double.getDouble(tripDetail?.data?.trip_details?.bo_long)
        
        
        
        let camera = GMSCameraPosition.camera(withLatitude: cust_lat, longitude: cust_long, zoom: 18.0)
        self.mapVw = GMSMapView.map(withFrame:  self.view.bounds, camera: camera)
        self.mapVw?.animate(toViewingAngle: 18)
        self.mapVw?.delegate = self
        self.mapVw?.isTrafficEnabled = true
        self.containerMapView.addSubview(self.mapVw!)

         let cust_marker: GMSMarker = GMSMarker() // Allocating Marker
         cust_marker.icon = UIImage(named: "home") // Marker icon
         let cust_location  = CLLocationCoordinate2D(latitude: cust_lat, longitude: cust_long)
         cust_marker.position = cust_location // CLLocationCoordinate2D
        cust_marker.map = self.mapVw // Setting marker on Mapview
        markers.append(cust_marker)

        let branch_marker: GMSMarker = GMSMarker() // Allocating Marker
        branch_marker.icon = UIImage(named: "nearestBranchMapLocation") // Marker icon
        branch_marker.appearAnimation = .pop // Appearing animation. default
        let branch_location  = CLLocationCoordinate2D(latitude: branch_lat, longitude: branch_long)
        branch_marker.position = branch_location // CLLocationCoordinate2D
        branch_marker.map = self.mapVw // Setting marker on Mapview
        markers.append(branch_marker)
   
        self.setMarkerBoundsOnMap()
        self.mapVw?.drawPolygon(from: cust_location, to: branch_location)
               
     }
  
    func setMarkerBoundsOnMap()  {
       
          var bounds = GMSCoordinateBounds()
          for marker in markers {
              bounds = bounds.includingCoordinate(marker.position)
          }
        mapVw?.animate(with: GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 100.0 , left: 50.0 ,bottom: 100.0 ,right: 50.0)))
      }
    
    
    
    func loadHeaderData(){

          let agentLat = Double.getDouble(tripDetail?.data?.trip_details?.agent_lat)
          let agentLng = Double.getDouble(tripDetail?.data?.trip_details?.agent_long)
          let boLat = Double.getDouble(tripDetail?.data?.trip_details?.bo_lat)
          let boLng = Double.getDouble(tripDetail?.data?.trip_details?.bo_long)
          let custLat = Double.getDouble(tripDetail?.data?.trip_details?.cust_lat)
          let custLng = Double.getDouble(tripDetail?.data?.trip_details?.cust_long)
          
        let distanceUrlFromAgentToBO = "\(Constant.GOOGLE_API_DISTANCE)origin=\(agentLat),\(agentLng)&destination=\(boLat),\(boLng)&key=\(Constant.GOOGLE_API_KEY)"
          agentViewModel.getDistance(distanceUrlFromAgentToBO) { (succes, response) in
              if succes{
                self.lblDistanceAgentToBo.text = "\(response.routes?.first?.legs?.first?.distance?.text ?? "")".uppercased()
              }
          }
        let distanceUrlFromBOToCustomer = "\(Constant.GOOGLE_API_DISTANCE)origin=\(boLat),\(boLng)&destination=\(custLat),\(custLng)&key=\(Constant.GOOGLE_API_KEY)"
          agentViewModel.getDistance(distanceUrlFromBOToCustomer) { (succes, response) in
                     if succes{
                        self.lblDistanceBoToCustomer.text = "\(response.routes?.first?.legs?.first?.distance?.text ?? "")".uppercased()
                     }
                 }
      }
    
    
    
    
    
    @IBAction func BtnTappedToAccept(_ sender: UIButton) {
        
        let vc = PopUpAcceptProductViewController(nibName: "PopUpAcceptProductViewController", bundle: nil)
        vc.delegate = self
        vc.titleLabel = "Are you sure want to accept?".localized
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnTappedToDecline(_ sender: Any) {
        
        let vc = PopUpAcceptProductViewController(nibName: "PopUpAcceptProductViewController", bundle: nil)
        vc.delegateDecline = self
        vc.titleLabel = "Are you sure want to decline?".localized
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func getTripDetail(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["search_id": searchId,
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.gettripDetail)
        ServerCalls.postRequest(Service.gettripDetail, withParameters: param) { [self] (response, success) in
            if success{
                
                if let body = response as? [String: Any] {
                    self.tripDetail  = Mapper<newOrderTripData>().map(JSON: body)
                    if let value = response as? NSDictionary{
                        let msg = value.object(forKey: "error_description") as! String
                        let error = value.object(forKey: "error_code") as! Int
                        if error == 700{
                            ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
                            
                            let errorData = value.object(forKey: "data") as! Dictionary<String, Any>
                            
                            
                            let vc = AgentDeliveryViewController()
                            vc.serviceID = "\(errorData["del_service_id"] as! Int)"
                            vc.selectedTab = "\(errorData["service_status"] as! Int)"
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
                    
                    print(self.tripDetail?.data)
//                    print(self.tripDetail?.data?.trip_details?.purchase_price)
//
                    self.lblQty.text = "Qty:\(tripDetail?.data?.trip_details?.qty ?? 0)"
                    self.lblSize.text = "Size:\(tripDetail?.data?.trip_details?.size ?? "")"
                    self.lblCreatedBy.text = "\(tripDetail?.data?.trip_details?.created_by ?? "")"
                    self.lblpickupTime.text = "\(tripDetail?.data?.trip_details?.pick_up_time ?? "")"
                    self.lblWeight.text = "Weight:\(tripDetail?.data?.trip_details?.weight ?? "")"
                    self.lblRating.text = "\(tripDetail?.data?.trip_details?.rating ?? "")"
                    self.lblavgRating.text = "\(tripDetail?.data?.trip_details?.total_rating ?? "")"
                    self.lblpickupTime.text = "\(tripDetail?.data?.trip_details?.pick_up_time ?? "")"
                    self.lblAlmostPurchasePrice.text = "\(tripDetail?.data?.trip_details?.purchase_price ?? "")"
                    self.lblDeliveryPrice.text = "\(tripDetail?.data?.trip_details?.delivery_price ?? "")"
                    self.lblAlmostTotalPrice.text = "\(tripDetail?.data?.trip_details?.total_price ?? "")"
                    self.imgCod.sd_setImage(with: URL(string: tripDetail?.data?.trip_details?.payment_icon ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                    
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        self.seconds -= 1
                        if self.seconds <= 0 {
                            print("Go!")
                            timer.invalidate()
                        } else {
                            print(self.seconds)
                            self.lblTime.text = "\(tripDetail?.data?.trip_details?.otp_time ?? 0)min"
                        }
                    }
                    self.loadHeaderData()
                    
                }
            }
        }
    }
    
    
    func callRequestAccept(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["search_id": searchId,
                     "user_id":userId,
                     "service_id":String.getString(tripDetail?.data?.trip_details?.service_id),
                     "user_type":String.getString(tripDetail?.data?.trip_details?.created_by),
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
//        let param = ["search_id": "45",
//                     "user_id":userId,
//                     "service_id":"399",
//                     "user_type":"CUSTOMER",
//                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.agentAcceptRequest)
        ServerCalls.postRequest(Service.agentAcceptRequest, withParameters: param) { [self] (response, success) in
            if success{
                
                if let body = response as? [String: Any] {
                    self.tripDetail  = Mapper<newOrderTripData>().map(JSON: body)
                    if success == true {
                        
                        let ResponseDict : NSDictionary = (response as? NSDictionary)!
                        print("ResponseDictionary %@",ResponseDict)
                        let x = ResponseDict.object(forKey: "error") as! Bool
                        if x {
                        ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "error_description") as? String)!, msg: "")
        //                    self.transactionListArray.removeAllObjects()
        //                    self.tableView.reloadData()
                            
//                            self.delegate?.reloadPage()
                        }
                        else{
                            
                            ModalController.showSuccessCustomAlertWith(title: ((ResponseDict.object(forKey: "error_description") as? String)!), msg: "")
                            let vc = AgentDeliveryViewController()
                            vc.serviceID = "\(tripDetail?.data?.trip_details?.service_id ?? 0)"
                            vc.serviceStatus = "\(tripDetail?.data?.trip_details?.service_status ?? 0)"
                            self.navigationController?.pushViewController(vc, animated: true)
                            
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
        }
    }
    
    func callRequestReject(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["search_id": searchId,
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.agentDeclineRequest)
        ServerCalls.postRequest(Service.agentDeclineRequest, withParameters: param) { [self] (response, success) in
            if success{
                
                if let body = response as? [String: Any] {
                    self.tripDetail  = Mapper<newOrderTripData>().map(JSON: body)
                    if success == true {
                        
                        let ResponseDict : NSDictionary = (response as? NSDictionary)!
                        print("ResponseDictionary %@",ResponseDict)
                        let x = ResponseDict.object(forKey: "error") as! Bool
                        if x {
                        ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "error_description") as? String)!, msg: "")
        //                    self.transactionListArray.removeAllObjects()
        //                    self.tableView.reloadData()
                            
//                            self.delegate?.reloadPage()
                        }
                        else{
                            
                            ModalController.showSuccessCustomAlertWith(title: ((ResponseDict.object(forKey: "error_description") as? String)!), msg: "")
                            let vc = AgentDeliveryViewController()
                            vc.serviceID = "\(tripDetail?.data?.trip_details?.service_id ?? 0)"
                            vc.serviceStatus = "\(tripDetail?.data?.trip_details?.service_status ?? 0)"
                            self.navigationController?.pushViewController(vc, animated: true)
                            
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
        }
    }
    
    
    
}