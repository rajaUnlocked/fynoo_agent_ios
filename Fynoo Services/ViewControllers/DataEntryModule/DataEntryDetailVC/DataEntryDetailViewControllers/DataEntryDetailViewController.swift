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

protocol DataEntryDetailViewControllerDelegate: class {
    func refreshDataEntryServiceList()
}
class DataEntryDetailViewController: UIViewController, MFMessageComposeViewControllerDelegate, DataEntryWorkConfirmationPopUpViewControllerDelegate, AddedServicesInDataEntryViewControllerDelegate {
    
   
    weak var delegate: DataEntryDetailViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerViewHeightConstant: NSLayoutConstraint!
    var isBranchLocationAvailable:Bool = false
    var BranchLat = 0.0
    var BranchLong = 0.0
    var serviceID:String = ""
    
    var dataEntryApiMnagagerModal = DataEntryApiManager()
       var serviceDetailData  : serviceDetailData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getServiceDetailAPI()
        
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
                    
                    //                    self.selectedBranchCity = pm.locality ?? ""
                    //                    self.selectedBranchCountryCode = pm.isoCountryCode ?? ""
                }
        })
        
    }
    @objc func DataEntryWorkConfirmationClicked(_ sender : UIButton) {
        
        if serviceDetailData?.data?.start_work != 3 {
            ModalController.showNegativeCustomAlertWith(title: "Agent has not submitted his work.You can approve it after final submission by agent", msg: "")
            return
        }else{
            
            let vc = DataEntryWorkConfirmationPopUpViewController(nibName: "DataEntryWorkConfirmationPopUpViewController", bundle: nil)
            vc.messageTxtStr = "Has the agent completed this work ?".localized
            vc.modalPresentationStyle = .overFullScreen
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            vc.delegate =  self
            self.present(vc, animated: true, completion: nil)
            
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
        self.workConfirmationAPI()
           
       }
       
       func popUpNoClicked(_ sender: Any) {
           
       }
    
    func workConfirmationAPI() {
        
        dataEntryApiMnagagerModal.BOWorkConfirmation(serviceID: ModalController.toString(serviceDetailData?.data?.id as Any) ) { (success, response) in
            ModalClass.stopLoading()
            if success{
                if let value = (response?.object(forKey: "error_description") as? String) {
                    ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                }
                let vc = AddedServicesInDataEntryViewController(nibName: "AddedServicesInDataEntryViewController", bundle: nil)
                
                vc.modalPresentationStyle = .overFullScreen
                vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                vc.delegate =  self
                vc.addedserviceDetailData = self.serviceDetailData
                self.present(vc, animated: true, completion: nil)
                
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
        guard let number = URL(string: "tel://" + (serviceDetailData?.data?.agent_number)!) else { return }
                   UIApplication.shared.open(number)
    }
    
    @objc func agentMessageClicked(_ sender : UIButton) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = ["\(serviceDetailData?.data?.agent_number ?? "")"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
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
            
            return 255
            
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

        cell.callBtn.addTarget(self, action: #selector(agentCallClicked(_:)), for: .touchUpInside)
        
        cell.textMessageBtn.addTarget(self, action: #selector(agentMessageClicked(_:)), for: .touchUpInside)
        
        let requestData = serviceDetailData?.data
        
        cell.headerLbl.text = requestData?.instruction
        let orderIdTxt = "Order Id:"
        cell.orderIdLbl.text = "\(orderIdTxt) \(requestData?.order_id ?? "")"
        cell.addressLbl.text = "\(requestData?.address ?? "")"
        
        cell.dateLbl.text = ModalController.convert13DigitTimeStampIntoDate(timeStamp: "\(requestData?.order_date ?? 0)", format: "E, MMM dd, yyyy h:mm")
        cell.paidTextLbl.text = "Holding"
         cell.priceValueLbl.text = "\(Constant.currency) \(requestData?.service_price ?? 0.00)"
        cell.agentProfileImgView.sd_setImage(with: URL(string:(requestData?.agent_pic ?? "")), placeholderImage: UIImage(named: "agent_indivdual.png"))
        cell.agentNameLbl.text = requestData?.agent_name
        cell.ratingLbl.text = requestData?.rating_avg
        cell.totalRatingLbl.text = "(\(requestData?.rating_count ?? 0))"
        cell.agentAddressLbl.text = "\(requestData?.address ?? "")"
        cell.completeImageView.image = UIImage(named: "inprogress_dataEntry-selected")
        cell.completeTxtLbl.text = "Inprocess"
        
        if requestData?.work_place == 1 {
            cell.addressLbl.text = "Online, \(requestData?.country_code ?? "")"
        }else if requestData?.work_place == 2 {
           cell.addressLbl.text = "\(requestData?.address ?? "")"
        }
        
        
        
        return cell
    }
    
    func dataEntryWorkConfirmationCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEInprogressDetailTableViewCell", for: index) as! DEInprogressDetailTableViewCell
        cell.selectionStyle = .none
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
            cell.workPlaceTypeLbl.text = "\(serviceDetailData?.data?.city_name ?? "")\(serviceDetailData?.data?.country_code ?? "")"
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
