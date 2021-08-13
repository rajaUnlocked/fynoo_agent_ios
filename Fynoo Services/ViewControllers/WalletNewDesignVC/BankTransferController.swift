//
//  BankTransferController.swift
//  Fynoo Business
//
//  Cr eated by SENDAN on 01/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import PopupDialog

class BankTransferController: UIViewController, UITextFieldDelegate, TransactionNewPopupViewControllerDelegate {

    
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
 
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
                
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var addmoneylbl: UILabel!
    @IBOutlet weak var availlbl: UILabel!
    
    @IBOutlet weak var remarklbl: UILabel!
    @IBOutlet weak var banklbl: UILabel!
    var bankId = 0
    var walletValue = 0.0
    var selectedDetailsDictTransfer : NSDictionary = NSDictionary()
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        ModalController.watermark(self.view)
        super.viewDidLoad()
        
        print(bankId)
        print(walletValue)
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        addmoneylbl.font = UIFont(name:"\(fontNameLight)",size:16)
        banklbl.font = UIFont(name:"\(fontNameLight)",size:14)
        availlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        remarklbl.font = UIFont(name:"\(fontNameLight)",size:12)
        currency.font = UIFont(name:"\(fontNameLight)",size:12)
        amount.font = UIFont(name:"\(fontNameLight)",size:16)
        remarklbl.font = UIFont(name:"\(fontNameLight)",size:12)
        txtView.font = UIFont(name:"\(fontNameLight)",size:12)
        proceedBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:15)
        
        
        self.amount.addTarget(self, action: #selector(BankTransferController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    
        let doubleStr = String(format: "%.2f", walletValue) // "3.14"
        
        let sa = "SAR".localized
//        totalAmount.attributedText = ModalController.setMultiColorTextString(str: "\(sa) \(walletValue)", str1: "\(sa)", str2: String(format: "%.2f", walletValue))
        totalAmount.text = "\(sa) \(doubleStr)"
        amount.delegate = self
        navigationView.viewControl = self
        navigationView.titleHeader.text = "Manage Your Wallet".localized
        topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        viewWidth.constant = UIScreen.main.bounds.width
        proceedBtn.addTarget(self, action: #selector(proceedClicked), for: .touchUpInside)
        proceedBtn.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 40)

        currency.attributedText = ModalController.setStricColor1(str: "\(sa) *", str1: "\(sa)", str2:" *" )
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty{
            return
        }
        
        let value = Double(textField.text!)
        if value! > walletValue{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Insufficient Balance")
            return
        }
        
        print(value!)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
          
        if textField.text != "" {
            let txt = Double(textField.text!)
            
            if txt! > self.walletValue {
        
                ModalController.showNegativeCustomAlertWith(title: "", msg: "You cannot transfer more than the available balance".localized)
                    
                    var str = textField.text!
                    let choppedString = String(str.dropLast())
                    amount.text = choppedString
            }
        }
        
    }

    @objc func proceedClicked(_ sender:UIButton){
        
        
        if amount.text == "" {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter amount".localized)
            return
        }
        
        if  amount.text == "0.0" || amount.text == "0"{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Amount Can't be Zero")
            return
        }
        
        let am = Double(self.amount.text!)
        if am! > self.walletValue {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Enter valid amount")
            return
        }
        
        let vc = TransactionNewPopupViewController(nibName: "TransactionNewPopupViewController", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        vc.delegate =  self
        self.present(vc, animated: true, completion: nil)
        
        
        
        
//        let obj = BankViewModal()
//        obj.TransferToBank(BankId: bankId, remark: txtView.text!, amount: Double(amount.text!)!) { (success, response) in
//            if success{
//
//                if let value = response?.object(forKey: "error_description") as? String{
//                    ModalController.showSuccessCustomAlertWith(title: "", msg: value)
//                    let vc = BankTransferHistoryController(nibName: "BankTransferHistoryController", bundle: nil)
//                    //
//                    //        vc.walletValue = "\(transactionData?.data?.wallet_summary?.wallet_free_bal ?? 0.0)"
//                    self.navigationController?.pushViewController(vc, animated: true)
//
//                }
//            }
//        }
        
        // transferProceed()
    }
    
    func yesTransactionClicked() {
        
                    ModalClass.startLoading(self.view)
                    let str = "\(Constant.BASE_URL)\(Constant.transferMoneyApi)"
                    let parameters = [
                        "user_id":Singleton.shared.getUserId(),
                        "amount":self.amount.text!,
                        "remarks":self.txtView.text!,
                        "user_bank_id":"\(bankId)",
                        "lang_code":HeaderHeightSingleton.shared.LanguageSelected
                    ]
                    print("request -",parameters)
                    ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
                        ModalClass.stopLoading()
                        if let value = response as? NSDictionary{
                            let msg = value.object(forKey: "error_description") as! String
                            let error = value.object(forKey: "error_code") as! Int
                            if error == 100{
                                ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
                            }else{
                                ModalController.showSuccessCustomAlertWith(title: "", msg: msg)

                                for controller in self.navigationController!.viewControllers as Array {
                                    if controller.isKind(of: BankAllListViewController.self) {
                                        self.navigationController!.popToViewController(controller, animated: true)
                                        
                                        NotificationCenter.default.post(name: Notification.Name("TransferSuccess"), object: nil, userInfo: nil)
                                        
                                        break
                                    }
                                }

                            }
                        }
                    }
    }
    
    @IBAction func backClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension BankTransferController : selectedBankDetail{
//    func selectedBank(bankDict: NSDictionary) {
//        accountIban.isHidden = false
//        bankName.isHidden = false
//        fullName.isHidden = false
//        shortName.isHidden = false
//        currency.isHidden = false
//        bankImg.isHidden = false
//        accNumber.isHidden = false
//        self.bankName.text = "\(bankDict.object(forKey: "bank_name") as! String)"
//        self.accountIban.text = "IBAN-\(bankDict.object(forKey: "account_iban_nbr") as! String)"
//        self.accNumber.text = "Account Number-\(bankDict.object(forKey: "account_nbr") as! String)"
//        self.fullName.text = "Full Name-\(bankDict.object(forKey: "full_name") as! String)"
//        self.shortName.text = "Short Name-\(bankDict.object(forKey: "short_name") as! String)"
//        self.currency.text = "Currency-\(bankDict.object(forKey: "currency_code") as! String)"
//        self.bankId = "\(bankDict.object(forKey: "id") as! Int)"
//    }
    
//    func transferProceed()
//    {
//
//        let str = "\(Constant.transferApi)"
//        if amountTrans.text == ""{
//            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Enter Transfer Amount")
//            return
//        }
//        if bankId == ""{
//            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Select Bank")
//            return
//        }
//
//
//        let value = walletValue
//        let amount = Double(amountTrans.text!)
//        if amount! > value{
//            ModalController.showNegativeCustomAlertWith(title: "", msg: "Max amount you can transfer is \(walletValue)")
//            return
//        }
//         ModalClass.startLoading(self.view)
//        let parameters = [
//            "user_id": Singleton.shared.getUserId(),
//            "amount": amountTrans.text!,
//            "bank_account_id": bankId,"remarks":remark.text!
//            ] as [String : Any]
//
//        print("request -",parameters)
//        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
//            ModalClass.stopLoading()
//
//            if let value = response as? NSDictionary{
//                let msg = value.object(forKey: "error_description") as! String
//                let vc = SuccessViewController(nibName: "SuccessViewController", bundle: nil)
//                vc.msg = msg
//                vc.delegate  = self
//                let popup = PopupDialog(viewController: vc,
//                                        buttonAlignment: .horizontal,
//                                        transitionStyle: .bounceDown,
//                                        tapGestureDismissal: true,
//                                        panGestureDismissal: false)
//
//                self.present(popup, animated: true, completion: nil)
//            }
//
//
//            else{
//                if let value = response as? NSDictionary{
//                    let msg = value.object(forKey: "error_description") as! String
//                     ModalController.showNegativeCustomAlertWith(title: "", msg: msg)
//                }
//            }
//
//        }
//
//
//    }
//
//
//}

extension BankTransferController : dismiss{
    func dismissController(){
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
}
