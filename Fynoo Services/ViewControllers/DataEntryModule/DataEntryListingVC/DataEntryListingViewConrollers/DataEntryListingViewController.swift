//
//  DataEntryListingViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 01/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import MTPopup

class DataEntryListingViewController: UIViewController,DataEntryListHeaderViewDelegate, DECancellationReasonViewControllerDelegate, DataEntryDetailViewControllerDelegate, DataEntryAgentRatingViewControllerDelegate, CompleteDataEntryListTableViewCellrDelegate, DataEntryFormViewControllerDelegate {
 
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUI()
        
        ModalClass.startLoading(self.view)
        isMoreDataAvailable = false
        currentPageNumber = 0
        self.getBoServicesRequestListAPI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationRefreshList(_:)), name: NSNotification.Name(rawValue: "refreshDataEntryList"), object: nil)
        
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
        self.getBoServicesRequestListAPI()
        
    }

    @objc func methodOfReceivedNotificationRefreshList(_ notification: NSNotification) {
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
        self.headerView.titleHeader.text = "Data Entry Service".localized;
        self.headerView.viewControl = self
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }
    
    @objc func filterClicked() {
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
       
        apiManagerModal.agentServicesOrderListing(serviceID:self.serviceID, tabStatus: self.selectedTab, searchStr: self.searchBoxEntryText, pageNumber: currentPageNumber, filter: selectedFilters ) { (success, response) in
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
                    
                }else{
                    self.isMoreDataAvailable = false
                    self.totalRequestListArray?.removeAll()
                    self.noDataView.isHidden = false
                }                
                
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
}

extension DataEntryListingViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            if headerView1 == nil || appliedFilterCount > 0 {
                
                headerView1 = DataEntryListHeaderView()
                
                let searchTxtFld = headerView1!.viewWithTag(103) as! UITextField
                let searchBtn = headerView1!.viewWithTag(104) as! UIButton
                let filterBtn = headerView1!.viewWithTag(105) as! UIButton
                let dataEntryLbl = headerView1!.viewWithTag(106) as! UILabel
                let filterCount = headerView1!.viewWithTag(1010) as! UILabel
                
                let avgLbl = headerView1!.viewWithTag(1001) as! UILabel
                //            let ratingView = sectionHeaderView.viewWithTag(1002) as! UIView
                let totalRatingLbl = headerView1!.viewWithTag(1003) as! UILabel
                filterCount.isHidden = true
                
                avgLbl.text = self.boServicesList?.data?.rating_avg
                totalRatingLbl.text = "(\(ModalController.toString(self.boServicesList?.data?.rating_count as Any)))"
                headerView1!.ratingValueView.rating = ModalController.convertInToDouble(str: self.boServicesList?.data?.rating_avg as AnyObject)
                
                
                searchBtn.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
                searchTxtFld.addTarget(self, action: #selector(DataEntryListingViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                
                filterBtn.addTarget(self, action: #selector(filterClicked), for: .touchUpInside)
                
                
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
                
                searchTxtFld.font = UIFont(name:"\(fontNameLight)",size:12)
                dataEntryLbl.font = UIFont(name:"\(fontNameLight)",size:16)
                
                if appliedFilterCount > 0 {
                    filterCount.isHidden = false
                    filterCount.text = ModalController.toString(appliedFilterCount as Any)
                    
                }else{
                    filterCount.isHidden = true
                    filterCount.text = ""
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
                 return 260
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
                closeAction.image = UIImage(named: "service-Reject.png")
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
                vc.serviceID = ModalController.toString(totalRequestListArray?[indexPath.row].id as Any)
                self.navigationController?.pushViewController(vc, animated: true)
            }else if tab == "Inprocess" {
                let vc = DataEntryDetailViewController()
                vc.delegate = self
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
        
        let requestData = totalRequestListArray?[index.row]
        
        if selectedTab == "4" {
            cell.rejectReasonLbl.isHidden = false
            cell.rejectReasonHeightConstant.constant = 20
        }else{
            cell.rejectReasonLbl.isHidden = true
            cell.rejectReasonHeightConstant.constant = 0
        }
        let reason = "Reason:"
        cell.rejectReasonLbl.text = "\(reason) \(requestData?.reason ?? "")"
        
        
        cell.headerTxt.text = requestData?.instruction
        
        let orderIdTxt = "Order Id:"
        cell.orderIdLbl.text = "\(orderIdTxt) \(requestData?.order_id ?? "")"
        cell.priceLbl.text = "\(Constant.currency) \(requestData?.order_price ?? 0.00)"
        
        cell.dateLbl.text = ModalController.convert13DigitTimeStampIntoDate(timeStamp: "\(requestData?.order_date ?? 0)", format: "E, MMM dd, yyyy h:mm")
        
        if requestData?.location == "1" {
            if requestData?.country_code != "" {
            cell.addressLbl.text = "Online, \(requestData?.country_code ?? "")"
            }else{
               cell.addressLbl.text = "Online"
            }
            
        }else if requestData?.location == "2" {
            if requestData?.country_code != "" {
           cell.addressLbl.text = "\(requestData?.city_name ?? ""), \(requestData?.country_code ?? "")"
            }else{
              cell.addressLbl.text = "\(requestData?.city_name ?? "")"
            }
        }
        
        
        return cell
    }
    
    
    func dataEntryCompleteServiceCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteDataEntryListTableViewCell", for: index) as! CompleteDataEntryListTableViewCell
        cell.selectionStyle = .none
        
        let requestData = totalRequestListArray?[index.row]
        
        cell.headerLbl.text = requestData?.instruction
        cell.giveRatingBtn.isHidden = true
        
        let orderIdTxt = "Order Id:"
        cell.orderIdLbl.text = "\(orderIdTxt) \(requestData?.order_id ?? "")"
        cell.priceValueLbl.text = "\(Constant.currency) \(requestData?.order_price ?? 0.00)"
        cell.addressLbl.text = "\(requestData?.address ?? "")"
        
        cell.dateLbl.text = ModalController.convert13DigitTimeStampIntoDate(timeStamp: "\(requestData?.order_date ?? 0)", format: "E, MMM dd, yyyy h:mm")
        cell.paidTextLbl.text = "Paid"
        cell.agentProfileImgView.sd_setImage(with: URL(string:(requestData?.bo_name ?? "")), placeholderImage: UIImage(named: "agent_indivdual.png"))
        cell.agentNameLbl.text = requestData?.bo_name
        cell.ratingLbl.text = requestData?.rating_avg
        cell.totalRatingLbl.text = "(\(requestData?.rating_count ?? 0))"
        cell.agentAddressLbl.text = "\(requestData?.branch_address ?? "")"
        
        if requestData?.location == "1" {
            if requestData?.country_code != "" {
                cell.addressLbl.text = "Online, \(requestData?.country_code ?? "")"
            }else{
                cell.addressLbl.text = "Online"
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
        
        cell.delegate = self
        cell.tag = index.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
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
