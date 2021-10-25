//
//  DataEntryListingViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 01/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import MTPopup
import MessageUI
import CoreLocation
import GoogleMaps

class DataEntryListingViewController: UIViewController,DataEntryListHeaderViewDelegate, DECancellationReasonViewControllerDelegate, DataEntryDetailViewControllerDelegate, DataEntryAgentRatingViewControllerDelegate, CompleteDataEntryListTableViewCellrDelegate, DataEntryFormViewControllerDelegate, MFMessageComposeViewControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var noDataLbl: UILabel!
    var apiManagerModal = DataEntryApiManager()
    var boServicesList  : DataEntryOrderRequestDatas?
    var totalRequestListArray:[OrderService_list]?
    
    var isMoreDataAvailable: Bool = false
    var currentPageNumber: Int = 0
    var searchBoxEntryText:String = ""
    var selectedTab:String = "1"
    var Index:Int = 0
    var clickIndex:Int = 99999
    var rejectReasonID:String = ""
    
    var headerView1 : DataEntryListHeaderView? = nil
    var selectedFilters =  [ChooseFilters]()
    var serviceID:String = ""
    var appliedFilterCount:Int = 0
    var createHeaderAgain:Bool = false
    
    var serviceName:String = ""
     var serviceIcon:String = ""
    var serviceStatus:String = ""
    
    var BranchLat = 0.0
    var BranchLong = 0.0
    let locationManager = CLLocationManager()
    var latitude = 0.0
    var longitude = 0.0
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        self.getUserLocation()
        self.setUpUI()
        self.SetFont()
        ModalClass.startLoading(self.view)
        isMoreDataAvailable = false
        currentPageNumber = 0
       
        self.getBoServicesRequestListAPI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationRefreshList(_:)), name: NSNotification.Name(rawValue: "refreshDataEntryList"), object: nil)
        
    }
    func SetFont() {
        
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        self.noDataLbl.font = UIFont(name:"\(fontNameBold)",size:20)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.noDataView.isHidden = true
        //        currentPageNumber = 1
    }
    func refreshServiceListing() {
        
        isMoreDataAvailable = false
        currentPageNumber = 0
        self.selectedTab = "2"
        self.Index = 1
        self.createHeaderAgain = true
        self.getBoServicesRequestListAPI()
        
    }



    @objc func methodOfReceivedNotificationRefreshList(_ notification: NSNotification) {
//          self.createHeaderAgain = true
        ModalClass.startLoading(self.view)
        isMoreDataAvailable = false
        currentPageNumber = 0
        self.getBoServicesRequestListAPI()


    }
    func setUpUI(){
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 105
        
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "DataEntryListingTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryListingTableViewCell")
        tableView.register(UINib(nibName: "DataEntryListingTopTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryListingTopTableViewCell")
        tableView.register(UINib(nibName: "CompleteDataEntryListTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteDataEntryListTableViewCell")
        
        self.headerView.menuBtn.isHidden = false
        self.headerView.titleHeader.text = "\(serviceName)".localized;
        self.headerView.viewControl = self
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }
    
    @objc func filterClicked() {
        print("filterClicked")
        appliedFilterCount = 0
        let vc = DataEntryFilterViewController(nibName: "DataEntryFilterViewController", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
        vc.delegate = self
        vc.fromWhere = self.selectedTab
        vc.choseFilters = self.selectedFilters
        vc.dataEntryFilter = self.boServicesList?.data?.filter_list
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func searchClicked() {
        
        self.view.endEditing(true)
        self.currentPageNumber = 0
        self.isMoreDataAvailable = false
        
        if searchBoxEntryText != "" {
            self.getBoServicesRequestListAPI()
        }
        
    }
    func selecteIndex(_ sender: Any, selectedIndexID: String) {
        self.selectedTab = selectedIndexID
        self.Index = Int(self.selectedTab)! - Int(1)
        isMoreDataAvailable = false
        currentPageNumber = 0
        self.getBoServicesRequestListAPI()
        
    }
    func refreshDataEntryServiceList() {
          self.createHeaderAgain = true
        isMoreDataAvailable = false
        currentPageNumber = 0
        self.selectedTab = "3"
        self.Index = 2
        self.getBoServicesRequestListAPI()
        
    }
    func refreshDataEntryCompleteServiceList() {
        isMoreDataAvailable = false
        currentPageNumber = 0
        self.getBoServicesRequestListAPI()
    }

    func getBoServicesRequestListAPI() {
        
        apiManagerModal.agentServicesOrderListing(serviceID:self.serviceID, tabStatus: self.selectedTab, searchStr: self.searchBoxEntryText, pageNumber: currentPageNumber, filter: selectedFilters ) { [self] (success, response) in
            ModalClass.stopLoading()
            if success{
                if self.currentPageNumber == 0 {
                    self.totalRequestListArray?.removeAll()
                }
                self.boServicesList = response
                
                if self.boServicesList?.data?.service_list?.count ?? 0 > 0 {
                    self.noDataView.isHidden = true
                    
                    guard let arr = self.boServicesList?.data?.service_list as NSArray? else {
                        
                        self.isMoreDataAvailable = false
                        self.tableView.reloadData()
                        return
                        
                    }
                    if let cont = self.totalRequestListArray {
                        self.totalRequestListArray = cont + (self.boServicesList?.data?.service_list)!
                        
                    }else{
                        
                        self.totalRequestListArray = self.boServicesList?.data?.service_list!
                        
                    }
                    if arr.count < 10 {
                        self.isMoreDataAvailable = false
                    }else{
                        self.isMoreDataAvailable = true
                    }
                    if self.selectedTab == "1" && self.serviceStatus == "0" {
                     self.noDataLbl.text = "You cannot receive any new request for this service as it is disabled. Please contact Fynoo Admin for more information.".localized
                    } else if  self.selectedTab == "1" && self.boServicesList?.data?.is_active == false {
                        
                        let active = "please active".localized
                        let service = "services to receive new order request.".localized
                        self.noDataLbl.text = "\(active) \(self.serviceName) \(service)"
                    }
                    else{
                      self.noDataLbl.text = "Sorry! No Order Found".localized
                    }

                }else{
                    if self.currentPageNumber == 0 {
                        self.totalRequestListArray?.removeAll()
                    }
                    self.isMoreDataAvailable = false
                    self.noDataView.isHidden = false
                }
                let avgLbl = self.headerView1!.viewWithTag(1001) as! UILabel
                //            let ratingView = sectionHeaderView.viewWithTag(1002) as! UIView
                let totalRatingLbl = self.headerView1!.viewWithTag(1003) as! UILabel
                avgLbl.text = self.boServicesList?.data?.rating_avg
                totalRatingLbl.text = "(\(ModalController.toString(self.boServicesList?.data?.rating_count as Any)))"
                self.headerView1!.ratingValueView.rating = ModalController.convertInToDouble(str: self.boServicesList?.data?.rating_avg as AnyObject)

                self.tableView.reloadData()
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "\(self.boServicesList?.error_description! ?? "")")
                self.noDataView.isHidden = false
                self.currentPageNumber = 0
                self.isMoreDataAvailable = false
                self.tableView.reloadData()
            }
        }
    }
    func selectedCancelReason(reasonID: String) {
        print("reasonID", reasonID)
        self.rejectReasonID = reasonID
        self.cancelDataEntryServiceAPI()
        
    }
    
    func cancelDataEntryServiceAPI() {
        let serviceData = totalRequestListArray?[self.clickIndex]
        //           let dataEntryServiceID = ModalController.toString(serviceData?.id as Any)
        
        apiManagerModal.cancelDataEntryFromList(serviceID: ModalController.toString(serviceData?.id as Any), reasonID: self.rejectReasonID) { (success, response) in
            if success{
                if let value = (response?.object(forKey: "error_description") as? String) {
                    ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                }
                self.getBoServicesRequestListAPI()
                self.tableView.reloadData()
            }else{
                if let value = response?.object(forKey: "error_description") as? String {
                    ModalController.showNegativeCustomAlertWith(title: "", msg: value)
                }
            }
        }
    }
    
    func ratingClicked(_ sender: Any) {
        
        print("sender.tag", (sender as AnyObject).tag!)
        let vc = DataEntryAgentRatingViewController(nibName: "DataEntryAgentRatingViewController", bundle: nil)
        vc.delegate =  self
        vc.serviceID = ModalController.toString(self.totalRequestListArray?[(sender as AnyObject).tag].id as Any)
        vc.agentID = ModalController.toString(self.totalRequestListArray?[(sender as AnyObject).tag].bo_id as Any)
        vc.agentName = ModalController.toString(self.totalRequestListArray?[(sender as AnyObject).tag].bo_name as Any)
        vc.agentProfilePic = ModalController.toString(self.totalRequestListArray?[(sender as AnyObject).tag].bo_name as Any)
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        self.present(vc, animated: true, completion: nil)
        
    }
    func callClicked(_ sender: Any) {
        print("sender.tag", (sender as AnyObject).tag!)
        guard let number = URL(string: "tel://" + ((self.totalRequestListArray?[(sender as AnyObject).tag].bo_number)!))
                               else { return }
        UIApplication.shared.open(number)
    }
    
    func messageClicked(_ sender: Any) {
        print("sender.tag", (sender as AnyObject).tag!)
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = ["\((self.totalRequestListArray?[(sender as AnyObject).tag].bo_number)!)"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    //MARK: - Message compose method
   func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
           //... handle sms screen actions
           self.dismiss(animated: true, completion: nil)
       }
    
    func navigationClicked(_ sender: Any){
        
        self.BranchLat = ModalController.convertInToDouble(str: self.totalRequestListArray?[(sender as AnyObject).tag].lat as AnyObject)
        self.BranchLong = ModalController.convertInToDouble(str: self.totalRequestListArray?[(sender as AnyObject).tag].long as AnyObject)
        
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
}

extension DataEntryListingViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            if headerView1 == nil || appliedFilterCount > 0 || self.createHeaderAgain == true {
                
                headerView1 = DataEntryListHeaderView()
                
                let searchTxtFld = headerView1!.viewWithTag(103) as! UITextField
                let searchBtn = headerView1!.viewWithTag(104) as! UIButton
                let filterBtn = headerView1!.viewWithTag(105) as! UIButton
                let filterCount = headerView1!.viewWithTag(1010) as! UILabel
                let avgLbl = headerView1!.viewWithTag(1001) as! UILabel
                let totalRatingLbl = headerView1!.viewWithTag(1003) as! UILabel
                let dataEntryLbl = headerView1!.viewWithTag(106) as! UILabel
                let serviceIcon = headerView1!.viewWithTag(1011) as! UIImageView
                
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
                dataEntryLbl.font = UIFont(name:"\(fontNameLight)",size:16)
                searchTxtFld.font = UIFont(name:"\(fontNameLight)",size:12)
                
                filterCount.isHidden = true
                
                dataEntryLbl.text = self.serviceName
                serviceIcon.setImageSDWebImage(imgURL: "\(self.serviceIcon)", placeholder: "")
                
                avgLbl.text = self.boServicesList?.data?.rating_avg
                totalRatingLbl.text = "(\(ModalController.toString(self.boServicesList?.data?.rating_count as Any)))"
                headerView1!.ratingValueView.rating = ModalController.convertInToDouble(str: self.boServicesList?.data?.rating_avg as AnyObject)
                
                
                searchBtn.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
                searchTxtFld.addTarget(self, action: #selector(DataEntryListingViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                
                filterBtn.addTarget(self, action: #selector(filterClicked), for: .touchUpInside)
                
                if appliedFilterCount > 0 {
                    filterCount.isHidden = false
                    filterCount.text = ModalController.toString(appliedFilterCount as Any)
                    
                }else{
                    filterCount.isHidden = true
                    filterCount.text = ""
                }
                
                if self.createHeaderAgain == true {
                    self.createHeaderAgain = false
                }
                
                headerView1!.delegate = self
            }

            headerView1!.selectedIndex = Index
         
            return headerView1
        }else{
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 162
        }else {
            return 0
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if let textStr = textField.text {
            self.searchBoxEntryText = textStr
            //            if self.searchBoxEntryText.count == 0{
            //                self.currentPageNumber = 1
            //                self.isMoreDataAvailable = false
            //                self.getBoServicesRequestListAPI()
            //            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 45
        }else{
            if selectedTab == "4" {
                return 130
            } else if selectedTab == "3"{
                return 230
            }else{
                return 105
            }
        }
    }
}

extension DataEntryListingViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.section == 0 {
            return nil
        }else{
            if selectedTab == "2" {
                
                let closeAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
                    print("CloseAction ...")
                    // action
                    self.clickIndex = indexPath.section - 1
                    print("clickIndex:-",self.clickIndex)
                    
                    self.view.endEditing(true)
                    let vc = DECancellationReasonViewController(nibName: "DECancellationReasonViewController", bundle: nil)
                    vc.delegate = self
                    let popupController = MTPopupController(rootViewController: vc)
                    popupController.autoAdjustKeyboardEvent = false
                    popupController.style = .bottomSheet
                    popupController.navigationBarHidden = true
                    popupController.hidesCloseButton = false
                    let blurEffect = UIBlurEffect(style: .dark)
                    popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
                    popupController.backgroundView?.alpha = 0.6
                    popupController.backgroundView?.onClick {
                        popupController.dismiss()
                    }
                    popupController.present(in: self)
                    
                    success(true)
                })
                closeAction.backgroundColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
                if HeaderHeightSingleton.shared.LanguageSelected == "AR"
                {
                    closeAction.image = UIImage(named: "reject_arabic")
                }
                else{
                    closeAction.image = UIImage(named: "reject_eng")
                }
                return UISwipeActionsConfiguration(actions: [closeAction])
                
            }else {
                return nil
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }else{
            if isMoreDataAvailable == true {
                if let count = self.totalRequestListArray?.count {
                    return count + 1
                }else{
                    return 0
                }
            }else{
                return (totalRequestListArray?.count) ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
        }else{
            var tab =  ""
            if selectedTab == "1" {
                tab = "waitingList"
            }else if selectedTab == "2"{
                tab = "Inprocess"
            }else if selectedTab == "3"{
                tab = "Completed"
            }else if selectedTab == "4"{
                tab = "Rejected"
            }
            
            if tab == "waitingList" || tab == "Rejected" {
                let vc = DataEntryFormViewController()
                vc.isForDetail = tab
                vc.delegate = self
//                 vc.mainServiceID = serviceID
                vc.serviceID = ModalController.toString(totalRequestListArray?[indexPath.row].id as Any)
                vc.serviceName = self.serviceName
                vc.serviceIcon = self.serviceIcon
                self.navigationController?.pushViewController(vc, animated: true)
            }else if tab == "Inprocess" {
                let vc = DataEntryDetailViewController()
                vc.delegate = self
                vc.mainServiceID = serviceID
                vc.serviceName = self.serviceName
                vc.serviceIcon = self.serviceIcon
                vc.serviceID = ModalController.toString(totalRequestListArray?[indexPath.row].id as Any)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            return dataEntryDashboardTopCell(index: indexPath)
        } else{
            if indexPath.row < (totalRequestListArray!.count) {
                if selectedTab == "3" {
                    return dataEntryCompleteServiceCell(index: indexPath)
                }else{
                    return dataEntryDashboardCell(index: indexPath)
                }
            }else{
                return self.loadingCell()
            }
        }
    }
    func dataEntryDashboardTopCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryListingTopTableViewCell", for: index) as! DataEntryListingTopTableViewCell
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func dataEntryDashboardCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryListingTableViewCell", for: index) as! DataEntryListingTableViewCell
        cell.selectionStyle = .none
        cell.rejectReasonLbl.isHidden = true
        cell.rejectReasonHeightConstant.constant = 0
        cell.StatusLbl.isHidden = true
        cell.statusLeadingConstant.constant = 0
        let requestData = totalRequestListArray?[index.row]
        
        if selectedTab == "4" {
            cell.rejectReasonLbl.isHidden = false
            cell.rejectReasonHeightConstant.constant = 20
        }else{
            cell.rejectReasonLbl.isHidden = true
            cell.rejectReasonHeightConstant.constant = 0
        }
        let reason = "Rejection Reason:".localized
        cell.rejectReasonLbl.text = "\(reason) \(requestData?.reason ?? "")"
        
        cell.headerTxt.text = requestData?.instruction
        
        let orderIdTxt = "Order Id".localized
        cell.orderIdLbl.text = "\(orderIdTxt): \(requestData?.order_id ?? "")"
        cell.priceLbl.text = "\(Constant.currency) \(requestData?.order_price ?? 0.00)"
        
        cell.dateLbl.text = ModalController.convert13DigitTimeStampIntoDate(timeStamp: "\(requestData?.order_date ?? 0)", format: "E, MMM dd, yyyy h:mm")
        
        let online = "Online".localized
        if requestData?.location == "1" {
            if requestData?.country_code != "" {
                cell.addressLbl.text = "\(online), \(requestData?.country_code ?? "")"
            }else{
                cell.addressLbl.text = "\(online)"
            }
            
        }else if requestData?.location == "2" {
            if requestData?.country_code != "" {
                cell.addressLbl.text = "\(requestData?.city_name ?? ""), \(requestData?.country_code ?? "")"
            }else{
                cell.addressLbl.text = "\(requestData?.city_name ?? "")"
            }
        }
        
        
        if selectedTab == "2" {
            cell.StatusLbl.isHidden = false
            cell.statusLeadingConstant.constant = 5
            let workStatus = requestData?.start_work
            
            if workStatus == 1 {
                cell.StatusLbl.text = "Start Work".localized
                cell.StatusLbl.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                // green color
            }else if workStatus == 2 {
                // green
                cell.StatusLbl.text = "Submit your work".localized
                cell.StatusLbl.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                
            }else{
                // grey
                cell.StatusLbl.text = "Already Submitted".localized
                cell.StatusLbl.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

            }
            
        }else{
            cell.StatusLbl.isHidden = true
            cell.statusLeadingConstant.constant = 0
        }
       
        return cell
    }
   
   
    func dataEntryCompleteServiceCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteDataEntryListTableViewCell", for: index) as! CompleteDataEntryListTableViewCell
        cell.selectionStyle = .none
        
        let requestData = totalRequestListArray?[index.row]
        
        cell.headerLbl.text = requestData?.instruction
        cell.giveRatingBtn.isHidden = true
        
        let orderIdTxt = "Order Id".localized
        cell.orderIdLbl.text = "\(orderIdTxt): \(requestData?.order_id ?? "")"
        cell.priceValueLbl.text = "\(Constant.currency) \(requestData?.order_price ?? 0.00)"
        cell.addressLbl.text = "\(requestData?.address ?? "")"
        
        cell.dateLbl.text = ModalController.convert13DigitTimeStampIntoDate(timeStamp: "\(requestData?.order_date ?? 0)", format: "E, MMM dd, yyyy h:mm")
        cell.paidTextLbl.text = "Paid".localized
        cell.agentProfileImgView.sd_setImage(with: URL(string:(requestData?.bo_pic ?? "")), placeholderImage: UIImage(named: "agent_indivdual.png"))
        cell.agentNameLbl.text = requestData?.bo_name
        cell.ratingLbl.text = requestData?.rating_avg
        cell.totalRatingLbl.text = "(\(requestData?.rating_count ?? 0))"
        cell.agentAddressLbl.text = "\(requestData?.branch_address ?? "")"
        
        let online = "Online".localized
        if requestData?.location == "1" {
            if requestData?.country_code != "" {
                cell.addressLbl.text = "\(online), \(requestData?.country_code ?? "")"
            }else{
                cell.addressLbl.text = "\(online)"
            }
        }else if requestData?.location == "2" {
            if requestData?.country_code != "" {
                cell.addressLbl.text = "\(requestData?.city_name ?? ""), \(requestData?.country_code ?? "")"
            }else{
                cell.addressLbl.text = "\(requestData?.city_name ?? "")"
            }
        }
        
        if requestData?.rating_given == 0 {
            cell.giveRatingBtn.isHidden = false
        }else  {
            cell.giveRatingBtn.isHidden = true
        }
        
        let avgRating = requestData?.rating_avg
        
        if avgRating == "0" || avgRating == "0.0" || avgRating == "0.00" || avgRating == "1" || avgRating == "1.0" || avgRating == "1.00" || avgRating == "2" || avgRating == "2.0" || avgRating == "2.00" || avgRating == "3" || avgRating == "3.0" || avgRating == "3.00" || avgRating == "4" || avgRating == "4.0" || avgRating == "4.00" || avgRating == "5" || avgRating == "5.0" || avgRating == "5.00" {
            cell.ratingStrImageView.image = UIImage(named: "star-full")
        }else {
            cell.ratingStrImageView.image = UIImage(named: "ratingHalfStar")
        }
        
        self.BranchLat = ModalController.convertInToDouble(str: requestData?.lat as AnyObject)
        self.BranchLong = ModalController.convertInToDouble(str: requestData?.long as AnyObject)
        
        if self.BranchLat != 0.0 {
            cell.boLocationBtn.isHidden = false
            cell.locationBtnWidthConstant.constant = 50
            
        }else{
            cell.boLocationBtn.isHidden = true
            cell.locationBtnWidthConstant.constant = 0
        }
        
        cell.delegate = self
        cell.tag = index.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.tag == 999999 {
            
            currentPageNumber += 1
            self.getBoServicesRequestListAPI()
        }
    }
    func loadingCell() -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        //  activityIndicator.center = cell.center;
        cell.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        cell.tag = 999999
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = cell.contentView.backgroundColor
        activityIndicator.frame = CGRect(x: (UIScreen.main.bounds.size.width / 2) - 10, y: 12, width: 20, height: 20)
        
        return cell
        
    }
}
extension DataEntryListingViewController : DataEntryFilterDelegate {
    
    func filterApplied(filters : [ChooseFilters]) {
        self.selectedFilters = filters
        
        appliedFilterCount = 0
        for item in filters {
            
            if item.range.isEmpty == false {
                appliedFilterCount = appliedFilterCount + 1;
                
            }
        }
        print("appliedFilterCount:-", appliedFilterCount)
        self.refreshDataEntryCompleteServiceList()
    }
}
