//
//  InvoiceNewViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-060 on 30/11/21.
//  Copyright © 2021 Sendan. All rights reserved.
//

import UIKit

class InvoiceNewViewController: UIViewController {
    
    @IBOutlet weak var headerVw: NavigationView!
    @IBOutlet weak var tableVw: UITableView!
    @IBOutlet weak var topheightConstraint: NSLayoutConstraint!
   
    let headView = InvoicingHeader()
    var selectedVl = 1000
    let fontNameLight = NSLocalizedString("LightFontName", comment: "")
    let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
    var invoiceType:String = ""
    var searchText:String = ""
    var tabID:Int = 1
    var pageno:Int = 0
    var isMoreDataAvailable: Bool = false
    var invoicelist:Welcome?
    var totalRequestListArray:[TxnList]?

    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.topheightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerVw.viewControl = self
        self.headerVw.backButton.isHidden = false
        self.headerVw.titleHeader.text = "Manage Your Invoice".localized
        //        self.headView.layer.frame.size.height = 40
        tableVw.contentInsetAdjustmentBehavior = .never
        tableVw.register(UINib(nibName: "BottomPopupTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomPopupTableViewCell");
        tableVw.register(UINib(nibName: "WalletNewSimpleTableViewCell", bundle: nil), forCellReuseIdentifier: "WalletNewSimpleTableViewCell");
        tableVw.register(UINib(nibName: "NodatafoundTableViewCell", bundle: nil), forCellReuseIdentifier: "NodatafoundTableViewCell");
        tableVw.delegate = self
        tableVw.dataSource = self
        self.tableVw.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        pageno = 0
        isMoreDataAvailable = false
        addUIRefreshToTable()

        self.getInvoiceListAPI()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if let textStr = textField.text {
            self.searchText = textStr
            if self.searchText.count == 0{
                self.pageno = 0
                self.isMoreDataAvailable = false
                self.getInvoiceListAPI()
            }
        }
    }
    func invoiceDownload(index : Int)
    {
      
        let invoce = totalRequestListArray?[index].txnInvoiceFor
        let fyid = totalRequestListArray?[index].txnTransID
        let orderid = totalRequestListArray?[index].txnOrderID
        let sellerid = totalRequestListArray?[index].txnSellerId
        var str: String = ""
        var noteType: Int = 0
        var parameters : Dictionary<String,Any> = [:]
        if tabID == 2
        {
            noteType = 1
        }
        else if tabID == 3
        {
            noteType = 2
        }
        ModalClass.startLoading(self.view)
        if tabID == 1 {
            
             str = "\(Constant.BASE_URL)\(Constant.viewinvoice)"
            parameters = [
                "order_id": orderid ?? "",
                "invoice_for": invoce ?? "",
                "fynoo_id": fyid ?? "",
                "seller_id": sellerid ?? "",
                "lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ] as [String : Any]
        }
        else{
            
             str = "\(Constant.BASE_URL)\(Constant.viewinvoiceDC)"
             parameters = [
                "order_id": orderid ?? "",
                "fynoo_id": fyid ?? "",
                "notes_for": invoce ?? "",
                "notes_type":noteType,
                "is_invoice_for":invoiceType,
                "lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ] as [String : Any]
        }
        print("request -",parameters)
        
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            
            ModalClass.stopLoadingAllLoaders(self.view)
            if success == true {
                
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
                ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "error_description") as? String)!, msg: "")
                   
                }
                else{
                    if let url = URL(string: (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "invoice_url") as! String), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, completionHandler: nil)
                    }
                    }
                    
                }
            else{
    
                if response == nil {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                }else{
                    print ("data not in proper json")
                }
            }
        }
    }
    func invoiceList(completion:@escaping(Bool, Welcome?) -> ()) {
        
        let str = "\(Constant.BASE_URL)\(Constant.invoiceApi)"
        
        
        let parameters = ["lang_code": HeaderHeightSingleton.shared.LanguageSelected,"user_id": Singleton.shared.getUserId() , "tab_id": tabID , "invoice_type": invoiceType , "next_page_no": pageno, "search": searchText] as [String : Any]
        
        
        print(str,parameters)
        ServerCalls.postRequestss(str, withParameters: parameters) { (response, success,resp) in
            
            if let value = response as? NSDictionary{
                print(value)
                
                let error = value.object(forKey: "error") as! Int
                if error == 0{
                    if let body = response as? [String: Any] {
                        let val = try! JSONDecoder().decode(Welcome.self, from: resp as! Data )
                        completion(true, val)
                        return
                    }
                    completion(false,nil)
                }else{
                    completion(false, nil)
                    
                }
                
            }
        }
    }
    func addUIRefreshToTable() {
        refreshControl = UIRefreshControl()
        tableVw.addSubview(refreshControl)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }
    @objc func refreshTable() {
        
        self.pageno = 0
        
        if  self.invoicelist!.error {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }else{
            self.getInvoiceListAPI()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            if totalRequestListArray?[indexPath.row].txnEntryType == 1{
                invoiceDownload(index: indexPath.row)
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if cell.tag == 999999
        {
            pageno += 1
        isMoreDataAvailable = false
            self.getInvoiceListAPI()
        }
    }
    func getInvoiceListAPI()
    {
        invoiceList { success, response in
            if success{
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
                if self.pageno == 0 {
                    self.totalRequestListArray?.removeAll()
                }
                self.invoicelist = response
                if self.invoicelist?.data.txnList.count ?? 0 > 0 {
//                    self.noDataView.isHidden = true
                    
                    guard let arr = self.invoicelist?.data.txnList as NSArray? else {
                        
                        self.isMoreDataAvailable = false
                        self.tableVw.reloadData()
                        return
                        
                    }
                    if let cont = self.totalRequestListArray {
                        self.totalRequestListArray = cont + (self.invoicelist?.data.txnList)!
                        
                    }else{
                        self.totalRequestListArray = self.invoicelist?.data.txnList
                    }
                    if arr.count < 10 {
                        self.isMoreDataAvailable = false
                    }else{
                        self.isMoreDataAvailable = true
                    }
                }
                else{
                    self.isMoreDataAvailable = false
             if self.pageno == 0 {
//  self.noDataView.isHidden = false
                       self.totalRequestListArray?.removeAll()
                    }else{
//                        self.noDataView.isHidden = true
                  }
                   
                }
                self.tableVw.reloadData()
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "\(self.invoicelist?.errorDescription ?? "")")
                if self.pageno == 0 {
                    self.totalRequestListArray?.removeAll()
                }
//                self.noDataView.isHidden = false
                self.tableVw.reloadData()
            }
        }
    }
}
extension InvoiceNewViewController :  UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 50
        }
        return 100
    }
    @objc func searchClicked() {
        
        self.view.endEditing(true)
        self.pageno = 0
        self.isMoreDataAvailable = false
        
        if searchText != "" {
            self.getInvoiceListAPI()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1{
            headView.btnInvoice.tag = 1000
            headView.btnDebitNotes.tag = 1001
            headView.btnCreditNotes.tag = 1002
            headView.searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            headView.searchBtnOutlet.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
            if invoiceType == "issued"{
                headView.btnInvoice.setTitle("Issued Invoice".localized, for: .normal)
                headView.btnDebitNotes.setTitle("Issued Debit Note".localized, for: .normal)
                headView.btnCreditNotes.setTitle("Issued Credit Note".localized, for: .normal)
            }
            else if invoiceType == "received" {
                headView.btnInvoice.setTitle("Received Invoice".localized, for: .normal)
                headView.btnDebitNotes.setTitle("Received Debit Note".localized, for: .normal)
                headView.btnCreditNotes.setTitle("Received Credit Note".localized, for: .normal)
            }
            else {
                headView.btnInvoice.setTitle("Fynoo Receipt".localized, for: .normal)
                headView.btnDebitNotes.setTitle("Fynoo Receipt".localized, for: .normal)
                headView.btnCreditNotes.setTitle("Fynoo Receipt".localized, for: .normal)
            }
            
            if selectedVl == 1000{
                headView.firstLbl.isHidden = false
                headView.secondLbl.isHidden = true
                headView.thirdLbl.isHidden = true
                headView.btnInvoice.backgroundColor = UIColor.white
                headView.btnDebitNotes.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.btnCreditNotes.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.btnInvoice.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
                headView.btnDebitNotes.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.btnCreditNotes.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.btnInvoice.titleLabel?.font = UIFont(name: fontNameBold, size: 12.0)
                headView.btnDebitNotes.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)
                headView.btnCreditNotes.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)
                
                headView.searchField.text = searchText
                
                headView.btnDebitNotes.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.btnDebitNotes.borderWidth = 0.2
                
                headView.btnCreditNotes.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.btnCreditNotes.borderWidth = 0.2
                
                headView.btnInvoice.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                headView.btnInvoice.borderWidth = 0.2
                
            }else if selectedVl == 1001{
                
                headView.firstLbl.isHidden = true
                headView.secondLbl.isHidden = false
                headView.thirdLbl.isHidden = true
                headView.btnInvoice.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.btnDebitNotes.backgroundColor = UIColor.white
                headView.btnCreditNotes.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.btnCreditNotes.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.btnDebitNotes.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
                headView.btnInvoice.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.btnDebitNotes.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                headView.btnDebitNotes.borderWidth = 0.2
                
                headView.btnCreditNotes.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.btnCreditNotes.borderWidth = 0.2
                
                headView.btnInvoice.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.btnInvoice.borderWidth = 0.2
               
                headView.searchField.text = searchText

                headView.btnInvoice.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)
                headView.btnDebitNotes.titleLabel?.font = UIFont(name: fontNameBold, size: 12.0)
                headView.btnCreditNotes.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)
                
            }else{
                
                headView.firstLbl.isHidden = true
                headView.secondLbl.isHidden = true
                headView.thirdLbl.isHidden = false
                headView.btnInvoice.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.btnDebitNotes.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.btnCreditNotes.backgroundColor = UIColor.white
                headView.btnInvoice.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.btnDebitNotes.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.btnCreditNotes.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
                
                headView.btnDebitNotes.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.btnDebitNotes.borderWidth = 0.2
                
                headView.btnCreditNotes.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                headView.btnCreditNotes.borderWidth = 0.2
                
                headView.btnInvoice.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.btnInvoice.borderWidth = 0.2
             
                headView.searchField.text = searchText

                headView.btnInvoice.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)
                headView.btnDebitNotes.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)
                headView.btnCreditNotes.titleLabel?.font = UIFont(name: fontNameBold, size: 12.0)
            }
            headView.btnInvoice.addTarget(self, action: #selector(btnHeaderClicked(_:)), for: .touchUpInside)
            headView.btnDebitNotes.addTarget(self, action: #selector(btnHeaderClicked(_:)), for: .touchUpInside)
            headView.btnCreditNotes.addTarget(self, action: #selector(btnHeaderClicked(_:)), for: .touchUpInside)
            return headView
        }else{
            return UIView()
        }
        
    }
    @objc func btnHeaderClicked(_ sender : UIButton){
        
        if sender.tag == selectedVl
        {
            return
        }
        switch sender.tag {
        case 1000:
            selectedVl = 1000
            tabID = 1
        case 1001:
            selectedVl = 1001
            tabID = 2
        case 1002:
            selectedVl = 1002
            tabID = 3
        default:
            print("ds")
        }
        pageno = 0
        self.getInvoiceListAPI()
        tableVw.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 100
        }
        return 0
    }
    
}
extension InvoiceNewViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return 1
        }
        else if section == 0{
            return 1
        }
        else{
            if isMoreDataAvailable == true {
                isMoreDataAvailable = false
                if let count = self.totalRequestListArray?.count {
                    return count + 1
                }else{
                    return 0
                }
            }else {
                return (totalRequestListArray?.count) ?? 0
            }
        }
//        return invoicelist?.data.txnList.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BottomPopupTableViewCell", for: indexPath) as! BottomPopupTableViewCell
            cell.nameLbl.text = "Invoicing".localized
            cell.infoBtn.isHidden = true
//            cell.img.
            return cell
        }
        else if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataFoundTableViewCell", for: indexPath) as! NoDataFoundTableViewCell

            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
            cell.titleLbl.text = "No Data Found"
            if HeaderHeightSingleton.shared.LanguageSelected == "AR"{
                cell.titleLbl.text = "لاتوجد بيانات"
            }
            cell.titleLbl.font =  UIFont(name:"\(fontNameBold)",size:20)
            cell.gobackBtn.isHidden = true


            return cell
        }
        else
        {
            if indexPath.row == (totalRequestListArray!.count) {
                return self.loadingCell()
            }
            else{
                   
                    let cell = tableView.dequeueReusableCell(withIdentifier: "WalletNewSimpleTableViewCell", for: indexPath) as! WalletNewSimpleTableViewCell
                    cell.walletIcon.isHidden = true
                    cell.holdingLbl.isHidden = true
                if totalRequestListArray?[indexPath.row].txnEntryType == 1{
                    cell.underline.isHidden = false
                }
                    let requestData = totalRequestListArray?[indexPath.row]
                    cell.titleLbl.text = requestData?.txnRemarks ?? ""
                    cell.orderIdLbl.text = "\(requestData?.txnTransID ?? "") | \(requestData?.txnDate ?? "")"
                    cell.transactionLbl.text = requestData?.txnOrderID ?? ""
                    cell.priceLbl.text = "SAR \(requestData?.txnAmount ?? "")"
                    return cell
                }
            
           
        }
        
    }
    func loadingCell() -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        //  activityIndicator.center = cell.center;
        cell.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        cell.tag = 999999
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = cell.contentView.backgroundColor
        activityIndicator.frame = CGRect(x: (UIScreen.main.bounds.size.width / 2) - 10, y: 12, width: 20, height: 20)
        
        
        return cell
    }
}
