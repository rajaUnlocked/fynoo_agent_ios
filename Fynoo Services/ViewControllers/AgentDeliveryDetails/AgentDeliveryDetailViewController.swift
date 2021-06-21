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
class AgentDeliveryDetailViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var mapVw: GMSMapView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblAvgRating: UILabel!
    
    @IBOutlet weak var lblTotalRating: UILabel!
    
    @IBOutlet weak var lblOpenClose: UILabel!
    
    @IBOutlet weak var lblDuration: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    var tripId = 0
    var nearestLat = 25.5518
    var nearestLong = 83.1834
    var nearestDistance = 10.0
    let locationManager = CLLocationManager()
    
    var acceptedtripDetail : deliveryTripDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Product Details"
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
        mapVw.delegate = self
        SetFont()
        self.setCustomerLocation()
        getAcceptedTripDetail()
        
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
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
        
        self.setMarkerInMap()

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
        let param = ["trip_id": tripId,
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected] as [String : Any]
        
        print("request:-", param)
        print("Url:-", Service.acceptedTripDetail)
        ServerCalls.postRequest(Service.acceptedTripDetail, withParameters: param) { [self] (response, success) in
            if success{
                
//                self.addPullUpController(animated: true)
               
                
                if let body = response as? [String: Any] {
                    self.acceptedtripDetail  = Mapper<deliveryTripDetail>().map(JSON: body)
                    print(self.acceptedtripDetail?.data)
                    lblName.text = acceptedtripDetail?.data?.trip_details?.cust_nam
                    lblAvgRating.text = acceptedtripDetail?.data?.trip_details?.rating
                    lblTotalRating.text = acceptedtripDetail?.data?.trip_details?.total_rating
                    lblAddress.text = acceptedtripDetail?.data?.trip_details?.cust_address


                }
            }
        }
    }
    
    
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
    
}
