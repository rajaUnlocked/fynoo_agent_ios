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

class SearchedProductDeatailViewC: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate {
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
    var currentLocation : CLLocationCoordinate2D!
    var markers = [GMSMarker]()

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
        
        
        
        self.locationManager.requestWhenInUseAuthorization()
              if CLLocationManager.locationServicesEnabled() {
                  locationManager.delegate = self
                  locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters

                  locationManager.startUpdatingLocation()
              }

        mapVw.delegate = self


          
         
    if HeaderHeightSingleton.shared.longitude == 0.0 {
                ModalController.showNegativeCustomAlertWith(title: "Please turn on your location services for navigation", msg: "")
            }else{
             
                //OPEN MAP
                if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                    UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")!)
                }
                else {
                    print("Can't use comgooglemaps://");
                    ModalController.showNegativeCustomAlertWith(title: "Please install Google Maps to start navigation", msg: "")
                }
            }
            
        
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
    
    
    
    override func viewDidAppear(_ animated: Bool) {
             self.loadMapView()

    }
    
    
    func loadMapView() {
        
        
        let agentLat = Double.getDouble(tripDetail?.data?.trip_details?.agent_lat)
                 let agentLng = Double.getDouble(tripDetail?.data?.trip_details?.agent_long)
                 let branch_lat = Double.getDouble(tripDetail?.data?.trip_details?.bo_lat)
                 let branch_long = Double.getDouble(tripDetail?.data?.trip_details?.bo_long)
                 let custLat = Double.getDouble(tripDetail?.data?.trip_details?.cust_lat)
                 let custLng = Double.getDouble(tripDetail?.data?.trip_details?.cust_long)
        
        let camera = GMSCameraPosition.camera(withLatitude: agentLat, longitude: agentLng, zoom: 18.0)
        self.mapVw = GMSMapView.map(withFrame:  self.view.bounds, camera: camera)
        self.mapVw?.animate(toViewingAngle: 18)
        self.mapVw?.delegate = self
        self.mapVw?.isTrafficEnabled = true
//        self.containerMapView.addSubview(self.mapVw!)

         let cust_marker: GMSMarker = GMSMarker() // Allocating Marker
         cust_marker.icon = UIImage(named: "home") // Marker icon
        let cust_location  = CLLocationCoordinate2D(latitude: custLat, longitude: custLng)
         cust_marker.position = cust_location // CLLocationCoordinate2D
         cust_marker.map = self.mapVw // Setting marker on Mapview
        markers.append(cust_marker)
        
        let agent_marker: GMSMarker = GMSMarker() // Allocating Marker
        agent_marker.icon = UIImage(named: "suv") // Marker icon
        let agent_location  = CLLocationCoordinate2D(latitude: agentLat, longitude: agentLng)
        agent_marker.position = agent_location // CLLocationCoordinate2D
        agent_marker.map = self.mapVw // Setting marker on Mapview
        markers.append(agent_marker)

        let branch_marker: GMSMarker = GMSMarker() // Allocating Marker
        branch_marker.icon = UIImage(named: "nearestBranchMapLocation") // Marker icon
        branch_marker.appearAnimation = .pop // Appearing animation. default
        let branch_location  = CLLocationCoordinate2D(latitude: branch_lat, longitude: branch_long)
        branch_marker.position = branch_location // CLLocationCoordinate2D
        branch_marker.map = self.mapVw // Setting marker on Mapview
        markers.append(branch_marker)
   
//        self.setMarkerBoundsOnMap()
        self.mapVw?.drawPolygon(from: agent_location, to: branch_location)
        self.mapVw?.drawPolygon(from: branch_location, to: cust_location)
               
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
