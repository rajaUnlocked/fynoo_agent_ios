//
//  AddWholeSlabViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 14/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class AddWholeSlabViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: NavigationView!
    var wholesalePrice = 0.0
    var discountPrice = 0.0
    var netSelling = 0.0
    var vatPrice = 0.0
    var minQty = ProductModel.shared.onlineQuanTo
    var isMax = false
    var maxQty = 0
    var slabtag = 0
    var isedit = false
    var isVat = false
    var textArray = ["","","Quantity".localized,"Wholesale Price *".localized,"Discount".localized,"Net Selling Price".localized,"VAT".localized,"Final Price".localized]
    var proName = ""
    var proImage = ""
    var vatPercent = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView.viewControl = self
        navigationView.titleHeader.text = "Price Detail".localized
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        self.heightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        bgImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        tableView.register(UINib(nibName: "AddWholeSlabViewCell", bundle: nil), forCellReuseIdentifier: "AddWholeSlabViewCell")
        tableView.register(UINib(nibName: "PriceTopTableViewCell", bundle: nil), forCellReuseIdentifier: "PriceTopTableViewCell")
        tableView.register(UINib(nibName: "RetailPriceListViewCell", bundle: nil), forCellReuseIdentifier: "RetailPriceListViewCell")
        tableView.register(UINib(nibName: "SingleButtonViewCell", bundle: nil), forCellReuseIdentifier: "SingleButtonViewCell")
        self.tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)

        if HeaderHeightSingleton.shared.LanguageSelected == "EN"{
            textArray = ["","","Quantity","Wholesale Price","Discount","Net Selling Price","VAT","Final Price"]
            navigationView.titleHeader.text = "Price Detail".localized
            
        }else{
            textArray = ["","","الكمية","سعر الجملة","الخصم","صافي سعر البيع","ضريبة القيمة المضافة","السعر النهائي"]
            navigationView.titleHeader.text = "تفاصيل السعر"
        }
        if !isedit{
            if isVat{
                getVat()
                
            }
        }
        
       
        
        
        
        // Do any additional setup after loading the view.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "0" || textField.text == "0.0" || textField.text == "0.00" || textField.text == "0.000"{
            textField.text = ""
        }
        if textField.text == "."{
             textField.text = "0."
        }
    }
    
    var vat = ""
    func getVat(){
        let obj = AddWholesaleSlab()
        obj.getVat { (success, response) in
            if success{

                let val = ((response?.object(forKey: "data") as! NSDictionary).object(forKey: "vat") as! Int)
                
                self.vatPercent = Double(val)
                self.tableView.reloadData()
            }
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func saveClicked(){
        
        self.view.endEditing(true)
        if maxQty == 0{
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.quantity)
            return
        }
        
       else if wholesalePrice == 0.0{
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.wholesalePrice)
            return
        }
        
       else if wholesalePrice == vatPrice{
             ModalController.showNegativeCustomAlertWith(title: "", msg: "Both cannot be same")
            return
        }
        else{
            
            
            if isedit
            {
                let pro = ProductModel.shared
                pro.OnlineQuantityFrom.replaceObject(at: slabtag, with: minQty)
                pro.OnlineQuantityto.replaceObject(at: slabtag, with: maxQty)
                
                pro.OnlineWholeSalePriceFrom.replaceObject(at: slabtag, with: wholesalePrice)
                pro.OnlineWholeSalePriceTo.replaceObject(at: slabtag, with: netSelling)
                pro.OnlinediscountWhole.replaceObject(at: slabtag, with: discountPrice)
                var value = getRupess(price: wholesalePrice, discount: discountPrice)
                    value = (value*100).rounded()/100

                pro.OnlinediscountWholePercent.replaceObject(at: slabtag, with: value)
                pro.OnlineVatValue.replaceObject(at: slabtag, with: vatPrice)
//                var values = getRupess(price: netSelling, discount: vatPrice)
//                values = (values*100).rounded()/100

                pro.OnlineVatPercent.replaceObject(at: slabtag, with: vatPercent)
                let final = netSelling + vatPrice
                pro.OnlineFinalPrice.replaceObject(at: slabtag, with: final)
                if slabtag == ProductModel.shared.OnlineQuantityFrom.count - 1
                {
                    ProductModel.shared.onlineQuanTo = maxQty + 1
                }
                
            }
            else{
                let pro = ProductModel.shared
                pro.OnlineQuantityFrom.add(minQty)
                pro.OnlineQuantityto.add(maxQty)
                print(wholesalePrice)
                pro.OnlineWholeSalePriceFrom.add(wholesalePrice)
                pro.OnlineWholeSalePriceTo.add(netSelling)
                pro.OnlinediscountWhole.add(discountPrice)
                var value = getRupess(price: wholesalePrice, discount: discountPrice)
                value = (value*100).rounded()/100

                pro.OnlinediscountWholePercent.add(value)
                pro.OnlineVatValue.add(vatPrice)
//                var values = getRupess(price: netSelling, discount: vatPrice)
//                values = (values*100).rounded()/100

                pro.OnlineVatPercent.add(vatPercent)
                let final = netSelling + vatPrice
                pro.OnlineFinalPrice.add(final)
                
                print(pro.OnlineQuantityto)
                ProductModel.shared.onlineQuanTo = maxQty + 1
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.tag == 6{
            if !textField.text!.isEmpty{
                vatPrice = Double(textField.text!)!
                vatPrice = (vatPrice*100).rounded()/100

            }
            self.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .none)
            self.tableView.reloadRows(at: [IndexPath(row: 7, section: 0)], with: .none)

        }
        
        
        if textField.tag == 500{
            if textField.text != "" {
                
                
                vatPercent = Double(textField.text!)!
                vatPercent = (vatPercent*100).rounded()/100

                vatPrice = getRupessfromPercent(price: netSelling, discount: vatPercent)
                vatPrice = (vatPrice*100).rounded()/100

            }
            self.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .none)

            self.tableView.reloadRows(at: [IndexPath(row: 7, section: 0)], with: .none)

        }
        
        if textField.tag == 3{
            if !textField.text!.isEmpty{
                if textField.text == "."{
                     textField.text = "0."
                }
                wholesalePrice = Double(textField.text!)!
                wholesalePrice = (wholesalePrice*100).rounded()/100
                print(wholesalePrice,"sdsd")
                print(vatPercent)
                vatPrice = getRupessfromPercent(price: wholesalePrice, discount: vatPercent)
              //  vatPrice = (vatPrice*100).rounded()/100
                print(vatPercent,"vatPercent")
                print(vatPrice,"vatPrice")

            }
            
            
            self.tableView.reloadRows(at: [IndexPath(row: 6, section: 0)], with: .none)
            self.tableView.reloadRows(at: [IndexPath(row: 5, section: 0)], with: .none)
            self.tableView.reloadRows(at: [IndexPath(row: 7, section: 0)], with: .none)
            self.tableView.reloadRows(at: [IndexPath(row: 8, section: 0)], with: .none)

            
        }
     
        if textField.tag == 4{
            if !textField.text!.isEmpty{
                if textField.text == "."{
                    textField.text = "0."
                }
                discountPrice = Double(textField.text!)!
                discountPrice = (discountPrice*100).rounded()/100

                if discountPrice > wholesalePrice || discountPrice == wholesalePrice{
                    textField.text = "0"
                    discountPrice=0.0
                }
                    
                else{
                    var value = getRupess(price: wholesalePrice, discount: discountPrice)
                    value = (value*100).rounded()/100

                    let cell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! RetailPriceListViewCell
                    cell.finalPrice.text = String(format: "%.2f",value)
                }
                
                
            }
            self.tableView.reloadRows(at: [IndexPath(row: 6, section: 0)], with: .none)
            self.tableView.reloadRows(at: [IndexPath(row: 5, section: 0)], with: .none)
            self.tableView.reloadRows(at: [IndexPath(row: 7, section: 0)], with: .none)
            
        }
        if textField.tag == 100{
            if !textField.text!.isEmpty{
                if textField.text == "."{
                    textField.text = "0."
                }
                var value = Double(textField.text!)!
                 discountPrice=0.0
                if value < 100.0{
                    value = (value*100).rounded()/100

                    discountPrice = getRupessfromPercent(price: wholesalePrice, discount: value)
                    discountPrice = (discountPrice*100).rounded()/100

                       let cell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! RetailPriceListViewCell
                   // cell.price.text = "\(discountPrice)"
                   // cell.finalPrice.text = String(format: "%.2f",value)
                    cell.price.text = String(format: "%.2f",discountPrice)

                }else{
                    textField.text = "0"
                    discountPrice=0.0
                }
            }
            self.tableView.reloadRows(at: [IndexPath(row: 5, section: 0)], with: .none)
             self.tableView.reloadRows(at: [IndexPath(row: 6, section: 0)], with: .none)
            self.tableView.reloadRows(at: [IndexPath(row: 7, section: 0)], with: .none)


        }
              

    }
    

    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.tag)
        if textField.tag == 201 {
            if !textField.text!.isEmpty{
                minQty = Int(textField.text!)!
            }
        }
        if textField.tag == 301 {
            if !textField.text!.isEmpty{
                if (textField.text?.contains("."))!{
                    ModalController.showNegativeCustomAlertWith(title: "", msg: "Decimal is not supported for Quantity")
                    return
                    
                }
                if Int(textField.text!)! < minQty{
                    ModalController.showNegativeCustomAlertWith(title: "", msg: "Max Quantity must be larger then min Quantuity")
                    tableView.reloadData()
                    return
                }
                maxQty = Int(textField.text!)!
            }
            
            
        }
        
        
        
        
//        if textField.tag == 3{
//            if !textField.text!.isEmpty{
//                wholesalePrice = Double(textField.text!)!
//                wholesalePrice = (wholesalePrice*100).rounded()/100
//
//            }
//
//
//        }
        if textField.tag == 4{
            if !textField.text!.isEmpty{
                discountPrice = Double(textField.text!)!
                discountPrice = (discountPrice*100).rounded()/100

                if discountPrice > wholesalePrice || discountPrice == wholesalePrice{
                    discountPrice=0.0
                }
            }
            
        }
        if textField.tag == 6{
            if !textField.text!.isEmpty{
                vatPrice = Double(textField.text!)!
                vatPrice = (vatPrice*100).rounded()/100

            }
        }
        
        if textField.tag == 100{
            if !textField.text!.isEmpty{
                let value = Double(textField.text!)!
                if value < 100.0{
                    discountPrice = getRupessfromPercent(price: wholesalePrice, discount: value)
                    discountPrice = (discountPrice*100).rounded()/100

                }else{
                    discountPrice=0.0
                }
            }
            
            
        }
        
        if textField.tag == 500{
            var value = 0.0
            if !textField.text!.isEmpty{
                value = Double(textField.text!)!

            }
            vatPrice = getRupessfromPercent(price: netSelling, discount: value)
                                vatPrice = (vatPrice*100).rounded()/100

        }
        tableView.reloadData()
    }
    
    
    
    
    func getRupess(price:Double,discount:Double)-> Double{
        
        if discount == price{
            
            return 0.0
        }
        
        let value  = (discount/price * 100)
        return value
    }
    
    func getRupessfromPercent(price:Double,discount:Double)-> Double{
        
        if discount == price{
            
            return 0.0
        }
        
        let value = discount/100 * price
        return value
    }
}
extension AddWholeSlabViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 130
        }
        if indexPath.row == 8 {
            return 120
        }
        
        else {
            return 50
        }
       
    }
    
}

extension AddWholeSlabViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = PriceHistoryViewController(nibName: "PriceHistoryViewController", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
                   
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddWholeSlabViewCell", for: indexPath) as! AddWholeSlabViewCell
            cell.wholesalelbl.text = "Wholesale".localized
            cell.proImg.sd_setImage(with: URL(string: proImage), placeholderImage: UIImage(named: "productplaceholder"))
            cell.proName.text = proName
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTopTableViewCell", for: indexPath) as! PriceTopTableViewCell
            cell.titleLblLeading.constant = 15
            cell.titleLabel.text = "Wholesale Price"
            if HeaderHeightSingleton.shared.LanguageSelected == "AR"
            {
                cell.titleLabel.text = "سعر الجملة";
            }
           
            cell.bottomConstraint.constant = 0
            cell.titleLabel.font = UIFont(name: "Gilroy-Light", size: 12.0)
            cell.selectionStyle = .none
            return cell
        }else if indexPath.row == 8{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingleButtonViewCell", for: indexPath) as! SingleButtonViewCell
            cell.saveButton.setTitle("Save".localized, for: .normal)
            if minQty == 0 || maxQty == 0 || wholesalePrice == 0.0{
                cell.saveButton.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
                cell.saveButton.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
            }else{
                cell.saveButton.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                cell.saveButton.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
               // cell.saveButton.isUserInteractionEnabled = true
            }
            cell.saveButton.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RetailPriceListViewCell", for: indexPath) as! RetailPriceListViewCell
            cell.price.delegate = self
            cell.selectionStyle = .none
            cell.finalPrice.tag = indexPath.row
            cell.finalPrice.delegate = self
            cell.finalPrice.keyboardType = .decimalPad
            cell.currency.keyboardType = .numberPad
            cell.price.keyboardType = .decimalPad
            //   cell.finalPrice.addTarget(self, action: #selector(AddWholeSlabViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            cell.titleLblLeading.constant = 15
            cell.leadingCurrency.constant = 30
            //cell.imgLeading.constant = 0
            //cell.priceLeading.constant = -10
            cell.percentTrailing.constant = 15
            
            cell.finalPrice.isUserInteractionEnabled = true
            cell.currency.isUserInteractionEnabled  = false
            cell.percentLabel.isHidden = true
            cell.titleLabel.text = textArray[indexPath.row]
            switch indexPath.row {
            case 2:
                cell.titleLabel.attributedText = ModalController.setStricColor(str: "\(textArray[indexPath.row]) *", str1: "\(textArray[indexPath.row])", str2:" *" )
                cell.currency.isUserInteractionEnabled = true
                cell.finalPrice.isUserInteractionEnabled = true
                if isMax
                {
                    cell.currency.isUserInteractionEnabled = false
                    cell.finalPrice.isUserInteractionEnabled = false
                }
                else{
                    cell.currency.isUserInteractionEnabled = true
                    cell.finalPrice.isUserInteractionEnabled = true
                    if ProductModel.shared.onlineQuanTo > 1
                    {
                        cell.currency.isUserInteractionEnabled = false
                    }
                     if ProductModel.shared.onlineQuanTo == 1
                                      {
                                          cell.currency.isUserInteractionEnabled = true
                                      }
                }
                
                
                cell.currency.tag = 201
                
                cell.finalPrice.tag = 301
                cell.finalPrice.delegate = self
                cell.currency.delegate = self
                cell.currency.text = "\(minQty)"
                cell.finalPrice.text = "\(maxQty)"
                cell.price.isHidden = true
                cell.exchangeImg.isHidden = false
                cell.min.isHidden = false
                cell.max.isHidden = false
                cell.currency.keyboardType = .asciiCapableNumberPad
                cell.finalPrice.keyboardType = .asciiCapableNumberPad
            case 3:
                cell.titleLabel.attributedText = ModalController.setStricColor(str: "\(textArray[indexPath.row]) *", str1: "\(textArray[indexPath.row])", str2:" *" )
                cell.currency.text = "SAR"
                cell.currency.font = UIFont(name: "Gilroy-Light", size: 7.0)
                cell.price.isHidden = true
                cell.exchangeImg.isHidden = true
                cell.finalPrice.text = "\(wholesalePrice)"
                cell.finalPrice.tag = indexPath.row
                
                cell.finalPrice.addTarget(self, action: #selector(AddWholeSlabViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            case 4:
                cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                cell.currency.text = "SAR"
                cell.currency.font = UIFont(name: "Gilroy-Light", size: 7.0)
                cell.price.isHidden = false
                cell.exchangeImg.isHidden = true
                cell.percentLabel.isHidden = false
                cell.price.tag = indexPath.row
                cell.price.delegate = self
                cell.price.text = "\(discountPrice)"
                cell.finalPrice.delegate = self
                cell.finalPrice.tag = 100
                cell.finalCurrency.isHidden = true
                
                if wholesalePrice != 0.0{
                    let value = getRupess(price: wholesalePrice, discount: discountPrice)
                    cell.finalPrice.text = String(format: "%.2f",value)
                    //cell.finalPrice.text = "\(value)"
                }
                cell.price.text = String(format: "%.2f",discountPrice)
                cell.price.addTarget(self, action: #selector(AddWholeSlabViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                
                cell.finalPrice.addTarget(self, action: #selector(AddWholeSlabViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            case 5:
                cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                cell.currency.text = "SAR"
                cell.currency.isHidden = false
                cell.price.isHidden = false
                cell.finalCurrency.isHidden = true
                cell.greenTick.isHidden = true
                cell.currency.font = UIFont(name: "Gilroy-Light", size: 7.0)
                cell.price.isHidden = true
                cell.exchangeImg.isHidden = true
                cell.finalPrice.isUserInteractionEnabled = false
                cell.finalPrice.textColor = #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1)
                cell.finalPrice.font = UIFont(name: "Gilroy-Light", size: 12.0)
                netSelling = wholesalePrice-discountPrice
                netSelling = (netSelling*100).rounded()/100

                cell.finalPrice.text = String(format: "%.2f",netSelling)
                
                
            case 6:
                cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                cell.price.isUserInteractionEnabled = false
                cell.finalPrice.isUserInteractionEnabled = false
                if isVat
                {
                    cell.titleLabel.attributedText = ModalController.setStricColor(str: "\(textArray[indexPath.row]) *", str1: "\(textArray[indexPath.row])", str2:" *" )
                    cell.price.isUserInteractionEnabled = true
                    cell.finalPrice.isUserInteractionEnabled = true
                }
                cell.currency.text = "SAR"
                cell.currency.font = UIFont(name: "Gilroy-Light", size: 7.0)
                cell.price.isHidden = false
                cell.exchangeImg.isHidden = true
                cell.percentLabel.isHidden = false
                cell.price.tag = indexPath.row
                cell.price.delegate = self
                
                cell.finalPrice.tag = 500
                cell.finalPrice.delegate = self
                cell.price.addTarget(self, action: #selector(AddWholeSlabViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                
                cell.finalPrice.addTarget(self, action: #selector(AddWholeSlabViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                
                cell.finalPrice.text = "\(vatPercent)"

           //     vatPrice = getRupessfromPercent(price: netSelling, discount: vatPercent)
                
              //  vatPrice = (vatPrice*100).rounded()/100

                
                cell.price.text = "\(vatPrice)"
                cell.price.text = String(format: "%.2f",vatPrice )
                cell.finalPrice.text = String(format: "%.2f",vatPercent)

                cell.currency.isHidden = false
                cell.price.isHidden = false
                cell.exchangeImg.isHidden = false
                cell.finalCurrency.isHidden = true
                cell.greenTick.isHidden = true
                cell.finalPrice.isUserInteractionEnabled = true
                cell.finalPrice.textColor = #colorLiteral(red: 0.4677127004, green: 0.4716644287, blue: 0.4717406631, alpha: 1)
                cell.finalPrice.font = UIFont(name: "Gilroy-Light", size: 12.0)
            default:
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                cell.currency.isHidden = true
                cell.price.isHidden = true
                cell.exchangeImg.isHidden = true
                cell.finalCurrency.isHidden = false
                cell.greenTick.isHidden = false
                cell.finalPrice.isUserInteractionEnabled = false
                cell.finalPrice.font = UIFont(name: "Gilroy-ExtraBold", size: 12.0)
                cell.finalPrice.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)

                var vall = netSelling+vatPrice
                vall = (vall*100).rounded()/100

                cell.finalPrice.text = String(format: "%.2f",vall)

//                cell.finalPrice.text = "\(netSelling+vatPrice)"

            }
            cell.currency.textAlignment = .left
           cell.price.textAlignment = .left
         cell.finalPrice.textAlignment = .left
            return cell
        }
    }
}



