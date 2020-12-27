//
//  BusinessTypeListViewController.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 09/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol businessTypeDelegate1 {
    func businessTypeName(name:NSMutableArray,id:NSMutableArray)
}
class BusinessTypeListViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
  
    @IBOutlet weak var btypelbl: UILabel!
    @IBOutlet weak var selectbtypelbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var innervw: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tabView: UITableView!
    @IBOutlet weak var headerVw: NavigationView!
    @IBOutlet weak var outerView: UIView!
    var BusinessTypeLIST: BusinessTYPEList?
    var textSTR = ""
    var filterArray:[Business_type]?
    var filterArray1:[Business_type]?
    var delegate:businessTypeDelegate1?
    var selectedIndexs : NSMutableArray = NSMutableArray()
    var selectedTypeArray:NSMutableArray = NSMutableArray()
   var selectarr = Array<Any>()
      var selectarray:NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
         selectarr = selectedTypeArray as! Array<Any>
        selectarray = NSMutableArray(array: selectarr)
        if selectedIndexs.count > 0
        {
            img.image = UIImage(named: "btype_green")
            
        }
        else
        {
              img.image = UIImage(named: "btype")
        }
         self.BusinessTypeList_API()
           bgImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        headerVw.viewControl = self
        self.headerVw.titleHeader.text = "Select Your Business Type".localized;
        tabView.register(UINib(nibName: "SelectBusinesstypeTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectBusinesstypeTableViewCell")
        tabView.separatorStyle = .none
           self.innerView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 60)
       self.innervw.setAllSideShadow(shadowShowSize: 1.0)
//        self.tabView.setAllSideShadowForFieldsWithHeight(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 20, sizeFloatHeight: UIScreen.main.bounds.size.width - (outerView.frame.maxY + 150))
      
        self.cancelBtn.setAllSideShadow(shadowShowSize: 3.0)
        self.saveBtn.setAllSideShadow(shadowShowSize: 3.0)
        var placeHolders = NSMutableAttributedString()
        let txt = "Search Business Type".localized
        placeHolders = NSMutableAttributedString(string:txt, attributes: [NSAttributedString.Key.font:UIFont(name: "Roboto-light", size: 12.0)!])
        placeHolders.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(red: 112/255, green: 112/255, blue: 112/255, alpha: 1), range:NSRange(location:0,length:txt.count))
        textField.attributedPlaceholder = placeHolders
        textField.addTarget(self, action: #selector(BranchListViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
          let fontNameLight = NSLocalizedString("LightFontName", comment: "")
      selectbtypelbl.font = UIFont(name:"\(fontNameLight)",size:16)
         btypelbl.font = UIFont(name:"\(fontNameLight)",size:12)
        saveBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
          cancelBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
    }
   @objc func textFieldDidChange(_ textField: UITextField) {
            if let textStr = textField.text {
                if self.BusinessTypeLIST?.business_type?.count == 0{
                    return
                }
                textSTR = textStr
                print("t5y7iglujkgm")
                
                filterArray =  self.BusinessTypeLIST?.business_type!.filter{$0.name.lowercased().contains(textStr.lowercased())}
                tabView.reloadData()
            }
    }

    
    @IBAction func searchClick(_ sender: Any) {
    }
    @IBAction func clear(_ sender: Any) {
        textField.text = ""
        textSTR = ""
        BusinessTypeList_API()
        
        
    }
    
    @IBAction func finalCancel(_ sender: Any) {
      
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
       
             if selectarray.count > 0
             {
                 self.navigationController?.popViewController(animated: true)
                 self.delegate?.businessTypeName(name: selectarray,id:selectedIndexs)
               
             }
             else{
                ModalController.showNegativeCustomAlertWith(title: "Please select atleast one business type".localized, msg: "")
             }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if textSTR.count > 0
               {
                   return filterArray?.count ?? 0
               }
               else{
                 return (BusinessTypeLIST?.business_type?.count)! 
               }
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      let cell = tabView.dequeueReusableCell(withIdentifier: "SelectBusinesstypeTableViewCell", for: indexPath) as! SelectBusinesstypeTableViewCell
       
        if textSTR.count > 0
        {
        filterArray1 = filterArray
        }
        else{
         filterArray1 = BusinessTypeLIST?.business_type
        }
        cell.lblName.text = filterArray1?[indexPath.row].name;
        cell.selectionStyle = .none
        cell.underlineHeight.constant = 0.3
      
        cell.leadingConstraints.constant = 25
        cell.traillingConstraints.constant = 25
        if selectarray.contains(filterArray1?[indexPath.row].name as Any) {
            cell.checkbtn.setImage(UIImage(named: "greenCheck-1"), for: .normal)
        }else{
            cell.checkbtn.setImage(UIImage(named: ""), for: .normal)
        }
        return cell
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 50
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if textSTR.count > 0
           {
               filterArray1 = filterArray
           }
           else{
               filterArray1 = BusinessTypeLIST?.business_type
           }
           if selectarray.contains(filterArray1![indexPath.row].name as Any) {
               selectarray.remove(filterArray1![indexPath.row].name as Any)
               selectedIndexs.remove(filterArray1![indexPath.row].id as Any)

           
           }else{
               selectarray.add(filterArray1![indexPath.row].name as Any)
              selectedIndexs.add(filterArray1![indexPath.row].id as Any)
           }
       
        if selectedIndexs.count > 0
               {
                   img.image = UIImage(named: "btype_green")
                 saveBtn.layer.borderColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1).cgColor
                           saveBtn.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
       
               }
               else
               {
                     img.image = UIImage(named: "btype")
                saveBtn.layer.borderColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1).cgColor
                            saveBtn.setTitleColor(UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1), for: .normal)
               }
           self.tabView.reloadData()
           
       }

        func BusinessTypeList_API()
        {
            ModalClass.startLoading(self.view)
            let device_id = UIDevice.current.identifierForVendor!.uuidString
            let str = "\(Constant.BASE_URL)\(Constant.BusinessType_List)"
            let parameters = [
                "lang_code":HeaderHeightSingleton.shared.LanguageSelected
                
            ]
            print("request -",parameters)
            ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
                ModalClass.stopLoading()
                if success == true {
                    self.BusinessTypeLIST = try! JSONDecoder().decode(BusinessTYPEList.self, from: resp as! Data )
                    if self.BusinessTypeLIST!.error! {
                        ModalController.showNegativeCustomAlertWith(title: self.BusinessTypeLIST!.error_description!, msg: "")
                    }
                    else{
                        self.tabView.delegate = self
                        self.tabView.dataSource = self
                        self.tabView.reloadData()
                        
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


}


