//
//  BankListViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 31/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import PopupDialog
import AMShimmer

protocol selectedBankDetail
{
    func selectedBank(bankDict:NSDictionary)
}
class BankListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, BankListTableViewCellDelegate, SearchBankTableViewCellDelegate {
    func addNewBankClicked(_ sender: Any) {
        print("nrw")
    }
    
    @IBOutlet weak var addnewbankout: UIButton!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var uppperVwHeight: NSLayoutConstraint!
    
    @IBOutlet weak var navigationView: NavigationView!
    
    @IBOutlet weak var selectedBank: UIButton!
    let vc = AddNewBankViewController(nibName: "AddNewBankViewController", bundle: nil)
    let arr_bankId:NSMutableArray = NSMutableArray()
    @IBOutlet weak var tableVw: UITableView!
    var delegate : selectedBankDetail?
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bankLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    var bank_list: BankList?
    var delete_bank: DeleteBank?
    var bankListArray : NSMutableArray = NSMutableArray()
    var filterListArray : NSMutableArray = NSMutableArray()
    var isFrom = false
    
    @IBOutlet weak var availlbl: UILabel!
    var walletValue = 0.0
    var bankView = BankViewModal()
    var bankList : BankList?
    @IBOutlet weak var walletbanklbl: UILabel!
    
    @IBOutlet weak var sendmoneylbl: UILabel!
    var chosenRow = 99999
 
    override func viewDidLoad() {
        super.viewDidLoad()
        availlbl.text = "\("Available Balance".localized): SAR"
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        sendmoneylbl.font = UIFont(name:"\(fontNameLight)",size:15)
        walletbanklbl.font = UIFont(name:"\(fontNameLight)",size:15)
        availlbl.font = UIFont(name:"\(fontNameLight)",size:11)
        balanceLbl.font = UIFont(name:"\(fontNameLight)",size:11)
        bankLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        addnewbankout.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:15)
        self.arrowImg.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"right_arrow_new")!)
        
        self.balanceLbl.text = String(format: "%.2f", walletValue)
        
        self.navigationView.viewControl = self
        self.navigationView.titleHeader.text = "Manage Your Wallet".localized
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        registerCellNibs()
    
    //    self.uppperVwHeight.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight) + 80.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        chosenRow = 99999
        bankListAPI()
        
//        bankView.getBankList { [weak self] (success, response) in
//            if success{
//                self?.bankList = response
//                self!.tableVw.reloadData()
//            }
//        }
        
    }
    
    
    @objc func editClicked(_ sender : UIButton){
        let vc = AddNewBankViewController(nibName: "AddNewBankViewController", bundle: nil)
        vc.isForEdit = true
        let bankId = self.bankList?.data?.users_bank?[sender.tag].bank_id ?? 0
         let bankName = self.bankList?.data?.users_bank?[sender.tag].bank_name ?? ""
        vc.selectedBankDict.setValue(bankId, forKey: "id")
        vc.selectedBankDict.setValue(bankName, forKey: "bank_name")
        let currency_id = self.bankList?.data?.users_bank?[sender.tag].currency_id ?? 0
        let currency_code = self.bankList?.data?.users_bank?[sender.tag].currency_code ?? ""
        vc.currencyDict.setValue(currency_id, forKey: "currency_id")
        vc.currencyDict.setValue(currency_code, forKey: "currency_code")
        vc.bankIds = self.bankList?.data?.users_bank?[sender.tag].id ?? 0
        let short_name =  self.bankList?.data?.users_bank?[sender.tag].short_name ?? ""
        vc.bankDetail.setValue(short_name, forKey: "short_name")
        let full_name =  self.bankList?.data?.users_bank?[sender.tag].full_name ?? ""
        vc.bankDetail.setValue(full_name, forKey: "full_name")
        let account_iban_nbr =  self.bankList?.data?.users_bank?[sender.tag].account_iban_nbr ?? ""
        vc.bankDetail.setValue(account_iban_nbr, forKey: "account_iban_nbr")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func transferRequest(){
        
        
        let vc = BankTransferController(nibName: "BankTransferController", bundle: nil)
        vc.walletValue = walletValue
      //  vc.bankId = (self.bankListArray.object(at: (sender as AnyObject).tag) as! NSDictionary).object(forKey: "bank_id") as! NSNumber
        self.navigationController?.pushViewController(vc, animated: true)
    }
   @objc func addNewClicked() {
         let vc = AddNewBankViewController(nibName: "AddNewBankViewController", bundle: nil)
         self.navigationController?.pushViewController(vc, animated: true)
     }
    @IBAction func selectedBank(_ sender: Any) {
        
        if bankListArray.count == 0{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Select Bank First")
            return
        }
        let selectedDetailsDictTransfer = self.bankListArray.object(at: selectedIndex) as! NSDictionary
           delegate?.selectedBank(bankDict: selectedDetailsDictTransfer)
           self.navigationController?.popViewController(animated: true)
   
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func registerCellNibs(){
        tableVw.delegate = self
        tableVw.dataSource = self
        tableVw.register(UINib(nibName: "BankListAddCell", bundle: nil), forCellReuseIdentifier: "BankListAddCell");
        tableVw.register(UINib(nibName: "BankListTableViewCell", bundle: nil), forCellReuseIdentifier: "BankListTableViewCell");
    }
    
    //MARK:-- TABLE DATA SOURCE DELEGATES
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 1
        }else{
            
            
            
            return bankListArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BankListAddCell", for: indexPath) as! BankListAddCell
            cell.transferRequest.addTarget(self, action: #selector(transferRequest), for: .touchUpInside)
            cell.addNewBank.addTarget(self, action: #selector(addNewClicked), for: .touchUpInside)
                   return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BankListTableViewCell", for: indexPath) as! BankListTableViewCell
            cell.delegate = self
            cell.tag = indexPath.row
            
            cell.selectionStyle = .none
            
            cell.nameHolder.text = "\((self.bankListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "full_name") as! String)"
            
            cell.bankNameLbl.text = "\((self.bankListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "bank_name") as! String)"
            
            let ib = "IBAN No.".localized
            
            let last = (self.bankListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "account_iban_nbr") as! String
            
            let last4 = String(last.suffix(4))
            
            
            cell.accountNoLbl.text = "\(ib) **** \(last4)"
            
            if chosenRow == indexPath.row {
                cell.bankSelect.isSelected = true
                cell.transferRequest.backgroundColor = UIColor(red: 97/256, green: 192/256, blue: 136/256, alpha: 1.0)
            }else{
                cell.bankSelect.isSelected = false
                cell.transferRequest.backgroundColor = UIColor(red: 236/256, green: 74/256, blue: 83/256, alpha: 1.0)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenRow = indexPath.row
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 1{
            return 128
        }
     return 130
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
        
            
             var userID = ""
                   let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
                   userID = "\(userid.data!.id)"
                   
                   ModalClass.startLoading(self.view)
                   let str = "\(Constant.BASE_URL)\(Constant.deleteBankNewAPI)"
                   let parameters = [
                       "user_id": userID,
                       "user_bank_id": "\((self.bankListArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "id") as! NSNumber)",
                       "lang_code":HeaderHeightSingleton.shared.LanguageSelected
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
                            
                            ModalController.showSuccessCustomAlertWith(title: "", msg:"\(ResponseDict.object(forKey: "error_description") as! String)")
                            self.bankListAPI()
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

    
    // MARK: - TableView Cells Return
   
    var selectedIndex = 0
   
    
    func editBankClicked(tag: Int){
        let vc = AddNewBankViewController(nibName: "AddNewBankViewController", bundle: nil)
//        if filterListArray.count > 0 {
//            vc.selectedDetailsDictTransfer = self.filterListArray.object(at: tag) as! NSDictionary
//        }else{
//            vc.selectedDetailsDictTransfer = self.bankListArray.object(at: tag) as! NSDictionary
//        }
        vc.bankDetail = self.bankListArray.object(at: tag) as! NSDictionary
        vc.selectedID = Int((self.bankListArray.object(at: tag) as! NSDictionary).object(forKey: "id") as! NSNumber)
        vc.isForEdit = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteBankClicked(_ sender: Any){
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.DeleteBankURL)"
        var mainArr : NSMutableArray = NSMutableArray()
        if self.filterListArray.count > 0{
            mainArr = self.filterListArray
        }else{
            mainArr = self.bankListArray
        }
        let parameters = [
            "bank_account_id":"\((mainArr.object(at: (sender as AnyObject).tag) as! NSDictionary).object(forKey: "id") as! NSNumber)","lang_code":HeaderHeightSingleton.shared.LanguageSelected,
            "user_id":Singleton.shared.getUserId(),
        ]
                
        print("request -",parameters)
        
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            
            ModalClass.stopLoading()
            
            if success == true {
                
                self.delete_bank = try! JSONDecoder().decode(DeleteBank.self, from: resp as! Data)
                
                if self.delete_bank!.error! {
        ModalController.showNegativeCustomAlertWith(title:"\(self.delete_bank!.error_description!)", msg: "")
                    
                }
                    
                else{
                    ModalController.showNegativeCustomAlertWith(title:" ", msg: "Deleted Successfully.")
                    self.filterListArray.removeAllObjects()
                  //  self.bankListApi()
                }
            }
                
            else{
                
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
    
 
    
//    Function -API INtegration
//    func bankListApi() {
//        ModalClass.startLoading(self.view)
//        let str = "\(Constant.BASE_URL)\(Service.BankList)"
//        let parameters = [
//            "user_id": Singleton.shared.getUserId(),
//        ]
//        print("request -",parameters)
//        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
//            ModalClass.stopLoading()
//
//            if success == true {
//                self.bank_list = try! JSONDecoder().decode(BankList.self, from: resp as! Data)
//                 if self.bank_list!.error! {
//                    ModalController.showNegativeCustomAlertWith(title:"\(self.bank_list!.error_description!)", msg: "")
//                    self.bankListArray.removeAllObjects()
//                    self.tableVw.dataSource = self
//                    self.tableVw.delegate = self
//                    self.tableVw.reloadData()
//                }
//                else{
//                    self.bankListArray.removeAllObjects()
//                    let ResponseDict : NSDictionary = (response as? NSDictionary)!
//                    let results = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "bank_details") as! NSArray
//                    for var i in (0..<results.count){
//                        let dict : NSDictionary = NSDictionary(dictionary: results.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
//                        self.bankListArray.add(dict)
//                    }
//                    self.tableVw.dataSource = self
//                    self.tableVw.delegate = self
//                    self.tableVw.reloadData()
//
//                    }
//                }
//            else{
//
//                if response == nil{
//
//                    print ("connection error")
//
//                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
//
//                }else{
//
//                    print ("data not in proper json")
//
//                }
//
//            }
//
//        }
//
//
//    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let textStr = textField.text {
            if self.bankListArray.count == 0{
                return
            }
    
            let searchPredicate = NSPredicate(format: "bank_name CONTAINS[C] %@", textStr)
            let array = (bankListArray as NSArray).filtered(using: searchPredicate)
            
            if(array.count == 0){
                self.filterListArray.removeAllObjects()
            } else {
                self.filterListArray.removeAllObjects()
                for var i in (0..<array.count)
                {
                    self.filterListArray.add((array[i] as! NSDictionary).RemoveNullValueFromDic())
                }
            }
            print(self.filterListArray)
            tableVw.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .none)
        }
    }
    
    @IBAction func addNewBankBtn(_ sender: Any) {
        let vc = AddNewBankViewController(nibName: "AddNewBankViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func transferBtnClicked(_ sender: Any) {
        
        if chosenRow != (sender as AnyObject).tag {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please select this bank for transfer request")
            return
        }
            
            
        let vc = BankTransferController(nibName: "BankTransferController", bundle: nil)
        vc.walletValue = walletValue
        vc.bankId = Int((self.bankListArray.object(at: (sender as AnyObject).tag) as! NSDictionary).object(forKey: "id") as! NSNumber)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - BANK LIST API
    func bankListAPI()
    {
      
        var userID = ""
        let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
        userID = "\(userid.data!.id)"
        
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.addedBanksList)"
        let parameters = [
            "user_id": userID,
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        print("request -",parameters)
        AMShimmer.start(for: self.tableVw)
        
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoadingAllLoaders(self.view)
            
            AMShimmer.stop(for: self.tableVw)
            DispatchQueue.main.async {
            AMShimmer.stop(for: self.view)
            }
            
            if success == true {
                
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
                ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "error_description") as? String)!, msg: "")
                    self.bankListArray.removeAllObjects()
                    self.tableVw.reloadData()
                }
                else{
                    self.bankListArray.removeAllObjects()

              //      self.wholeDict = ResponseDict.object(forKey: "data") as! NSDictionary
                    let results = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "users_bank") as! NSArray
                    for var i in (0..<results.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.bankListArray.add(dict)
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
}
