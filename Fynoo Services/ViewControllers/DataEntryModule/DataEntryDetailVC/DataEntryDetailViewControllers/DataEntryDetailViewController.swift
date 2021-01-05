//
//  DataEntryDetailViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 19/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import GoogleMaps
import MessageUI
import CoreLocation

protocol DataEntryDetailViewControllerDelegate: class {
    func refreshDataEntryServiceList()
}

class DataEntryDetailViewController: UIViewController, MFMessageComposeViewControllerDelegate, DataEntryWorkConfirmationPopUpViewControllerDelegate, AddedServicesInDataEntryViewControllerDelegate, CLLocationManagerDelegate {
    
    weak var delegate: DataEntryDetailViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerViewHeightConstant: NSLayoutConstraint!
    var isBranchLocationAvailable:Bool = false
    var BranchLat = 0.0
    var BranchLong = 0.0
    var serviceID:String = ""
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0

    
    var dataEntryApiMnagagerModal = DataEntryApiManager()
       var serviceDetailData  : serviceDetailData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getServiceDetailAPI()
        self.getUserLocation()
        self.setUpUI()
        
    }
    
    func setUpUI() {
        
        self.headerViewHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 220
        self.tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "DataEntryFormFirstTopTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryFormFirstTopTableViewCell")
        tableView.register(UINib(nibName: "CompleteDataEntryListTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteDataEntryListTableViewCell")
        tableView.register(UINib(nibName: "DEInprogressDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DEInprogressDetailTableViewCell")
        tableView.register(UINib(nibName: "DEInprogressOrderInformationFirstTableViewCell", bundle: nil), forCellReuseIdentifier: "DEInprogressOrderInformationFirstTableViewCell")
        tableView.register(UINib(nibName: "DEInprogressOrderInformationSecondTableViewCell", bundle: nil), forCellReuseIdentifier: "DEInprogressOrderInformationSecondTableViewCell")
        tableView.register(UINib(nibName: "DataEntryFromOrderInstractionTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryFromOrderInstractionTableViewCell")
        tableView.register(UINib(nibName: "DEInprogressDetailWorkPlaceTableViewCell", bundle: nil), forCellReuseIdentifier: "DEInprogressDetailWorkPlaceTableViewCell")
        tableView.register(UINib(nibName: "DEInprogressShowInstructionTableViewCell", bundle: nil), forCellReuseIdentifier: "DEInprogressShowInstructionTableViewCell")
        
        self.headerView.menuBtn.isHidden = true
        self.headerView.titleHeader.text = "Data Entry Service".localized;
        self.headerView.viewControl = self
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }
    
    func getServiceDetailAPI() {
        ModalClass.startLoading(self.view)
        dataEntryApiMnagagerModal.dataEntryDetail(serviceID: serviceID) { (success, response) in
            ModalClass.stopLoading()
            if success{
                self.serviceDetailData = response
                
                if  self.serviceDetailData?.data?.work_place == 2 {
                    
                    self.BranchLat = ModalController.convertInToDouble(str: self.serviceDetailData?.data?.branch_lat as AnyObject)
                    self.BranchLong = ModalController.convertInToDouble(str: self.serviceDetailData?.data?.branch_long as AnyObject)
                    
                    if self.BranchLat != 0.0 {
                        
                        self.getAddressFromLatLon(pdblLatitude: ModalController.convertInString(str: self.BranchLat as AnyObject), withLongitude: ModalController.convertInString(str: self.BranchLong as AnyObject))
                        
                        self.isBranchLocationAvailable = true
                    }else{
                        self.isBranchLocationAvailable = false
                    }
                }else{
                    self.isBranchLocationAvailable = false
                }
                self.tableView.reloadData()
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "\(self.serviceDetailData?.error_description ?? "")")
            }
        }
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
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
                    print(pm.isoCountryCode)
                    print(pm.locality)
                    
                }
        })
        
    }
    
    @objc func DataEntryWorkConfirmationClicked(_ sender : UIButton) {
        
        let workStatus = serviceDetailData?.data?.start_work
        
        if workStatus == 1 {
            
            let vc = DataEntryWorkConfirmationPopUpViewController(nibName: "DataEntryWorkConfirmationPopUpViewController", bundle: nil)
            vc.messageTxtStr = "Are you sure you want to start the work?".localized
            vc.comeFromStr = "startWork"
            vc.modalPresentationStyle = .overFullScreen
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            vc.delegate =  self
            self.present(vc, animated: true, completion: nil)
            
        }else if workStatus == 2 {
            
            let vc = DataEntryWorkConfirmationPopUpViewController(nibName: "DataEntryWorkConfirmationPopUpViewController", bundle: nil)
            vc.messageTxtStr = "Do you want to submit your work?".localized
            vc.comeFromStr = "workConfirmation"
            vc.modalPresentationStyle = .overFullScreen
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            vc.delegate =  self
            self.present(vc, animated: true, completion: nil)
            
        }else if workStatus == 3 {
            ModalController.showSuccessCustomAlertWith(title: "You have already submitted the work for this order.", msg: "")
            return
        }
        
    }
    
    @objc func productDataEntryClicked(_ sender : UIButton) {
        let vc = DataEntryTypelistingViewController()
        vc.serviceID = ModalController.toString(serviceDetailData?.data?.id as Any)
        vc.dataEntryType = "1"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func branchDataEntryClicked(_ sender : UIButton) {
        let vc = DataEntryTypelistingViewController()
        vc.serviceID = ModalController.toString(serviceDetailData?.data?.id as Any)
        vc.dataEntryType = "2"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func popUpYesClicked(_ sender: Any, fromWhere: String) {
        
        if fromWhere == "startWork"{
            self.startWorkAPI()
            
        }else if fromWhere == "workConfirmation" {
             self.workConfirmationAPI()
            
        }
    }
       
    func popUpNoClicked(_ sender: Any) {
        
    }
    
    func startWorkAPI() {
        
        dataEntryApiMnagagerModal.BOStartWork(serviceID: ModalController.toString(serviceDetailData?.data?.id as Any) ) { (success, response) in
            ModalClass.stopLoading()
            if success{
                if let value = (response?.object(forKey: "error_description") as? String) {
                    ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                }
                self.getServiceDetailAPI()
            }else{
                if let value = response?.object(forKey: "error_description") as? String {
                    ModalController.showNegativeCustomAlertWith(title: "", msg: value)
                }
            }
        }
    }
    
    func workConfirmationAPI() {
        
        dataEntryApiMnagagerModal.BOWorkConfirmation(serviceID: ModalController.toString(serviceDetailData?.data?.id as Any) ) { (success, response) in
            ModalClass.stopLoading()
            if success{
                if let value = (response?.object(forKey: "error_description") as? String) {
                    ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                }
                   self.getServiceDetailAPI()

            }else{
                if let value = response?.object(forKey: "error_description") as? String {
                    ModalController.showNegativeCustomAlertWith(title: "", msg: value)
                }
            }
        }
    }
    
    func popUpOkayClicked(_ sender: Any) {
        
        self.delegate?.refreshDataEntryServiceList()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func agentCallClicked(_ sender : UIButton) {
        guard let number = URL(string: "tel://" + (serviceDetailData?.data?.bo_number)!) else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func agentMessageClicked(_ sender : UIButton) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = ["\(serviceDetailData?.data?.bo_number ?? "")"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func getUserLocation() {
          self.locationManager.requestWhenInUseAuthorization()
          if CLLocationManager.locationServicesEnabled() {
              locationManager.delegate = self
              locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
              locationManager.startUpdatingLocation()
          }
      }
      
    // MARK: - Location Delegates
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         
         guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
         print("locations = \(locValue.latitude) \(locValue.longitude)")
         latitude = locValue.latitude
         longitude = locValue.longitude
         
         if HeaderHeightSingleton.shared.longitude == 0.0 {
             HeaderHeightSingleton.shared.longitude = longitude
             HeaderHeightSingleton.shared.latitude = latitude
            
         }
         locationManager.stopUpdatingLocation()
     }
     
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         ModalController.showNegativeCustomAlertWith(title: "Please turn on your location services", msg: "")
         
         HeaderHeightSingleton.shared.longitude = 0.0
         HeaderHeightSingleton.shared.latitude = 0.0

    }
    
    
    @objc func boBranchNavigationClicked(_ sender : UIButton) {
        
        self.BranchLat = ModalController.convertInToDouble(str: self.serviceDetailData?.data?.branch_lat as AnyObject)
        self.BranchLong = ModalController.convertInToDouble(str: self.serviceDetailData?.data?.branch_long as AnyObject)
        
        if HeaderHeightSingleton.shared.longitude == 0.0 {
            ModalController.showNegativeCustomAlertWith(title: "Please turn on your location services for navigation", msg: "")
        }else{
            print("GoogleNavigation")
            var latStr = 0.0
            var longStr = 0.0
            let lati = HeaderHeightSingleton.shared.latitude
            if lati != 0.0 {
                latStr = HeaderHeightSingleton.shared.latitude
                longStr = HeaderHeightSingleton.shared.longitude
            }
            
            if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=\(latStr),\(longStr)&daddr=\(self.BranchLat),\(self.BranchLong)&directionsmode=driving&zoom=14&views=traffic")!)
                
            }else{
                //            self.openTrackerInBrowser()
                UIApplication.shared.openURL(URL(string:
                    "https://www.google.co.in/maps/dir/?saddr=\(latStr),\(longStr)&daddr=\(self.BranchLat),\(self.BranchLong)&directionsmode=driving&zoom=14&views=traffic")!)
                
            }
            
        }
        
    }
    
     //MARK: - Message compose method
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            //... handle sms screen actions
            self.dismiss(animated: true, completion: nil)
        }
}

extension DataEntryDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 120
            
        } else if indexPath.section == 1 {
            
            return 260
            
        }else if indexPath.section == 2 {
            return 50
        }else if indexPath.section == 3 {
            return 120
        }else if indexPath.section == 4 {
            return UITableView.automaticDimension
        }else if indexPath.section == 5 {
            return UITableView.automaticDimension
//            return 300
        }else  {
            if isBranchLocationAvailable == true {
                return 255
            }else{
                return 100
            }
        }
    }
}
//should choose someone who choose as you.
extension DataEntryDetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        }else if section == 3 {
            return 1
        }else if section == 4 {
            return 1
        }else if section == 5 {
            return 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            return dataEntryFirstTopCell(index: indexPath)
            
        }else if indexPath.section == 1 {
            return dataEntryBasicDetailCell(index: indexPath)
            
        }else if indexPath.section == 2 {
            return dataEntryWorkConfirmationCell(index: indexPath)
            
        }else if indexPath.section == 3 {
            return dataEntryOrderInformationFirstCell(index: indexPath)
            
        }else if indexPath.section == 4 {
            return dataEntryOrderInformationSecondCell(index: indexPath)
            
        }else if indexPath.section == 5 {
            return dataEntryOrderInstructionCell(index: indexPath)
            
        } else{
            return dataEntryWorkPlaceCell(index: indexPath)
        }
    }
    
    func dataEntryFirstTopCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryFormFirstTopTableViewCell", for: index) as! DataEntryFormFirstTopTableViewCell
        cell.selectionStyle = .none
        cell.createLbl.text = "Data Entry Order"
        cell.bttomLbl.isHidden = true
        
        
        return cell
    }
    
    func dataEntryBasicDetailCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteDataEntryListTableViewCell", for: index) as! CompleteDataEntryListTableViewCell
        cell.selectionStyle = .none
        cell.lowerLbl.isHidden = true
        cell.giveRatingBtn.isHidden = true
        cell.boLocationBtn.isHidden = true
        cell.locationBtnWidthConstant.constant = 0
        cell.callBtn.addTarget(self, action: #selector(agentCallClicked(_:)), for: .touchUpInside)
        
        cell.textMessageBtn.addTarget(self, action: #selector(agentMessageClicked(_:)), for: .touchUpInside)
        cell.boLocationBtn.addTarget(self, action: #selector(boBranchNavigationClicked), for: .touchUpInside)
        
        self.BranchLat = ModalController.convertInToDouble(str: self.serviceDetailData?.data?.branch_lat as AnyObject)
        self.BranchLong = ModalController.convertInToDouble(str: self.serviceDetailData?.data?.branch_long as AnyObject)
        
        if self.BranchLat != 0.0 {
            cell.boLocationBtn.isHidden = false
            cell.locationBtnWidthConstant.constant = 50
            
        }else{
            cell.boLocationBtn.isHidden = true
            cell.locationBtnWidthConstant.constant = 0
        }
        
        let requestData = serviceDetailData?.data
        
        cell.headerLbl.text = requestData?.instruction
        let orderIdTxt = "Order Id:"
        cell.orderIdLbl.text = "\(orderIdTxt) \(requestData?.order_id ?? "")"
        
        cell.dateLbl.text = ModalController.convert13DigitTimeStampIntoDate(timeStamp: "\(requestData?.order_date ?? 0)", format: "E, MMM dd, yyyy h:mm")
        cell.paidTextLbl.text = "Holding"
        cell.priceValueLbl.text = "\(Constant.currency) \(requestData?.service_price ?? 0.00)"
        cell.agentProfileImgView.sd_setImage(with: URL(string:(requestData?.bo_name ?? "")), placeholderImage: UIImage(named: "agent_indivdual.png"))
        cell.agentNameLbl.text = requestData?.bo_name
        cell.ratingLbl.text = requestData?.rating_avg
        cell.totalRatingLbl.text = "(\(requestData?.rating_count ?? 0))"
        cell.agentAddressLbl.text = "\(requestData?.address ?? "")"
        //        cell.completeImageView.image = UIImage(named: "inprogress_dataEntry-selected")
        //        cell.completeTxtLbl.text = "Inprocess"
        
        if requestData?.work_place == 1 {
            if requestData?.country_code != "" {
                cell.addressLbl.text = "Online, \(requestData?.country_code ?? "")"
            }else{
                cell.addressLbl.text = "Online"
            }
            
        }else if requestData?.work_place == 2 {
            if requestData?.country_code != "" {
                cell.addressLbl.text = "\(requestData?.city_name ?? ""), \(requestData?.country_code ?? "")"
            }else{
                cell.addressLbl.text = "\(requestData?.city_name ?? "")"
            }
        }
        
        
        return cell
    }
    
    func dataEntryWorkConfirmationCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEInprogressDetailTableViewCell", for: index) as! DEInprogressDetailTableViewCell
        cell.selectionStyle = .none
        
        let workStatus = serviceDetailData?.data?.start_work
        
        if workStatus == 1 {
            cell.workConfirmtionBtn.setTitle("Start Work", for: .normal)
        }else if workStatus == 2 {
            cell.workConfirmtionBtn.setTitle("Work Confirmation", for: .normal)
        }
        
        
        cell.workConfirmtionBtn.addTarget(self, action: #selector(DataEntryWorkConfirmationClicked(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func dataEntryOrderInformationFirstCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEInprogressOrderInformationFirstTableViewCell", for: index) as! DEInprogressOrderInformationFirstTableViewCell
        cell.selectionStyle = .none
        cell.productDataEntryView.isHidden = true
        cell.branchDataEntryView.isHidden = true
         cell.productDataEntryHeightConstant.constant = 0
         cell.branchDataEntryHeightConstant.constant = 0
        
        if serviceDetailData?.data?.des_product_count ?? 0 > 0 {
            cell.productDataEntryHeightConstant.constant = 25
            cell.productDataEntryView.isHidden = false
            cell.productDataEntryCountLbl.text = "\(serviceDetailData?.data?.des_product_count ?? 0)"
            if serviceDetailData?.data?.des_product_complete == 1 {
                cell.productDataEntryTickImgeView.isHidden = false
            }else{
               cell.productDataEntryTickImgeView.isHidden = true
            }
        }else{
            cell.productDataEntryHeightConstant.constant = 0
        }
        
        if serviceDetailData?.data?.des_branch_count ?? 0 > 0 {
            cell.branchDataEntryHeightConstant.constant = 25
            cell.branchDataEntryView.isHidden = false
            cell.branchDataEntryCount.text = "\(serviceDetailData?.data?.des_branch_count ?? 0)"
            if serviceDetailData?.data?.des_branch_complete == 1 {
                cell.branchDataEntryTickImageView.isHidden = false
            }else{
               cell.branchDataEntryTickImageView.isHidden = true
            }
        }else{
            cell.branchDataEntryHeightConstant.constant = 0
        }

       cell.productDataEntryBtn.addTarget(self, action: #selector(productDataEntryClicked), for: .touchUpInside)
        cell.branchDataEntryBtn.addTarget(self, action: #selector(branchDataEntryClicked(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func dataEntryOrderInformationSecondCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEInprogressOrderInformationSecondTableViewCell", for: index) as! DEInprogressOrderInformationSecondTableViewCell
        cell.selectionStyle = .none
        cell.orderInstructionValueLbl.text = serviceDetailData?.data?.rem_days_text
        
        
        return cell
    }
    
    func dataEntryOrderInstructionCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEInprogressShowInstructionTableViewCell", for: index) as! DEInprogressShowInstructionTableViewCell
        cell.selectionStyle = .none

        
        cell.instructionValueLbl.text = serviceDetailData?.data?.instruction
          
        return cell
    }
    
    func dataEntryWorkPlaceCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEInprogressDetailWorkPlaceTableViewCell", for: index) as! DEInprogressDetailWorkPlaceTableViewCell
        cell.selectionStyle = .none
        cell.mapViewHeightConstant.constant = 0
        
        let workPlace = serviceDetailData?.data?.work_place
        
        if workPlace == 1 {
            cell.workPlaceTypeLbl.text = "Online"
        }else if workPlace == 2 {
            if serviceDetailData?.data?.country_code != "" {
                cell.workPlaceTypeLbl.text = "\(serviceDetailData?.data?.city_name ?? ""), \(serviceDetailData?.data?.country_code ?? "")"
            }else{
                cell.workPlaceTypeLbl.text = "\(serviceDetailData?.data?.city_name ?? "")"
            }
            //            cell.workPlaceTypeLbl.text = "\(serviceDetailData?.data?.city_name ?? ""), \(serviceDetailData?.data?.country_code ?? "")"
        }
        
        
                if isBranchLocationAvailable == true {
                    cell.mapViewHeightConstant.constant = 140
                    var latStr = 0.0
                    var longStr = 0.0
                    let lati = self.BranchLat
                    if lati != 0.0 {
                        latStr =  self.BranchLat
                        longStr = self.BranchLong
                    }
                    let marker = GMSMarker()
        
                    marker.position = CLLocationCoordinate2D(latitude: latStr , longitude: longStr )
                    let camera = GMSCameraPosition.camera(withLatitude: latStr ,  longitude: longStr , zoom: 8.0)
        
                    cell.mapView.camera = camera
                    marker.title = "Sydney"
                    marker.snippet = "Australia"
                    cell.mapView.setMinZoom(10, maxZoom: 15)
                    marker.map = cell.mapView
        
        
                }else{
                    cell.mapViewHeightConstant.constant = 0
                }
        
        
        cell.tag = index.row
        return cell
    }
    
    
}
