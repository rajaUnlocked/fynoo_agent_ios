//
//  SelectMultipleBranchesNewDesignViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya on 14/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol SelectMultipleBranchesNewDesignViewControllerDelegate: class {
    func selectedBranchesMethod(branchArray : NSMutableArray)
}

class SelectMultipleBranchesNewDesignViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
   
    @IBOutlet weak var titlelabel: UILabel!
    var textSTR = ""
    var filterArrayVW:[Product_listdata]?
     var filterArrayVW1:[Product_listdata]?
    var viewproduct:CreateViewProductList?
    var proid = ""
    var prolist = NSDictionary()
    var isProduct = false
    var branch = [String]()
    var branchFilterNEW = [String]()
   // var data_bank_model = FynooDataBankModel()
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var downImage: UIImageView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableVw: UITableView!
    @IBOutlet weak var saveOutlet: UIButton!
    @IBOutlet weak var cancelOutlet: UIButton!
    var branchListArray : NSMutableArray = NSMutableArray()
    var selectedBranchArray : NSMutableArray = NSMutableArray()
    var filterListArray : NSMutableArray = NSMutableArray()
    weak var delegate: SelectMultipleBranchesNewDesignViewControllerDelegate?
    
    var branchImage = [String]()
    var isFromProductList = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        titlelabel.font = UIFont(name:"\(fontNameLight)",size:16)
         searchField.font = UIFont(name:"\(fontNameLight)",size:12)
        saveOutlet.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
         cancelOutlet.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        setupUIMethod()
    }
    
    func setupUIMethod(){
        if isProduct
        {
//            saveOutlet.isHidden = true
//            cancelOutlet.isHidden = true
//            ModalClass.startLoading(view)
//            data_bank_model.proid = proid
//            data_bank_model.createviewproduct { (success, response) in
//                if success{
//                    ModalClass.stopLoading()
//                    self.viewproduct = response!
//                    self.tableVw.reloadData()
//                }}
        }
        else
        {
            if branch.count > 0 {
                       self.cancelOutlet.isHidden = true
                       self.saveOutlet.isHidden = true
                   }else{
                   branchListingAPI()
                   }
        }
       
        searchField.addTarget(self, action: #selector(SelectMultipleBranchesNewDesignViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        downImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
           self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
           headerView.titleHeader.text = "Branch List"
        if isProduct
        {
            headerView.titleHeader.text = "Product Created"
            self.titlelabel.text = "Product Created"
        }
           self.headerView.viewControl = self
        self.searchField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)])
        tableVw.register(UINib(nibName: "SelectMultipleBranchesNewDesignTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectMultipleBranchesNewDesignTableViewCell");
        
    //    let trackY = self.searchVw.frame.maxY
   //     let trackedHeight = 125 + 48 + trackY
   //     self.tableVw.setAllSideShadowForFieldsWithHeight(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 32, sizeFloatHeight: trackedHeight)
         self.cancelOutlet.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: 100)
         self.saveOutlet.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: 100)
       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Branch Listing API
    func branchListingAPI()
    {
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.Branch_List)"
      
        let parameters = [
             "user_id": Singleton.shared.getUserId(),
            "lang_code":HeaderHeightSingleton.shared.LanguageSelected
        ]
        print("request -",parameters)
        ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if success == true {
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
              ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "error_description") as? String)!, msg: "")
                }
                else{
                    let results = (ResponseDict.object(forKey: "data") as! NSDictionary).object(forKey: "branch_list") as! NSArray
                    for var i in (0..<results.count){
                        let dict : NSDictionary = NSDictionary(dictionary: results.object(at: i) as! NSDictionary).RemoveNullValueFromDic()
                        self.branchListArray.add(dict)
                       
                    }
                    if self.selectedBranchArray.count == 0
                    {
                        if self.branchListArray.count > 0
                        {
                        for var i in (0...self.branchListArray.count - 1){
                            let branch:NSDictionary =  self.branchListArray[i] as! NSDictionary
                            if ProductModel.shared.branchIdnew.contains(branch.value(forKey: "id")!)
                            {
                                self.selectedBranchArray.add(self.branchListArray.object(at: i))
                            }
                           
                                                             }
                        }
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
    
    @IBAction func searchBtn(_ sender: Any) {
    }
    
    @IBAction func qrCodeBtn(_ sender: Any) {
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if self.selectedBranchArray.count == 0 {
            ModalController.showNegativeCustomAlertWith(title: "Please select a branch", msg: "")
            return
        }
        self.navigationController?.popViewController(animated: true)
        self.delegate?.selectedBranchesMethod(branchArray: selectedBranchArray)
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - TableView DataSource Delegates

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let views = MultipleBranchHeader()
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        views.titleLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        if branch.count > 0 {
        views.titleLbl.text = "Selected Branches"
        }
        if isProduct
        {
       views.titleLbl.text = "Select your Product"
        }
        return views
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isProduct
        {
           if textSTR.count > 0
                       {
                        return filterArrayVW?.count ?? 0
                       }
                       else{
                return  self.viewproduct?.data?.product_list?.count ?? 0
                       }
          
        }
        else
        {
        if filterListArray.count > 0 || ( searchField.text != "" && filterListArray.count == 0 && branch.count == 0) {
                  return self.filterListArray.count
              }
             else if branch.count > 0 {
                  if branchFilterNEW.count > 0 || (searchField.text != "" && branchFilterNEW.count == 0 && branch.count != 0){
                  return branchFilterNEW.count
              }else{
              return self.branch.count
              }
             }
             else{
              return self.branchListArray.count
              }
        }
      
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return branchListCell(index: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isProduct{
            return
        }
         if branch.count > 0 {
        return
        }
        
        if filterListArray.count > 0 || searchField.text != ""{
            
            if selectedBranchArray.contains(self.filterListArray.object(at: indexPath.row)) {
                selectedBranchArray.remove(self.filterListArray.object(at: indexPath.row))
            }else{
                selectedBranchArray.add(self.filterListArray.object(at: indexPath.row))
            }
            }else{
            if selectedBranchArray.contains(self.branchListArray.object(at: indexPath.row)) {
                selectedBranchArray.remove(self.branchListArray.object(at: indexPath.row))
            }else{
                selectedBranchArray.add(self.branchListArray.object(at: indexPath.row))
            }
        }
        self.tableVw.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40
    }
    
    // MARK: - TableView Cells Return
    func branchListCell(index : IndexPath) -> UITableViewCell {
        let cell = self.tableVw.dequeueReusableCell(withIdentifier: "SelectMultipleBranchesNewDesignTableViewCell",for: index) as! SelectMultipleBranchesNewDesignTableViewCell
        cell.selectionStyle = .none
             if isProduct
             {
                if textSTR.count > 0
                           {
                               filterArrayVW1 = filterArrayVW
                           }
                           else{
                               filterArrayVW1 = self.viewproduct?.data?.product_list
                           }
                cell.nameLbl.text = filterArrayVW1?[index.row].pro_name ?? ""
            cell.branchLogo.sd_setImage(with: URL(string:filterArrayVW1?[index.row].pro_image ?? ""), placeholderImage: UIImage(named: "category_placeholder"))
                cell.tickImage.isHidden = true
          }
                
                
             else{
        if branch.count > 0 {
            if branchFilterNEW.count > 0 {
                cell.nameLbl.text = branchFilterNEW[index.row] as! String
            }else{
            cell.nameLbl.text = branch[index.row] as! String
            }
            cell.tickImage.isHidden = false
        }else{
            if self.selectedBranchArray.count == 0 {
            self.saveOutlet.borderColor = #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1)
            self.saveOutlet.setTitleColor(#colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), for: .normal)
            }else{
                self.saveOutlet.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                self.saveOutlet.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
            }
            if filterListArray.count > 0 || searchField.text != ""{
             cell.nameLbl.text = "\((self.filterListArray.object(at: index.row) as! NSDictionary).object(forKey: "branch_name") as! String)"
                  cell.branchLogo.sd_setImage(with: URL(string:"\((self.branchListArray.object(at: index.row) as! NSDictionary).object(forKey: "branch_logo") as! String)"), placeholderImage: UIImage(named: "category_placeholder"))
             
            if selectedBranchArray.contains(self.filterListArray.object(at: index.row)) {
                
                 cell.tickImage.isHidden = false
             }else{
                 cell.tickImage.isHidden = true
             }
         }else{
         cell.nameLbl.text = "\((self.branchListArray.object(at: index.row) as! NSDictionary).object(forKey: "branch_name") as! String)"
              cell.branchLogo.sd_setImage(with: URL(string:"\((self.branchListArray.object(at: index.row) as! NSDictionary).object(forKey: "branch_logo") as! String)"), placeholderImage: UIImage(named: "category_placeholder"))
     
             if selectedBranchArray.contains(self.branchListArray.object(at: index.row)) {
             cell.tickImage.isHidden = false
                
         }else{
             cell.tickImage.isHidden = true
         }
        }
        }
                
                if isFromProductList {
                    cell.branchLogo.sd_setImage(with: URL(string:"\(branchImage[index.row] as! String)"), placeholderImage: UIImage(named: "category_placeholder"))
                }
        }
        return cell
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if isProduct
        {
            if let textStr = textField.text {
                       if self.viewproduct?.data?.product_list?.count == 0{
                           return
                       }
                       textSTR = textStr
                       print("t5y7iglujkgm")
                       
                       filterArrayVW =  self.viewproduct?.data?.product_list!.filter{($0.pro_name!.lowercased() as AnyObject).contains(textStr.lowercased())}
                       tableVw.reloadData()
        }
        }
        else
        {
        if branch.count > 0 {
            if let textStr = textField.text {
                       if self.branch.count == 0{
                           return
                       }
    
            branchFilterNEW = self.branch.filter { item in
                
                   return item.lowercased().contains(textStr.lowercased())
               }
        }
            print(branchFilterNEW)
            tableVw.reloadData()
        }
        else{
        if let textStr = textField.text {
            if self.branchListArray.count == 0{
                return
            }
            var countryOr = ""
                countryOr = "branch_name"
          
            let searchPredicate = NSPredicate(format: "\(countryOr) CONTAINS[C] %@", textStr)
            let array = (branchListArray as NSArray).filtered(using: searchPredicate)
            
            if(array.count == 0){
                self.filterListArray.removeAllObjects()
            } else {
                self.filterListArray.removeAllObjects()
                for var i in (0..<array.count)
                {
                    self.filterListArray.add((array[i] as! NSDictionary).RemoveNullValueFromDic())
                }
            }
            self.tableVw.reloadData()
        }
        }
        }
    }
}
