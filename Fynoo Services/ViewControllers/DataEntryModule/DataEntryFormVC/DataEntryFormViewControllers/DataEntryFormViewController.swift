//
//  DataEntryFormViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 05/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import MTPopup
import GoogleMaps

protocol  DataEntryFormViewControllerDelegate {
    
     func refreshServiceListing()
}

class DataEntryFormViewController: UIViewController, DataEntryFormItemPopUpViewControllerDelegate, UITextFieldDelegate,UITextViewDelegate, DataEntryFormWorkPlaceTableViewCellDelegate, DataEntryWorkConfirmationPopUpViewControllerDelegate {

    
    
    var  delegate : DataEntryFormViewControllerDelegate?
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var placeOrderBtn: UIButton!
    var selectedFormTypeArray = [String]()
    var enterItemArray = [String]()
    var enterQuantityArray = [String]()
    var enterItemDescTypeIDArray = [String]()
    
    var isWorkOnlineClicked:Bool = false
    var isWorkBranchClicked:Bool = false
    var branchNameDict : NSMutableDictionary = NSMutableDictionary()
    var selectedBranchName:String = ""
    var selectedBranchID:String = ""
    var isBranchLocationAvailable:Bool = false
    var BranchLat = 0.0
    var BranchLong = 0.0
    var selectedBranchCity:String = ""
    var selectedBranchCountryCode:String = ""
    var workPlaceStr:String = ""
    
    var dataEntryApiMnagagerModal = DataEntryApiManager()
    var serviceDetailData  : serviceDetailData?
    
    var dataEntryPrice:String = ""
    var dataEntryTimePeriod:String = ""
    var dataEntryOrderInstruction:String = ""
    
     var isForDetail:String = ""
    var serviceID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
         self.getServiceDetailAPI()
        
            if  isForDetail == "waitingList" {
                self.placeOrderBtn.isUserInteractionEnabled = true
                self.placeOrderBtn.setTitle("Accept Order", for: .normal)
                self.placeOrderBtn.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                
            }else if isForDetail == "Rejected" {
                self.placeOrderBtn.isUserInteractionEnabled = false
                self.placeOrderBtn.setTitle("Rejected", for: .normal)
                self.placeOrderBtn.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 1)
            }
       
        
    }
    func setUpUI() {
        
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "DataEntryFormFirstTopTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryFormFirstTopTableViewCell")
        tableView.register(UINib(nibName: "DataEntryFromTopTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryFromTopTableViewCell")
        tableView.register(UINib(nibName: "DataEntryFormAddItemTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryFormAddItemTableViewCell")
        tableView.register(UINib(nibName: "DataEntryItemEntryTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryItemEntryTableViewCell")
        tableView.register(UINib(nibName: "DataEntryPricePayTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryPricePayTableViewCell")
        tableView.register(UINib(nibName: "DataEntryFormDayTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryFormDayTableViewCell")
        tableView.register(UINib(nibName: "DataEntryFromOrderInstractionTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryFromOrderInstractionTableViewCell")
        tableView.register(UINib(nibName: "DataEntryFormWorkPlaceTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryFormWorkPlaceTableViewCell")
        
        self.headerView.menuBtn.isHidden = true
        self.headerView.titleHeader.text = "Service Orders".localized;
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
                    self.workPlaceStr = "2"
                    self.isWorkBranchClicked = true
                    self.isWorkOnlineClicked = false
                    self.BranchLat = ModalController.convertInToDouble(str: self.serviceDetailData?.data?.branch_lat as AnyObject)
                    self.BranchLong = ModalController.convertInToDouble(str: self.serviceDetailData?.data?.branch_long as AnyObject)
                    
                    if self.BranchLat != 0.0 {
                        
                        self.getAddressFromLatLon(pdblLatitude: ModalController.convertInString(str: self.BranchLat as AnyObject), withLongitude: ModalController.convertInString(str: self.BranchLong as AnyObject))
                        
                        
                        self.isBranchLocationAvailable = true
                    }else{
                        self.isBranchLocationAvailable = false
                    }
                }else if self.serviceDetailData?.data?.work_place == 1 {
                    self.workPlaceStr = "1"
                    self.isBranchLocationAvailable = false
                    self.isWorkOnlineClicked = true
                    self.isWorkBranchClicked = false
                }
                
                self.tableView.reloadData()
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "\(self.serviceDetailData?.error_description ?? "")")
            }
        }
    }
    
    @IBAction func placeOrderClicked(_ sender: Any) {
        
        let vc = DataEntryWorkConfirmationPopUpViewController(nibName: "DataEntryWorkConfirmationPopUpViewController", bundle: nil)
        vc.messageTxtStr = "Are you sure you want accept the order?".localized
        vc.comeFromStr = "acceptOrder"
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        vc.delegate =  self
        self.present(vc, animated: true, completion: nil)
        
      
    }
    
    @objc func DataEntryItemAdded(_ sender : UIButton) {
        
        self.view.endEditing(true)
        let vc = DataEntryFormItemPopUpViewController(nibName: "DataEntryFormItemPopUpViewController", bundle: nil)
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
        
    }
    
    func selectDataEntryItem(str:String, ItemID:String) {
        
        selectedFormTypeArray.append("\(str)")
        enterItemArray.append("")
        enterQuantityArray.append("")
        enterItemDescTypeIDArray.append("\(ItemID)")
        
        print("selectedItem:-", selectedFormTypeArray)
        print("selectedFormTypeArray:-", selectedFormTypeArray.count)
        self.tableView.reloadData()
        
        
    }
    
    func workFromOnlineClicked(_ sender: Any) {
        self.workPlaceStr = "1"
        if(isWorkOnlineClicked){
            
            isWorkOnlineClicked = false
        }else{
            isWorkOnlineClicked = true
            isWorkBranchClicked = false
            isBranchLocationAvailable = false
        }
        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 6)], with: .none)
        
    }
    
    func workFromBranchClicked(_ sender: Any) {
        self.workPlaceStr = "2"
        if(isWorkBranchClicked)
        {
            isWorkBranchClicked = false
        }else{
            isWorkBranchClicked = true
            isWorkOnlineClicked = false
        }
        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 6)], with: .none)
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
                    
                    self.selectedBranchCity = pm.locality ?? ""
                    self.selectedBranchCountryCode = pm.isoCountryCode ?? ""
                }
        })
        
    }
    
    func dataEntryNewFromApi() {
        
        ModalClass.startLoading(self.view)
        dataEntryApiMnagagerModal.addDataEntryForm(serviceID: self.serviceID) { (success,response) in
            ModalClass.stopLoading()
            if success{
                if let value = response?.object(forKey: "error_description") as? String{
                    ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                }
                                
                self.delegate?.refreshServiceListing()
                       self.navigationController?.popViewController(animated: true)
               
            }else{
                if let value = response?.object(forKey: "error_description") as? String{
                    ModalController.showNegativeCustomAlertWith(title: "", msg: value)
                }
            }
        }
    }
    
    func popUpYesClicked(_ sender: Any, fromWhere:String){
        
       self.dataEntryNewFromApi()
    }
    
    func popUpNoClicked(_ sender: Any){
        
    }
}

extension DataEntryFormViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 110
            }else{
                return 40
            }
        } else if indexPath.section == 1 {
            
            if  serviceDetailData?.data?.data_entry_lines?.count ?? 0 > 0 {
               return 50
            }else{
                return 0
            }
        }else if indexPath.section == 2 {
            return 90
        }else if indexPath.section == 3 {
            return 131
        }else if indexPath.section == 4 {
            return 210
        }else  {
            if isBranchLocationAvailable == true {
                return 323
            }else{
                return 160
            }
        }
    }
}
//should choose someone who choose as you.
extension DataEntryFormViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else if section == 1 {

            return serviceDetailData?.data?.data_entry_lines?.count ?? 0

        } else if section == 2 {
            return 1
        }else if section == 3 {
            return 1
        }else if section == 4 {
            return 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return dataEntryFirstTopCell(index: indexPath)
            }else{
                return dataEntryTopCell(index: indexPath)
            }
        }else if indexPath.section == 1 {
            return dataEntryEnterItemCell(index: indexPath)
            
        }else if indexPath.section == 2 {
            return dataEntryPriceCell(index: indexPath)
            
        }else if indexPath.section == 3 {
            return dataEntryRequiredDateCell(index: indexPath)
            
        }else if indexPath.section == 4 {
            return dataEntryOrderInstructionCell(index: indexPath)
            
        } else{
            return dataEntryWorkPlaceCell(index: indexPath)
        }
    }
    
    func dataEntryFirstTopCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryFormFirstTopTableViewCell", for: index) as! DataEntryFormFirstTopTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    func dataEntryTopCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryFromTopTableViewCell", for: index) as! DataEntryFromTopTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func dataEntryEnterItemCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryItemEntryTableViewCell", for: index) as! DataEntryItemEntryTableViewCell
        cell.selectionStyle = .none
       
        cell.itemNameTxtFld.isUserInteractionEnabled = false
        cell.quantityTxtFld.isUserInteractionEnabled = false
        cell.quantityTxtFld.textAlignment = .center
        
        
        cell.itemNameTxtFld.text = serviceDetailData?.data?.data_entry_lines?[index.row].des_name
        cell.quantityTxtFld.text = ModalController.toString(serviceDetailData?.data?.data_entry_lines?[index.row].des_type_count as Any)
        

        return cell
    }
    
    
    func dataEntryPriceCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryPricePayTableViewCell", for: index) as! DataEntryPricePayTableViewCell
        cell.selectionStyle = .none
         cell.priceTxtFld.isUserInteractionEnabled = false
        cell.priceTxtFld.text = ModalController.toString(serviceDetailData?.data?.service_price as Any)
        
        
       
        return cell
    }
    
    func dataEntryRequiredDateCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryFormDayTableViewCell", for: index) as! DataEntryFormDayTableViewCell
        cell.selectionStyle = .none
         cell.timeTxtFld.isUserInteractionEnabled = false
        cell.timeTxtFld.text = ModalController.toString(serviceDetailData?.data?.completion_days as Any)
        
        
        return cell
    }
    
    func dataEntryOrderInstructionCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryFromOrderInstractionTableViewCell", for: index) as! DataEntryFromOrderInstractionTableViewCell
        cell.selectionStyle = .none
        cell.instructionTxtView.isUserInteractionEnabled = false
        cell.instructionTxtView.text = serviceDetailData?.data?.instruction

       
        return cell
    }
    
    func dataEntryWorkPlaceCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryFormWorkPlaceTableViewCell", for: index) as! DataEntryFormWorkPlaceTableViewCell
        cell.selectionStyle = .none
        cell.branchSearchView.isHidden = true
        cell.mapViewHeightConstant.constant = 0
         cell.onlineViewHeightConstant.constant = 0
        
        cell.onlineBtn.isUserInteractionEnabled = false
        cell.branchBtn.isUserInteractionEnabled = false
        cell.branchSearchTxtFld.isUserInteractionEnabled = false
        
        
        if isWorkBranchClicked {
            cell.branchBtn.isSelected = true
            cell.branchSearchView.isHidden = false
            
        }else{
            cell.branchBtn.isSelected = false
            cell.branchSearchView.isHidden = true
            
        }
        
        if isWorkOnlineClicked {
            cell.onlineBtn.isSelected = true
            
        }else{
            cell.onlineBtn.isSelected = false
        }
        
        
        if isForDetail != "" {
            
            if isWorkBranchClicked {
                cell.branchBtn.isSelected = true
                cell.branchSearchView.isHidden = false
                
            }else{
                cell.branchBtn.isSelected = false
                cell.branchSearchView.isHidden = true
                
            }
            
            if isWorkOnlineClicked {
                cell.onlineBtn.isSelected = true
                
            }else{
                cell.onlineBtn.isSelected = false
            }
            
            cell.branchSearchTxtFld.text = ModalController.toString(self.serviceDetailData?.data?.branch_name as Any)
            
        }
        
        if self.serviceDetailData?.data?.work_place == 1 {
                cell.onlineBtn.isSelected = true
                cell.branchBtn.isSelected = false
                cell.mapViewHeightConstant.constant = 0
                cell.branchMapView.isHidden = true
                cell.branchView.isHidden = true
                cell.onlineViewHeightConstant.constant = 25
                
            } else if self.serviceDetailData?.data?.work_place == 2 {
                cell.branchSearchTxtFld.text = ModalController.toString(self.serviceDetailData?.data?.branch_name as Any)
                
                
                cell.onlineBtn.isSelected = false
                cell.onlineViewHeightConstant.constant = 0
                cell.onlineView.isHidden = true
                
                cell.branchBtn.isSelected = true
                cell.branchView.isHidden = false
                cell.branchMapView.isHidden = false
                cell.branchSearchView.isHidden = false
                                
            }
        
        
        
        if isBranchLocationAvailable == true {
            cell.mapViewHeightConstant.constant = 163
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
            
            cell.branchMapView.camera = camera
            marker.title = "Sydney"
            marker.snippet = "Australia"
            cell.branchMapView.setMinZoom(10, maxZoom: 15)
            marker.map = cell.branchMapView
            
            
        }else{
            cell.mapViewHeightConstant.constant = 0
        }
        
        
        cell.delegate = self
        cell.tag = index.row
        return cell
    }
    
}


extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
