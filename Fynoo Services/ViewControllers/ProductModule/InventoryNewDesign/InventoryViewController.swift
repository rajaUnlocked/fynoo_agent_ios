//
//  InventoryViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 14/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//
//get_stock_data?.data?.available_qty
import UIKit
import iOSDropDown

class InventoryViewController: UIViewController {
    @IBOutlet weak var headerVw: NavigationView!
    @IBOutlet weak var topHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var tabView: UITableView!
    var leftAr = ["Available Quantity".localized,"Date Created".localized,"Date Updated".localized]
    var rightAr = ["02","06 Aug 2019","12 Aug 2019"]
    var inventory_model = NewInventoryManageModel()
    var get_stock_data : StockData?
    var update_stock: updateStock?
 
    var flag = "a"
    var availableQty = ""
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        
        self.headerVw.viewControl = self
        self.headerVw.titleHeader.text = "Manage Inventory".localized
        self.headerVw.menuBtn.isHidden = false
        
        tabView.register(UINib(nibName: "HeaderBranchTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderBranchTableViewCell")
        tabView.register(UINib(nibName: "InventoryTableViewCell", bundle: nil), forCellReuseIdentifier: "InventoryTableViewCell")
         tabView.register(UINib(nibName: "InventoryDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "InventoryDetailTableViewCell")
          tabView.register(UINib(nibName: "spacingTableViewCell", bundle: nil), forCellReuseIdentifier: "spacingTableViewCell")
        self.tabView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)

        tabView.separatorStyle = .none
        stockDataAPI()
        // Do any additional setup after loading the view.
    }

    func stockDataAPI()
    {
        inventory_model.proId = ProductModel.shared.productId
        inventory_model.getStockData { (success, response) in
            if success {
                self.get_stock_data = response
                ProductModel.shared.stockQuan = "\(self.get_stock_data?.data?.available_qty ?? 0)"
                self.tabView.delegate = self
                self.tabView.dataSource = self
                self.tabView.reloadData()
                print(response!)
            }
        }
    }

     func updateStockAPI()
     {
        
        
        if availableQty == "" {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter the stock update value.".localized)
            return
        }
        inventory_model.proId = ProductModel.shared.productId
        inventory_model.proUpdateQty = availableQty
        inventory_model.flag = flag
        
         inventory_model.updateStock { (success, response) in
             if success {
                 self.update_stock = response
                 self.stockDataAPI()
                 print(response!)
             }
         }
     }
    
   

}
extension InventoryViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tabView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as! HeaderBranchTableViewCell
            cell.rightarrow.isHidden = true
            cell.lbl.text = "Stock Update".localized
            cell.lbl.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            cell.lbl.font = UIFont(name: "\(fontNameLight)", size: 16.0)
            cell.btn.setImage(UIImage(named: "producticon"), for: .normal)
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
            cell.innerView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
            cell.selectionStyle = .none
            return cell
        }
        else {
            if indexPath.row == 0 {
                let cell = tabView.dequeueReusableCell(withIdentifier: "InventoryTableViewCell", for: indexPath) as! InventoryTableViewCell
                cell.selectionStyle = .none
                cell.txtField.addTarget(self, action: #selector(InventoryViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                cell.delegate = self
                cell.addSubtract.didSelect{(selected , index ,id) in
                    if selected == "+"{
                        self.flag = "a"
                    }
                    if selected == "-"{
                        self.flag = "s"
                    }
                }
                return cell
            }
            if indexPath.row == 1 {
                let cell = tabView.dequeueReusableCell(withIdentifier: "spacingTableViewCell", for: indexPath) as! spacingTableViewCell
                cell.selectionStyle = .none
                
                return cell
            }
            else {
                let cell = tabView.dequeueReusableCell(withIdentifier: "InventoryDetailTableViewCell", for: indexPath) as! InventoryDetailTableViewCell
                cell.leftLbl.text = leftAr[indexPath.row - 2]
                var qty = ""
                let update = get_stock_data?.data?.updated_at
                let created = get_stock_data?.data?.created_at
                if let qtyOfpro = get_stock_data?.data?.available_qty{
                    qty = String(qtyOfpro )
                }
                else{
                    qty = "";
                }
                rightAr = [qty  ,update ?? "",created ?? ""]
                cell.rightLbl.text = rightAr[indexPath.row - 2]
                cell.selectionStyle = .none
                
                return cell
            }
            
        }
    }
         @objc func textFieldDidChange(_ textField: UITextField) {
            availableQty = textField.text!
            print(availableQty)
            let cell = tabView.cellForRow(at: IndexPath(row: 0, section: 1)) as! InventoryTableViewCell
            if textField.text!.count > 0
                 {
                     if textField.text!.containArabicNumber
                     {
                        cell.txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor

                     }
                     else{
                         cell.txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor

                     }

                 }
                 else
                 {
                     cell.txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                    

                 }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 40
        }
        else {
            if indexPath.row == 0 {
                return 55
            }
                if indexPath.row == 1 {
                              return 20
                          }
            else {
                return 45
            }
           
        }
    }
    
}
extension InventoryViewController : InventoryTableViewCellDelegate {
    func add(tag: Int) {
       updateStockAPI()
      
     
      
    }
   
    
}
