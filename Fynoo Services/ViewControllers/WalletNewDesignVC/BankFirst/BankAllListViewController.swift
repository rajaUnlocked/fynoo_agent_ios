//
//  BankAllListViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 19/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import AMShimmer

class BankAllListViewController: UIViewController, WalletFilterNewViewControllerDelegate {
    @IBOutlet weak var watermarkConst: NSLayoutConstraint!
    @IBOutlet weak var topheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerVw: NavigationView!
    @IBOutlet weak var downImage: UIImageView!
    var selectedVl = 1000
    var pageNo = 0
    var bankTransferType = 1
    var transactionListArray : NSMutableArray = NSMutableArray()
    var wholeDict = NSDictionary()
    let headView = BankHeader()
    
    var minAmount = 0.0
    var maxAmount = 0.0
    var fromStr = ""
    var toStr = ""
    let fontNameLight = NSLocalizedString("LightFontName", comment: "")
    let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
      //  watermarkConst.constant = -(self.view.frame.width - 295)/2
//        downImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        self.navigationController?.navigationBar.isHidden = true
        self.topheightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerVw.viewControl = self
        self.headerVw.backButton.isHidden = false
        
        tableView.tableFooterView = UIView()
        self.headerVw.titleHeader.text = "Manage Your Wallet".localized
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UINib(nibName: "WalletAvailableTopCell", bundle: nil), forCellReuseIdentifier: "WalletAvailableTopCell");
        tableView.register(UINib(nibName: "TransactionInnerTableCell", bundle: nil), forCellReuseIdentifier: "TransactionInnerTableCell");
//        tableView.register(UINib(nibName: "NoDataFoundTableViewCell", bundle: nil), forCellReuseIdentifier: "NoDataFoundTableViewCell");
        tableView.register(UINib(nibName: "NoDataFoundTableViewCell", bundle: nil
        ), forCellReuseIdentifier: "NoDataFoundTableViewCell")
        tableView.register(UINib(nibName: "PaymentProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "PaymentProgressTableViewCell");

        tableView.register(UINib(nibName: "ShowMoreViewCell", bundle: nil), forCellReuseIdentifier: "ShowMoreViewCell");
        tableView.register(UINib(nibName: "WalletNewSimpleTableViewCell", bundle: nil), forCellReuseIdentifier: "WalletNewSimpleTableViewCell");

        tableView.register(UINib(nibName: "WalletTransferReqNewTableViewCell", bundle: nil), forCellReuseIdentifier: "WalletTransferReqNewTableViewCell");


        tableView.delegate = self
        tableView.dataSource = self

        walletTransactionsAPI(searchValue: "")
        
        self.tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotificationTransferSuccess(_:)), name: NSNotification.Name(rawValue: "TransferSuccess"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @objc func methodOfReceivedNotificationTransferSuccess(_ notification: NSNotification) {
        headView.searchField.text = ""
        pageNo = 0
        walletTransactionsAPI(searchValue: "")
    }

    @objc func walletBalance(_ sender : UIButton){
        if sender.tag == selectedVl
        {
            return
        }
        switch sender.tag {
        case 1000:
            selectedVl = 1000
        case 1001:
             selectedVl = 1001
        case 1002:
             selectedVl = 1002
        default:
            print("ds")
        }
        headView.searchField.text = ""
        pageNo = 0
        walletTransactionsAPI(searchValue: "")
 //        tableView.reloadData()
    }
    
    @objc func searchFromHeader(_ sender : UIButton){
           pageNo = 0
           walletTransactionsAPI(searchValue: "")
       }
    
    @objc func filterTabClicked(_ sender : UIButton){
        
        let vc = WalletFilterNewViewController(nibName: "WalletFilterNewViewController", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func emailBtnClicked(_ sender : UIButton){
        emailTransactionsAPI()
    }
    
    @objc func downloadBtnClicked(_ sender : UIButton){
        
        var userID = ""
        let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
        userID = "\(userid.data!.id)"
        
        var tabID = ""
        if selectedVl == 1000 { tabID = "1" }
        else if selectedVl == 1001 { tabID = "2" }
        else { tabID = "3" }
        
        var payType = ""
        if tabID == "3" {
           payType = "\(bankTransferType)"
        }else{
            payType = "none"
        }
        
        let str = "\(Constant.BASE_URL)wallet/download_wallet_pdf/\(userID)/\(tabID)/none/none/none/none/\(payType)/\(HeaderHeightSingleton.shared.LanguageSelected)/"
                         
        let url = str
        let fileName = "MyFile pdf"
        
        savePdf(urlString: url, fileName: fileName)
    }
    
    func savePdf(urlString:String, fileName:String) {
            DispatchQueue.main.async {
                let url = URL(string: urlString)
                let pdfData = try? Data.init(contentsOf: url!)
                let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
                let pdfNameFromUrl = "YourAppName-\(fileName).pdf"
                let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
                do {
                    try pdfData?.write(to: actualPath, options: .atomic)
                    print("pdf successfully saved!")
                    ModalController.showSuccessCustomAlertWith(title: "", msg: "Downloaded successfully.")
    //file is downloaded in app data container, I can find file from x code > devices > MyApp > download Container >This container has the file
                } catch {
                    print("Pdf could not be saved")
                }
            }
        }
    
    @objc func progressBtnOutletClicked(_ sender : UIButton){
        if bankTransferType == 2 {
            bankTransferType = 1
            walletTransactionsAPI(searchValue: "")
        }
    }
    
    @objc func successBtnOutletClicked(_ sender : UIButton){
        if bankTransferType == 1 {
            bankTransferType = 2
            walletTransactionsAPI(searchValue: "")
        }
    }
    
    
    @objc func sendMoneyClicked(){
        let vc = BankListViewController(nibName: "BankListViewController", bundle: nil)
        
        if wholeDict.count > 0 {
            vc.walletValue = Double(Float((self.wholeDict.object(forKey: "head_data") as! NSDictionary).object(forKey: "main_available") as! String)!)
        }
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BankAllListViewController :  UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.transactionListArray.count == 0
        {
            return 3
        }
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       if indexPath.section == 2{
            return 300
       }
        if indexPath.section == 0{
             return 135
        }else{
            if indexPath.row == self.transactionListArray.count{
                return 30
            }
            if selectedVl == 1002 {
                return 127
            }else{
                return UITableView.automaticDimension
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1{
//            let headView = BankHeader()
             headView.holdingAmount.tag = 1001
            headView.paymentProgress.tag = 1002
            headView.walletBalance.tag = 1000
            headView.paymentsucceslbl.text = "Payment Successfully".localized
            
            if selectedVl == 1000{
                
                if wholeDict.count > 0 {
                    headView.totalLbl.text = "\(self.wholeDict.object(forKey: "wallet_total_bal") as! String)"
                    headView.availableLbl.text = "\("Available".localized): SAR \(self.wholeDict.object(forKey: "wallet_available_bal") as! String)"
                }else{
                    headView.totalLbl.text = ""
                    headView.availableLbl.text = "\("Available".localized): SAR"
                }
                
                headView.bankVwHeight.constant = 0
                headView.bankVw.isHidden = true
                
                headView.firstLbl.isHidden = false
                headView.secondLbl.isHidden = true
                headView.thirdLbl.isHidden = true
                headView.walletBalance.backgroundColor = UIColor.white
                headView.holdingAmount.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.paymentProgress.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.walletBalance.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
                headView.holdingAmount.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.paymentProgress.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.walletBalance.titleLabel?.font = UIFont(name: fontNameBold, size: 12.0)
                headView.holdingAmount.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)
                headView.paymentProgress.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)

                headView.holdingAmount.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.holdingAmount.borderWidth = 0.2
                
                headView.paymentProgress.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.paymentProgress.borderWidth = 0.2
                
                headView.walletBalance.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                headView.walletBalance.borderWidth = 0.2
                
                
                
            }else if selectedVl == 1001{
                
                //Available: SAR 400
                
                if wholeDict.count > 0 {
                    headView.totalLbl.text = "\(self.wholeDict.object(forKey: "wallet_total_bal") as! String)"
                    headView.availableLbl.text = "\("Holding".localized): SAR \(self.wholeDict.object(forKey: "wallet_holding_bal") as! String)"
                }else{
                    headView.totalLbl.text = ""
                    headView.availableLbl.text = "\("Holding".localized): SAR"
                }
                
                headView.bankVwHeight.constant = 0
                headView.bankVw.isHidden = true
                
                headView.firstLbl.isHidden = true
                headView.secondLbl.isHidden = false
                headView.thirdLbl.isHidden = true
                headView.walletBalance.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.holdingAmount.backgroundColor = UIColor.white
                headView.paymentProgress.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.paymentProgress.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.holdingAmount.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
                headView.walletBalance.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.holdingAmount.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                headView.holdingAmount.borderWidth = 0.2
                
                headView.paymentProgress.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.paymentProgress.borderWidth = 0.2
                
                headView.walletBalance.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.walletBalance.borderWidth = 0.2
                headView.walletBalance.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)
                headView.holdingAmount.titleLabel?.font = UIFont(name: fontNameBold, size: 12.0)
                headView.paymentProgress.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)
                
            }else{
                
                if bankTransferType == 1 {
                    headView.progressBtnOutlet.isSelected = true
                    headView.successBtnOutlet.isSelected = false
                    
                    if wholeDict.count > 0 {
                        headView.totalLbl.text = "\(self.wholeDict.object(forKey: "wallet_total_bal") as! String)"
                        headView.availableLbl.text = "\("Payment in Progress".localized): SAR \(self.wholeDict.object(forKey: "wallet_available_bal") as! String)"
                    }else{
                        headView.totalLbl.text = ""
                        headView.availableLbl.text = "\("Payment in Progress".localized): SAR"
                    }
                    
                }else{
                    headView.progressBtnOutlet.isSelected = false
                    headView.successBtnOutlet.isSelected = true
                    
                    if wholeDict.count > 0 {
                        headView.totalLbl.text = "\(self.wholeDict.object(forKey: "wallet_total_bal") as! String)"
                        headView.availableLbl.text = ""
                    }else{
                        headView.totalLbl.text = ""
                        headView.availableLbl.text = ""
                    }
                }
                
                
                headView.bankVwHeight.constant = 50
                headView.bankVw.isHidden = false
                
                headView.firstLbl.isHidden = true
                headView.secondLbl.isHidden = true
                headView.thirdLbl.isHidden = false
                headView.walletBalance.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.holdingAmount.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headView.paymentProgress.backgroundColor = UIColor.white
                headView.walletBalance.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.holdingAmount.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headView.paymentProgress.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
                
                headView.holdingAmount.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.holdingAmount.borderWidth = 0.2
                
                headView.paymentProgress.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                headView.paymentProgress.borderWidth = 0.2
                
                headView.walletBalance.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headView.walletBalance.borderWidth = 0.2
                headView.walletBalance.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)
                headView.holdingAmount.titleLabel?.font = UIFont(name: fontNameLight, size: 12.0)
                headView.paymentProgress.titleLabel?.font = UIFont(name: fontNameBold, size: 12.0)
            }
            headView.walletBalance.addTarget(self, action: #selector(walletBalance(_:)), for: .touchUpInside)
            headView.holdingAmount.addTarget(self, action: #selector(walletBalance(_:)), for: .touchUpInside)
            headView.paymentProgress.addTarget(self, action: #selector(walletBalance(_:)), for: .touchUpInside)
            
            headView.searchBtnOutlet.addTarget(self, action: #selector(searchFromHeader(_:)), for: .touchUpInside)
            
            headView.progressBtnOutlet.addTarget(self, action: #selector(progressBtnOutletClicked(_:)), for: .touchUpInside)
            headView.successBtnOutlet.addTarget(self, action: #selector(successBtnOutletClicked(_:)), for: .touchUpInside)
            
            headView.filterBtnOutlet.addTarget(self, action: #selector(filterTabClicked(_:)), for: .touchUpInside)
            
            headView.emailBtnOutlet.addTarget(self, action: #selector(emailBtnClicked(_:)), for: .touchUpInside)
            
            headView.downloadBtnOutlet.addTarget(self, action: #selector(downloadBtnClicked(_:)), for: .touchUpInside)
            
            
            var count = 0
            if minAmount == 0.0 && maxAmount == 0.0 {
                count = 0
            }else{
                count = count + 1
            }
                    
            if fromStr == "" {
            }else{
                count = count + 1
            }
                
            if count == 0 {
                headView.filterCountLbl.isHidden = true
            }else{
                headView.filterCountLbl.text = "\(count)"
                headView.filterCountLbl.isHidden = false
            }
            
            
            
            return headView
        }else{
            return UIView()
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            
        if selectedVl == 1002{
            return 285
        }else{
            return 225
            }
        }else{
            return 0
        }
    }
    
}

extension BankAllListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
             return 1
        }
        else if section == 0{
             return 1
        }else{
            
            if wholeDict.count > 0 {
            let tot_record = wholeDict.object(forKey: "total_records") as! NSNumber
            if Int(tot_record) > self.transactionListArray.count {
                return self.transactionListArray.count + 1
            }else{
                return self.transactionListArray.count
            }
            }else{
                return 0
            }
        }
       
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2
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
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "WalletAvailableTopCell", for: indexPath) as! WalletAvailableTopCell
            cell.sendMoney.addTarget(self, action:#selector(sendMoneyClicked), for:.touchUpInside)
            cell.totalamtlbl.text = "Total Balance".localized
            if wholeDict.count > 0 {
                cell.totalLbl.text = "\((self.wholeDict.object(forKey: "head_data") as! NSDictionary).object(forKey: "main_total_balance") as! String)"
                cell.availableLbl.text = "\("Available".localized): SAR \((self.wholeDict.object(forKey: "head_data") as! NSDictionary).object(forKey: "main_available") as! String)"
            }else{
                cell.totalLbl.text = ""
                cell.availableLbl.text = "\("Available".localized): SAR"
            }
            
            cell.selectionStyle = .none
                  return cell
        }else{
            if indexPath.row == self.transactionListArray.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ShowMoreViewCell", for: indexPath) as! ShowMoreViewCell
                cell.showMore.setTitle("Show More".localized, for: .normal)
                cell.showMore.addTarget(self, action: #selector(showClicked), for: .touchUpInside)
                return cell
            }else{
                if selectedVl == 1000{
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "WalletNewSimpleTableViewCell", for: indexPath) as! WalletNewSimpleTableViewCell
                    cell.walletIcon.isHidden = true
                    cell.holdingLbl.isHidden = true
                    cell.transHeight.constant = 17
                    cell.selectionStyle = .none
                    
                    cell.titleLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_remarks") as! String)"
                    
                   let orderIds = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_order_id") as! String)"
                    cell.transactionLbl.text = orderIds
                    cell.underline.isHidden = false
                    
                    cell.orderIdLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_trans_id") as! String) |  \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_date") as! String)"
                    
                    let creditDebit = (self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_dr_cr_flag") as! String
                    let currency = (self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_currency") as! String
                    if creditDebit == "C" {
                        cell.priceLbl.text = "(-) \(currency) \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_amount") as! String)"
                        cell.priceLbl.textColor = UIColor(red: 236/256, green: 74/256, blue: 83/256, alpha: 1.0)
                    }else{
                        cell.priceLbl.text = "\(currency) \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_amount") as! String)"
                        cell.priceLbl.textColor = UIColor(red: 97/256, green: 192/256, blue: 136/256, alpha: 1.0)
                    }
                    
                    if cell.transactionLbl.text == "" {
                        cell.transHeight.constant = 0
                    }else{
                        cell.transHeight.constant = 17
                    }
                    cell.viewInvoice.isHidden = false
                  
                    cell.viewInvoice.tag = indexPath.row
                    cell.viewInvoice.addTarget(self, action: #selector(clickedViewInvoice(_:)), for: .touchUpInside)
                    return cell
                    
                }else if selectedVl == 1001{
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionInnerTableCell", for: indexPath) as! TransactionInnerTableCell
//                    cell.transcIcon.isHidden = false
//                    cell.orderId.isHidden = false
//                    cell.amountType.isHidden = false
//                    cell.walletIcon.isHidden = false
//                    cell.userType.isHidden = true
//                    cell.selectionStyle = .none
//                    return cell
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "WalletNewSimpleTableViewCell", for: indexPath) as! WalletNewSimpleTableViewCell
                    cell.walletIcon.isHidden = false
                    cell.holdingLbl.isHidden = false
                    cell.transHeight.constant = 17
                    cell.selectionStyle = .none
                    
                    cell.titleLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_remarks") as! String)"
                    
                    let orderIds = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_order_id") as! String)"
                     cell.transactionLbl.text = orderIds
                    cell.underline.isHidden = true
                    cell.orderIdLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_trans_id") as! String) |  \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_date") as! String)"
                    let currency = (self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_currency") as! String
                    let creditDebit = (self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_dr_cr_flag") as! String
                    if creditDebit == "D" {
                        cell.priceLbl.text = "(-) \(currency) \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_amount") as! String)"
                        cell.priceLbl.textColor = UIColor(red: 236/256, green: 74/256, blue: 83/256, alpha: 1.0)
                    }else{
                        cell.priceLbl.text = "\(currency) \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_amount") as! String)"
                        cell.priceLbl.textColor = UIColor(red: 97/256, green: 192/256, blue: 136/256, alpha: 1.0)
                    }
                    cell.priceLbl.text = "SAR \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_amount") as! String)"
                    cell.viewInvoice.isHidden = true
                  
                    return cell
                    
                }
                else{
//                    let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentProgressTableViewCell", for: indexPath) as! PaymentProgressTableViewCell
//                    return cell
                    let cell = tableView.dequeueReusableCell(withIdentifier: "WalletTransferReqNewTableViewCell", for: indexPath) as! WalletTransferReqNewTableViewCell
                    cell.statuslbl.text = "\("Status".localized):"
                    if bankTransferType == 2 {
                        
                        cell.titleLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_remarks") as! String)"
                        
                        cell.transactionLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_order_id") as! String)"
                        
                        cell.orderIdLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_trans_id") as! String) |  \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_date") as! String)"
                        
                        cell.priceLbl.text = "SAR \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_amount") as! String)"
                        
                        cell.walletIcon.isHidden = true
                        cell.holdingLbl.isHidden = true
                        cell.infoOutlet.isHidden = true
                        cell.rejectedLbl.text = "Transferred".localized
                        cell.rejectedLbl.textColor = UIColor(red: 43/256, green: 163/256, blue: 215/256, alpha: 1.0)
                        cell.reasonVw.isHidden = true
                        cell.infoWidth.constant = 0
                        
                    }
                    
                    else{
                        cell.titleLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_remarks") as! String)"
                        
                        cell.transactionLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_order_id") as! String)"
                        
                        cell.orderIdLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_trans_id") as! String) |  \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_date") as! String)"
                        
                        cell.holdingLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_type") as! String)"
                        
                        let creditDebit = (self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_status") as! Int
                        let currency = (self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_currency") as! String
                        
                        if creditDebit == 2 {
                            cell.priceLbl.text = "(-) \(currency) \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_amount") as! String)"
                            cell.rejectedLbl.textColor = UIColor(red: 236/256, green: 74/256, blue: 83/256, alpha: 1.0)
                            cell.rejectedLbl.text = "Rejected".localized;
                            cell.infoWidth.constant = 30
                            cell.infoOutlet.isHidden = false
                            cell.priceLbl.textColor = UIColor(red: 236/256, green: 74/256, blue: 83/256, alpha: 1.0)
                            cell.holdingLbl.textColor = UIColor(red: 97/256, green: 192/256, blue: 136/256, alpha: 1.0)
                        }else{
                            cell.priceLbl.text = "\(currency) \((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_amount") as! String)"
                            cell.rejectedLbl.text = "Pending".localized
                            cell.rejectedLbl.textColor = UIColor(red: 43/256, green: 163/256, blue: 215/256, alpha: 1.0)
                            cell.infoWidth.constant = 0
                            cell.infoOutlet.isHidden = true
                            cell.priceLbl.textColor = UIColor(red: 97/256, green: 192/256, blue: 136/256, alpha: 1.0)
                            cell.holdingLbl.textColor = UIColor(red: 236/256, green: 74/256, blue: 83/256, alpha: 1.0)
                        }
                        
                       
                        
                        cell.reasonLbl.text = "\((self.transactionListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "txn_rejection_reason") as! String)"
                        
                        cell.walletIcon.isHidden = false
                        cell.holdingLbl.isHidden = false
                         if cell.reasonLbl.text == ""
                         {
                            cell.reasonVw.isHidden = true
                         }
                        else
                         {
                            cell.reasonVw.isHidden = false
                         }
                        if cell.transactionLbl.text == ""
                        {
                            cell.transIconWidth.constant = 0
                            cell.leadingWalletConst.constant = -9
                        }else{
                            cell.transIconWidth.constant = 17
                          cell.leadingWalletConst.constant = 10.5
                        }
                    }
                    
                    cell.selectionStyle = .none
                    return cell
                    
                }
            }
            
            
        }
      
    }
    @objc func clickedViewInvoice(_ sender:UIButton)
    {
      
        let invoce = (self.transactionListArray.object(at: sender.tag) as! NSDictionary).object(forKey: "txn_invoice_for") as! Int
        let fyid = (self.transactionListArray.object(at: sender.tag) as! NSDictionary).object(forKey: "fynoo_id") as! String
        let orderid = (self.transactionListArray.object(at: sender.tag) as! NSDictionary).object(forKey: "txn_order_id") as! String
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.viewinvoice)"
        let parameters = [
            "order_id": orderid,
            "invoice_for": invoce,
            "fynoo_id": fyid,
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ] as [String : Any]
        print("request -",parameters)
       // AMShimmer.start(for: self.tableView)
        
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            
            AMShimmer.stop(for: self.tableView)
            DispatchQueue.main.async {
            AMShimmer.stop(for: self.view)
            }
            
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
    @objc func showClicked(){
        pageNo += 1
        walletTransactionsAPI(searchValue: "")
    }
    
    
    // MARK: - WALLET TRANSACTIONS LIST API
    func walletTransactionsAPI(searchValue : String)
    {
      
        var am_range = ""
        
        if minAmount == 0.0 && maxAmount == 0.0 {
            am_range = ""
        }else{
            am_range = "\(minAmount)-\(maxAmount)"
        }
        
        var da_range = ""
        
        if fromStr == "" {
            da_range = ""
        }else{
            
            let dfmatter = DateFormatter()
            dfmatter.dateFormat="dd/MM/yyyy"
            let date = dfmatter.date(from: "\(fromStr)")
            let dateStamp:TimeInterval = date!.timeIntervalSince1970
            let dateSt:Int = Int(dateStamp)
            
            let dfmatter1 = DateFormatter()
            dfmatter1.dateFormat="dd/MM/yyyy"
            let date1 = dfmatter1.date(from: "\(toStr)")
            let dateStamp1:TimeInterval = date1!.timeIntervalSince1970
            let dateSt1:Int = Int(dateStamp1)
            
            
            da_range = "\(dateSt)-\(dateSt1)"
        }
        
        var userID = ""
        let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
        userID = "\(userid.data!.id)"
        
        var tabID = ""
        if selectedVl == 1000 { tabID = "1" }
        else if selectedVl == 1001 { tabID = "2" }
        else { tabID = "3" }
        
        var payType = ""
        if tabID == "3" {
           payType = "\(bankTransferType)"
        }
        
        let sea = headView.searchField.text!
        
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.allWalletTransactionsAPI)"
        let parameters = [
            "next_page_no": "\(pageNo)",
            "bo_id": userID,
            "tab_id": "\(tabID)",
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
            "payment_type": "\(payType)",
            "search": sea,
            "AMOUNT_RANGE": am_range,
            "DATE_RANGE": da_range
        ]
        print("request -",parameters)
       // AMShimmer.start(for: self.tableView)
        
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            
            AMShimmer.stop(for: self.tableView)
            DispatchQueue.main.async {
            AMShimmer.stop(for: self.view)
            }
            
            ModalClass.stopLoadingAllLoaders(self.view)
            if success == true {
                
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
                ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "error_description") as? String)!, msg: "")
                    self.transactionListArray.removeAllObjects()
                    self.tableView.reloadData()
                }
                else{
                    if self.pageNo == 0 {
                    self.transactionListArray.removeAllObjects()
                    }

                    self.wholeDict = ResponseDict.object(forKey: "data") as! NSDictionary
                    let results = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "txn_list") as! NSArray
                    for var i in (0..<results.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.transactionListArray.add(dict)
                    }
                    self.tableView.reloadData()
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
    
    func clearAllClicked() {
        
         minAmount = 0.0
         maxAmount = 0.0
         fromStr = ""
         toStr = ""
        
        headView.searchField.text = ""
        pageNo = 0
        walletTransactionsAPI(searchValue: "")
        
    }
    
    func applyFilerClicked(min: Double, max: Double, fromD: String, toD: String) {
        
        minAmount = min
        maxAmount = max
        fromStr = fromD
        toStr = toD
        
        headView.searchField.text = ""
        pageNo = 0
        walletTransactionsAPI(searchValue: "")
    }
    
    // MARK: - EMAIL TRANSACTIONS API
    func emailTransactionsAPI()
    {
      
        var userID = ""
        let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
        userID = "\(userid.data!.id)"
        
        var tabID = ""
        if selectedVl == 1000 { tabID = "1" }
        else if selectedVl == 1001 { tabID = "2" }
        else { tabID = "3" }
        
        var payType = ""
        if tabID == "3" {
           payType = "\(bankTransferType)"
        }
                        
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.send_wallet_pdf_email)"
        let parameters = [
            "bo_id": userID,
            "tab_id": "\(tabID)",
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
            "payment_type": "\(payType)",
            "from_date": "",
            "to_date": "",
            "from_amount": "",
            "to_amount": "",
        ]
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
                    ModalController.showSuccessCustomAlertWith(title: "", msg: (ResponseDict.object(forKey: "error_description") as? String)!)
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
}
