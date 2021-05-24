//
//  MallMarketPopupViewController.swift
//  Fynoo Business
//
//  Created by Sendan IT on 23/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import ObjectMapper
protocol savemallmarketDelegate {
    func addNew()
    func otherAddress(Name: String ,Address: String)
    func save(type:NSMutableArray, id : Int)
}
class MallMarketPopupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var pageno = 0
    var isDataLoading = false
    @IBOutlet weak var save: UIButton!
    
    @IBOutlet weak var headerVw: NavigationView!
    
    @IBOutlet weak var tableHeightConstraints: NSLayoutConstraint!
    var addressTxtField = ""
    var mallmarketList:MallMarket?
    var mallmarketArr = [Mall_market_list]()
    var latitude = 0.0
    var longitude = 0.0
    var mallId:Int?
    var delegate:savemallmarketDelegate?
    var Name = ""
    var add = ""
    var listcount = 0
    var radiocheck = 0
    @IBOutlet weak var headerView: UIView!
    var isTrue:Bool = false
    var selectedIndexs:NSMutableArray = NSMutableArray()
    var selectmallArray:NSMutableArray = NSMutableArray()
    var selectmallId:Int?
    @IBOutlet weak var tabView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MallMarketList_API()
        //        self.headerView.layer.insertSublayer(ModalController.setnewGradientColorBGBlackWithPopupHeight(), at: 0)
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        save.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:16)
        headerVw.titleHeader.text = "Name Of Mall & Market".localized
        headerVw.viewControl = self
        headerVw.backButton.isHidden = true
        self.tabView.register(UINib(nibName: "otherTableViewCell", bundle: nil), forCellReuseIdentifier: "otherTableViewCell")
        self.tabView.register(UINib(nibName: "marketTableViewCell", bundle: nil), forCellReuseIdentifier: "marketTableViewCell")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(isTrue == false)
        {
            return (mallmarketArr.count) + 1
            
            
        }
        else
        {
            return mallmarketArr.count + 2
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isTrue
        {
            if indexPath.row  == (mallmarketArr.count ) + 1
            {
                let cell1 = tabView.dequeueReusableCell(withIdentifier: "otherTableViewCell", for: indexPath) as! otherTableViewCell
                if cell1.nametxtfield.text!.count > 0
                {
                    if !cell1.nametxtfield.text!.containArabicNumber
                    
                    {
                        cell1.lbl.backgroundColor =  ModalController.hexStringToUIColor(hex: "#EC4A53")
                    }
                    else
                    {
                        cell1.lbl.backgroundColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2")
                    }
                }
                else
                {
                    cell1.lbl.backgroundColor =  ModalController.hexStringToUIColor(hex: "#EC4A53")
                }
                cell1.nametxtfield.addTarget(self, action: #selector(MallMarketPopupViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                return cell1
            }
        }
        
        if indexPath.row  == (mallmarketArr.count )
        {
            
            let cell1 = tabView.dequeueReusableCell(withIdentifier: "marketTableViewCell", for: indexPath) as! marketTableViewCell
            cell1.tag = indexPath.row
            cell1.toplbl.isHidden = true
            cell1.bottomlbl.isHidden = true
            cell1.middlelbl.isHidden = false
            cell1.middlelbl.text = "Other"
            if isTrue{
                cell1.checkbtn.isSelected = true
            }else{
                cell1.checkbtn.isSelected = false
            }
            
            return cell1
        }
        
        
        
        else
        {
            let cell1 = tabView.dequeueReusableCell(withIdentifier: "marketTableViewCell", for: indexPath) as! marketTableViewCell
            cell1.toplbl.isHidden = false
            cell1.bottomlbl.isHidden = false
            cell1.middlelbl.isHidden = true
            cell1.tag = indexPath.row
            if selectedIndexs.contains(indexPath.row) {
                cell1.checkbtn.isSelected = true
            }else{
                cell1.checkbtn.isSelected = false
            }
            cell1.toplbl.text = "\(mallmarketArr[indexPath.row].name ?? "")"
            cell1.bottomlbl.text = "\(mallmarketArr[indexPath.row].area ?? "")"
            return cell1
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == (mallmarketArr.count ))
        {
            isTrue = !isTrue
        }
        if(indexPath.row < (mallmarketArr.count))
        {
            if selectedIndexs.contains(indexPath.row)
            {
                selectedIndexs.remove(indexPath.row)
            }
            else
            {
                selectedIndexs.add(indexPath.row)
            }
        }
        save.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
        save.setTitleColor(ModalController.hexStringToUIColor(hex: "#EC4A53"), for: .normal)
        if selectedIndexs.count > 0 || addressTxtField.count > 0
        {
            save.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#61C088").cgColor
            save.setTitleColor(ModalController.hexStringToUIColor(hex: "#61C088"), for: .normal)
        }
        self.tabView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row <= (mallmarketArr.count )) {
            return 55
        }
        
        else{
            return 100
        }
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isDataLoading = false
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if Double(self.mallmarketList?.data?.total_records ?? 0) / Double(self.mallmarketList?.data?.page_limit ?? 0) > Double(pageno) + 1.0
        {
            if ((tabView.contentOffset.y + tabView.frame.size.height) >= tabView.contentSize.height)
            {
                if !isDataLoading{
                    
                    isDataLoading = true
                    self.pageno=self.pageno + 1
                    MallMarketList_API()
                }
                
            }
        }
        
    }
    @objc private func textFieldDidChange(_ textField: UITextField)
    {
        addressTxtField = textField.text!
        let cell1 = tabView.cellForRow(at: IndexPath(row: (mallmarketArr.count ) + 1, section: 0)) as! otherTableViewCell
        if cell1.nametxtfield.text!.count > 0
        {
            if !cell1.nametxtfield.text!.containArabicNumber
            
            {
                cell1.lbl.backgroundColor =  ModalController.hexStringToUIColor(hex: "#EC4A53")
            }
            else
            {
                cell1.lbl.backgroundColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2")
            }
        }
        else
        {
            cell1.lbl.backgroundColor =  ModalController.hexStringToUIColor(hex: "#EC4A53")
        }
        save.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
        save.setTitleColor(ModalController.hexStringToUIColor(hex: "#EC4A53"), for: .normal)
        
        if selectedIndexs.count > 0 || addressTxtField.count > 0
        {
            save.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#61C088").cgColor
            save.setTitleColor(ModalController.hexStringToUIColor(hex: "#61C088"), for: .normal)
            
            
        }
    }
    @IBAction func savebtn(_ sender: Any) {
        
        if isTrue
        {
            
            if  addressTxtField.count > 0
            {
                self.delegate?.otherAddress(Name: addressTxtField, Address: "")
                self.dismiss(animated: true, completion: nil)
                
            }
            else
            {
                ModalController.showNegativeCustomAlertWith(title:" Error", msg: "Can't add blank address")
            }
            
        }
        else{
            if selectedIndexs.count > 0
            {
                
                for (index,item) in selectedIndexs.enumerated()
                {
                    if mallmarketArr.count == 0 {
                        break
                    }
                    selectmallArray.add("\(mallmarketArr[index].name ?? "") \(mallmarketArr[index].area ?? "") \(mallmarketArr[index].city ?? "")")
                    self.selectmallId = mallmarketArr[index].id
                }
                
                
                
                
                self.dismiss(animated: true) {
                    if  self.selectmallArray.count > 0 {
                        self.delegate?.save(type: self.selectmallArray, id: self.selectmallId!)
                    }
                }
            }
            else
            {
                if self.radiocheck == 3
                {
                    ModalController.showNegativeCustomAlertWith(title:"Enter market/shop name".localized, msg: "")
                }
                if self.radiocheck == 4
                {
                    ModalController.showNegativeCustomAlertWith(title:" Enter mall/shop name".localized, msg: "")
                }
                
            }
        }
        
        
    }
    @IBAction func crossBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func MallMarketList_API()
    {
        ModalClass.startLoading(self.view)
        // let device_id = UIDevice.current.identifierForVendor!.uuidString
        let str = "\(Constant.BASE_URL)\(Constant.MAllMarket_List)"
        let parameters = [
            "id": "\(mallId!)",
            "lat": "\(latitude)",
            "long": "\(longitude)",
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
            "next_page_no":pageno
            
        ] as [String : Any]
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if success == true {
                self.mallmarketList = Mapper<MallMarket>().map(JSON: response as! [String : Any])
                if self.mallmarketList!.error! {
                    ModalController.showNegativeCustomAlertWith(title:self.mallmarketList?.error_description ?? "", msg: "")
                    
                    
                }
                else{
                    if self.mallmarketList?.data?.mall_market_list?.count ?? 0 > 0
                    {
                        for i in 0...((self.mallmarketList?.data?.mall_market_list?.count ?? 0) - 1)
                        {
                            self.mallmarketArr.append((self.mallmarketList?.data?.mall_market_list![i])!)
                        }
                    }
                    
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
extension MallMarketPopupViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if !string.containArabicNumber
        {
         return false
        }
        return true
    }
}
