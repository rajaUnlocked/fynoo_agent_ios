//
//  BranchListViewController.swift
//  Fynoo Business
//
//  Created by SENDAN on 02/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class BranchListViewController: UIViewController{
    var BranchLIST:BranchList?
    var BranchChanges:BranchChange?
    var isAddBranch:Bool = false
    var textSTR = ""
      var branchdetail:BranchDetail?
    var SelectedId = NSMutableArray()
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
//    var productArray : NSMutableArray = NSMutableArray()
//    var selectedDict : NSMutableDictionary = NSMutableDictionary()
    var filterArray : [Branch_list]?
     var filterArray1 : [Branch_list]?
    let device_id = UIDevice.current.identifierForVendor!.uuidString
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.branchList_API()
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.viewBack.layer.insertSublayer(ModalController.setGradientColorBGBlack(), at: 0)
        tableView.delegate = self 
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "BranchListSearchTableCell", bundle: nil), forCellReuseIdentifier: "BranchListSearchTableCell");
        tableView.register(UINib(nibName: "BranchListDetailTableCell", bundle: nil), forCellReuseIdentifier: "BranchListDetailTableCell");
    }
   
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let textStr = textField.text {
            if self.BranchLIST?.data?.branch_list.count == 0{
                return
            }
            textSTR = textStr
            print("t5y7iglujkgm")
            
            filterArray =  self.BranchLIST?.data?.branch_list.filter{$0.branch_name.lowercased().contains(textStr.lowercased())}
            tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if isAddBranch
        {
            branchList_API()
        }
        
        
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func branchList_API()
    {
        ModalClass.startLoading(self.view)
        
        let str = "\(Constant.BASE_URL)\(Constant.Branch_List)"
        let parameters = [
            "user_id":Singleton.shared.getUserId(),
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        print(str)
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if success == true {
                self.BranchLIST = try! JSONDecoder().decode(BranchList.self, from: resp as! Data )
                if self.BranchLIST!.error! {
                    ModalController.showNegativeCustomAlertWith(title:" Error", msg: (self.BranchLIST?.error_description)!)
                    
                }
                else{
                  
                    
                    self.tableView.reloadData()
                    
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
    func BranchChange_API(param:[String:String],str:String,istype:Int)
    {
        ModalClass.startLoading(self.view)
        
        let str = str
        let parameters = param
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if success == true {
                self.BranchChanges = try! JSONDecoder().decode(BranchChange.self, from: resp as! Data )
                if self.BranchLIST!.error! {
                    ModalController.showNegativeCustomAlertWith(title:" Error", msg: "")
                    
                }
                else{
                    if istype == 1
                    {
                     ModalController.showSuccessCustomAlertWith(title: "Success", msg: "  Branch Status Changed Successfully")
                    }
                    else if istype == 2
                    {
                     ModalController.showSuccessCustomAlertWith(title: "Success", msg: "Main Branch Changed Successfully")
                    }
                    else
                    {
                    ModalController.showSuccessCustomAlertWith(title: "Success", msg: " Branch Deleted Successfully")
                    }
                    self.branchList_API()
                   
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
extension BranchListViewController : UITableViewDelegate,BranchListDetailTableCellDelegate{
  
   
    
    func edit(tag:Int) {
          AddBranch.shared.removeall()
          AddBranch.shared.isedit = true
       ModalClass.startLoading(self.view)
            addBranch.selectId = "\(filterArray1?[tag].id ?? 0)"
        addBranch.ismain = "\(filterArray1?[tag].is_main_branch ?? "")"
                  addBranch.getBranchdetail { (success, response) in
                           ModalClass.stopLoading()
                  if success
                    {
                        let vc = CreateBranchFirstStepViewController(nibName: "CreateBranchFirstStepViewController", bundle: nil)
                               self.navigationController?.pushViewController(vc, animated: true)
                    }
       
    }
    }
    func draft(tag: Int) {
          AddBranch.shared.removeall()
       
        AddBranch.shared.isdraft = true
         ModalClass.startLoading(self.view)
       addBranch.selectId = "\(filterArray1?[tag].id ?? 0)"
              addBranch.getBranchdetail { (success, response) in
                       ModalClass.stopLoading()
              if success
                {
                    let vc = CreateBranchFirstStepViewController(nibName: "CreateBranchFirstStepViewController", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: false)
                
                    }
     
    }
    }
    func deleteBranch(tag: Int) {
        
        let parameter = [
            "device_id": "\(device_id)",
            "device_type": "ios",
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
            "user_id":Singleton.shared.getUserId(),
            "branch_id":"\(filterArray1?[tag].id ?? 0)",
            "user_type":"BO"
        ]
         let str = "\(Constant.BASE_URL)\(Constant.BranchDelete_List)"
        self.BranchChange_API(param:parameter, str: str,istype: 3)
        
    }
    
    func changeMain(tag: Int) {
      if  filterArray1![tag].is_branch_active == 0
       {
         ModalController.showSuccessCustomAlertWith(title: "Success", msg:"Please Active Branch First")
        return
        }
        let parameter = [
            "device_id": "\(device_id)",
            "device_type": "ios",
            "branch_id":"\(filterArray1![tag].id)",
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
            "bo_user_id":Singleton.shared.getUserId()
        ]
         let str = "\(Constant.BASE_URL)\(Constant.BranchMain_List)"
         self.BranchChange_API(param:parameter, str: str,istype: 2)
        
    }
    
    func active(tag: Int) {
        
        var stat = "\(filterArray1![tag].is_branch_active)"
        if stat == "0"
        {
          stat = "1"
        }
        else{
           stat = "0"
        }
        let parameter = [
            "device_id": "\(device_id)",
            "device_type": "ios",
            "branch_id":"\(filterArray1![tag].id)",
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
            "status":stat,
        ]
         let str = "\(Constant.BASE_URL)\(Constant.BranchActive_List)"
        self.BranchChange_API(param:parameter, str: str,istype: 1)
    }
    
    func viewGallery(tag: Int) {
        if filterArray1![tag].is_branch_active == 3
        {
            ModalController.showNegativeCustomAlertWith(title: "Warning", msg: "please add product firstly")
            return
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 130
        }
        return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if BranchLIST!.data!.branch_list[indexPath.row].is_branch_active == 1
        {
            if indexPath.section == 1
            {
                let vc = ViewMoreBusinessViewController(nibName: "ViewMoreBusinessViewController", bundle: nil)
                // vc.isFrom = "WALLET TRANSACTION HISTORY"
                vc.selectId = "\(filterArray1![indexPath.row].id)"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
      
    }
}


extension BranchListViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            if textSTR.count > 0
            {
                return filterArray!.count
            }
            else{
                 return BranchLIST?.data!.branch_list.count ?? 0
            }
          
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BranchListDetailTableCell",for: indexPath) as! BranchListDetailTableCell
            cell.mainBranch.layer.cornerRadius = cell.mainBranch.layer.frame.height*0.5
            cell.switchs.transform = CGAffineTransform(scaleX: 0.85, y: 0.75)
            cell.selectionStyle = .none
           if textSTR.count > 0
            {
             filterArray1 = filterArray
            }
            else{
              filterArray1 = BranchLIST?.data?.branch_list
            }
            cell.branchName.text = filterArray1?[indexPath.row].branch_name ?? ""
            cell.noProduct.text = "number Of product  \(filterArray1?[indexPath.row].total_products ?? 0)"
            cell.tag = indexPath.row
            cell.delegate = self
            cell.mainBranchLbl.isHidden = true
            cell.switchs.isOn = true
            cell.mainBranch.isHidden = false
            cell.activelbl.text = "Active"
             cell.switchs.isUserInteractionEnabled = true
            if filterArray1![indexPath.row].is_branch_active == 0
            {
                cell.switchs.isOn = false
                cell.activelbl.text = "Inactive"
            }
          
            if filterArray1![indexPath.row].is_main_branch == "1"
            {
                cell.switchs.isUserInteractionEnabled = false
                cell.mainBranch.alpha = 0.3
                cell.mainBranch.isEnabled = false
    
                cell.mainBranchLbl.isHidden = false
            }

         

            if filterArray1![indexPath.row].is_branch_active != 3

            {
                cell.mainBranch.alpha = 1
                cell.mainBranch.isEnabled = true
                if filterArray1?[indexPath.row].is_main_branch == "1"
                {
                    cell.mainBranch.alpha = 0.3
                    cell.mainBranch.isEnabled = false
                }
                
                
            }
            if filterArray1![indexPath.row].is_branch_active == 3
            {
                
                cell.draftbtn.isHidden = false
                cell.draftimg.isHidden = false
                cell.switchs.alpha = 0.3
                cell.switchs.isEnabled = false
                cell.editbtn.alpha = 0.3
                cell.editbtn.isEnabled = false
                cell.activelbl.alpha = 0.3
                cell.activelbl.isEnabled = false
                cell.deletebtn.isHidden = false
                cell.mainBranch.alpha = 0.3
                cell.mainBranch.isEnabled = false
               
            }
            else
            {
                cell.draftbtn.isHidden = true
                cell.draftimg.isHidden = true
                cell.switchs.alpha = 1
                cell.switchs.isEnabled = true
                cell.editbtn.alpha = 1
                cell.editbtn.isEnabled = true
                cell.activelbl.alpha = 1
                cell.activelbl.isEnabled = true
                
                cell.deletebtn.isHidden = true
            }
           
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BranchListSearchTableCell",for: indexPath) as! BranchListSearchTableCell
         cell.searchtxt.addTarget(self, action: #selector(BranchListViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        cell.addNew.addTarget(self, action: #selector(clickAdd), for: .touchUpInside)
        cell.selectionStyle = .none
        cell.noBranch.text = "\(BranchLIST?.data!.active_branches ?? 0 )/\(BranchLIST?.data?.branch_limit ?? 0)"
        return cell
    }
     @objc func clickAdd()
       {
          AddBranch.shared.removeall()
    let vc = CreateBranchFirstStepViewController(nibName: "CreateBranchFirstStepViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
       }
}
