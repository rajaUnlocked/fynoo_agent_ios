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
import Cosmos
import MapKit
import CoreLocation
import Alamofire
class AgentDeliveryDetailViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblAvgRating: UILabel!
    
    @IBOutlet weak var lblTotalRating: UILabel!
    
    @IBOutlet weak var lblOpenClose: UILabel!
    
    @IBOutlet weak var lblDuration: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var containerMapView: UIView!
    
    @IBOutlet weak var imgCustWidth: NSLayoutConstraint!
    
    @IBOutlet weak var lblClose: UILabel!
    
    @IBOutlet weak var imgAddressIcon: UIImageView!
    var checkStatus = 0
    var checkUsertype = ""
    
    
    var tripId = 0
    var nearestLat = 25.5518
    var nearestLong = 83.1834
    var nearestDistance = 10.0
    let locationManager = CLLocationManager()
    var markers = [GMSMarker]()
    var mapVw:GMSMapView?
    
    var acceptedtripDetail : deliveryTripDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Order Details".localized
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
        
        SetFont()
        //        self.setCustomerLocation()
        getAcceptedTripDetail()
        
        //        self.locationManager.requestWhenInUseAuthorization()
        //        if CLLocationManager.locationServicesEnabled() {
        //            locationManager.delegate = self
        //            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //            locationManager.startUpdatingLocation()
        //        }
        //
        //        let obj = BranchOnMapDetailModel()
        //        obj.productId = productId
        //        obj.getProductBranchList { (success, response) in
        //            if success{
        //                self.mapProductBranchList = response
        //
        //                if self.mapProductBranchList?.data?.count == 1 {
        //                    self.selectedIndex = 1
        //                }
        //                else {
        //                    self.selectedIndex = 0
        //                }
        //                //                self.tabView.reloadData()
        //                self.addPullUpController(animated: true)
        //                self.setMarkerInMap(response: response!, toSort: true)
        //
        //            }
        //        }
        
        //        self.setMarkerInMap()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //             self.loadMapViewa()
        //        self.loadMapViewForCustomer()
        
    }
    
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        
        
    }
    
    func loadMapViewBO() {
        
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
        let agentLat : Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.agent_lat)
        let agentLng : Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.agent_long)
        var cust_lat:Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.cust_lat)
        var cust_long : Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.cust_long)
        var branch_lat : Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.bo_lat)
        var branch_long : Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.bo_long)
        
        
        let camera = GMSCameraPosition.camera(withLatitude: cust_lat, longitude: cust_long, zoom: 18.0)
        self.mapVw = GMSMapView.map(withFrame:  self.view.bounds, camera: camera)
        self.mapVw?.animate(toViewingAngle: 18)
        self.mapVw?.delegate = self
        self.mapVw?.isTrafficEnabled = true
        self.containerMapView.addSubview(self.mapVw!)
        
        let cust_marker: GMSMarker = GMSMarker() // Allocating Marker
        //         cust_marker.icon = UIImage(named: "Car") // Marker icon
        cust_marker.icon = #imageLiteral(resourceName: "placeholder (2)")
        let cust_location  = CLLocationCoordinate2D(latitude: cust_lat, longitude: cust_long)
        cust_marker.position = cust_location // CLLocationCoordinate2D
        cust_marker.map = self.mapVw // Setting marker on Mapview
        markers.append(cust_marker)
        
        let branch_marker: GMSMarker = GMSMarker() // Allocating Marker
        //        branch_marker.icon = UIImage(named: "home") // Marker icon
        branch_marker.icon = #imageLiteral(resourceName: "Group 821")
        branch_marker.appearAnimation = .pop // Appearing animation. default
        let branch_location  = CLLocationCoordinate2D(latitude: branch_lat, longitude: branch_long)
        branch_marker.position = branch_location // CLLocationCoordinate2D
        branch_marker.map = self.mapVw // Setting marker on Mapview
        markers.append(branch_marker)
        
        
        let agent_marker: GMSMarker = GMSMarker() // Allocating Marker
        //        branch_marker.icon = UIImage(named: "home") // Marker icon
        agent_marker.icon = #imageLiteral(resourceName: "Car")
        agent_marker.appearAnimation = .pop // Appearing animation. default
        let agent_location  = CLLocationCoordinate2D(latitude: agentLat, longitude: agentLng)
        agent_marker.position = agent_location // CLLocationCoordinate2D
        agent_marker.map = self.mapVw // Setting marker on Mapview
        markers.append(agent_marker)
        
        self.setMarkerBoundsOnMap()
        self.mapVw?.drawPolygon(from: cust_location, to: branch_location)
        self.mapVw?.drawPolygon(from: branch_location, to: agent_location)
        
    }
    
    
    func loadMapViewForCustomer() {
        
        
        let agentLat : Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.agent_lat)
        let agentLng : Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.agent_long)
        var cust_lat:Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.cust_lat)
        var cust_long : Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.cust_long)
        var branch_lat : Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.bo_lat)
        var branch_long : Double = Double.getDouble(acceptedtripDetail?.data?.trip_details?.bo_long)
        
        
        let camera = GMSCameraPosition.camera(withLatitude: cust_lat, longitude: cust_long, zoom: 18.0)
        self.mapVw = GMSMapView.map(withFrame:  self.view.bounds, camera: camera)
        self.mapVw?.animate(toViewingAngle: 18)
        self.mapVw?.delegate = self
        self.mapVw?.isTrafficEnabled = true
        self.containerMapView.addSubview(self.mapVw!)
        
        let cust_marker: GMSMarker = GMSMarker() // Allocating Marker
        //         cust_marker.icon = UIImage(named: "Car") // Marker icon
        cust_marker.icon = #imageLiteral(resourceName: "placeholder (2)")
        let cust_location  = CLLocationCoordinate2D(latitude: cust_lat, longitude: cust_long)
        cust_marker.position = cust_location // CLLocationCoordinate2D
        cust_marker.map = self.mapVw // Setting marker on Mapview
        markers.append(cust_marker)
        
        //        let branch_marker: GMSMarker = GMSMarker() // Allocating Marker
        //        branch_marker.icon = UIImage(named: "home") // Marker icon
        //        branch_marker.icon = #imageLiteral(resourceName: "Group 821")
        //        branch_marker.appearAnimation = .pop // Appearing animation. default
        //        let branch_location  = CLLocationCoordinate2D(latitude: branch_lat, longitude: branch_long)
        //        branch_marker.position = branch_location // CLLocationCoordinate2D
        //        branch_marker.map = self.mapVw // Setting marker on Mapview
        //        markers.append(branch_marker)
        
        
        let agent_marker: GMSMarker = GMSMarker() // Allocating Marker
        //        branch_marker.icon = UIImage(named: "home") // Marker icon
        agent_marker.icon = #imageLiteral(resourceName: "Car")
        agent_marker.appearAnimation = .pop // Appearing animation. default
        let agent_location  = CLLocationCoordinate2D(latitude: agentLat, longitude: agentLng)
        agent_marker.position = agent_location // CLLocationCoordinate2D
        agent_marker.map = self.mapVw // Setting marker on Mapview
        markers.append(agent_marker)
        
        self.setMarkerBoundsOnMap()
        self.mapVw?.drawPolygon(from: agent_location, to: cust_location)
        
    }
    
    
    func setMarkerBoundsOnMap()  {
        
        var bounds = GMSCoordinateBounds()
        for marker in markers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        mapVw?.animate(with: GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 100.0 , left: 50.0 ,bottom: 100.0 ,right: 50.0)))
    }
    
    
    
    
    func getAcceptedTripDetail(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["trip_id": tripId,
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected] as [String : Any]
        
        print("request:-", param)
        print("Url:-", Service.acceptedTripDetail)
        ModalClass.startLoading(self.view)
        ServerCalls.postRequest(Service.acceptedTripDetail, withParameters: param) { [self] (response, success) in
            if success{
                
                
                
                //                self.addPullUpController(animated: true)
                
                ModalClass.stopLoadingAllLoaders(self.view)
                if let body = response as? [String: Any] {
                    self.acceptedtripDetail  = Mapper<deliveryTripDetail>().map(JSON: body)
                    print(self.acceptedtripDetail?.data)
                    
                    
                    if let value = response as? NSDictionary{
                        let msg = value.object(forKey: "error_description") as! String
                        let error = value.object(forKey: "error_code") as! Int
                        if error == 100{
                            self.view.alpha = 0.5
                            ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
                            
                        }
                    }
                    //                    lblName.text = acceptedtripDetail?.data?.trip_details?.cust_nam
                    //                    lblAvgRating.text = acceptedtripDetail?.data?.trip_details?.cust_rating
                    //                    lblTotalRating.text = acceptedtripDetail?.data?.trip_details?.cust_total_rating
                    //                    lblAddress.text = acceptedtripDetail?.data?.trip_details?.cust_address
                    //                    lblDuration.text = (acceptedtripDetail?.data?.trip_details?.delivery_times?[0].time ?? "") + "(\(acceptedtripDetail?.data?.trip_details?.delivery_times?[0].distance ?? "" )km)"
                    //                    self.imgUser.sd_setImage(with: URL(string: acceptedtripDetail?.data?.trip_details?.cust_image ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                    let km = "km".localized
                    let addressStr = "Address :".localized
                    if checkUsertype == "BO" {
                        lblName.text = acceptedtripDetail?.data?.trip_details?.branch_name
                        lblAvgRating.text = "(\(acceptedtripDetail?.data?.trip_details?.rating ?? ""))"
                        lblTotalRating.text = "(\(acceptedtripDetail?.data?.trip_details?.total_rating ?? ""))"
                        lblAddress.text = "\(addressStr)\(acceptedtripDetail?.data?.trip_details?.address ?? "")"
                        
                        lblDuration.text = (acceptedtripDetail?.data?.trip_details?.delivery_times?[0].time ?? "") + "(\(acceptedtripDetail?.data?.trip_details?.delivery_times?[0].distance ?? "" )\(km))"
                        
                        self.imgUser.sd_setImage(with: URL(string: acceptedtripDetail?.data?.trip_details?.branch_image ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                        
                        self.loadMapViewBO()
                    }else
                    {
                        lblName.text = acceptedtripDetail?.data?.trip_details?.cust_nam
                        lblAvgRating.text = acceptedtripDetail?.data?.trip_details?.cust_rating
                        lblTotalRating.text = acceptedtripDetail?.data?.trip_details?.cust_total_rating
                        
                        lblAddress.text =  "\(addressStr)\(acceptedtripDetail?.data?.trip_details?.cust_address ?? "")"
                        lblDuration.text = (acceptedtripDetail?.data?.trip_details?.delivery_times?[0].time ?? "") + "(\(acceptedtripDetail?.data?.trip_details?.delivery_times?[0].distance ?? "" )\(km))"
                        self.imgUser.sd_setImage(with: URL(string: acceptedtripDetail?.data?.trip_details?.cust_image ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
                        self.loadMapViewForCustomer()
                    }
                    
                    callOpenCloseStatus()
                    if checkUsertype ==  "CUSTOMER" {
                        imgCustWidth.constant = 0
                        lblOpenClose.isHidden = true
                        lblClose.isHidden = true
                        imgAddressIcon.image = #imageLiteral(resourceName: "businessOwner_locationIcon")
                    }
                }
            }
        }
    }
    
    
    func callOpenCloseStatus()  {
        switch acceptedtripDetail?.data?.trip_details?.time_display_code {
        
        case "NO_HOURS_AVAILABLE":
            
            
            lblOpenClose.text = acceptedtripDetail?.data?.trip_details?.store_time_display
            
            lblOpenClose.textColor = UIColor.AppThemeRedTextColor()
            
            lblClose.isHidden = true
            
            
            
            break
            
        case "PERMANENTLY_CLOSED":
            
            lblOpenClose.text = acceptedtripDetail?.data?.trip_details?.store_time_display
            
            lblOpenClose.textColor = UIColor.AppThemeRedTextColor()
            
            lblClose.isHidden = true
            
            break
            
        case "OPEN_SELECTED_HOURS":
            
            
            lblClose.isHidden = false
            lblClose.text = acceptedtripDetail?.data?.trip_details?.available_time
            
            
            if  acceptedtripDetail?.data?.trip_details?.is_store_open == true
            
            {
                
                lblOpenClose.text = "Open".localized
                
                lblOpenClose.textColor = UIColor.AppThemeGreenTextColor()
                lblClose.textColor = UIColor.AppThemeRedTextColor()
            }
            
            else
            
            {
                lblOpenClose.text = "Closed"
                lblOpenClose.textColor = UIColor.AppThemeRedTextColor()
                lblClose.textColor = UIColor.AppThemeGreenTextColor()
            }
            
            break
        case "ALWAYS_OPEN":
            
            lblOpenClose.text = acceptedtripDetail?.data?.trip_details?.store_time_display
            lblOpenClose.textColor = UIColor.AppThemeGreenTextColor()
            lblClose.isHidden = true
            
            break
            
        default:
            break
            
        }
    }
    
    /*
     
     func setCustomerLocation() {
     
     // show CustomerLocation
     var latStr = 0.0
     var longStr = 0.0
     let lati = HeaderHeightSingleton.shared.latitude
     if lati != 0.0 {
     latStr = HeaderHeightSingleton.shared.latitude
     longStr = HeaderHeightSingleton.shared.longitude
     }
     let marker = GMSMarker()
     marker.position = CLLocationCoordinate2D(latitude: latStr , longitude: longStr )
     
     marker.icon = UIImage(named: "customer_mapLocation")
     marker.map = mapVw
     
     }
     
     
     //MARK:- Draw Path line
     
     func drawPath(from polyStr: String){
     let path = GMSPath(fromEncodedPath: polyStr)
     let polyline = GMSPolyline(path: path)
     polyline.strokeWidth = 3.0
     polyline.map = mapVw // Google MapView
     
     var latStr = 0.0
     var longStr = 0.0
     let lati = HeaderHeightSingleton.shared.latitude
     if lati != 0.0 {
     latStr = HeaderHeightSingleton.shared.latitude
     longStr = HeaderHeightSingleton.shared.longitude
     }
     let sourceValue:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latStr, longStr);
     let destinationValue:CLLocationCoordinate2D = CLLocationCoordinate2DMake(25.5518, 83.1834);
     let cameraUpdate = GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: sourceValue, coordinate: destinationValue))
     
     
     mapVw.moveCamera(cameraUpdate)
     let currentZoom = mapVw.camera.zoom
     mapVw.animate(toZoom: currentZoom - 1.4)
     }
     
     
     func getRouteSteps(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
     
     
     let session = URLSession.shared
     let Your_API_Key = "AIzaSyBIe_mJxFS1Hc_Q0tlQ_xfW_EjAq7A5L_8"
     //         let Your_API_Key = "AIzaSyDp6EyF7Fl-yv44p6N3BH6z4YcGI5ID_G8"
     let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(Your_API_Key)")!
     
     print("route:-",url )
     
     let task = session.dataTask(with: url, completionHandler: {
     (data, response, error) in
     
     guard error == nil else {
     print(error!.localizedDescription)
     return
     }
     
     guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {
     
     print("error in JSONSerialization")
     return
     
     }
     
     let  routes = jsonResult["routes"] as? [Any]
     if routes?.count ?? 0 == 0 {
     return
     }
     
     guard let route = routes?[0] as? [String: Any] else {
     return
     }
     
     guard let legs = route["legs"] as? [Any] else {
     return
     }
     
     guard let leg = legs[0] as? [String: Any] else {
     return
     }
     
     guard let steps = leg["steps"] as? [Any] else {
     return
     }
     for item in steps {
     
     guard let step = item as? [String: Any] else {
     return
     }
     
     guard let polyline = step["polyline"] as? [String: Any] else {
     return
     }
     
     guard let polyLineString = polyline["points"] as? String else {
     return
     }
     
     //Call this method to draw path on map
     DispatchQueue.main.async {
     self.drawPath(from: polyLineString)
     }
     }
     })
     task.resume()
     }
     
     
     func setMarkerInMap() {
     
     //        if (response.data!.count) > 0 {
     //            let val = response.data?.count
     //            let array = response.data
     //
     //            if toSort == true {
     //                array?.sorted { ($0.distance ?? 0) < ($1.distance ?? 0) }
     //
     //            }
     //
     //            self.nearestDistance = array![0].distance ?? 0.0
     //            self.nearestLat =   Double(array![0].lat ?? "0.0") ?? 0.0
     //            self.nearestLong =  Double(array![0].long ?? "0.0") ?? 0.0
     //
     var latStr = 0.0
     var longStr = 0.0
     let lati = HeaderHeightSingleton.shared.latitude
     if lati != 0.0 {
     latStr = HeaderHeightSingleton.shared.latitude
     longStr = HeaderHeightSingleton.shared.longitude
     }
     
     let sourceValue:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latStr, longStr);
     let destinationValue:CLLocationCoordinate2D = CLLocationCoordinate2DMake(nearestLat, nearestLong);
     self.getRouteSteps(from: sourceValue, to: destinationValue)
     //
     //
     //
     //            for i in 0 ..< val!
     //            {
     let marker = GMSMarker()
     //
     //                let lat = Double(response.data?[i].lat ?? "0.0")
     //                let long = Double(response.data?[i].long ?? "0.0")
     //
     //                let distance = Double(response.data?[i].distance ?? 0.0)
     //
     //                if distance == nearestDistance {
     //                    marker.icon = UIImage(named: "nearestBranchMapLocation")
     //                    marker.map = mapVw
     //                }else{
     //                    marker.icon = UIImage(named: "branchMapLocation.png")
     //                    marker.map = mapVw
     //                }
     
     
     let lat = 25.3176
     let long = 82.9739
     
     print("lat",lat,long)
     marker.position = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: long ?? 0.0)
     let camera = GMSCameraPosition.camera(withLatitude: lat ?? 0.0,  longitude: long ?? 0.0, zoom: 8.0)
     
     mapVw.camera = camera
     marker.title = "Sydney"
     marker.snippet = "Australia"
     mapVw.setMinZoom(10, maxZoom: 15)
     marker.map = mapVw
     //            }
     //        }
     }
     
     */
    
    
}
