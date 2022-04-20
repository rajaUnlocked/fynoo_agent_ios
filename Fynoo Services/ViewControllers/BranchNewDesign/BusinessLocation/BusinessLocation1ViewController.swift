//
//  BusinessLocation1ViewController.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 08/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import GoogleMaps
import PopupDialog
class BusinessLocation1ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GMSMapViewDelegate,BusinessLocationSearch2TableViewCellDelegate,UITextViewDelegate,UITextFieldDelegate {
    func checkBox(tag: Int) {
        print("hhhh")
    }
    
    
    @IBOutlet weak var topHeightConstraints: NSLayoutConstraint!
    var detaillength = 0
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var tabView: UITableView!
    @IBOutlet weak var headerLbl: UILabel!
    var Forgot_Password: ForgotPassword?
    var fynoo_ID: String?
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var headerVw: NavigationView!
    var AdressTypeList: AddressTypeList?
    var radiocheck = 0
    var mall_id = ""
    var lat = 0.0
    var longi = 0.0
    var city = ""
    var country = ""
    var zipcode = ""
    var mall_market_name = ""
    var details  = ""
    var add = ""
    var charCount = 0
    var placeHolderAr = ["","Add Select Market","Add Select Mall"]
    var nameAr = ["Store on Road","Store in Market","Store in Mall"]
    let fontNameLight = NSLocalizedString("LightFontName", comment: "")
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        self.topHeightConstraints.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        AddressList_API()
        headerVw.titleHeader.text = "Welcome, Let's Select Your Location".localized
        
        headerVw.viewControl = self
        tabView.delegate = self
        tabView.dataSource = self
        tabView.register(UINib(nibName: "purchasedHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "purchasedHeaderTableViewCell")
        tabView.register(UINib(nibName: "spacingTableViewCell", bundle: nil), forCellReuseIdentifier: "spacingTableViewCell")
        tabView.register(UINib(nibName: "HeaderBranchTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderBranchTableViewCell")
        tabView.register(UINib(nibName: "BusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessTableViewCell")
        tabView.register(UINib(nibName: "nextTableViewCell", bundle: nil), forCellReuseIdentifier: "nextTableViewCell")
        tabView.register(UINib(nibName: "BusinessLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessLocationTableViewCell")
        tabView.register(UINib(nibName: "MapViewTableViewCell", bundle: nil), forCellReuseIdentifier: "MapViewTableViewCell")
        tabView.register(UINib(nibName: "BusinessLocationSearch2TableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessLocationSearch2TableViewCell")
        tabView.register(UINib(nibName: "LocationDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationDetailsTableViewCell")
        tabView.register(UINib(nibName: "CountingTableViewCell", bundle: nil), forCellReuseIdentifier: "CountingTableViewCell")
        //         bgImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        self.tabView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        
        tabView.separatorStyle = .none
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 3
        }
        else if section == 1{
            return 5
        }
        else
        {
            return 4
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if indexPath.row == 0{
                let cell = tabView.dequeueReusableCell(withIdentifier: "purchasedHeaderTableViewCell", for: indexPath) as! purchasedHeaderTableViewCell
                cell.contentView.backgroundColor = UIColor.clear
                cell.leftLbl.text = "Add Your Business Location".localized
                
                cell.leftLbl.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
                cell.leftLbl.font = UIFont(name: "\(fontNameLight)", size: 16.0)
                cell.bottomLbl.isHidden = true
                cell.rightLbl.isHidden = true
                cell.selectionStyle = .none
                
                return cell
            }
            else if indexPath.row == 1{
                let cell = tabView.dequeueReusableCell(withIdentifier: "spacingTableViewCell", for: indexPath) as! spacingTableViewCell
                cell.selectionStyle = .none
                
                return cell
            }
            else{
                let cell = tabView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as! HeaderBranchTableViewCell
                cell.rightarrow.isHidden = true
                if AddBranch.shared.location.count > 0 &&  radiocheck != 0
                {
                    cell.btn.setImage(UIImage(named: "loc_green"), for: .normal)
                }
                else
                {
                    cell.btn.setImage(UIImage(named: "loc"), for: .normal)
                }
                
                
                cell.lbl.text = "LocationB".localized
                cell.cornerRadius = 6
                cell.lbl.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
                cell.lbl.font = UIFont(name: "\(fontNameLight)", size: 12.0)
                cell.leadingConstant.constant = 0
                cell.trailingConstant.constant = 0
                cell.selectionStyle = .none
                cell.btn.clipsToBounds = true
                cell.btnWidth.constant = 22
                cell.btnHeight.constant = 22
                return cell
            }
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0{
                let cell = tabView.dequeueReusableCell(withIdentifier: "BusinessLocationTableViewCell", for: indexPath) as! BusinessLocationTableViewCell
                if AddBranch.shared.location.count > 0
                {
                    if !AddBranch.shared.location.containArabicNumber
                    {
                        cell.borderVw.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                    }
                    else
                    {
                        cell.borderVw.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                    }
                }
                else
                {
                    cell.borderVw.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor                }
                
                cell.txtField.text = AddBranch.shared.location
                cell.txtField.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
                cell.selectionStyle = .none
                cell.delegate = self
                return cell
            }
            
            else if indexPath.row == 1{
                let cell = tabView.dequeueReusableCell(withIdentifier: "MapViewTableViewCell", for: indexPath) as! MapViewTableViewCell
                cell.mapView.clear()
                let marker = GMSMarker()
                
                let camera = GMSCameraPosition.camera(withLatitude: AddBranch.shared.lat, longitude: AddBranch.shared.long, zoom: 17.0)
                cell.mapView.camera = camera
                marker.position = CLLocationCoordinate2DMake(AddBranch.shared.lat,AddBranch.shared.long)
                marker.map = cell.mapView
                cell.mapView.isUserInteractionEnabled = false
                cell.mapView.delegate = self
                return cell
            }
            else {
                let cell = tabView.dequeueReusableCell(withIdentifier: "BusinessLocationSearch2TableViewCell", for: indexPath) as! BusinessLocationSearch2TableViewCell
                
                
                if indexPath.row == radiocheck
                {
                    if radiocheck == 2 {
                        cell.txtField.isHidden = true
                        cell.checkBox.isSelected = true
                        
                    }
                    else{
                        cell.txtField.text = "\(AddBranch.shared.BusName)"
                        if radiocheck == 4
                        {
                            cell.txtField.isHidden = false
                            cell.checkBox.isSelected = true
                            if cell.txtField.text!.count > 1
                            {
                                cell.txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                            }
                            else
                            {
                                cell.txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                            }
                            cell.checkBox.isSelected = true
                            cell.txtField.isHidden = false
                            cell.txtField.placeholder = "  Select/ Add Mall name"
                        }
                        if radiocheck == 3
                        {
                            cell.txtField.isHidden = false
                            cell.checkBox.isSelected = true
                            cell.txtField.placeholder = "  Select/ Add Market name"
                            if cell.txtField.text!.count > 1
                            {
                                cell.txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                            }
                            else
                            {
                                cell.txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                            }
                        }
                        
                        
                    }
                }
                else
                {
                    cell.checkBox.isSelected = false
                    cell.txtField.isHidden = true
                }
                
                cell.txtField.addTarget(self, action: #selector(BusinessLocation1ViewController.textFieldDidBeginEditing(_:)), for: UIControl.Event.editingDidBegin)
                cell.lbl.text = nameAr[indexPath.row - 2].localized
                cell.selectionStyle = .none
                
                return cell
            }
        }
        else{
            if indexPath.row == 0{
                let cell = tabView.dequeueReusableCell(withIdentifier: "LocationDetailsTableViewCell", for: indexPath) as! LocationDetailsTableViewCell
                cell.txtView.delegate = self
                cell.txtView.text = AddBranch.shared.locationdetails
                cell.txtView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                if radiocheck == 2
                {
                    if AddBranch.shared.locationdetails.count > 0
                    {
                        if !AddBranch.shared.locationdetails.containArabicNumber
                        {
                            cell.txtView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                        }
                        else
                        {
                            cell.txtView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                        }
                    }
                    else
                    {
                        cell.txtView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor                }
                }
                cell.selectionStyle = .none
                
                return cell
            }
            if indexPath.row == 1 {
                let cell = tabView.dequeueReusableCell(withIdentifier: "CountingTableViewCell", for: indexPath) as! CountingTableViewCell
                cell.trailConst.constant = 35
                cell.contentView.backgroundColor = UIColor.clear
                cell.counlbl.text = "\(AddBranch.shared.locationdetails.count)/\(detaillength)"
                return cell
            }
            if indexPath.row == 2 {
                let cell = tabView.dequeueReusableCell(withIdentifier: "spacingTableViewCell", for: indexPath) as! spacingTableViewCell
                cell.contentView.backgroundColor = UIColor.clear
                return cell
            }
            
            else{
                let cell = tabView.dequeueReusableCell(withIdentifier: "nextTableViewCell", for: indexPath) as! nextTableViewCell
                cell.savedraft.tag = indexPath.row - 3
                cell.savedraft.addTarget(self, action: #selector(cancelClick(_ :)), for: .touchUpInside)
                cell.nextbtn.tag = indexPath.row - 3
                cell.nextbtn.addTarget(self, action: #selector(saveClick(_ :)), for: .touchUpInside)
                
                
                return cell
                
            }
        }
        
        
    }
    
    
    
    
    @objc func cancelClick(_ tag:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func saveClick(_ tag:UIButton){
        print("save click")
        // other case scenario
        
        if AddBranch.shared.location == "" {
            ModalController.showNegativeCustomAlertWith(title: "Please add location".localized, msg: "")
            return
        }
        if radiocheck == 0
        {
            ModalController.showNegativeCustomAlertWith(title: "mall/ market name is mandatory", msg: "")
            return
        }
        if radiocheck == 3
        {
            if self.mall_market_name.count == 0
            {
                ModalController.showNegativeCustomAlertWith(title: "Select market".localized, msg: "")
                return
            }
        }
        if radiocheck == 4
        {
            if self.mall_market_name.count == 0
            {
                ModalController.showNegativeCustomAlertWith(title: "Select mall".localized, msg: "")
                return
            }
        }
        if radiocheck == 2 {
            let cell = tabView.cellForRow(at: IndexPath(row: 0, section: 2)) as! LocationDetailsTableViewCell
            AddBranch.shared.locationdetails = cell.txtView.text
            if AddBranch.shared.locationdetails == ""
            {
                ModalController.showNegativeCustomAlertWith(title: "Enter the location description".localized, msg: "")
                return
            }
            
            
        }
        
        //AddBranch.shared.locationdetails = details
        AddBranch.shared.isLocation = true
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            if indexPath.row == 0  {
                let vc = GetLocationViewController(nibName: "GetLocationViewController", bundle: nil)
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 1 {
                return
            }
            else {
                radiocheck = indexPath.row
                AddBranch.shared.addTypeId.removeAll()
                AddBranch.shared.BusName.removeAll()
                AddBranch.shared.locationdetails.removeAll()
                AddBranch.shared.BusId = 0
                if self.AdressTypeList?.address_type_list?.count ?? 0 > 0
                {
                    AddBranch.shared.addTypeId = "\(self.AdressTypeList?.address_type_list?[0].id ?? 0)"
                }
                
                
                tabView.reloadData()
                
            }
        }
        
        
        
        
    }
    
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if AddBranch.shared.location == "" {
            ModalController.showNegativeCustomAlertWith(title: "Please Search Location", msg: "")
            
            return
        }
        let vc = MallMarketPopupViewController(nibName: "MallMarketPopupViewController", bundle: nil)
        let branch = AddBranch.shared
        vc.mallId = AdressTypeList?.address_type_list?[radiocheck - 2].id
        vc.latitude = branch.lat
        vc.longitude = branch.long
        vc.delegate = self
        vc.radiocheck = self.radiocheck
        AddBranch.shared.addTypeId = "\(AdressTypeList?.address_type_list?[radiocheck - 2].id ?? 0)"
        let popup = PopupDialog(viewController: vc,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        present(popup, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 50
            }
            else if indexPath.row == 1 {
                return 40
            }
            else {
                return 50
            }
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                return 110
            }
            else if indexPath.row == 1{
                return 180
            }
            else {
                return 35
            }
        }
        else {
            if indexPath.row == 0{
                return 120
            }
            if indexPath.row == 1{
                return 20
            }
            if indexPath.row == 2{
                return 40
            }
            else {
                return 50
            }
        }
        
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if !text.containArabicNumber
        {
            return false
        }
        var textstr = ""
        if let text1 = textView.text as NSString? {
            let txtAfterUpdate = text1.replacingCharacters(in: range, with: text)
            textstr = txtAfterUpdate
        }
        
        if textstr.count > 100
        {
            return false
        }
        AddBranch.shared.locationdetails = textstr
        let cell = tabView.cellForRow(at: IndexPath(row: 0, section: 2)) as! LocationDetailsTableViewCell
        if radiocheck == 2
        {
            if AddBranch.shared.locationdetails.count > 0
            {
                if !AddBranch.shared.locationdetails.containArabicNumber
                {
                    cell.txtView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                }
                else
                {
                    cell.txtView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                }
            }
            else
            {
                cell.txtView.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor                }
        }
        tabView.reloadRows(at: [IndexPath(row: 1, section: 2)], with: .none)
        return true
    }
    
}
extension BusinessLocation1ViewController:GetLocationViewControllerDelegate
{
    func getlocations(City: String, Country: String, ZipCode: String, latitude: Double, longitude: Double, location: String) {
        let branch = AddBranch.shared
        branch.lat = latitude
        branch.long = longitude
        branch.City = City
        branch.Country = Country
        branch.ZipCode = ZipCode
        branch.location = location
        tabView.reloadData()
        
    }
    func AddressList_API(){
        
        let device_id = UIDevice.current.identifierForVendor!.uuidString
        
        let str = "\(Constant.BASE_URL)\(Constant.AddressType_List)"
        
        let parameters = [
            
            "device_id": "\(device_id)",
            
            "device_type": "ios",
            
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
            
        ]
        
        print("request -",parameters)
        
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            
            ModalClass.stopLoading()
            
            if success == true {
                
                self.AdressTypeList = try! JSONDecoder().decode(AddressTypeList.self, from: resp as! Data )
                
                if self.AdressTypeList!.error! {
                    ModalController.showNegativeCustomAlertWith(title:" Error", msg: "")
                    
                }
                
                else{
                    if self.AdressTypeList?.address_type_list?.count ?? 0 > 0
                    {
                        for i in 0...((self.AdressTypeList?.address_type_list?.count ?? 0) - 1)
                        {
                            if "\((self.AdressTypeList?.address_type_list?[i].id ?? 0))" == AddBranch.shared.addTypeId
                            {
                                self.radiocheck = i + 2
                                self.tabView.reloadData()
                            }
                        }
                    }
                    
                }
                
                
            }else{
                
                if response == nil
                    
                {
                    
                    print ("connection error")
                    
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                    
                }else{
                    
                    print ("data not in proper json")
                    
                }
                
            }
            
        }
        
    }
    
    
}
extension BusinessLocation1ViewController: savemallmarketDelegate,BusinessLocationTableViewCellDelegate{
    func otherAddress(Name: String, Address: String) {
        AddBranch.shared.BusName = Name
        AddBranch.shared.BusId = 0
        self.mall_market_name = AddBranch.shared.BusName
        tabView.reloadData()
    }
    
    func locationSearch(tag: Int) {
        let vc = GetLocationViewController(nibName: "GetLocationViewController", bundle: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func locationCancel(tag: Int) {
        print("Clear location and search enable")
        let cell = tabView.cellForRow(at: IndexPath(row: 0, section: 1)) as! BusinessLocationTableViewCell
        cell.txtField.text = ""
        
    }
    
    func addNew() {
        print("Other scenario")
        //
        //        mall_market_name =  AddBranch.shared.BusName
        //        AddBranch.shared.BusId = 0
        //        tabView.reloadData()
    }
    
    func save(type: NSMutableArray, id: Int) {
        if(type.count > 0)
        {
            self.mall_market_name = (type[0] as? String)!
            AddBranch.shared.BusId = id
            AddBranch.shared.BusName = (type[0] as? String)!
            self.mall_market_name = AddBranch.shared.BusName
        }
        else{
            ModalController.showSuccessCustomAlertWith(title: "Found No Mall/Market", msg: "")
        }
        tabView.reloadData()
    }
    
    
    
    
}
