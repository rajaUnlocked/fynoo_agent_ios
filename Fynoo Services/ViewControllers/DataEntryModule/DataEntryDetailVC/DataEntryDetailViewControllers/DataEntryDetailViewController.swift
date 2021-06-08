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
    
    var mainServiceID:String = ""
    var isOpenMoreEntryItem:Bool = false
    var clickEntryItemID:String = ""
    var serviceName:String = ""
    var serviceIcon:String = ""
    
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
        tableView.register(UINib(nibName: "OtherServicesOrderInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherServicesOrderInformationTableViewCell")
                tableView.register(UINib(nibName: "MoreDetailSpecificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreDetailSpecificationsTableViewCell")
               
        
        self.headerView.menuBtn.isHidden = true
        self.headerView.titleHeader.text = self.serviceName
        self.headerView.viewControl = self
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }
    
    @objc func openMoreSpecification(_ sender:UIButton){
            if self.isOpenMoreEntryItem == true {
                self.isOpenMoreEntryItem = false
            }else{
                self.isOpenMoreEntryItem = true
            }
            self.tableView.reloadData()

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
            for var i in (0..<(serviceDetailData?.data?.data_entry_lines?.count ?? 0)) {
               let entryStatus = ModalController.toString (serviceDetailData?.data?.data_entry_lines?[i].is_complete as Any)

                if entryStatus == "1" {
                    
                    let vc = DataEntryWorkConfirmationPopUpViewController(nibName: "DataEntryWorkConfirmationPopUpViewController", bundle: nil)
                    vc.messageTxtStr = "Do you want to submit your work?".localized
                    vc.comeFromStr = "workConfirmation"
                    vc.modalPresentationStyle = .overFullScreen
                    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                    vc.delegate =  self
                    self.present(vc, animated: true, completion: nil)
                }else{
                    ModalController.showNegativeCustomAlertWith(title: "Please complete all task before submit your work.".localized, msg: "")
                    return
                }
            }
        }else if workStatus == 3 {
            ModalController.showSuccessCustomAlertWith(title: "You have already submitted the work for this order.", msg: "")
            return
        }
        
    }
    
    @objc func productDataEntryClicked(_ sender : UIButton) {
        let vc = DataEntryTypelistingViewController()
        vc.serviceID = ModalController.toString(serviceDetailData?.data?.id as Any)
        vc.boID = ModalController.toString(serviceDetailData?.data?.bo_id as Any)
        vc.dataEntryType = "1"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func branchDataEntryClicked(_ sender : UIButton) {
        let vc = DataEntryTypelistingViewController()
        vc.serviceID = ModalController.toString(serviceDetailData?.data?.id as Any)
        vc.dataEntryType = "2"
        vc.boID = ModalController.toString(serviceDetailData?.data?.bo_id as Any)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func popUpYesClicked(_ sender: Any, fromWhere: String) {
        
        if fromWhere == "startWork"{
            self.startWorkAPI()
            
        }else if fromWhere == "workConfirmation" {
             self.workConfirmationAPI()
            
        }else if fromWhere == "agentSubmitServiceTask" {
            self.agentSubmitServiceTask(entryID: self.clickEntryItemID)
            
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

    func agentSubmitServiceTask(entryID:String) {
        
        dataEntryApiMnagagerModal.agentSubmitServiceTask(entryID: entryID) { (success, response) in
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
    
    @objc func entryItemClicked(_ sender : UIButton) {
        print("tag", sender.tag)
        
        
        let workStatus = serviceDetailData?.data?.start_work
       clickEntryItemID = ModalController.toString(serviceDetailData?.data?.data_entry_lines?[sender.tag].des_id as Any)
        
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
            vc.messageTxtStr = "Have you completed this task item?".localized
            vc.comeFromStr = "agentSubmitServiceTask"
            vc.modalPresentationStyle = .overFullScreen
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            vc.delegate =  self
            self.present(vc, animated: true, completion: nil)
            
//            self.agentSubmitServiceTask(entryID: entryID)
        }
    }
}

extension DataEntryDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 && mainServiceID != "1" {
            let views = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
            let label = UILabel(frame: CGRect(x: 20, y: 20, width: view.frame.size.width - 20, height: 20))
            views.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            label.font = UIFont(name:"\(fontNameLight)",size:16)
            label.textAlignment = .left
            label.text = "Order information"
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
                if value[0]=="ar"{
                    label.textAlignment = .right
                }else if value[0]=="en"{
                    label.textAlignment = .left
                }
            }
            
            views.addSubview(label)
            return views
        }else{
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 && mainServiceID != "1" {
            return 50
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return 120
            
        } else if indexPath.section == 1 {
            
            return 260
            
        }else if indexPath.section == 2 {
            return 50
        }else if indexPath.section == 3 {
            if mainServiceID == "1" {
                return 120
            }else{
                let entryItemCount = serviceDetailData?.data?.data_entry_lines?.count
                if indexPath.row == entryItemCount! + 1 {
                    return 50
                }else{
                    return UITableView.automaticDimension
                }
            }
        }else if indexPath.section == 4 {
            return UITableView.automaticDimension
        }else if indexPath.section == 5 {
            return UITableView.automaticDimension
        }else  {
            if isBranchLocationAvailable == true {
                return 255
            }else{
                return 110
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
            if mainServiceID == "1" {
                return 1
            }else{
                let entryItemCount  = serviceDetailData?.data?.data_entry_lines?.count
                if entryItemCount ?? 0 > 0 {
                    if isOpenMoreEntryItem == true {
                        if (entryItemCount ?? 0) > 2 {
                            return (entryItemCount ?? 0) + 1
                        }else{
                            return (entryItemCount ?? 0)
                        }
                    }else{
                        if (entryItemCount ?? 0) > 2 {
                            return 3
                        }else{
                            return (entryItemCount ?? 0)
                        }
                    }
                }else {
                    return 0
                }
            }
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
            if mainServiceID == "1" {
                return dataEntryOrderInformationFirstCell(index: indexPath)
            }else{
                let entryItemCount  = serviceDetailData?.data?.data_entry_lines?.count
                if isOpenMoreEntryItem == true {
                    if indexPath.row == entryItemCount!  {
                        return ProductMoreSpecificationsCell(index: indexPath)
                    }else{
                        return OtherServicesOrderInformationFirstCell(index: indexPath)
                    }
                }else {
                    if (entryItemCount ?? 0) > 2 {
                        if indexPath.row == 2 {
                            return ProductMoreSpecificationsCell(index: indexPath)
                        }else{
                            return OtherServicesOrderInformationFirstCell(index: indexPath)
                        }
                    }else{
                        return OtherServicesOrderInformationFirstCell(index: indexPath)
                    }
                }
            }

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
        cell.createLbl.text = self.serviceName
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
        
        let online = "Online".localized
        
        if requestData?.work_place == 1 {
            cell.agentAddressLbl.text = "\(online)"
            if requestData?.country_code != "" {
                cell.addressLbl.text = "\(online), \(requestData?.country_code ?? "")"
            }else{
                cell.addressLbl.text = "\(online)"
              
            }
            
        }else if requestData?.work_place == 2 {
            cell.agentAddressLbl.text = "\(requestData?.address ?? "")"
            if requestData?.country_code != "" {
                cell.addressLbl.text = "\(requestData?.city_name ?? ""), \(requestData?.country_code ?? "")"
            }else{
                cell.addressLbl.text = "\(requestData?.city_name ?? "")"
            }
        }
        
        let avgRating = requestData?.rating_avg
        
        if avgRating == "0" || avgRating == "0.0" || avgRating == "0.00" || avgRating == "1" || avgRating == "1.0" || avgRating == "1.00" || avgRating == "2" || avgRating == "2.0" || avgRating == "2.00" || avgRating == "3" || avgRating == "3.0" || avgRating == "3.00" || avgRating == "4" || avgRating == "4.0" || avgRating == "4.00" || avgRating == "5" || avgRating == "5.0" || avgRating == "5.00" {
            cell.ratingStrImageView.image = UIImage(named: "star-full")
        }else {
             cell.ratingStrImageView.image = UIImage(named: "ratingHalfStar")
        }
        
        
        return cell
    }
    
    func dataEntryWorkConfirmationCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEInprogressDetailTableViewCell", for: index) as! DEInprogressDetailTableViewCell
        cell.selectionStyle = .none
        
        let workStatus = serviceDetailData?.data?.start_work
        
        if workStatus == 1 {
            cell.workConfirmtionBtn.setTitle("Start Work".localized, for: .normal)
            cell.workConfirmtionBtn.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
            // green color
        }else if workStatus == 2 {
            // green
           
            cell.workConfirmtionBtn.setTitle("Submit your work".localized, for: .normal)
            cell.workConfirmtionBtn.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
        }else{
            // grey
            cell.workConfirmtionBtn.setTitle("Already Submitted".localized, for: .normal)
            cell.workConfirmtionBtn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
    
    func OtherServicesOrderInformationFirstCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherServicesOrderInformationTableViewCell", for: index) as! OtherServicesOrderInformationTableViewCell
        cell.selectionStyle = .none
        cell.quantityLbl.isHidden = false
        
        let entryItemData = serviceDetailData?.data?.data_entry_lines![index.row]
        
        cell.entryName.underlineButton(text: "\(entryItemData?.des_name ?? "")")
        cell.quantityLbl.text = ModalController.toString(entryItemData?.des_type_count as Any)
        
        if entryItemData?.is_complete == 1 {
            cell.tickImgView.isHidden = false
        }else{
            cell.tickImgView.isHidden = true
        }
        cell.entryName.addTarget(self, action: #selector(entryItemClicked(_:)), for: .touchUpInside)
        
        
        cell.entryName.tag = index.row
        return cell
    }
      
      func ProductMoreSpecificationsCell(index : IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "MoreDetailSpecificationsTableViewCell", for: index) as! MoreDetailSpecificationsTableViewCell
          cell.selectionStyle = .none
          cell.moreDetailBtn.addTarget(self, action: #selector(openMoreSpecification), for: .touchUpInside)
          if isOpenMoreEntryItem == true {
              cell.moreDetailLbl.text = "Hide Details".localized
              cell.downIconImageView.image = UIImage(named: "upArror_blue")
          }else {
              cell.moreDetailLbl.text = "More Details".localized
              cell.downIconImageView.image = UIImage(named: "DownArror_blue")
          }
          
          cell.tag = index.row
          return cell
      }
    
    func dataEntryOrderInformationSecondCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEInprogressOrderInformationSecondTableViewCell", for: index) as! DEInprogressOrderInformationSecondTableViewCell
        cell.selectionStyle = .none
        cell.orderInstructionValueLbl.text = serviceDetailData?.data?.rem_days_text
        
        if mainServiceID == "1" {
            cell.upperLbl.isHidden = true
        }else{
            cell.upperLbl.isHidden = false
        }
        
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
extension UIButton {
    func underlineButton(text: String) {
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, text.count))
        self.setAttributedTitle(titleString, for: .normal)
    }
}
