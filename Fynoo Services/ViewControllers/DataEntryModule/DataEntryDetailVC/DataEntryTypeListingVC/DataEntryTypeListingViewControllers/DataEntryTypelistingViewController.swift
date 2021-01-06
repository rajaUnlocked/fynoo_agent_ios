//
//  DataEntryTypelistingViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 23/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryTypelistingViewController: UIViewController {
    
    @IBOutlet weak var customHeader: NavigationView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableVw: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
   
    @IBOutlet weak var crossBtn: UIButton!
    
    var serviceID:String = ""
    var dataEntryType:String = ""
    var apiManagerModal = DataEntryApiManager()
    var serviceTypeList  : ServiceTypeData?
     var searchBoxEntryText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUiMethod()
        registerCellNibs()
        self.tableVw.dataSource = self
        self.tableVw.delegate = self
        self.SetFont()
        self.getServiceTypeAPI()
        
        }
                    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.searchField.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }


  func setupUiMethod(){

    searchField.addTarget(self, action: #selector(DataEntryTypelistingViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
      let yourColor : UIColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233.0/255.0, alpha: 1.0)
      searchVw.layer.masksToBounds = true
      searchVw.layer.borderColor = yourColor.cgColor
      searchVw.layer.borderWidth = 1.0
      searchVw.layer.cornerRadius = 5.0
      
      self.searchField.attributedPlaceholder = NSAttributedString(string: "Enter Data Entry Item", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126.0/255.0, green: 139.0/255.0, blue: 152.0/255.0, alpha: 1.0)])
      
      self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
//      self.navigationController?.isNavigationBarHidden = true
    self.customHeader.titleHeader.text = "Data Entry Sevice"
    self.customHeader.viewControl = self
    
    
  }
    
       @IBAction func searchBtnClicked(_ sender: Any) {
           self.view.endEditing(true)
                if searchBoxEntryText != "" {
                    self.getServiceTypeAPI()
                }
           
       }
       @IBAction func crossBtnClicked(_ sender: Any) {
        self.searchField.text = ""
        self.getServiceTypeAPI()
       }
       
    func getServiceTypeAPI() {
          
        apiManagerModal.dataEntryTypeListing(serviceId: self.serviceID,dataEntryType: dataEntryType , searchStr: "") { (success, response) in
               ModalClass.stopLoading()
               if success{
                   self.serviceTypeList = response
                   
                   self.tableVw.reloadData()
               }else{
                   ModalController.showNegativeCustomAlertWith(title: "", msg: "\(self.serviceTypeList?.error_description ?? "")")
               }
           }
       }
    
    func registerCellNibs(){
          tableVw.register(UINib(nibName: "DataEntryTypeListingTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryTypeListingTableViewCell");
      }
    

    @objc func textFieldDidChange(_ textField: UITextField) {
        if let textStr = textField.text {
                self.searchBoxEntryText = textStr
         
            }
    }
}

extension DataEntryTypelistingViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension DataEntryTypelistingViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return serviceTypeList?.data?.data_entry_lines?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataEntryTypeListingTableViewCell", for: indexPath) as! DataEntryTypeListingTableViewCell
        cell.selectionStyle = .none
        cell.tickImageView.isHidden = true
        
        let typeData = serviceTypeList?.data?.data_entry_lines?[indexPath.row]
        cell.productTxtLbl.text = typeData?.des_name
        cell.productTxtLbl.textColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 1, alpha: 1)
        
        if typeData?.is_complete == 1 {
            cell.tickImageView.isHidden = false
        }else {
            cell.tickImageView.isHidden = true
            cell.productTxtLbl.text = typeData?.des_name
        }
        
        return cell
        
    }
}
