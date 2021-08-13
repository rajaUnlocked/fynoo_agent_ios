//
//  AddFilterViewController.swift
//  Fynoo Business
//
//  Created by SENDAN on 05/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
protocol AddFilterViewControllerDelegate {
    func addFilter(val:Int)
}
class AddFilterViewController: UIViewController,UITextFieldDelegate {
    var delegate:AddFilterViewControllerDelegate?
    
    @IBOutlet weak var feturelbl: UILabel!
    var selectedRows = 0
    var fetureName:String = ""
    var filterValue:Int = 0
    var txt = ""
    var FeatureArr:NSMutableArray = NSMutableArray()
    let pro = ProductModel.shared
    var isEdit = false
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
       if fetureName == ""
       {
        isEdit = true
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
         let fontNameLight = NSLocalizedString("LightFontName", comment: "")
      feturelbl.font = UIFont(name:"\(fontNameLight)",size:12)
        tableView.register(UINib(nibName: "AddFilterTopTableViewCell", bundle: nil), forCellReuseIdentifier: "AddFilterTopTableViewCell");
        tableView.register(UINib(nibName: "AddFilterRowsViewCell", bundle: nil), forCellReuseIdentifier: "AddFilterRowsViewCell");
        tableView.register(UINib(nibName: "AddFilterInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "AddFilterInfoTableViewCell");
        
        // Do any additional setup after loading the view.
    }
 
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true) {
                    self.delegate?.addFilter(val: self.filterValue)
               }
    }
    
}

extension AddFilterViewController : addRowsProtocol{
    
    
   
    @objc func clickSave(_ sender: UIButton)
    {
        self.view.endEditing(true)
       
        if  txt.count > 0
                {
                    FeatureArr.add(txt)
                }
                else
                {
                 ModalController.showNegativeCustomAlertWith(title: "Please Add Atleast One Filter Type", msg: "")
                     return
                }
                
           
       
        if fetureName.count > 0 && FeatureArr.count > 0
        {
            var feature = ""
            if FeatureArr.count > 0
            {
                
                for item in FeatureArr{
                    feature = "\(item),\(feature)"
                }
                feature.removeLast()
            }
            ModalClass.startLoading(self.view)
            let str = "\(Constant.BASE_URL)\(Constant.addfilternew)"
           
            let parameters = [
                 "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                "user_id":Singleton.shared.getUserId(),
                "user_type":"bo",
                "sub_cat_id":pro.subcataId,
                "filter_key":fetureName,
                "filter_values": feature,
                "pro_id":pro.productId
            ]
            print("request -",parameters)
            ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
                ModalClass.stopLoading()
                if success == true {
                    let value = response as! NSDictionary
                    let error = value.value(forKey: "error_code") as! Int
                    if error == 100
                    {
                        ModalController.showNegativeCustomAlertWith(title:" Error", msg: value.value(forKey: "error_description") as! String)
                    }
                        
                    else
                    {
                        ModalController.showSuccessCustomAlertWith(title:" Success", msg: value.value(forKey: "error_description") as! String)
                        self.dismiss(animated: true) {
                            self.delegate?.addFilter(val:self.filterValue)
                        }
                        
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
        else{
           ModalController.showNegativeCustomAlertWith(title: "Warning", msg: "Please fill madatory Field")
        }
    
    }
    func addRows(tag: Int) {
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddFilterTopTableViewCell
              if cell.featureNameType.text!.isArabic
                   {
                       ModalController.showNegativeCustomAlertWith(title: "Should not Accept Arbic Number", msg: "")
                       return
                   }
        if cell.featureNameType.text!.count > 0
        {
            FeatureArr.add(cell.featureNameType.text!)
                   tableView.reloadData()
        }
       
    }
    
    
}

extension AddFilterViewController : UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 2:
            return 1
        default:
            return FeatureArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddFilterTopTableViewCell",for: indexPath) as! AddFilterTopTableViewCell
             cell.isUserInteractionEnabled = true
            cell.delegate = self
            cell.featureName.text = fetureName
            cell.featureName.tag = 0
            cell.featureNameType.tag = 1
            cell.featureNameType.text = ""
            cell.featureName.delegate = self
            cell.featureNameType.delegate = self
            cell.featureName.isUserInteractionEnabled = isEdit
            if !isEdit
            {
             cell.featureName.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#383838").cgColor
            }
            cell.featureNameType.isUserInteractionEnabled = true
            cell.selectionStyle = .none
          cell.featureName.addTarget(self, action: #selector(AddFilterViewController.filterNameDidChange(_:)), for: UIControl.Event.editingChanged)
             cell.featureNameType.addTarget(self, action: #selector(AddFilterViewController.filterTypeDidChange(_:)), for: UIControl.Event.editingChanged)
            return cell
            
        }
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddFilterInfoTableViewCell",for: indexPath) as! AddFilterInfoTableViewCell
            if fetureName.count > 0 && (FeatureArr.count > 0 || txt.count > 0)
            {
               cell.save.layer.borderColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1).cgColor
                cell.save.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)

                
            }
            else
            {
                cell.save.layer.borderColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1).cgColor
                 cell.save.setTitleColor(UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1), for: .normal)
            }
            cell.save.tag = indexPath.row
            cell.save.addTarget(self, action: #selector(clickSave(_ : )), for: .touchUpInside)
            cell.info.tag = indexPath.row
            cell.info.addTarget(self, action: #selector(infoClick(_ : )), for: .touchUpInside)
             cell.selectionStyle = .none
          
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddFilterRowsViewCell",for: indexPath) as! AddFilterRowsViewCell

//          cell.featureType.delegate = self
            cell.featureType.isUserInteractionEnabled = false
            cell.featureType.text = "\(FeatureArr[indexPath.row])"
            cell.minus.tag = indexPath.row
            cell.minus.addTarget(self, action: #selector(clickMinus(_:)), for: .touchUpInside)
            cell.selectionStyle = .none
             
            return cell
        }
        
    }
    
    @objc private func filterNameDidChange(_ textField: UITextField)
              {
                fetureName = textField.text!
                if textField.text!.count > 0
                {
                    let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddFilterTopTableViewCell
                 cell.featureName.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#383838").cgColor
                }
                else{
                    let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddFilterTopTableViewCell
                   cell.featureName.layer.borderColor =  ModalController.hexStringToUIColor(hex:"#EC4A53").cgColor
                }
          tableView.reloadSections(IndexSet(integer: 2), with: .none)
       }
    @objc private func filterTypeDidChange(_ textField: UITextField)
        {
            if textField.text!.isArabic
            {
              
                 let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddFilterTopTableViewCell
                    cell.featureNameType.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                return
            }
            if FeatureArr.count > 0
            {
                   let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddFilterTopTableViewCell
               cell.featureNameType.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#383838").cgColor
            }
            else
            {
                if textField.text!.count > 0
                                         {
                                             let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddFilterTopTableViewCell
                                          cell.featureNameType.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#383838").cgColor
                                         }
                                         else{
                                             let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddFilterTopTableViewCell
                                            cell.featureNameType.layer.borderColor =  ModalController.hexStringToUIColor(hex:"#EC4A53").cgColor
                                         }
            }
            txt = textField.text!
            tableView.reloadSections(IndexSet(integer: 2), with: .none)
    }

    @objc func clickMinus(_ sender:UIButton)
    {
        FeatureArr.removeObject(at: sender.tag)
     
        tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
   
    }
    @objc func infoClick(_ sender:UIButton)
      {
          print("HR ")
      }
      
    
    
   
}

extension AddFilterViewController : UITableViewDelegate{
 
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 130
        }
       else if indexPath.section == 2{
            return 100
        }
        else{
            return 50
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("jnm")
    }
}
