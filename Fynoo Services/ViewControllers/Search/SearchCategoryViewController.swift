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
    func selectedCountryCode(countryCode : NSMutableDictionary)
}

class SearchCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
     var tag = 0
    @IBOutlet weak var customHeader: NavigationView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowVw: UIView!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var searchField: UITextField!{
        didSet {
//            searchField.textColor = Constant.Grey_TEXT_COLOR
//            searchField.font = UIFont(name:"\(Constant.FONT_Light)",size:13)
        }
    }
    var idArr = NSMutableArray()
    var langArr : NSMutableArray = NSMutableArray()
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
    var isForCounrtyCode=false
    var selectedOLDCountryDict : NSDictionary = NSDictionary()
    var selectedCountryID  = ""
    var isForLanguage = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUiMethod()
        registerCellNibs()
        customHeader.viewControl = self
        if isForCountry {
            self.customHeader.titleHeader.text = "Select Country"
            self.searchField.placeholder = "Enter Country Name"
            countryAPI()
            
        }else if isForBankList {
           self.customHeader.titleHeader.text = "Select Bank"
               self.searchField.placeholder = "Enter Bank Name"
            bankListAPI()
            
        }else if isForCity {
            self.customHeader.titleHeader.text = "Select City"
             self.searchField.placeholder = "Enter City Name"
            cityAPI()
            
        }else if isForEducationList {
            self.customHeader.titleHeader.text = "Select Education"
            self.searchField.placeholder = "Enter Education Name"
            EducationListAPI()
            
        }else if currencyLists {
            self.customHeader.titleHeader.text = "Select Currency"
             self.searchField.placeholder = "Enter Currency"
              bankListAPI()
        }
        else if isForMajorEducationList  {
            self.customHeader.titleHeader.text = "Select Major Education"
            print("majorDict-", self.selectedOLDCountryDict)
            let array =  selectedOLDCountryDict.object(forKey: "list_value") as! NSArray
            self.countryListArray = NSMutableArray(array: array)
            self.tableVw.reloadData()
            
        }
        
        else if isForCounrtyCode {
            self.customHeader.titleHeader.text = "Select Country Code"
            self.countryAPI()
             self.tableVw.reloadData()
        }
        
        else if isForLanguage{
            self.customHeader.titleHeader.text = "Select Language"
            self.languageApi()
            self.tableVw.reloadData()
        }
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
        
        self.searchField.attributedPlaceholder = NSAttributedString(string: "Type here", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126.0/255.0, green: 139.0/255.0, blue: 152.0/255.0, alpha: 1.0)])
        
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
                  if myIntValue == 44{
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
        tableVw.register(UINib(nibName: "TwoButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "TwoButtonsTableViewCell");

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
        }
        else if self.isForCounrtyCode{
            self.delegate?.selectedCurrency(currency: self.selectedCountryDict)

        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - TableView DataSource Delegates
    func numberOfSections(in tableView: UITableView) -> Int{
        if isForLanguage{
            return 2
        }
        return 1
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1{
            return 1
        }
        if filterListArray.count > 0 || searchField.text!.count > 0 {
            return self.filterListArray.count
        }else{
        return self.countryListArray.count
        }
    }
    
    @objc func saveChange(){
        
        
        for i in 0..<langArr.count{

        }
        var ACTIVATION = ""
               if langArr.count > 0
               {
                   ACTIVATION.removeAll()
                   for item in langArr{
                       ACTIVATION = "\(item),\(ACTIVATION)"
                   }
                   ACTIVATION.removeLast()
               }
        let param = ["lang_code":"en","user_id":"1106","selected_lag":ACTIVATION]
        ServerCalls.postRequest(Service.saveLanguage, withParameters: param) { (response, success) in
            if success{
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1{
            
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "TwoButtonsTableViewCell",for: indexPath) as! TwoButtonsTableViewCell
            cell.cancel.isHidden = true
            cell.save.addTarget(self, action: #selector(saveChange), for: .touchUpInside)
            return cell
        }else{
            
        }
        return countryCell(index: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if isForLanguage{
            if langArr.contains(((self.countryListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "name") as! String)){
                
                langArr.remove(((self.countryListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "name") as! String))
            }else{
                langArr.add(((self.countryListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "name") as! String))
            }
            tableView.reloadData()
            
        }
        else{
            if filterListArray.count > 0 || searchField.text!.count > 0{
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
            }
                
            else if self.currencyLists {
                self.delegate?.selectedCurrency(currency: self.selectedCountryDict)
            }
            else if self.isForCounrtyCode{
                self.delegate?.selectedCountryCode(countryCode: self.selectedCountryDict)
                
            }
        }
        
        
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    // MARK: - TableView Cells Return
    func countryCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "SearchCategoryTableViewCell",for: index) as! SearchCategoryTableViewCell
        cell.selectionStyle = .none
        cell.imgWidth.constant = 0
        
       
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
            }
            else if isForCounrtyCode{
                cell.imgWidth.constant = 20
                cell.countryCode.isHidden = false
                cell.img.isHidden = false
                cell.catName.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "country_name") as! String)"
                let str = (self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "country_flag") as! String
                cell.img.sd_setImage(with: URL(string: "\(str)"), placeholderImage: UIImage(named: "branch_logo_temp"))
                cell.countryCode.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "mobile_code") as! String)"
            }
            
            if (self.filterListArray.object(at: index.row) as! NSDictionary) == self.selectedCountryDict {
                cell.tickImage.isHidden = false
            }else{
                cell.tickImage.isHidden = true
            }
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
            }
            
            else if isForCounrtyCode {
                  cell.imgWidth.constant = 20
                cell.countryCode.isHidden = false
                cell.img.isHidden = false
                cell.catName.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "country_name") as! String)"
                let str = (self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "country_flag") as! String
               cell.img.sd_setImage(with: URL(string: "\(str)"), placeholderImage: UIImage(named: "branch_logo_temp"))
                cell.countryCode.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "mobile_code") as! String)"
                
            }
            
        
            
        if (self.countryListArray.object(at: index.row) as! NSDictionary) == self.selectedCountryDict {
            cell.tickImage.isHidden = false
        }else{
            cell.tickImage.isHidden = true
        }
            
            
             if isForLanguage{
                
                print(langArr,"jyzg")
                if langArr.contains(((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "name") as! String)){
                    cell.tickImage.isHidden = false
                    
                }else{
                    cell.tickImage.isHidden = true
                    
                }
                cell.imgWidth.constant = 0
                cell.countryCode.isHidden = true
                cell.catName.text = "\((self.countryListArray.object(at: index.row) as! NSDictionary).object(forKey: "name") as! String)"
            }
       }
        return cell
    }
    
    func languageApi()
    {
        ModalClass.startLoading(self.view)
        let device_id = UIDevice.current.identifierForVendor!.uuidString
        let str = "\(Service.languageList)"
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
                    let results = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "lang_list") as! NSArray
                    
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

    @objc func textFieldDidChange(_ textField: UITextField) {
        if let textStr = textField.text {
            if self.countryListArray.count == 0{
                return
            }
            var countryOr = ""
            if isForCountry{
                countryOr = "country_name"
            }else if isForBankList{
                countryOr = "bank_name"
            } else if isForCity {
                countryOr = "city_name"
            }else if isForEducationList {
                countryOr = "education_type"
            }else if isForMajorEducationList {
                countryOr = "education_major"
            }
            else if currencyLists {
                countryOr = "currency"
            }else if isForCounrtyCode{
                 countryOr = "country_name"
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
