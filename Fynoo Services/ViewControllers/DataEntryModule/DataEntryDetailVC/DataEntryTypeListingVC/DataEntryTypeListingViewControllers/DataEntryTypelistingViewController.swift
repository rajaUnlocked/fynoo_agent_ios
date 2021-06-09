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
     var branchmodel = branchsmodel()
     var productmodel = AddProductModel()
    var serviceID:String = ""
    var boID:String = ""
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
        ModalClass.startLoading(self.view)
        
      
    }
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.searchField.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.getServiceTypeAPI()
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
//    func setupUiMethod() {
//
//        searchField.addTarget(self, action: #selector(DataEntryTypelistingViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
//        let yourColor : UIColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 233.0/255.0, alpha: 1.0)
//        searchVw.layer.masksToBounds = true
//        searchVw.layer.borderColor = yourColor.cgColor
//        searchVw.layer.borderWidth = 1.0
//        searchVw.layer.cornerRadius = 5.0
//
//        self.searchField.attributedPlaceholder = NSAttributedString(string: "Enter Data Entry Item", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 126.0/255.0, green: 139.0/255.0, blue: 152.0/255.0, alpha: 1.0)])
//
//        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
//        self.customHeader.titleHeader.text = "Data Entry Sevice"
//        self.customHeader.viewControl = self
//
//
//    }
    
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
        
        apiManagerModal.dataEntryTypeListing(serviceId: self.serviceID,dataEntryType: dataEntryType , searchStr: self.searchField.text!) { (success, response) in
            ModalClass.stopLoading()
            if success{
                self.serviceTypeList = response
                
                self.tableVw.reloadData()
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "\(self.serviceTypeList?.error_description ?? "")")
            }
        }
    }
    
    func registerCellNibs() {
        
        tableVw.register(UINib(nibName: "DataEntryTypeListingTableViewCell", bundle: nil), forCellReuseIdentifier: "DataEntryTypeListingTableViewCell");
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let textStr = textField.text {
            self.searchBoxEntryText = textStr
            
        }
    }
}

extension DataEntryTypelistingViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension DataEntryTypelistingViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return serviceTypeList?.data?.data_entry_lines?.count ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let typeData = serviceTypeList?.data?.data_entry_lines?[indexPath.row]
        
        if typeData?.type_name == "Product" {
            if (typeData?.product_id ?? 0) > 0{
                
                ProductModel.shared.remove()
                Singleton.shared.setBoId(BoId: self.boID)
                ModalClass.startLoading(self.view)
                ProductModel.shared.productId = "\(typeData?.product_id ?? 0 )"
                productmodel.productDetails{ (success, response) in
                    ModalClass.stopLoading()
                    
                    if success{
                        let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                        vc.serviceid = "\(typeData?.form_id ?? 0 )"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }else{
                ProductModel.shared.remove()
                let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                Singleton.shared.setBoId(BoId: self.boID)
                vc.serviceid = "\(typeData?.form_id ?? 0 )"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if typeData?.type_name == "Branch" {
            if (typeData?.branch_id ?? 0) > 0{
                
                AddBranch.shared.removeall()
                Singleton.shared.setBoId(BoId: self.boID)
                branchmodel.branchid = "\(typeData?.branch_id ?? 0)"
                ModalClass.startLoading(self.view)
                branchmodel.branchDetail { (success, response) in
                    
                    if success {
                        ModalClass.stopLoading()
                        let vc = CreateBranchFirstStepViewController(nibName: "CreateBranchFirstStepViewController", bundle: nil)
                        vc.serviceid = "\(typeData?.form_id ?? 0 )"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }else{
                
                AddBranch.shared.removeall()
                let vc = CreateBranchFirstStepViewController(nibName: "CreateBranchFirstStepViewController", bundle: nil)
                Singleton.shared.setBoId(BoId: self.boID)
                vc.serviceid = "\(typeData?.form_id ?? 0 )"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
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
