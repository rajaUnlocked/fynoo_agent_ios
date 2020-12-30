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

class DataEntryFormViewController: UIViewController, DataEntryFormItemPopUpViewControllerDelegate, UITextFieldDelegate,UITextViewDelegate, DataEntryFormWorkPlaceTableViewCellDelegate,SearchCategoryViewControllerDelegate {
    
    func selectedCategoryMethod(countryDict: NSMutableDictionary, tag: Int) {
    }
    func selectedCityMethod(cityDict: NSMutableDictionary) {
    }
    func selectedEducationMethod(educationDict: NSMutableDictionary) {
    }
    func selectedMajorEducationMethod(educationDict: NSMutableDictionary) {
    }
    func selectedCurrency(currency: NSMutableDictionary) {
    }
    func selectedBankMethod(bankDict: NSMutableDictionary) {
    }
    func selectetCourierCompanyMethod(courierCompanyDict: NSMutableDictionary) {
    }
    func selectedCountryCodeMethod(mobileCodeDict : NSMutableDictionary){
    }
    func selectPhoneCodeMethod(phoneCodeDict : NSMutableDictionary){
    }
    
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
        
        if isForDetail != "" {
            self.getServiceDetailAPI()
            
            if  isForDetail == "waitingList" {
                self.placeOrderBtn.isUserInteractionEnabled = false
                self.placeOrderBtn.setTitle("Order Placed", for: .normal)
                self.placeOrderBtn.backgroundColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6039215686, alpha: 1)
                
            }else if isForDetail == "Cancelled" {
                self.placeOrderBtn.isUserInteractionEnabled = true
                self.placeOrderBtn.setTitle("Place Order Again", for: .normal)
                self.placeOrderBtn.backgroundColor = #colorLiteral(red: 0.3254901961, green: 0.7058823529, blue: 0.4901960784, alpha: 1)
            }
        }else{
            self.placeOrderBtn.isUserInteractionEnabled = true
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
                
                
                for var i in (0..<(self.serviceDetailData?.data?.data_entry_lines?.count ?? 0)) {
                    let typeName = ModalController.toString (self.serviceDetailData?.data?.data_entry_lines?[i].type_name as AnyObject)
                    self.selectedFormTypeArray.append("\(typeName)")
                    let enterItem = ModalController.toString (self.serviceDetailData?.data?.data_entry_lines?[i].des_name as AnyObject)
                    self.enterItemArray.append("\(enterItem)")
                    let enterQuantity = ModalController.toString (self.serviceDetailData?.data?.data_entry_lines?[i].des_type_count as AnyObject)
                    self.enterQuantityArray.append("\(enterQuantity)")
                    let typeID = ModalController.toString (self.serviceDetailData?.data?.data_entry_lines?[i].des_id as AnyObject)
                    self.enterItemDescTypeIDArray.append("\(typeID)")
                    
                }
                
                self.dataEntryPrice = ModalController.toString(self.serviceDetailData?.data?.service_price as Any)
                self.dataEntryTimePeriod = ModalController.toString(self.serviceDetailData?.data?.completion_days as Any)
                self.dataEntryOrderInstruction = ModalController.toString(self.serviceDetailData?.data?.instruction as Any)
                self.selectedBranchName = ModalController.toString(self.serviceDetailData?.data?.branch_name as Any)
                
                print("selectedItem:-", self.selectedFormTypeArray)
                print("enterItemArray:-", self.enterItemArray)
                print("enterQuantityArray:-", self.enterQuantityArray)
                print("enterItemDescTypeIDArray:-", self.enterItemDescTypeIDArray)
                
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
        self.dataEntryNewFromApi()
        
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
    @objc func DataEntryItemDelete(_ sender : UIButton) {
        print("senderTag:-", sender.tag)
        self.view.endEditing(true)
        
        if isForDetail != "" {
            if isForDetail == "Cancelled" {
                self.serviceDetailData?.data?.data_entry_lines?.remove(at: sender.tag)
                selectedFormTypeArray.remove(at: sender.tag)
                enterItemArray.remove(at: sender.tag)
                enterQuantityArray.remove(at: sender.tag)
                enterItemDescTypeIDArray.remove(at: sender.tag)
            }
        }else{
            
            selectedFormTypeArray.remove(at: sender.tag)
            enterItemArray.remove(at: sender.tag)
            enterQuantityArray.remove(at: sender.tag)
            enterItemDescTypeIDArray.remove(at: sender.tag)
        }
        print("selectedItem:-", selectedFormTypeArray)
        print("enterItemArray:-", enterItemArray)
        print("enterQuantityArray:-", enterQuantityArray)
        print("enterItemDescTypeIDArray:-", enterItemDescTypeIDArray)
        
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
    
    func branchSearchClicked(_ sender: Any) {
        let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
        vc.delegate = self
        vc.isFromBranchSearch = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func selectetBranchMethod(BranchDict: NSMutableDictionary) {
        
        self.branchNameDict = BranchDict
        
        if self.branchNameDict.count > 0 {
            self.selectedBranchName = "\(self.branchNameDict.object(forKey: "branch_name") as! String)"
            self.selectedBranchID = ModalController.toString(self.branchNameDict.object(forKey: "id") as Any) 
            self.BranchLat = ModalController.convertInToDouble(str: self.branchNameDict.object(forKey: "lat") as AnyObject)
            self.BranchLong = ModalController.convertInToDouble(str: self.branchNameDict.object(forKey: "long") as AnyObject)
            
            if self.BranchLat != 0.0 {
                
                self.getAddressFromLatLon(pdblLatitude: ModalController.convertInString(str: self.BranchLat as AnyObject), withLongitude: ModalController.convertInString(str: self.BranchLong as AnyObject))
                
                
                self.isBranchLocationAvailable = true
            }else{
                self.isBranchLocationAvailable = false
            }
        }else{
            self.isBranchLocationAvailable = false
        }
        
        print("branchDict:-", self.branchNameDict)
        self.tableView.reloadData()
        
    }
    
    func cancelBranchClicked(_ sender: Any) {
        let   cell = tableView.cellForRow(at: IndexPath(row:0 , section: 6)) as! DataEntryFormWorkPlaceTableViewCell
        cell.branchSearchTxtFld.text = ""
        self.selectedBranchName = ""
        self.BranchLat = 0.0
        self.BranchLong = 0.0
        self.isBranchLocationAvailable = false
        self.tableView.reloadData()
        
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
 
        
        if self.enterItemArray.count == 0 {
            
            ModalController.showNegativeCustomAlertWith(title: "Please add atleast one data entry.", msg: "")
            return
        } else if self.dataEntryPrice == ""  {
            ModalController.showNegativeCustomAlertWith(title: "Please enter data entry price.", msg: "")
            return
        }else if self.dataEntryTimePeriod == "" {
            ModalController.showNegativeCustomAlertWith(title: "Please enter data entry completion days.", msg: "")
            return
        }else if self.dataEntryOrderInstruction == "" || self.dataEntryOrderInstruction == "Please provide the instruction for your order." {
            ModalController.showNegativeCustomAlertWith(title: "Please enter data entry order instruction.", msg: "")
            return
        } else if self.workPlaceStr == "" {
            ModalController.showNegativeCustomAlertWith(title: "Please select any work place.", msg: "")
            return
        }else{
            self.placeOrderBtn.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
        }
        
        
        let lineItem = enterItemArray.joined(separator:",")
        let lineQuantity = enterQuantityArray.joined(separator:",")
        let lineDescId = enterItemDescTypeIDArray.joined(separator:",")
        
        
        ModalClass.startLoading(self.view)
        dataEntryApiMnagagerModal.addDataEntryForm(lineItemName: lineItem, lineItemQuantity: lineQuantity, lineItemTypeID: lineDescId, servicePrice: self.dataEntryPrice.trimmingCharacters(in: .whitespacesAndNewlines), totalDays: self.dataEntryTimePeriod.trimmingCharacters(in: .whitespacesAndNewlines), InstructionStr: self.dataEntryOrderInstruction.trimmingCharacters(in: .whitespacesAndNewlines), workPlaceStr: self.workPlaceStr, branchID: self.selectedBranchID, CityNameStr: self.selectedBranchCity, CountryCodeStr: self.selectedBranchCountryCode) { (success,response) in
            ModalClass.stopLoading()
            if success{
//                if let value = response?.object(forKey: "error_description") as? String{
//                    ModalController.showSuccessCustomAlertWith(title: "", msg: value)
//                }
                
                let payAmount = (response?.object(forKey: "data") as! NSDictionary).object(forKey: "amount_to_pay") as? String
                let entryId = (response?.object(forKey: "data") as! NSDictionary).object(forKey: "entry_id") as? Int
                
//
//                let vc = DataEntryFormPaymentOverviewViewController()
//                vc.amountPay = ModalController.toString(payAmount as Any)
//                vc.entryID = ModalController.toString(entryId as Any)
//                self.navigationController?.pushViewController(vc, animated: true)
//
            }else{
//                if let value = response?.object(forKey: "error_description") as? String{
//                    ModalController.showNegativeCustomAlertWith(title: "", msg: value)
//                }
            }
        }
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
            
            if isForDetail != "" && (serviceDetailData?.data?.data_entry_lines?.count ?? 0 > 0) {
               return 50
            }else{
            if selectedFormTypeArray.count > 0 {
                return 50
            }else{
                return 0
            }
            }
        }else if indexPath.section == 2 {
            return 60
        }else if indexPath.section == 3 {
            return 90
        }else if indexPath.section == 4 {
            return 131
        }else if indexPath.section == 5 {
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
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else if section == 1 {
//            if isForDetail != "" {
//                return self.serviceDetailData?.data?.data_entry_lines?.count ?? 0
//            }else{
                 return selectedFormTypeArray.count
//            }
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
            if indexPath.row == 0 {
                return dataEntryFirstTopCell(index: indexPath)
            }else{
                return dataEntryTopCell(index: indexPath)
            }
        }else if indexPath.section == 1 {
            return dataEntryEnterItemCell(index: indexPath)
            
        }else if indexPath.section == 2 {
            return dataEntryAddItemCell(index: indexPath)
            
        }else if indexPath.section == 3 {
            return dataEntryPriceCell(index: indexPath)
            
        }else if indexPath.section == 4 {
            return dataEntryRequiredDateCell(index: indexPath)
            
        }else if indexPath.section == 5 {
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
        cell.deleteItemBtn.tag = index.row
        cell.deleteItemBtn.addTarget(self, action: #selector(DataEntryItemDelete(_:)), for: .touchUpInside)
        
        cell.itemNameTxtFld.delegate = self
        cell.quantityTxtFld.delegate = self
        
        cell.itemNameTxtFld.addTarget(self, action: #selector(DataEntryFormViewController.textFieldDidChange(_:)), for:
            UIControl.Event.editingChanged)
        
        cell.quantityTxtFld.addTarget(self, action: #selector(DataEntryFormViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        cell.itemNameTxtFld.text = enterItemArray[index.row]
        cell.quantityTxtFld.text = enterQuantityArray[index.row]
        
        let itemType = selectedFormTypeArray[index.row]
        
        if itemType == "Product".localized {
            cell.itemTypeImgeView.image = UIImage(named: "manageProduct_new")
            
        }else if itemType == "Branch".localized {
            cell.itemTypeImgeView.image = UIImage(named: "branch_single_new")
        }
        
        if isForDetail != "" {
            if cell.itemNameTxtFld.text == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.entryItemView)
            }else {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.entryItemView)
            }
            
            if cell.quantityTxtFld.text == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.quantityView)
            }else {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.quantityView)
            }
            
            if  isForDetail == "waitingList" {
                cell.itemNameTxtFld.isUserInteractionEnabled = false
                cell.quantityTxtFld.isUserInteractionEnabled = false
                cell.deleteItemBtn.isUserInteractionEnabled = false
            }else{
                cell.itemNameTxtFld.isUserInteractionEnabled = true
                cell.quantityTxtFld.isUserInteractionEnabled = true
                cell.deleteItemBtn.isUserInteractionEnabled = true
            }
        }else{
            cell.itemNameTxtFld.isUserInteractionEnabled = true
            cell.quantityTxtFld.isUserInteractionEnabled = true
            
        }
        
        
        cell.itemNameTxtFld.accessibilityHint = "Item"
        cell.quantityTxtFld.accessibilityHint = "Quantity"
        
        cell.itemNameTxtFld.tag = index.row
        cell.quantityTxtFld.tag = index.row
        return cell
    }
    
    func dataEntryAddItemCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryFormAddItemTableViewCell", for: index) as! DataEntryFormAddItemTableViewCell
        cell.selectionStyle = .none
        cell.addEntryItemBtn.addTarget(self, action: #selector(DataEntryItemAdded(_:)), for: .touchUpInside)
        
        if isForDetail != "" {
           if isForDetail == "waitingList"  {
            cell.addEntryItemBtn.isUserInteractionEnabled = false
        }else {
            cell.addEntryItemBtn.isUserInteractionEnabled = true
        }
        }else{
            cell.addEntryItemBtn.isUserInteractionEnabled = true
        }
        
        return cell
    }
    
    func dataEntryPriceCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryPricePayTableViewCell", for: index) as! DataEntryPricePayTableViewCell
        cell.selectionStyle = .none
        
        cell.priceTxtFld.addTarget(self, action: #selector(DataEntryFormViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        if isForDetail != "" {
            ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.priceView)
            if  isForDetail == "waitingList" {
                cell.priceTxtFld.isUserInteractionEnabled = false
            }else{
                cell.priceTxtFld.isUserInteractionEnabled = true
            }
            cell.priceTxtFld.text = self.dataEntryPrice
        }
        
        cell.priceTxtFld.accessibilityHint = "Price"
        return cell
    }
    
    func dataEntryRequiredDateCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryFormDayTableViewCell", for: index) as! DataEntryFormDayTableViewCell
        cell.selectionStyle = .none
        
        cell.timeTxtFld.addTarget(self, action: #selector(DataEntryFormViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        if isForDetail != "" {
             ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.timeView)
            if  isForDetail == "waitingList" {
                cell.timeTxtFld.isUserInteractionEnabled = false
            }else{
                cell.timeTxtFld.isUserInteractionEnabled = true
            }
             cell.timeTxtFld.text = self.dataEntryTimePeriod
        }
        
        
        cell.timeTxtFld.accessibilityHint = "Time"
        return cell
    }
    
    func dataEntryOrderInstructionCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryFromOrderInstractionTableViewCell", for: index) as! DataEntryFromOrderInstractionTableViewCell
        cell.selectionStyle = .none
        ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.instructionView)
        
        cell.instructionTxtView.delegate = self
        cell.instructionTxtView.text = "Please provide the instruction for your order."
        //        self.dataEntryOrderInstruction = "Please provide the instruction for your order."
        cell.instructionTxtView.accessibilityHint = "Instruction"
        
        if isForDetail != "" {
            if cell.instructionTxtView.text != "" {
             ModalController.setViewBorderColor(color:#colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.instructionView)
            }else{
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.instructionView)
            }
            if  isForDetail == "waitingList" {
                cell.instructionTxtView.isUserInteractionEnabled = false
            }else{
                cell.instructionTxtView.isUserInteractionEnabled = true
            }
            cell.instructionTxtView.text = self.dataEntryOrderInstruction
            
        }
        
        return cell
    }
    
    func dataEntryWorkPlaceCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryFormWorkPlaceTableViewCell", for: index) as! DataEntryFormWorkPlaceTableViewCell
        cell.selectionStyle = .none
        cell.branchSearchView.isHidden = true
        cell.branchSearchTxtFld.accessibilityHint = "BranchName"
        cell.mapViewHeightConstant.constant = 0
        cell.branchSearchTxtFld.addTarget(self, action: #selector(DataEntryFormViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
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
              
              cell.branchSearchTxtFld.text = self.selectedBranchName
              
              if cell.branchSearchTxtFld.text == "" {
                  ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.branchSearchView)
              }else{
                  ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.branchSearchView)
              }
              
 
              
        
        if isForDetail != "" {
            
            if  isForDetail == "waitingList" {
                cell.onlineBtn.isUserInteractionEnabled = false
                cell.branchBtn.isUserInteractionEnabled = false
                cell.crossBtn.isUserInteractionEnabled = false
                cell.searchBtn.isUserInteractionEnabled = false
                cell.branchSearchTxtFld.isUserInteractionEnabled = false
                
                
            }else{
                cell.onlineBtn.isUserInteractionEnabled = true
                cell.branchBtn.isUserInteractionEnabled = true
                cell.crossBtn.isUserInteractionEnabled = true
                cell.searchBtn.isUserInteractionEnabled = true
                cell.branchSearchTxtFld.isUserInteractionEnabled = true
            }
            
//            if self.serviceDetailData?.data?.work_place == 1 {
//                cell.onlineBtn.isSelected = true
//                cell.branchBtn.isSelected = false
//                cell.mapViewHeightConstant.constant = 0
//                cell.branchMapView.isHidden = true
//                cell.onlineViewHeightConstant.constant = 25
//                
//            } else if self.serviceDetailData?.data?.work_place == 2 {
//                cell.branchSearchTxtFld.text = ModalController.toString(self.serviceDetailData?.data?.branch_name as Any)
//                if cell.branchSearchTxtFld.text == "" {
//                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.branchSearchView)
//                }else{
//                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.branchSearchView)
//                }
//                
//                cell.onlineBtn.isSelected = false
//                cell.onlineViewHeightConstant.constant = 25
//                
//                cell.branchBtn.isSelected = true
//                cell.branchView.isHidden = false
//                cell.branchMapView.isHidden = false
//                cell.branchSearchView.isHidden = false
//                                
//            }
            
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
                   
                   cell.branchSearchTxtFld.text = self.selectedBranchName
                   
                   if cell.branchSearchTxtFld.text == "" {
                       ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.branchSearchView)
                   }else{
                       ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.branchSearchView)
                   }
            
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
    
    
    // MARK:- textViewDelegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if (textView.text == "Please provide the instruction for your order.") {
            textView.text = ""
        }
        textView.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return true
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let   cell = tableView.cellForRow(at: IndexPath(row:0 , section: 5)) as! DataEntryFromOrderInstractionTableViewCell
        
        cell.instructionTxtView.text = textView.text!
        if textView.text.count == 0 {
            textView.textColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
            textView.text = "Please provide the instruction for your order."
            self.dataEntryOrderInstruction = "Please provide the instruction for your order."
            
            
                if  isForDetail == "Cancelled" {
                    self.serviceDetailData?.data?.instruction = ""
                    
                }
            
            
            textView.resignFirstResponder()
        }
        
        if textView.accessibilityHint == "Instruction" {
            self.dataEntryOrderInstruction = textView.text!
            if cell.instructionTxtView.text == "" || cell.instructionTxtView.text == "Please provide the instruction for your order." {
                
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.instructionView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.instructionView)
            }
            
        }
        
    }
    
    // MARK:- textFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if  textField.accessibilityHint == "Item" {
            
            var letters = string.map { String($0) }
            for i in 0..<string.count{
                
                if !letters[i].containArabicNumber {
                    ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validName)
                    letters[i] = ""
                    return false
                }
            }
            return true
            
        }else {
            
        }
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if  textField.accessibilityHint == "Item" {
            enterItemArray[textField.tag] = textField.text ?? "".trimmingCharacters(in: .whitespacesAndNewlines)
        }else if textField.accessibilityHint == "Quantity"{
            enterQuantityArray[textField.tag] = textField.text ?? "".trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        print("tag:-", textField.tag)
        
        if  textField.accessibilityHint == "Item" {
            let   cell = tableView.cellForRow(at: IndexPath(row:textField.tag , section: 1)) as! DataEntryItemEntryTableViewCell
            if ModalController.isValidName(title: cell.itemNameTxtFld.text!) == false {
                
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.entryItemView)
            }else{
                if cell.itemNameTxtFld.text == "" {
                    ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.entryItemView)
                }else{
                    ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.entryItemView)
                }
            }
            
        }else if textField.accessibilityHint == "Quantity"{
            let   cell = tableView.cellForRow(at: IndexPath(row:textField.tag , section: 1)) as! DataEntryItemEntryTableViewCell
            if cell.quantityTxtFld.text == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.quantityView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.quantityView)
            }
            
        }else if textField.accessibilityHint == "Price" {
            let   cell1 = tableView.cellForRow(at: IndexPath(row:0 , section: 3)) as! DataEntryPricePayTableViewCell
            self.dataEntryPrice = textField.text!
            if cell1.priceTxtFld.text == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell1.priceView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell1.priceView)
            }
            
        }else if textField.accessibilityHint == "Time" {
            let   cell2 = tableView.cellForRow(at: IndexPath(row:0 , section: 4)) as! DataEntryFormDayTableViewCell
            self.dataEntryTimePeriod = textField.text!
            if cell2.timeTxtFld.text == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell2.timeView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell2.timeView)
            }
//            cell.branchSearchTxtFld.accessibilityHint = "BranchName"
        }else if textField.accessibilityHint == "BranchName" {
            let   cell = tableView.cellForRow(at: IndexPath(row:0 , section: 6)) as! DataEntryFormWorkPlaceTableViewCell
//            self.dataEntryOrderInstruction = textField.text!
            if cell.branchSearchTxtFld.text == "" {
                ModalController.setViewBorderColor(color:#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), view: cell.branchSearchView)
            }else{
                ModalController.setViewBorderColor(color: #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1), view: cell.branchSearchView)
            }
            
            if  isForDetail == "Cancelled" {
                self.serviceDetailData?.data?.branch_name = ""
                
            }
        }
        
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
