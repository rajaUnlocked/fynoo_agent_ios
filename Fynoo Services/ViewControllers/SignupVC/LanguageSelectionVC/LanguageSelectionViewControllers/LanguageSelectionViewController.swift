//
//  LanguageSelectionViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-040 on 29/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

import Alamofire

protocol LanguageSelectionViewControllerDelegate: class {
   
    func selectLanguageMethod(languageDict : NSMutableDictionary)
}

class LanguageSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    weak var delegate: LanguageSelectionViewControllerDelegate?
    @IBOutlet weak var customHeader: NavigationView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowVw: UIView!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableVw: UITableView!
    @IBOutlet var signUpBtn: UIButton!
    
    var selectedLanguageyDict : NSMutableDictionary = NSMutableDictionary()
    var filterListArray : NSMutableArray = NSMutableArray()
    var languageListArray : NSMutableArray = NSMutableArray()
    var selectedArray:NSMutableArray = NSMutableArray()
     var selectLanguageStr:String = ""
    
    var IBANinformationModal = AgentIbanLengthModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUiMethod()
        registerCellNibs()
        customHeader.viewControl = self
        self.customHeader.titleHeader.text = "Please Select Language"
        self.searchField.placeholder = "Enter Language"
        languageListAPI()
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        searchField.font = UIFont(name:"\(fontNameLight)",size:12)
        customHeader.viewControl = self
        
    }
    
    func setupUiMethod(){
        self.headerHeightMethod()
        searchField.addTarget(self, action: #selector(LanguageSelectionViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        let yourColor : UIColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233.0/255.0, alpha: 1.0)
        searchVw.layer.masksToBounds = true
        searchVw.layer.borderColor = yourColor.cgColor
        searchVw.layer.borderWidth = 1.0
        searchVw.layer.cornerRadius = 5.0
        
        self.searchField.attributedPlaceholder = NSAttributedString(string: "Type here", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126.0/255.0, green: 139.0/255.0, blue: 152.0/255.0, alpha: 1.0)])
        
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.navigationController?.isNavigationBarHidden = true
        
        self.signUpBtn.layer.cornerRadius = 5
        self.signUpBtn.clipsToBounds = true
        self.signUpBtn.setAllSideShadow(shadowShowSize: 3.0)
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
        tableVw.register(UINib(nibName: "LanguageSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "LanguageSelectionTableViewCell");
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        
        IBANinformationModal.savedSelectedLanguage(languageID:self.selectLanguageStr) { (success, response) in
            if success{
                if let value = (response?.object(forKey: "error_description") as? String) {
                    ModalController.showSuccessCustomAlertWith(title: "", msg: value)
                }
               
            }else{
                if let value = response?.object(forKey: "error_description") as? String {
                    ModalController.showNegativeCustomAlertWith(title: "", msg: value)
                }
            }
        }
        
        
        
        
    }
    
    @IBAction func crossBtn(_ sender: Any) {
        
        self.searchField.text = ""
        self.filterListArray.removeAllObjects()
        self.tableVw.reloadData()
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
            return self.languageListArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return languageCell(index: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filterListArray.count > 0 || searchField.text!.count > 0 {

            let langugageID = ModalController.toString(((self.filterListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "id") as Any ))
            
            if selectedArray.contains(langugageID){
                selectedArray.remove(langugageID)
            }else{
                selectedArray.add(langugageID)
            }
            self.selectLanguageStr = self.selectedArray.componentsJoined(by: ",")
            print("indexPath -", selectedArray)
            self.tableVw.reloadData()
            
        }else{
            
            let langugageID = ModalController.toString(((self.languageListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "id") as Any ))
            
            if selectedArray.contains(langugageID){
                selectedArray.remove(langugageID)
            }else{
                selectedArray.add(langugageID)
            }
            self.selectLanguageStr = selectedArray.componentsJoined(by: ",")
            
            print("selectedArray -", selectedArray)
            print("selectLanguageStr -", self.selectLanguageStr)
            self.tableVw.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    // MARK: - TableView Cells Return
    func languageCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "LanguageSelectionTableViewCell",for: index) as! LanguageSelectionTableViewCell
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        cell.catName.font = UIFont(name:"\(fontNameLight)",size:12)
        
        cell.selectionStyle = .none
        
        if selectedArray.count > 0  {
            self.signUpBtn.setTitleColor(UIColor(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
            self.signUpBtn.layer.borderWidth = 0.5
            self.signUpBtn.borderColor =  UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1)
        }else {
            
            self.signUpBtn.setTitleColor(UIColor(red: 236/255, green: 74/255, blue: 83/255, alpha: 1), for: .normal)
            self.signUpBtn.layer.borderWidth = 0.5
            self.signUpBtn.borderColor =  UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
        }
        
        if filterListArray.count > 0 || searchField.text!.count > 0 {
            cell.catName.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "name") as! String)"
            
            let langugageID = ModalController.toString(((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "id") as Any ))
            
            if selectedArray.contains(langugageID){
                cell.tickImage.isHidden = false
            }else{
                cell.tickImage.isHidden = true
            }
           
        }else{
            
            cell.catName.text = "\((self.languageListArray.object(at: index.row) as! NSDictionary).object(forKey: "name") as! String)"
            
            let langugageID = ModalController.toString(((self.languageListArray.object(at: index.row) as! NSDictionary).object(forKey: "id") as Any ))
            
            if selectedArray.contains(langugageID){
                cell.tickImage.isHidden = false
            }else{
                cell.tickImage.isHidden = true
            }
        }
        
        return cell
    }
    
    // MARK: - Language API
    func languageListAPI(){
        ModalClass.startLoading(self.view)
        
        let str = "\(Constant.BASE_URL)\(Constant.language_List)"
        let parameters = [
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
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
                        self.languageListArray.add(dict)
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
            if self.languageListArray.count == 0{
                return
            }
            let countryOr = "name"
            
            let searchPredicate = NSPredicate(format: "\(countryOr) CONTAINS[C] %@", textStr)
            let array = (languageListArray as NSArray).filtered(using: searchPredicate)
            
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
}