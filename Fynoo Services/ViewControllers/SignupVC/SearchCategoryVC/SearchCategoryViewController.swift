//
//  SearchCategoryViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 29/05/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import Alamofire

protocol SearchCategoryViewControllerDelegate: class {
    func selectedCategoryMethod(countryDict : NSMutableDictionary,tag:Int)
    func selectedCityMethod(cityDict : NSMutableDictionary)
    func selectedEducationMethod(educationDict : NSMutableDictionary)
    func selectedMajorEducationMethod(educationDict : NSMutableDictionary)
    func selectedCurrency(currency : NSMutableDictionary)
    func selectedBankMethod(bankDict : NSMutableDictionary)
    func selectetCourierCompanyMethod(courierCompanyDict : NSMutableDictionary)
    func selectedCountryCodeMethod(mobileCodeDict : NSMutableDictionary)
    func selectPhoneCodeMethod(phoneCodeDict : NSMutableDictionary)
    func selectetBranchMethod(BranchDict : NSMutableDictionary)
}

class SearchCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var tag = 0
    @IBOutlet weak var customHeader: NavigationView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowVw: UIView!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableVw: UITableView!
    var countryListArray : NSMutableArray = NSMutableArray()
    var selectedCountryDict : NSMutableDictionary = NSMutableDictionary()
    var filterListArray : NSMutableArray = NSMutableArray()
    weak var delegate: SearchCategoryViewControllerDelegate?
    var isForCountry : Bool = false
    var isForCity : Bool = false
    var isForBankList : Bool = false
    var isForEducationList : Bool = false
    var isForMajorEducationList : Bool = false
    var currencyLists : Bool = false
    var isFromCourierCompany:Bool = false
    var isFromCountryMobileCode:Bool = false
    var isFromCountryPhoneCode:Bool = false
    var isFromBranchSearch:Bool = false
    
    var selectedOLDCountryDict : NSDictionary = NSDictionary()
    var selectedCountryID  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUiMethod()
        registerCellNibs()
        customHeader.viewControl = self
        if isForCountry {
            self.customHeader.titleHeader.text = "Select Country".localized
            self.searchField.placeholder = "Enter Country Name".localized
            countryAPI()
            
        }else if isForBankList {
            self.customHeader.titleHeader.text = "Select Bank"
            self.searchField.placeholder = "Enter Bank Name"
            bankListAPI()
            
        }else if isForCity {
            self.customHeader.titleHeader.text = "Select City".localized
            self.searchField.placeholder = "Enter City Name".localized
            cityAPI()
            
        }else if isForEducationList {
            self.customHeader.titleHeader.text = "Select Education".localized
            self.searchField.placeholder = "Search".localized
            EducationListAPI()
            
        }else if currencyLists {
            self.customHeader.titleHeader.text = "Select Currency"
            self.searchField.placeholder = "Enter Currency"
            bankListAPI()
        }
        else if isForMajorEducationList {
            self.customHeader.titleHeader.text = "Select Major".localized
            print("majorDict-", self.selectedOLDCountryDict)
            let array =  selectedOLDCountryDict.object(forKey: "list_value") as! NSArray
            self.countryListArray = NSMutableArray(array: array)
            self.tableVw.reloadData()
            
        }else if isFromCountryMobileCode {
            self.customHeader.titleHeader.text = "Select Country".localized
            self.searchField.placeholder = "Enter Country Name".localized
            
            countryAPI()
            
        }else if isFromCountryPhoneCode {
            self.customHeader.titleHeader.text = "Select Country".localized
            self.searchField.placeholder = "Enter Country Name".localized
            
            countryAPI()
            
        }else if isFromBranchSearch {
            self.customHeader.titleHeader.text = "Branch List"
             self.searchField.placeholder = "Search"
              branchNameListAPI()
        }
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        searchField.font = UIFont(name:"\(fontNameLight)",size:12)
        self.customHeader.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        searchField.textColor = Constant.Black_TEXT_COLOR
        self.customHeader.titleHeader.textColor = Constant.Black_TEXT_COLOR
        
        customHeader.viewControl = self
    }
    func setupUiMethod(){
        self.headerHeightMethod()
        searchField.addTarget(self, action: #selector(SearchCategoryViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        let yourColor : UIColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233.0/255.0, alpha: 1.0)
        searchVw.layer.masksToBounds = true
        searchVw.layer.borderColor = yourColor.cgColor
        searchVw.layer.borderWidth = 1.0
        searchVw.layer.cornerRadius = 5.0
        
        self.searchField.attributedPlaceholder = NSAttributedString(string: "Search".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126.0/255.0, green: 139.0/255.0, blue: 152.0/255.0, alpha: 1.0)])
        
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.navigationController?.isNavigationBarHidden = true
    }
    func headerHeightMethod(){
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            let myIntValue = Int(topPadding!)
            
            if myIntValue > 0{
                let glblHeight = HeaderHeightSingleton.shared
                glblHeight.headerHeight = 120
            }
            
        }
        if #available(iOS 12.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            let myIntValue = Int(topPadding!)
            
            if myIntValue > 0{
                if myIntValue == 44 || myIntValue == 47 || myIntValue == 48 {
                    let glblHeight = HeaderHeightSingleton.shared
                    glblHeight.headerHeight = 120
                }else{
                    let glblHeight = HeaderHeightSingleton.shared
                    glblHeight.headerHeight = 105
                }
            }
        }
        
    }
    func registerCellNibs(){
        tableVw.register(UINib(nibName: "SearchCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchCategoryTableViewCell");
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        if self.selectedCountryDict.count == 0 {
            ModalController.showNegativeCustomAlertWith(title: "Nothing selected", msg: "")
            return
        }
        self.navigationController?.popViewController(animated: true)
        if self.isForCountry{
            self.delegate?.selectedCategoryMethod(countryDict: self.selectedCountryDict,tag:self.tag)
            
        }else if self.isForBankList {
            self.delegate?.selectedBankMethod(bankDict: self.selectedCountryDict)
            
        } else if self.isForCity {
            self.delegate?.selectedCityMethod(cityDict: self.selectedCountryDict)
            
        }else if self.isForEducationList {
            self.delegate?.selectedEducationMethod(educationDict: self.selectedCountryDict)
        }
        else if self.isForMajorEducationList {
            self.delegate?.selectedMajorEducationMethod(educationDict: self.selectedCountryDict)
        }
        else if self.currencyLists {
            self.delegate?.selectedCurrency(currency: self.selectedCountryDict)
            
        } else if self.isFromCourierCompany {
            self.delegate?.selectetCourierCompanyMethod(courierCompanyDict: self.selectedCountryDict)
            
        } else if self.isFromCountryMobileCode {
            self.delegate?.selectedCountryCodeMethod(mobileCodeDict: self.selectedCountryDict)
            
        } else if self.isFromCountryPhoneCode {
            self.delegate?.selectPhoneCodeMethod(phoneCodeDict: self.selectedCountryDict)
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - TableView DataSource Delegates
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterListArray.count > 0 || searchField.text!.count > 0 {
            return self.filterListArray.count
        }else{
            return self.countryListArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return countryCell(index: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filterListArray.count > 0 || searchField.text!.count > 0 {
            selectedCountryDict = self.filterListArray.object(at: indexPath.row) as! NSMutableDictionary
        }else{
            selectedCountryDict = NSMutableDictionary(dictionary: self.countryListArray.object(at: indexPath.row) as! NSDictionary)
        }
        //    self.tableVw.reloadData()
        self.navigationController?.popViewController(animated: true)
        if self.isForCountry{
            self.delegate?.selectedCategoryMethod(countryDict: self.selectedCountryDict, tag: self.tag)
            
        }else if self.isForBankList {
            self.delegate?.selectedBankMethod(bankDict: self.selectedCountryDict)
            
        } else if self.isForCity {
            self.delegate?.selectedCityMethod(cityDict: self.selectedCountryDict)
            
        }else if self.isForEducationList {
            self.delegate?.selectedEducationMethod(educationDict: self.selectedCountryDict)
        }
        else if self.isForMajorEducationList {
            self.delegate?.selectedMajorEducationMethod(educationDict: self.selectedCountryDict)
            
        }else if self.currencyLists {
            self.delegate?.selectedCurrency(currency: self.selectedCountryDict)
            
        }else if self.isFromCourierCompany {
            self.delegate?.selectetCourierCompanyMethod(courierCompanyDict: self.selectedCountryDict)
            
        } else if self.isFromCountryMobileCode {
            self.delegate?.selectedCountryCodeMethod(mobileCodeDict: self.selectedCountryDict)
            
        } else if self.isFromCountryPhoneCode {
            self.delegate?.selectPhoneCodeMethod(phoneCodeDict: self.selectedCountryDict)
        }else if self.isFromBranchSearch {
            self.delegate?.selectetBranchMethod(BranchDict: self.selectedCountryDict)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    // MARK: - TableView Cells Return
    func countryCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "SearchCategoryTableViewCell",for: index) as! SearchCategoryTableViewCell
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        cell.catName.font = UIFont(name:"\(fontNameLight)",size:12)
        
        cell.selectionStyle = .none
        cell.countryFlagImageView.isHidden = true
        cell.countryFlgWidthConstant.constant = 0
        cell.countryCodeLbl.isHidden = true
        
              
        
        if filterListArray.count > 0 || searchField.text!.count > 0 {
            if isForCountry{
                cell.catName.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "country_name") as! String)"
                
            }else if isForBankList {
                cell.catName.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "bank_name") as! String)"
                
            }else if isForCity{
                cell.catName.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "city_name") as! String)"
                
            }else if isForEducationList{
                cell.catName.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "education_type") as! String)"
                
            }else if isForMajorEducationList{
                cell.catName.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "education_major") as! String)"
                
            }else if isFromCourierCompany{
                cell.catName.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "company_name") as! String)"
                
            } else if self.isFromCountryMobileCode || self.isFromCountryPhoneCode {
                
                cell.countryFlagImageView.isHidden = false
                cell.countryFlgWidthConstant.constant = 25
                cell.countryCodeLbl.isHidden = false
                cell.tickImage.isHidden = true
                
                cell.catName.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "country_name") as! String)"
                cell.countryCodeLbl.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "mobile_code") as! String)"
                
                if let str = ((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "country_flag") as? String)  {
                    if str.count > 0{
                        
                        cell.countryFlagImageView.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "flag_placeholder.png"))
                        
                    }
                }
                
            }else if isFromBranchSearch{
                cell.catName.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "branch_name") as! String)"
            }
            
            if (self.filterListArray.object(at: index.row) as! NSDictionary) == self.selectedCountryDict {
                cell.tickImage.isHidden = false
            }else{
                cell.tickImage.isHidden = true
            }
            
//            if (self.isFromCountryMobileCode || self.isFromCountryPhoneCode) && (self.filterListArray.object(at: index.row) as! NSDictionary) == self.selectedCountryDict {
//                cell.contentView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            }else{
//                cell.contentView.backgroundColor = .white
//            }
            
        }else{
            
            if isForCountry{
                cell.catName.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "country_name") as! String)"
                
            } else if isForBankList {
                cell.catName.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "bank_name") as! String)"
            }
            else if currencyLists {
                cell.catName.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "currency_code") as! String)"
            }
            else if isForCity {
                cell.catName.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "city_name") as! String)"
            }
            else if isForEducationList {
                cell.catName.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "education_type") as! String)"
            }
            else if isForMajorEducationList {
                cell.catName.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "education_major") as! String)"
                
            }else if isFromCourierCompany {
                cell.catName.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "company_name") as! String)"
                
            }else if self.isFromCountryMobileCode || self.isFromCountryPhoneCode {
                cell.countryFlagImageView.isHidden = false
                cell.countryFlgWidthConstant.constant = 25
                cell.countryCodeLbl.isHidden = false
                cell.tickImage.isHidden = true
                
                cell.catName.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "country_name") as! String)"
                cell.countryCodeLbl.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "mobile_code") as! String)"
                
                if let str = ((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "country_flag") as? String)  {
                    if str.count > 0{
                        
                        cell.countryFlagImageView.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "flag_placeholder.png"))
                    }
                }
            }else if isFromBranchSearch {
                cell.catName.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "branch_name") as! String)"
            }
            
            
            if (self.countryListArray.object(at: index.row) as! NSDictionary) == self.selectedCountryDict {
                cell.tickImage.isHidden = false
            }else{
                cell.tickImage.isHidden = true
            }
            
//            if (self.isFromCountryMobileCode || self.isFromCountryPhoneCode) && (self.countryListArray.object(at: index.row) as! NSDictionary) == self.selectedCountryDict {
//                cell.contentView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//            }else{
//                cell.contentView.backgroundColor = .white
//            }
        }
        
        if self.isFromCountryMobileCode || self.isFromCountryPhoneCode {
            cell.tickImage.isHidden = true
        }
                   
        
        return cell
    }
    
    // MARK: - Country API
    func countryAPI()
    {
        ModalClass.startLoading(self.view)
        let device_id = UIDevice.current.identifierForVendor!.uuidString
        let str = "\(Constant.BASE_URL)\(Constant.Country_List)"
        let parameters = [
            "device_id": "\(device_id)",
            "device_type": "ios","lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if success == true {
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
                    ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "msg") as? String)!, msg: "")
                }
                else{
                    let results = ResponseDict.object(forKey: "data") as! NSArray
                    for var i in (0..<results.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.countryListArray.add(dict)
                    }
                    self.tableVw.reloadData()
                }
            }else{
                if response == nil {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
        }
    }
    
    // MARK: - City API
    func cityAPI()
    {
        ModalClass.startLoading(self.view)
        let device_id = UIDevice.current.identifierForVendor!.uuidString
        let str = "\(Constant.BASE_URL)\(Constant.City_List)"
        var parameters = [String:String]()
        if selectedCountryID == ""{
            parameters = [
                "device_id": "\(device_id)",
                "device_type": "ios",
                "country_id": "\(self.selectedOLDCountryDict.object(forKey: "country_id") as! NSNumber)","lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ]
        }else{
            parameters = [
                "device_id": "\(device_id)",
                "device_type": "ios",
                "country_id": selectedCountryID,"lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ]
        }
        
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if success == true {
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
                    ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "msg") as? String)!, msg: "")
                }
                else{
                    let results = ResponseDict.object(forKey: "data") as! NSArray
                    for var i in (0..<results.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.countryListArray.add(dict)
                    }
                    self.tableVw.reloadData()
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
    
    // MARK: - Bank API
    func bankListAPI(){
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.Bank_List)"
        let parameters = [
            "lang_code": HeaderHeightSingleton.shared.LanguageSelected
        ]
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if success == true {
                
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
                    ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "msg") as? String)!, msg: "")
                }
                else{
                    let results = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "bank_name_list") as! NSArray
                    if self.currencyLists{
                        let resultss = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "currency_list") as! NSArray
                        for var i in (0..<resultss.count){
                            let dict : NSDictionary = NSDictionary(dictionary: resultss.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                            self.countryListArray.add(dict)
                        }
                    }else{
                        for var i in (0..<results.count){
                            let dict : NSDictionary = NSDictionary(dictionary: results.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                            self.countryListArray.add(dict)
                        }
                        
                    }
                    
                    print(self.countryListArray,"df")
                    self.tableVw.reloadData()
                }
            }else{
                if response == nil {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
        }
    }
    
    // MARK: - Education API
    func EducationListAPI(){
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.Education_List)"
        let parameters = [
            "lang_code": HeaderHeightSingleton.shared.LanguageSelected
        ]
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if success == true {
                
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
                    ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "msg") as? String)!, msg: "")
                }
                else{
                    let results = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "education_list") as! NSArray
                    for var i in (0..<results.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.countryListArray.add(dict)
                    }
                    self.tableVw.reloadData()
                }
            }else{
                if response == nil {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
        }
    }
    
    // MARK: - branchNameList API
    
      func branchNameListAPI(){
        
          ModalClass.startLoading(self.view)
          let str = "\(dataEntryModuleApi.branchName_list)"
          let parameters = [
               "lang_code": HeaderHeightSingleton.shared.LanguageSelected,
               "bo_id": Singleton.shared.getUserId()
               ]
                ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
              ModalClass.stopLoading()
              if success == true {
                  
                  let ResponseDict : NSDictionary = (response as? NSDictionary)!
                  let x = ResponseDict.object(forKey: "error") as! Bool
                  if x {
                 ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "msg") as? String)!, msg: "")
                  }
                  else{
                    let results = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "branch_list") as! NSArray
                    
                    for var i in (0..<results.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.countryListArray.add(dict)
                    }
                    
                    self.tableVw.reloadData()
                }
              }else{
                  if response == nil {
                      print ("connection error")
                      ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                  }else{
                      print ("data not in proper json")
                  }
              }
          }
      }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let textStr = textField.text {
            if self.countryListArray.count == 0{
                return
            }
            var countryOr = ""
            if isForCountry || isFromCountryMobileCode || isFromCountryPhoneCode {
                countryOr = "country_name"
            }else if isForBankList{
                countryOr = "bank_name"
            } else if isForCity {
                countryOr = "city_name"
            }else if isForEducationList {
                countryOr = "education_type"
            }else if isForMajorEducationList {
                countryOr = "education_major"
            }else if currencyLists {
                countryOr = "currency"
            }else if isFromCourierCompany {
                countryOr = "company_name"
            }else if isFromBranchSearch {
                countryOr = "branch_name"
            }
            
            let searchPredicate = NSPredicate(format: "\(countryOr) CONTAINS[C] %@", textStr)
            let array = (countryListArray as NSArray).filtered(using: searchPredicate)
            
            if textField.text!.count > 0 && (array.count == 0){
                ModalController.showNegativeCustomAlertWith(title: "", msg: "No result found")
                
            }
            if(array.count == 0){
                self.filterListArray.removeAllObjects()
            } else {
                self.filterListArray.removeAllObjects()
                for var i in (0..<array.count)
                {
                    self.filterListArray.add((array[i] as! NSDictionary).RemoveNullValueFromDic())
                }
            }
            self.tableVw.reloadData()
        }
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        self.searchField.text = ""
        self.filterListArray.removeAllObjects()
        self.tableVw.reloadData()
    }
}
