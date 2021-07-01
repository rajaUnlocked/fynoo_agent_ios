//
//  AgentDeliveryViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 22/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import ObjectMapper
import MessageUI

class AgentDeliveryViewController: UIViewController, DataEntryListHeaderViewDelegate, MFMessageComposeViewControllerDelegate, AgentServiceListDelegate,AddAmountDelegate {
   
    var isRating = false
    @IBOutlet weak var tableView: UITableView!
    var selectedVl = 1000
    var headerView1 : DataBankHeader? = nil
    
    @IBOutlet weak var deliveryDashboardHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var headerView: NavigationView!
    
    var orderSuccessData:Dictionary<String,Any> = [:]
    
    
    var selectedTab:String = "1"
    var Index:Int = 0
    var deliverData : deliveryDashboard?
    var tripList : TripListInfo?
    var serviceID:String = ""
    var serviceStatus:String = ""
    
    var tripListListArray:[triplist]?
    var isMoreDataAvailable: Bool = false
    var currentPageNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "AgentDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "AgentDeliveryTableViewCell");
        tableView.register(UINib(nibName: "TripAchievementViewCell", bundle: nil), forCellReuseIdentifier: "TripAchievementViewCell");
        tableView.register(UINib(nibName: "AgentServiceList", bundle: nil), forCellReuseIdentifier: "AgentServiceList");
        tableView.register(UINib(nibName: "NoTripFoundTableViewCell", bundle: nil), forCellReuseIdentifier: "NoTripFoundTableViewCell");
        
        isMoreDataAvailable = false
        currentPageNumber = 0
        self.SetFont()
        
        tableView.delegate=self
        tableView.dataSource=self
        
        self.deliveryDashboardHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Delivery Services".localized
        self.headerView.menuBtn.isHidden = false
        self.headerView.viewControl = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(getOrderSuccessData(_:)), name: NSNotification.Name(Constant.NF_KEY_FOR_PASS_DATA_TO_DELIVERYDASHBOARD), object: nil)
        
        print(orderSuccessData)
        
        if isRating == true {
            self.headerView.backButton.isHidden = true
        }else{
            self.headerView.backButton.isHidden = false
        }
    }
    func reloadPage() {
        getTripData()
        getAgentData()
    }
    func ratingClicked(_ sender: Any) {
        
        let vc = DataEntryAgentRatingViewController(nibName: "DataEntryAgentRatingViewController", bundle: nil)
        vc.isFromService = true
       // vc.delegate =  self
        vc.serviceID = ModalController.toString((orderSuccessData as NSDictionary).value(forKey: "del_service_id") as Any)
 vc.custID = ModalController.toString((orderSuccessData as NSDictionary).value(forKey: "cust_id") as Any)
    vc.boID = ModalController.toString((orderSuccessData as NSDictionary).value(forKey: "bo_id") as Any)
        vc.custName = ModalController.toString((orderSuccessData as NSDictionary).value(forKey: "cust_name") as Any)
           vc.boName = ModalController.toString((orderSuccessData as NSDictionary).value(forKey: "bo_name") as Any)
        vc.Orderid = ModalController.toString((orderSuccessData as NSDictionary).value(forKey: "order_id") as Any)
        vc.CustProfilePic = ModalController.toString((orderSuccessData as NSDictionary).value(forKey: "cust_image") as Any)
        vc.BoProfilePic = ModalController.toString((orderSuccessData as NSDictionary).value(forKey: "bo_image") as Any)
        vc.usertype = ModalController.toString((orderSuccessData as NSDictionary).value(forKey: "user_type") as Any)
        
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        self.present(vc, animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if ((orderSuccessData as NSDictionary).value(forKey: "isRating") != nil)
        {
            self.serviceID = ModalController.toString((orderSuccessData as NSDictionary).value(forKey: "del_service_id") as Any)
            if (orderSuccessData as NSDictionary).value(forKey: "isRating") as! Bool
            {
               ratingClicked((Any).self)
            }
        }
        getAgentData()
        getTripData()
    }
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }
    
    
    @objc func getOrderSuccessData( _ userInfo:NSNotification)  {
               
           print("Received Data")
        
    }
    
    func activateService(){
        
        let str = Service.activateService
        
        let param = ["user_id":Singleton.shared.getUserId(),
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                     "services":self.serviceID]
        print("request:-", param)
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
            if success{
                self.getAgentData()
                let value = response as! NSDictionary
                let msg = value.object(forKey: "error_description") as! String
                ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                print(response)
            }
        }
    }
    
    func deactivateService(){
        
        let str = Service.deactivateService
        
        let param = ["user_id":Singleton.shared.getUserId(),
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                     "services":self.serviceID]
        print("request:-", param)
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
            if success{
                print(response)
                self.getAgentData()
                let value = response as! NSDictionary
                let msg = value.object(forKey: "error_description") as! String
                ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
            }
        }
    }
    
    
    func getAgentData(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["service_id":self.serviceID,
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.deliveryDashboard)
        ServerCalls.postRequest(Service.deliveryDashboard, withParameters: param) { (response, success) in
            if success{
                
                if let body = response as? [String: Any] {
                    self.deliverData  = Mapper<deliveryDashboard>().map(JSON: body)
                    if self.deliverData?.data?.agent_information?.del_service_document_uploaded == 0 {
                    let vc = AddAmountViewController(nibName: "AddAmountViewController", bundle: nil)
                     vc.isNotFill = true
                     vc.isFrom = true
                        vc.descrptxt = "Please fill the document service form to activate the delivery service"
                    vc.modalPresentationStyle = .overFullScreen
                    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                    self.present(vc, animated: true, completion: nil)
                    print(self.deliverData?.data?.agent_information?.del_service_document ?? "","del_service_document")
                    self.tableView.reloadData()
                    }
                    
                }
            }
        }
    }
    
    func getTripData(){
        
        let param = ["service_id":self.serviceID,
                     "user_id":Singleton.shared.getUserId(),
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                     "tab_id": self.selectedTab,
                     "next_page_no":currentPageNumber] as [String : Any]
        
        print("request:-", param)
        print("Url:-", Service.tripList)
        if currentPageNumber == 0
        {
        ModalClass.startLoading(self.view)
        }
        ServerCalls.postRequest(Service.tripList, withParameters: param) { (response, success) in
            if success{
                //   print(response)
                
                ModalClass.stopLoading()
                if let body = response as? [String: Any] {
                    self.tripList  = Mapper<TripListInfo>().map(JSON: body)
                    if self.currentPageNumber == 0 {
                        self.tripListListArray?.removeAll()
                    }
                   
                    if self.tripList?.data?.trip_list?.count ?? 0 > 0 {
                       
                        guard let arr = self.tripList?.data?.trip_list as NSArray? else {
                            
                            self.isMoreDataAvailable = false
                            self.tableView.reloadData()
                            return
                            
                        }
                        if let cont = self.tripListListArray {
                            self.tripListListArray = cont + (self.tripList?.data?.trip_list)!
                            
                        }else{
                            
                            self.tripListListArray = self.tripList?.data?.trip_list!
                            
                        }
                        if arr.count < 10 {
                            self.isMoreDataAvailable = false
                        }else{
                            self.isMoreDataAvailable = true
                        }
                        
                    }else{
                        if self.currentPageNumber == 0
                        {
                            self.tripListListArray?.removeAll()
                        }
                        self.isMoreDataAvailable = false
                       
                    }
                    
                    self.tableView.reloadData()
                }
               
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "\(self.tripList?.error_description ?? "")")
                self.currentPageNumber = 0
                self.isMoreDataAvailable = false
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func editAmountClicked(){
        let vc = AddAmountViewController(nibName: "AddAmountViewController", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.present(vc, animated: true, completion: nil)
    }
    @objc func segmentClicked(_ sender:UIButton){
        print(sender.tag)
        selectedVl = sender.tag
        getTripData()
        // tableView.reloadData()
    }
    @objc func profileClicked(){
        let vc = UserProfileDetailsViewController(nibName: "UserProfileDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func infoClicked(_ sender:UIButton){
        let vc = AddAmountViewController(nibName: "AddAmountViewController", bundle: nil)
        vc.isFrom = true
        vc.taG = sender.tag
        vc.descrptxt = deliverData?.data?.agent_information?.del_service_document_reason ?? ""
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.present(vc, animated: true, completion: nil)
    }
    
    //    @objc func messageClicked(){
    //        if (MFMessageComposeViewController.canSendText()) {
    //            let controller = MFMessageComposeViewController()
    //            controller.body = ""
    //            controller.recipients = ["\(serviceDetailData?.data?.bo_number ?? "")"]
    //            controller.messageComposeDelegate = self
    //            self.present(controller, animated: true, completion: nil)
    //        }
    //
    //    }
    //    @objc func callClicked(){
    //
    //       }
    //    @objc func navigationClicked() {
    //
    //       }
    
    //MARK: - Message compose method
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func clickedservicedoc(_ sender: UIButton)
    {
     let vc = DeliveryDocumentViewController(nibName: "DeliveryDocumentViewController", bundle: nil)
     vc.primaryid = self.deliverData?.data?.agent_information?.dsd_id ?? 0
     self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func switchClicked(_ sender: UIButton){
        print("switch")
        if deliverData?.data?.agent_information?.del_service_document_uploaded == 1
        {
            ModalController.showNegativeCustomAlertWith(title: "Delivery services cannot be activated until delivery documents are approved by Fynoo Admin", msg: "")
            return
        }
        if sender.isSelected {
            sender.isSelected = false
            
            deactivateService()
            
        }else{
            sender.isSelected = true
            activateService()
        }
        
        tableView.reloadData()
    }
    func selecteIndex(_ sender: Any, selectedIndexID:String){
        
        self.selectedTab = selectedIndexID
        self.Index = Int(self.selectedTab)! - Int(1)
        isMoreDataAvailable = false
        currentPageNumber = 0
        getTripData()
        
    }
    
    func callClicked(_ sender: Any) {
        
        guard let number = URL(string: "tel://" + (tripListListArray?[(sender as AnyObject).tag].cust_mobile ?? "")!) else { return }
        UIApplication.shared.open(number)
    }
    
    func messageClicked(_ sender: Any) {
        
        let mobileNumber = tripListListArray?[(sender as AnyObject).tag].cust_mobile ?? ""
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = ["\(mobileNumber)"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    
    func navigationClicked(_ sender: Any) {
       let vc = AgentDeliveryDetailViewController()
//        let vc = SearchedProductDeatailViewC()
        vc.tripId = (tripListListArray?[(sender as AnyObject).tag].id ?? 0)
        let status = (tripListListArray?[(sender as AnyObject).tag].status ?? 0)
        
        if status == 1 {
            vc.checkUsertype = "CUSTOMER"
        }else
        {
            vc.checkUsertype = "BO"
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension AgentDeliveryViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 2
        }else{
            if isMoreDataAvailable == true {
                if let count = self.tripListListArray?.count {
                    return count + 1
                }else{
                    return 1
                }
            }else{
                if self.tripListListArray?.count ?? 0 == 0
                {
                    return 1
                }
                
                return ((tripListListArray?.count) ?? 0)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0{
            if indexPath.row == 0{
                return 365
            }else {
                return 195
                
            }
        }
       else{
        if tripListListArray?.count ?? 0 == 0
        {
            return 400
        }
            return 236
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 1{
            if tripListListArray?.count ?? 0 == 0
            {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoTripFoundTableViewCell",for: indexPath) as! NoTripFoundTableViewCell
                cell.notripfoundlbl.text = "No Trips Found".localized
            return cell
            }
            else if indexPath.row < (tripListListArray!.count) {
                return deliveryServiceListCell(index: indexPath)
            }else{
                return self.loadingCell()
            }
        }else{
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgentDeliveryTableViewCell",for: indexPath) as! AgentDeliveryTableViewCell
              cell.clickservicedocument.addTarget(self, action: #selector(clickedservicedoc), for: .touchUpInside)
            cell.switches.addTarget(self, action: #selector(switchClicked), for: .touchUpInside)
            if deliverData?.data?.agent_information?.del_service_status == 1{
                cell.switches.isSelected = true
            }else{
                cell.switches.isSelected = false
            }
            cell.name.text = deliverData?.data?.agent_information?.name ?? ""
            cell.avgRating.text = "\(deliverData?.data?.agent_information?.avg_rating ?? 0)"
            cell.totalRating.text = "(\(deliverData?.data?.agent_information?.total_rating ?? 0))"
            cell.trip.text = "\(deliverData?.data?.agent_information?.total_trips ?? 0)"
            cell.year.text = "\(deliverData?.data?.agent_information?.active_years ?? 0)"
            cell.earning.text = "\(deliverData?.data?.agent_information?.total_earnings ?? 0)"
            cell.cod.text = (deliverData?.data?.del_accept_limit?.today_cod ?? 0) == 0 ? "" : "\(deliverData?.data?.del_accept_limit?.today_cod ?? 0)"
            cell.agentProfileImageView.sd_setImage(with: URL(string: deliverData?.data?.agent_information?.user_img ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
            cell.langugae.text = "\(deliverData?.data?.user_lang ?? "")"
            cell.infoClicked.isHidden = true
            cell.widthconst.constant = 0
            if deliverData?.data?.agent_information?.del_service_document_uploaded == 0 {
                cell.delivery.image = UIImage(named: "grayTick")
                //pending
            }
            else if deliverData?.data?.agent_information?.del_service_document_uploaded == 1 {
                cell.delivery.image = UIImage(named: "timer")
                //pending
            }else if deliverData?.data?.agent_information?.del_service_document_uploaded == 2{
                //approved
                cell.delivery.image = UIImage(named: "accepted_tick")

            }else if deliverData?.data?.agent_information?.del_service_document_uploaded == 3{
                //reject
                cell.infoClicked.tag = 1
                cell.delivery.image = UIImage(named: "cross-1")
                cell.infoClicked.isHidden = false
                cell.widthconst.constant = 24

            }else if deliverData?.data?.agent_information?.del_service_document_uploaded == 4{
                //edit & approve
                cell.infoClicked.tag = 2
                cell.delivery.image = UIImage(named: "accepted_tick")
                cell.infoClicked.isHidden = false
                cell.widthconst.constant = 24
            }
            cell.editAmount.addTarget(self, action: #selector(editAmountClicked), for: .touchUpInside)
            cell.infoClicked.addTarget(self, action: #selector(infoClicked), for: .touchUpInside)
            cell.clickedProfile.addTarget(self, action: #selector(profileClicked), for: .touchUpInside)
            
            cell.selectionStyle = .none
              return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TripAchievementViewCell",for: indexPath) as! TripAchievementViewCell
            cell.selectionStyle = .none
            cell.tripAchivementLbl.text = "Trips Achievement".localized
            cell.tripAchivementData = deliverData?.data?.agent_information?.trips_achievements
            cell.collectionView.reloadData()
            
            
            return cell
        }
    }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
//                let vc = ProductDetailsViewC()
//        //        vc.serviceID = ModalController.toString(((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_id") as! NSNumber) as Any)
//                self.navigationController?.pushViewController(vc, animated: true)
        
        if indexPath.section == 1 {
            if self.selectedTab == "2"
            {
                
                if self.tripList?.data?.trip_list?.count ?? 0 > 0  {
                    let vc = SearchedProductDeatailViewC()
                    vc.searchId = "\(self.tripList?.data?.trip_list?[indexPath.row].search_id ?? 0)"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
               
                return
            }
            if (tripListListArray?[indexPath.row].status) == 1  {
                let vc = OtpForCodViewC()
                vc.orderId = tripListListArray?[indexPath.row].order_id ?? ""
                vc.tripId = tripListListArray?[indexPath.row].id ?? 0
                self.navigationController?.pushViewController(vc, animated: true)
            }else
            {
            let vc = ProductDetailsViewC()
            vc.orderId = tripListListArray?[indexPath.row].order_id ?? ""
                vc.tripId = tripListListArray?[indexPath.row].id ?? 0
//                ModalController.toString(((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_id") as! NSNumber) as Any)
            self.navigationController?.pushViewController(vc, animated: true)
         }
        }
             
        
//        if isTypeFrom == "CustomerProDetail"{
//            let vc = VariantPRoductsViewController(nibName: "VariantPRoductsViewController", bundle: nil)
//                  vc.productId = "\(self.varientCustomerProductList?.data?.pro_id ?? 0)"
//                parent.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            let vc = VariantPRoductsViewController(nibName: "VariantPRoductsViewController", bundle: nil)
//            vc.productId = "\(self.varientProductList?.data?.pro_id ?? 0)"
//            parent.navigationController?.pushViewController(vc, animated: true)
//        }
     
    }
    
    func deliveryServiceListCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentServiceList", for: index) as! AgentServiceList
        cell.selectionStyle = .none
        
        cell.statusView.cornerRadius = 8
        cell.cardView.cornerRadius = 8
        cell.statusView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cell.cardView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        if tripListListArray?[index.row].status == 0 || tripListListArray?[index.row].status == 3 {
            cell.almostPriceLbl.text = "Almost Total Amount".localized
        }else
        {
            cell.almostPriceLbl.text = "Actual Total Amount".localized
        }
        cell.name.text = tripListListArray?[index.row].cust_name ?? ""
        cell.profileImageView.sd_setImage(with: URL(string: tripListListArray?[index.row].cust_image ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
        cell.avgRating.text = "\(tripListListArray?[index.row].avg_rating ?? "")"
        cell.totalRate.text = "(\(tripListListArray?[index.row].total_rating ?? ""))"
        cell.totalCount.text = "\(tripListListArray?[index.row].qty ?? 0)"
        cell.orderId.text = "\("Order Id ".localized):\(tripListListArray?[index.row].order_id ?? "")"
        cell.date.text  = tripListListArray?[index.row].order_date ?? ""
        cell.address.text = "\("Address".localized):\(tripListListArray?[index.row].address ?? "")"
        cell.price.text = "\(tripListListArray?[index.row].currency ?? "") \(ModalController.toString(tripListListArray?[index.row].almost_total_price ?? 0.0 as Any))"
        cell.walletIcon.sd_setImage(with: URL(string: tripListListArray?[index.row].payment_icon ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
        cell.statusLbl.text = tripListListArray?[index.row].status_desc
       
        cell.callBtn.isHidden = false
        cell.messageBtn.isHidden = false
        if selectedTab == "2" {
            cell.callBtn.isHidden = true
            cell.messageBtn.isHidden = true
            cell.statusLbl.text = "Tap to accept".localized
            cell.statusView.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
        }else{
           cell.statusView.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        }

        cell.delegate = self
        cell.tag = index.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
           
           if cell.tag == 999999 {
            
               currentPageNumber += 1
               self.getTripData()
             
           }
       }
    
    func loadingCell() -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        cell.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        cell.tag = 999999
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = cell.contentView.backgroundColor
        activityIndicator.frame = CGRect(x: (UIScreen.main.bounds.size.width / 2) - 10, y: 12, width: 20, height: 20)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          if section == 0{
              return 0
          }
          return 90
      }
      
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return UIView()
        }else{
            
            if headerView1 == nil
            {
                
                headerView1 = DataBankHeader()

                headerView1!.delegate = self
            }
            headerView1!.selectedIndex = Index
            if isRating
            {
                headerView1!.selectedIndex = 2
            }
            return headerView1
            
            
        }
        
    }
}

extension AgentDeliveryViewController : UITableViewDelegate {
 
    
}


