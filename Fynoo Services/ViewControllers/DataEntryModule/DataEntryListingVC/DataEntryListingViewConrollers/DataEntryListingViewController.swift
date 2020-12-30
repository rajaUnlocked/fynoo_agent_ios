//
//  DataEntryListingViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 01/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import MTPopup

class DataEntryListingViewController: UIViewController,DataEntryListHeaderViewDelegate, DECancellationReasonViewControllerDelegate, DataEntryDetailViewControllerDelegate, DataEntryAgentRatingViewControllerDelegate, CompleteDataEntryListTableViewCellrDelegate {
 
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
        
    }
    
    @objc func DataEntryNewOrder(_ sender : UIButton) {
        
        let vc = DataEntryFormViewController(nibName: "DataEntryFormViewController", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
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
       
        apiManagerModal.bussinessOwnerServicesOrderListing(tabStatus: self.selectedTab, searchStr: self.searchBoxEntryText, pageNumber: currentPageNumber ) { (success, response) in
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
        vc.agentID = ModalController.toString(self.totalRequestListArray?[(sender as AnyObject).tag].agent_id as Any)
        vc.agentName = ModalController.toString(self.totalRequestListArray?[(sender as AnyObject).tag].agent_name as Any)
        vc.agentLanguage = ModalController.toString(self.totalRequestListArray?[(sender as AnyObject).tag].agent_lang as Any)
        vc.agentProfilePic = ModalController.toString(self.totalRequestListArray?[(sender as AnyObject).tag].agent_pic as Any)
        //            vc.messageTxtStr = "Has the agent completed this work ?".localized
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        self.present(vc, animated: true, completion: nil)
        
        
        
    }
//    @objc func ratingClicked(_ sender : UIButton) {
//        print("sender.tag", sender.tag)
//        let vc = DataEntryAgentRatingViewController(nibName: "DataEntryAgentRatingViewController", bundle: nil)
//        //            vc.messageTxtStr = "Has the agent completed this work ?".localized
//        vc.modalPresentationStyle = .overFullScreen
//        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        vc.delegate =  self
//        vc.serviceID = ModalController.toString(self.totalRequestListArray?[sender.tag].id as Any)
//        vc.agentID = ModalController.toString(self.totalRequestListArray?[sender.tag].agent_id as Any)
//        vc.agentName = ModalController.toString(self.totalRequestListArray?[sender.tag].agent_name as Any)
//        vc.agentLanguage = ModalController.toString(self.totalRequestListArray?[sender.tag].agent_lang as Any)
//        vc.agentProfilePic = ModalController.toString(self.totalRequestListArray?[sender.tag].agent_pic as Any)
//        self.present(vc, animated: true, completion: nil)
//
//
//
//    }
}

extension DataEntryListingViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            
            let sectionHeaderView = DataEntryListHeaderView()
            
            let searchTxtFld = sectionHeaderView.viewWithTag(103) as! UITextField
            let searchBtn = sectionHeaderView.viewWithTag(104) as! UIButton
            let filterBtn = sectionHeaderView.viewWithTag(105) as! UIButton
            let dataEntryLbl = sectionHeaderView.viewWithTag(106) as! UILabel
            let newOrderBtn = sectionHeaderView.viewWithTag(107) as! UIButton


            searchBtn.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
            searchTxtFld.addTarget(self, action: #selector(DataEntryListingViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            
            filterBtn.addTarget(self, action: #selector(filterClicked), for: .touchUpInside)
             newOrderBtn.addTarget(self, action: #selector(DataEntryNewOrder(_:)), for: .touchUpInside)
           
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            
            searchTxtFld.font = UIFont(name:"\(fontNameLight)",size:12)
             dataEntryLbl.font = UIFont(name:"\(fontNameLight)",size:16)
            newOrderBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:16)
//
            sectionHeaderView.selectedIndex = Index
            sectionHeaderView.delegate = self
            return sectionHeaderView
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
                 return 255
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
            if selectedTab == "1" {
                
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
                closeAction.image = UIImage(named: "swipe-cancel.png")
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
                tab = "Cancelled"
            }
            
            if tab == "waitingList" || tab == "Cancelled" {
                let vc = DataEntryFormViewController()
                vc.isForDetail = tab
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
        cell.rejectReasonLbl.text = requestData?.reason
        
        
        cell.headerTxt.text = requestData?.instruction
        
        let orderIdTxt = "Order Id:"
        cell.orderIdLbl.text = "\(orderIdTxt) \(requestData?.order_id ?? "")"
        cell.priceLbl.text = "\(Constant.currency) \(requestData?.order_price ?? 0.00)"
        
        cell.dateLbl.text = ModalController.convert13DigitTimeStampIntoDate(timeStamp: "\(requestData?.order_date ?? 0)", format: "E, MMM dd, yyyy h:mm")
        
        if requestData?.location == "1" {
            cell.addressLbl.text = "Online"
            
        }else if requestData?.location == "2" {
          cell.addressLbl.text = "\(requestData?.address ?? "")"
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
        cell.paidTextLbl.text = "Holding"
        cell.agentProfileImgView.sd_setImage(with: URL(string:(requestData?.agent_pic ?? "")), placeholderImage: UIImage(named: "agent_indivdual.png"))
        cell.agentNameLbl.text = requestData?.agent_name
        cell.ratingLbl.text = requestData?.rating_avg
        cell.totalRatingLbl.text = "(\(requestData?.rating_count ?? 0))"
        cell.agentAddressLbl.text = "\(requestData?.address ?? "")"
        cell.completeImageView.image = UIImage(named: "inprogress_dataEntry-selected")
        cell.completeTxtLbl.text = "Inprocess"
        
        if requestData?.location == "1" {
            cell.addressLbl.text = "Online, \(requestData?.country_code ?? "")"
        }else if requestData?.location == "2" {
           cell.addressLbl.text = "\(requestData?.address ?? "")"
        }
        
        if requestData?.rating_given == 0 {
            cell.giveRatingBtn.isHidden = false
        }else  {
          cell.giveRatingBtn.isHidden = true
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
