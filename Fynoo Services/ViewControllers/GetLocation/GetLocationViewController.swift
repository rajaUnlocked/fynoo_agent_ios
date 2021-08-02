//
//  GetLocationViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 17/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces
protocol GetLocationViewControllerDelegate {
    func getlocations(City:String,Country:String,ZipCode:String,latitude:Double,longitude:Double,location:String)
}
class GetLocationViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    var delegate:GetLocationViewControllerDelegate?
    
    
    @IBOutlet weak var headerVw: NavigationView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var doneOutlet: UIButton!
    @IBOutlet weak var mapVw: GMSMapView!
    @IBOutlet weak var shadowVw: UIView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressField: UITextField!
    var City = ""
    var Country = ""
    var ZipCode = ""
    var latitude = 0.0
    var longitude = 0.0
    let marker = GMSMarker()
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        doneOutlet.titleLabel?.font =  UIFont(name:"\(fontNameLight)",size:16)
        addressField.placeholder = "Search".localized
        addressField.font =  UIFont(name:"\(fontNameLight)",size:14)
        self.headerVw.titleHeader.text = "LocationB".localized;
        self.headerVw.menuBtn.isHidden = false
             self.headerVw.viewControl = self
//      self.headerView.layer.insertSublayer(ModalController.setGradientColorBGBlack(), at: 0)
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        setupUiMethod()
    }
    
    func setupUiMethod(){
        mapVw.delegate = self


        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.navigationController?.isNavigationBarHidden = true
        
          
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func doneBtn(_ sender: Any) {
        self.getCityFromLatLon(pdblLatitude: "\(latitude)", withLongitude: "\(longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        latitude = locValue.latitude
        longitude = locValue.longitude
        getAddressFromLatLon(pdblLatitude: "\(latitude)", withLongitude: "\(longitude)")

        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 17.0)
        self.mapVw.camera = camera
        
        // Creates a marker in the center of the map.
        
        marker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
        marker.map = mapVw
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        ModalController.showNegativeCustomAlertWith(title: "Please turn on your location services", msg: "")
    }
    @IBAction func crossBtn(_ sender: Any) {
        addressField.text = ""
        latitude = 0.0
        longitude = 0.0
        self.addressView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
       
    }
    @IBAction func addressFieldAction(_ sender: Any) {
        addressField.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        latitude = coordinate.latitude
        longitude = coordinate.longitude
        getAddressFromLatLon(pdblLatitude: "\(latitude)", withLongitude: "\(longitude)")
    //    marker.map = nil
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 17.0)
        self.mapVw.camera = camera
   //     marker.map = nil
   //     marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
   //     marker.map = mapVw
       let destinationLocation = CLLocation(latitude:latitude,  longitude: longitude)
       let destinationCoordinate = destinationLocation.coordinate
       marker.position = destinationCoordinate
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        let lon: Double = Double("\(pdblLongitude)")!
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]

                    var addressString : String = ""
                    if pm.name != nil {
                        addressString = addressString + pm.name! + ", "
                    }
                    if pm.subAdministrativeArea != nil {
                        addressString = addressString + pm.subAdministrativeArea! + ", "
                    }
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        self.City = pm.locality!
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                          self.Country = pm.country!
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                          self.ZipCode = pm.postalCode!
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    self.addressField.text = addressString
                    self.addressView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                    if self.addressField.text!.count > 0
                           {
                    self.addressView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor

                       }
                    print(addressString)
                }
        })
        
    }
    
    func getCityFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        let lon: Double = Double("\(pdblLongitude)")!
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]

                    if pm.locality != nil {
                        self.City = pm.locality!
                    }
                    if pm.country != nil {
                          self.Country = pm.country!
                    }
                    if pm.postalCode != nil {
                          self.ZipCode = pm.postalCode!
                    }
                }
                self.delegate?.getlocations(City: self.City, Country: self.Country, ZipCode: self.ZipCode, latitude: self.latitude, longitude: self.longitude, location: self.addressField.text!)
                self.navigationController?.popViewController(animated: true)
               
              
    
        })
        
    }
}

extension GetLocationViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Get the place name from 'GMSAutocompleteViewController'
        // Then display the name in textField
        addressField.text = "\(place.name!), \(place.formattedAddress!)"
        print("\(place.name!), \(place.formattedAddress!)")
        latitude = place.coordinate.latitude
        longitude = place.coordinate.longitude
        self.addressView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                           if self.addressField.text!.count > 0
                                  {
                           self.addressView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor

                              }
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 17.0)
        self.mapVw.camera = camera
   //     marker.map = nil
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.map = mapVw
        // Dismiss the GMSAutocompleteViewController when something is selected
        dismiss(animated: true, completion: nil)
      
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
}
}
