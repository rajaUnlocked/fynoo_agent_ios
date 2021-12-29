//
//  CreateProductFirstViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 11/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import PopupDialog
import MTPopup
import ObjectMapper
import BarcodeScanner
class CreateProductFirstViewController: UIViewController {
    var prolimit:ProductLimit?
    var dataforsale = false
    var isDataBank = false
     var isPurchaseData = false
   var serviceid = ""
    var Currency_Type_List:CurrencyLIST?
    var addproductmodel = AddProductModel()
    var productmodel = AddProductModel()
    var editpronew:EditProductnew?
    var checkbar:CheckBarCode?
    var imgcount = 0
    var isNextColor = false
    var isVarient = false
    var isSimilar = false
    var pro = ProductModel.shared
    var currency = NSMutableArray()
     var currencyid = NSMutableArray()
    @IBOutlet weak var tabvw: UITableView!
    @IBOutlet weak var headervw: NavigationView!
    @IBOutlet weak var TopHeightConst: NSLayoutConstraint!
    var productValArr = [String]()
    var borderColor = [String]()
    var selectedCurrency:NSMutableDictionary = NSMutableDictionary()
    var selectedBranch:NSMutableArray = NSMutableArray()
    var isOnline = true
     var isStore = false
    var headerLbl = ["Manage Products","General Information","Product/Service Pictures"]
    var headerImg = ["producticon","edit_feature","cameras-1"]
    var headerLbl1 = ["Scan Bar Code","Currency","Product/Service Name","Select Branch","Description"]
    var headerLblImg1 = ["barcode_new-1","banknote_new","product1","branchnew",""]
    var typeLbl = [["Type","Product","Service"],["Product Availiblity","Online","In Store"]]
  
    var isFromBranch = ""
    override func viewDidLoad() {
        
        ModalController.watermark(self.view)
        super.viewDidLoad()
        print("Device Gallery".localized)
        self.navigationController?.isNavigationBarHidden = true
        productlimit_API()
             self.tabvw.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
              if  ProductModel.shared.pro_final_status == 1
              {
                
             }
             else if  ProductModel.shared.filledstep > 1
             {
                let vc = CreateProductSecondViewController(nibName: "CreateProductSecondViewController", bundle: nil)
                vc.isDataBank = isDataBank
                vc.isFromBranch = isFromBranch
                             if ProductModel.shared.filledstep == 2
                             {
                                         vc.clicktab = 0
                             }
                             else if ProductModel.shared.filledstep == 3
                             {
                                         vc.clicktab = 1
                             }
                              else if ProductModel.shared.filledstep == 4
                             {
                                          vc.clicktab = 2
                             }
                      vc.hidesBottomBarWhenPushed = true;
                    self.navigationController?.pushViewController(vc, animated: false)
        }
             
          if isVarient || isSimilar
          {
           // ModalClass.startLoading(self.view)
                           addproductmodel.getproductcode { (success, response) in
                               ModalClass.stopLoading()
                            if success {
                                ProductModel.shared.productcode = response!.value(forKey: "product_code") as! String
                            }}
        }
        let pro = ProductModel.shared
        isOnline = ProductModel.shared.isOnline
        isStore =  ProductModel.shared.isoffline
       productValArr = [pro.barcode,pro.Currencyname,pro.productTitle,"\(pro.branchIdnew.count)",pro.productDecription]
       
        if pro.productId == ""
        {
            borderColor = ["#B2B2B2","#EC4A53","#EC4A53","#EC4A53","#EC4A53"]
            pro.galleryId = ["","","","","","","","","",""]
            productValArr = ["","","","",""]
          ProductModel.shared.galleryIdImageNew = [#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder")]
           
        }
        else
        {
             borderColor = ["#B2B2B2","#B2B2B2","#B2B2B2","#B2B2B2","#B2B2B2"]
            for i in 0...ProductModel.shared.galleryId.count - 1 {
                                     if "\(ProductModel.shared.galleryId[i])" == ""
                                     {
                                      
                                     }
                                     else{
                                     imgcount = imgcount + 1
                                     }
                               
                                 }
        }
        if isPurchaseData
        {
           
            pro.purchaseId = pro.productId
             pro.productId = ""
        }
        self.TopHeightConst.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headervw.titleHeader.text = "Manage Your Products".localized
        self.headervw.viewControl = self
        self.headervw.menuBtn.isHidden = false
        self.UINibs()
        self.bankListAPI()
    }
    func productlimit_API()
         {
            // ModalClass.startLoading(self.view)
                           productmodel.productlimit { (success, response) in
                               ModalClass.stopLoading()
                             
                               if success
                               {
                                  self.prolimit = response
                                  for item in (self.prolimit?.data!.br_limit_list)!
                                  {
                                      if item.code! == "PRO_DESC"
                                      {
                                          ProductModel.shared.productDecriptionVal = item.value!
                                      }
                                     else if item.code! == "PRO_WARRANTY"
                                      {
                                        ProductModel.shared.supportdescriptionsVal = item.value!
                                      }
                                     else if item.code! == "PRO_TECH_DESC"
                                      {
                                        ProductModel.shared.descriptionsVal = item.value!
                                      }
                                          else if item.code! == "PRO_IMG"
                                           {
                                                 ProductModel.shared.productImageVal = item.value!
                                                                             }
                                      else if item.code! == "PRO_DOC"
                                                    {
                                                  ProductModel.shared.productDocVal = item.value!
                                                                }
                                  }
                                self.tabvw.reloadData()
                               }
             }
         }
    func bankListAPI(){
        ModalClass.startLoading(self.view)
        let str = "\(Constant.BASE_URL)\(Constant.Bank_List)"
        let parameters = [
             "lang_code": HeaderHeightSingleton.shared.LanguageSelected
             ]
              ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
            ModalClass.stopLoading()
            if success == true {
                
                let ResponseDict : NSDictionary = (response as? NSDictionary)!
                print("ResponseDictionary %@",ResponseDict)
                let x = ResponseDict.object(forKey: "error") as! Bool
                if x {
               ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "msg") as? String)!, msg: "")
                }
                else
                {
                    self.currency.removeAllObjects()
                    self.currencyid.removeAllObjects()
            self.Currency_Type_List = Mapper<CurrencyLIST>().map(JSON: response as! [String : Any])
                    for i in 0...(self.Currency_Type_List?.data?.currency_list.count)! - 1
                    {
                        self.currency.add((self.Currency_Type_List?.data?.currency_list[i].currency)!)
                        self.currencyid.add((self.Currency_Type_List?.data?.currency_list[i].id)!)
                        if self.productValArr[1] == ""
                        {
                            self.productValArr[1] = self.currency[0] as! String
                            ProductModel.shared.currencyId = "\(self.currencyid[0])"
                            if ProductModel.shared.currencyId.count > 0
                                   {
                                self.borderColor[1] = "#B2B2B2"
                                      }
                                   else
                                   {
                                    self.borderColor[1] = "#EC4A53"
                                   }
                            self.tabvw.reloadSections(IndexSet(integer: 1), with: .none)
                        }
                    }
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
    func checkMadatory()
    
    {
        
        let pro = ProductModel.shared
      if isDataBank
             {
             if  pro.productTitle.count > 0 && pro.productDecription.count > 0   && "\(ProductModel.shared.galleryId[0])" != ""
             {
                 headerImg[1] = "green_checked"
                            isNextColor = true
                 }
                else
             {
                headerImg[1] = "edit_feature"
                isNextColor = false
                }
             }
        else
      {
        if pro.currencyId.count > 0 && pro.productTitle.count > 0 &&  pro.branchIdnew.count > 0 && pro.productDecription.count > 0 && (isOnline || isStore) && "\(ProductModel.shared.galleryId[0])" != ""
        {
            headerImg[1] = "green_checked"
            isNextColor = true
       
        }
        
        else
        {
            headerImg[1] = "edit_feature"
             isNextColor = false
              
        }
        }
        UITableView.performWithoutAnimation({
                       tabvw.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
                       tabvw.reloadRows(at: [IndexPath(row: 0, section: 4)], with: .none)
                   })
       
         
    }
    override func viewDidAppear(_ animated: Bool) {
        ModalClass.stopLoading()
            self.checkMadatory()
    }
   
    @objc func selectCurrencyCity()
    {
       
            let vc = SelectMultipleBranchesNewDesignViewController(nibName: "SelectMultipleBranchesNewDesignViewController", bundle: nil)
            vc.delegate = self
            vc.selectedBranchArray = selectedBranch
            self.navigationController?.pushViewController(vc, animated: true)
            
       
        
    }
    func UINibs()
    {
        tabvw.register(UINib(nibName: "HeaderBranchTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderBranchTableViewCell")
        tabvw.register(UINib(nibName: "SelectProductTypeNewTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectProductTypeNewTableViewCell")
        tabvw.register(UINib(nibName: "nextTableViewCell", bundle: nil), forCellReuseIdentifier: "nextTableViewCell")
        tabvw.register(UINib(nibName: "BusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessTableViewCell")
        tabvw.register(UINib(nibName: "CountingTableViewCell", bundle: nil), forCellReuseIdentifier: "CountingTableViewCell")
        tabvw.register(UINib(nibName: "CollectionViewTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionViewTableViewCell")
        tabvw.register(UINib(nibName: "spacingTableViewCell", bundle: nil), forCellReuseIdentifier: "spacingTableViewCell")
        
        
    }
    @objc func saveClick(_ sender :UIButton)
    {
     
        ProductModel.shared.isOnline = isOnline
        ProductModel.shared.isoffline = isStore
        
            if ProductModel.shared.productTitle == ""
                   {
                ModalController.showNegativeCustomAlertWith(title: "Please Add Product Name".localized, msg: "")

                       return
                   }
                   if  ProductModel.shared.productTitle.count > 0
                   {
                       if !ProductModel.shared.productTitle.containArabicNumber{
                          ModalController.showNegativeCustomAlertWith(title: "Should not accept Arbic Number", msg: "")
                            return
                       }
                      
                   }
            if ProductModel.shared.productTitle.first!.isWhitespace ||  ProductModel.shared.productTitle.count > 70
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Enter Valid Product Name  ", msg: "")
                return
            }
            if ProductModel.shared.productDecription == ""
                   {
                ModalController.showNegativeCustomAlertWith(title: "Please Add description".localized, msg: "")

                       return
                   }
                   if ProductModel.shared.productDecription.first!.isWhitespace
                   {
                       ModalController.showNegativeCustomAlertWith(title: "Blank Space should not be allowed at the starting.", msg: "")
                       return
                   }
            if  ProductModel.shared.productDecription.count > 0
                          {
                              if !ProductModel.shared.productDecription.containArabicNumber{
                                 ModalController.showNegativeCustomAlertWith(title: "Should not accept Arbic Number", msg: "")
                                return
                              }
                             
                          }
            if "\(ProductModel.shared.galleryId[0])" == ""
                 {
                ModalController.showNegativeCustomAlertWith(title: "Please add product main picture".localized, msg: "")

                     return
                 }
                  if  ProductModel.shared.videoUrl.count > 0
                                {
                                    if ProductModel.shared.videoUrl.isArabic{
                                       ModalController.showNegativeCustomAlertWith(title: "Should not accept Arbic Char", msg: "")
                                      return
                                    }
                                    if !ProductModel.shared.videoUrl.isValidURL()
                                                                                                                                                                   {
                                                                                                                                                                      ModalController.showNegativeCustomAlertWith(title: "Enter valid link".localized, msg: "" )
                                                                                                                                                                                                                                              return
                                                                                                                                                                                                        }
                                   
                                }
     

        
        if !isDataBank
        {
            if ProductModel.shared.currencyId == ""
                   {
                       ModalController.showNegativeCustomAlertWith(title: "Please Select Currency  ", msg: "")
                       return
        }
        
        if ProductModel.shared.branchIdnew.count == 0
               {
                   ModalController.showNegativeCustomAlertWith(title: "Please Select Branch  ", msg: "")
                   return
               }
        if !ProductModel.shared.isOnline && !ProductModel.shared.isoffline
               {
                   ModalController.showNegativeCustomAlertWith(title: "Please Select Online / In Store ", msg: "")
                   return
               }
       
        }
        
    if isDataBank
    {
        if isSimilar || isVarient || pro.productId != ""
        {
            let vc = CreateProductSecondViewController(nibName: "CreateProductSecondViewController", bundle: nil)
                  vc.isDataBank = self.isDataBank
                  vc.isSimilar = self.isSimilar
                  vc.isVarient = self.isVarient
                  vc.hidesBottomBarWhenPushed = true;
                 self.navigationController?.pushViewController(vc, animated: true)
            return
        }
    
            ModalClass.startLoading(self.view)
                       productmodel.isdraft = true
                          productmodel.step = 1
                     productmodel.proid = pro.productId
                         productmodel.addDatasaleNew { (success, response) in
                             ModalClass.stopLoading()
                             self.editpronew = response
                             if success {
                                 if sender.tag == 0
                                        {
                                 self.navigationController?.popViewController(animated: true)
                                 }
                                 else
                                 {
                                  
                        self.pro.finalStatus = self.editpronew?.data?.pro_status ?? 0
                        self.pro.productcode = self.editpronew?.data?.pro_code ?? ""
                         self.pro.productTitle = self.editpronew?.data?.pro_name ?? ""
                          self.pro.statusActive = self.editpronew?.data?.pro_status ?? 0
                            self.pro.productstatus = self.editpronew?.data?.product_status ?? ""
                          self.pro.productDecription = self.editpronew?.data?.pro_description ?? ""
                 self.pro.productId = "\(self.editpronew?.data?.pro_id ?? 0)"
                      self.pro.galleryFeatureImage = "\(self.editpronew?.data?.pro_featured_image ?? "")"
                     let vc = CreateProductSecondViewController(nibName: "CreateProductSecondViewController", bundle: nil)
                                                     //vc.isFromBranch = self.isFromBranch
                                                     vc.isDataBank = self.isDataBank
                                                     vc.isSimilar = self.isSimilar
                                                       vc.isVarient = self.isVarient
                                                     //vc.isPurchaseData = self.isPurchaseData
                                                      vc.hidesBottomBarWhenPushed = true;
                                                     self.navigationController?.pushViewController(vc, animated: true)
                                                 }
                                                
                                             }
                                      
                                     
                                 
                             
                             else
                             {
                                 ModalController.showNegativeCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
                             }
                         }
    }
        else
     {
        if sender.tag == 0
        {
            if ProductModel.shared.productId == ""
            {
                ModalClass.startLoading(self.view)
                addproductmodel.serviceid = self.serviceid
                addproductmodel.addProductNew { (success, response) in
                    ModalClass.stopLoading()
                    self.editpronew = response
                    if success {
                  self.navigationController?.backToViewController(viewController: DataEntryTypelistingViewController.self)
                        }
                    else
                    {
                 ModalController.showNegativeCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
                    }
                }
            }
            else{
                                 productmodel.isdraft = true
                                   productmodel.step = 1
                                   ModalClass.startLoading(self.view)
                                   productmodel.editProductNew { (success, response) in
                                       ModalClass.stopLoading()
                                       if success
                                       {
                                           self.editpronew = response
                                    
                                        ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "");                                   self.navigationController?.backToViewController(viewController: DataEntryTypelistingViewController.self)
                                           
                                           
                                       }
                                   } }
        }
        else{
            if ProductModel.shared.productId == ""
            {
                ModalClass.startLoading(self.view)
                addproductmodel.serviceid = self.serviceid
                addproductmodel.addProductNew { (success, response) in
                    ModalClass.stopLoading()
                    if success {
                        self.editpronew = response
                        let pro = ProductModel.shared
                         pro.productcode = self.editpronew?.data?.pro_code ?? ""
                        pro.productTitle = self.editpronew?.data?.pro_name ?? ""
                        pro.statusActive = self.editpronew?.data?.pro_status ?? 0
                        self.pro.productstatus = self.editpronew?.data?.product_status ?? ""
                        pro.barcode = self.editpronew?.data?.pro_barcode ?? ""
                        pro.Currencyname = self.editpronew?.data?.pro_currency_name ?? ""
                        pro.BranchCount = self.editpronew?.data?.pro_no_of_branch ?? 0
                        pro.productDecription = self.editpronew?.data?.pro_description ?? ""
                        pro.productId = "\(self.editpronew?.data?.product_id ?? 0)"
                        pro.galleryFeatureImage = "\(self.editpronew?.data?.pro_featured_image ?? "")"
                        if self.isPurchaseData && pro.pro_reference_id.count > 0
                                             {
                                             if (self.editpronew?.data?.pro_pdf?.count ?? 0) > 0
                                                                                          
                                                                    {
                                                  pro.documentId.removeAllObjects()
                                                    pro.documentImage.removeAllObjects()
                                                    pro.documentImageSize.removeAllObjects()
                                                            for i in 0...(self.editpronew?.data?.pro_pdf?.count ?? 0) - 1
                                                                        {
                                                            let br:Pro_pdf1 = (self.editpronew?.data?.pro_pdf![i])!
                                                             pro.documentId.add(br.id!)
                                                             pro.documentImage.add(br.pdf!)
                                                             pro.documentImageSize.add(br.size!)
                                                                         }
                                                                                            
                                                                                               
                                                             }
                                             }
                        let vc = CreateProductSecondViewController(nibName: "CreateProductSecondViewController", bundle: nil)
                        vc.isFromBranch = self.isFromBranch
                        vc.isPurchaseData = self.isPurchaseData
                     
                         vc.hidesBottomBarWhenPushed = true;
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else
                    {
                        ModalController.showNegativeCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
                    }
                }
            }
            else
            {
                let vc = CreateProductSecondViewController(nibName: "CreateProductSecondViewController", bundle: nil)
                vc.isFromBranch = isFromBranch
                 vc.hidesBottomBarWhenPushed = true;
                vc.isDataBank = isDataBank
                vc.isPurchaseData = isPurchaseData
                vc.isVarient = isVarient
                vc.isSimilar = isSimilar
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
     }
        
        
    }
    
}
// datasource
extension CreateProductFirstViewController:UITableViewDataSource,OCRViewControllerDelegate,QRCOdeViewControllerDelegate,SelectMultipleBranchesNewDesignViewControllerDelegate,BarCodePopupNewViewControllerDelegate
{
    func yourProductList(tag: Int) {
//        let vc = ProductListNewViewController(nibName: "ProductListNewViewController", bundle: nil)
//        vc.searchTxt = productmodel.barcode
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func fynooProductDataBank(tag: Int) {
//        let vc = ProductDataBankController(nibName: "ProductDataBankController", bundle: nil)
//
//               vc.textSTR = productmodel.barcode
//               self.navigationController?.pushViewController(vc, animated: true)
//        UITableView.performWithoutAnimation({
//        self.tabvw.reloadSections(IndexSet(integer: 1), with: .none)
  //      }
  //  )
        
    }
    
    func continueAdding(tag: Int) {
        UITableView.performWithoutAnimation({
               self.tabvw.reloadSections(IndexSet(integer: 1), with: .none)
               })
       
    }
    
    func selectedBranchesMethod(branchArray: NSMutableArray) {
        ProductModel.shared.branchIdnew.removeAllObjects()
        ProductModel.shared.BranchNamenew.removeAllObjects()
        let branchArr = branchArray
        if branchArray.count > 0
        {
            
            
            self.selectedBranch = branchArr
            for i in 0...self.selectedBranch.count - 1
            {
                let branch:NSDictionary =  self.selectedBranch[i] as! NSDictionary
                ProductModel.shared.branchIdnew.add(branch.value(forKey: "id")!)
                ProductModel.shared.BranchNamenew.add(branch.value(forKey: "branch_name")!)

            }
            productValArr[3] = "\(ProductModel.shared.branchIdnew.count)"
            if productValArr[3].count > 0
            {
                borderColor[3] = "#B2B2B2"
            }
            else
            {
             borderColor[3] = "#EC4A53"
            }
            UITableView.performWithoutAnimation({
                   self.tabvw.reloadSections(IndexSet(integer: 1), with: .none)
                   })
        }
        
        
        
    }
    
    func QRCodeScanner(str: String) {
        ModalClass.startLoading(self.view)
        productmodel.barcode = str
      
        productmodel.checkbarcode { (success, response) in
            ModalClass.stopLoading()
            self.checkbar = response
            if success
            {
                ProductModel.shared.barcode = str
                self.productValArr[0] = str
                
                if (self.checkbar?.data?.status_val)! == 0
                {
                    
                    UITableView.performWithoutAnimation({
                           self.tabvw.reloadSections(IndexSet(integer: 1), with: .none)
                           })
                }
                else
                {
                   let vc = BarCodePopupNewViewController(nibName: "BarCodePopupNewViewController", bundle: nil)
                                     
                                      vc.modalPresentationStyle = .overFullScreen
                                      vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                         
                         vc.checkbar = self.checkbar
                    vc.showData()
                            vc.delegate = self
                            self.present(vc, animated: true, completion: nil)
                    
                }
               
                
            }
        }
        return
    }
    
    
    func OCRCodeScanner(str: String) {
        if str.count == 0
        {
            ModalController.showNegativeCustomAlertWith(title: "Text not Found", msg: "")
        }
        var str1 = str
        if str.count > ProductModel.shared.productDecriptionVal
        {
            str1 = String(str.dropLast(str.count - ProductModel.shared.productDecriptionVal))
        }
        productValArr[4] = str1
         ProductModel.shared.productDecription = str1
        if ProductModel.shared.productDecription.count > 0
                   {
                    if !ProductModel.shared.productDecription.containArabicNumber
                    {
                        borderColor[4] = "#EC4A53"
                    }
                    else
                    {
                        borderColor[4] = "#B2B2B2"
                    }
                      
                   }
        UITableView.performWithoutAnimation({
               self.tabvw.reloadSections(IndexSet(integer: 1), with: .none)
               })
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    @objc func clickAvailbility( _ sender:UIButton)
       {
        if sender.tag == 0
        {
            isOnline = !isOnline
        }
        else
        {
             isStore = !isStore
        }
        UITableView.performWithoutAnimation({
            self.tabvw.reloadRows(at: [IndexPath(row: 7, section: 1)], with: .none)
               })
       
      checkMadatory()
        
    }
    @objc func clickOcr()
    {
        let vc = OCRViewController(nibName: "OCRViewController", bundle: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func clickBarCode()
    {
        
      let controller = BarcodeScannerViewController()
        controller.headerViewController.titleLabel.text = "Scan"
         controller.headerViewController.closeButton.setTitle("Close", for: .normal)
             controller.codeDelegate = self
                    controller.errorDelegate = self
                    controller.dismissalDelegate = self
         present(controller, animated: true, completion: nil)
    }
    
   
    @objc private func textFieldDidChange(_ textField: UITextField)
    
          {
              textField.textAlignment =  ("\(textField.text!.first)".isArabic ? .right:.left)
              if textField.tag == 100
              {
                  return
              }
            ProductModel.shared.productTitle = textField.text!
            productValArr[textField.tag - 1] = textField.text!
             let cell = tabvw.cellForRow(at: IndexPath(row: 3, section: 1)) as! BusinessTableViewCell
            if textField.text!.count > 0
            {
                if !textField.text!.containArabicNumber
                {
                    borderColor[textField.tag - 1] = "#EC4A53"
                                  cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: borderColor[textField.tag - 1]).cgColor
                }
                else
                {
                    borderColor[textField.tag - 1] = "#B2B2B2"
                    cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: borderColor[textField.tag - 1]).cgColor
                }
                
            }
            else
            {
                borderColor[textField.tag - 1] = "#EC4A53"
                 let cell = tabvw.cellForRow(at: IndexPath(row: 3, section: 1)) as! BusinessTableViewCell
                 cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: borderColor[textField.tag - 1]).cgColor
            }
            checkMadatory()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 2:
            return 3
        case 1:
            return 9
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0
            {
                let cell = tabvw.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as! HeaderBranchTableViewCell
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
                 cell.innerView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
               //cell.btnLeading.constant = 23
                cell.leadingConstant.constant = 0
                cell.trailingConstant.constant = 0
                cell.innerView.layer.cornerRadius = 0
                cell.rightarrow.isHidden = true
//                cell.lbl.font = UIFont.systemFont(ofSize: 16)
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
                cell.lbl.font = UIFont(name:"\(fontNameLight)",size:16)
                cell.lbl.text = headerLbl[indexPath.section].localized
                
                cell.btn.setImage(UIImage(named: headerImg[indexPath.section]), for: .normal)
                return cell
            }
            else
            {
                let cell = tabvw.dequeueReusableCell(withIdentifier: "SelectProductTypeNewTableViewCell", for: indexPath) as! SelectProductTypeNewTableViewCell
                cell.lbl.text = typeLbl[indexPath.section][0].localized
                cell.leftlbl.text = typeLbl[indexPath.section][1].localized
                cell.rgtlbl.text = typeLbl[indexPath.section][2].localized
                cell.leadingConst.constant = 20
                cell.trailingConst.constant = 0
                cell.outervw.layer.borderWidth = 0
                cell.leftbtn.tag = 0
                cell.rgtbtn.tag = 1
                 // cell.btnleading.constant = 10
                cell.isUserInteractionEnabled = false
                cell.leftbtn.setImage(UIImage(named: "selected_new"), for: .normal)
                  cell.rgtbtn.setImage(UIImage(named: "unselected_new"), for: .normal)
                return cell
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tabvw.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as! HeaderBranchTableViewCell
                cell.rightarrow.isHidden = true
                  cell.innerView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
                cell.leadingConstant.constant = 15
                cell.trailingConstant.constant = 15
                cell.bottomConst.constant = 0
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
                cell.lbl.font = UIFont(name:"\(fontNameLight)",size:12)
                cell.lbl.text = headerLbl[indexPath.section].localized
                cell.btn.setImage(UIImage(named: headerImg[indexPath.section]), for: .normal)
                cell.innerView.clipsToBounds = true
                cell.innerView.layer.cornerRadius = 10
                cell.innerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                return cell
            case 1...5:
                let cell = tabvw.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as! BusinessTableViewCell
               
                
                
                cell.outerVw.isHidden = false
                cell.nameTextField.text = productValArr[indexPath.row - 1];
                cell.bordertxt.setAllSideShadowForFields(shadowShowSize: 0.0, sizeFloat: 0)
                cell.img.isUserInteractionEnabled = false
                cell.downarrow.isUserInteractionEnabled = false
                cell.txtView.isHidden = true
                cell.nameTextField.isUserInteractionEnabled = true
                cell.nameTextField.isHidden = false
                cell.leadingConstlbl.constant = 40
                //cell.lblk.text = headerLbl1[indexPath.row - 1]
                cell.imgLeading.constant = 15
                cell.img.image = UIImage(named: headerLblImg1[indexPath.row - 1])
                cell.leadingConst.constant = 25
                cell.trailingConst.constant = 25
                cell.ocrbtn.isHidden = true
                cell.downarrow.isHidden = true
                cell.imgbtn.isHidden = false
                cell.lblk.text = "\(headerLbl1[indexPath.row - 1])".localized
//                if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
//                    if value[0]=="ar"{
//                        cell.lblk.textAlignment = .right
//                    }else if value[0]=="en"{
//                        cell.lblk.textAlignment = .left
//                    }
//                }
                cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: borderColor[indexPath.row - 1]).cgColor
                if isDataBank
                {
                 //cell.lblk.isHidden = true
                 //cell.img.isHidden = true
                cell.nameTextField.isHidden = true
                }
                if indexPath.row == 1{
                     cell.nameTextField.isUserInteractionEnabled = false
                    cell.imgbtn.isHidden = false
                    cell.nameTextField.text = productValArr[indexPath.row - 1];
                }
               
                if indexPath.row == 2 || indexPath.row == 4
                {
                     cell.nameTextField.isUserInteractionEnabled = false
                    //cell.downarrow.tag = indexPath.row
                    cell.downarrow.setImage(UIImage(named: "down-arrow-2"), for: .normal)
                    cell.downarrow.isHidden = false
                    if isDataBank
                        {
                        cell.downarrow.isHidden = true
                        }
                   // cell.downarrow.addTarget(self, action: #selector(selectCurrencyCity(_:)), for: .touchUpInside)
                    
                    
                }
                if indexPath.row == 3
                               {
                                cell.lblk.isHidden = false
                                cell.img.isHidden = false
                                cell.nameTextField.isHidden = false
                }
                if indexPath.row == 5
                {
                  
                    cell.txtView.isHidden = false
                    cell.nameTextField.isHidden = true
                    cell.ocrbtn.isHidden = false
                   cell.txtView.text = productValArr[indexPath.row - 1];
                  
                 cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: borderColor[indexPath.row - 1]).cgColor
                }
                
                cell.outerVw.addBorder(.right, color: UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1), thickness: 0.5)
                cell.outerVw.addBorder(.left, color: UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1), thickness: 0.5)
                //cell.imgbtn.addTarget(self, action: #selector(clickBarCode), for: .touchUpInside)
              
                cell.nameTextField.tag = indexPath.row
                  cell.nameTextField.delegate = self
                cell.nameTextField.addTarget(self, action: #selector(CreateProductFirstViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                cell.txtView.tag = 10
              
                cell.txtView.delegate = self
                cell.nameTextField.delegate = self
                cell.ocrbtn.addTarget(self, action: #selector(clickOcr), for: .touchUpInside)
                return cell
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CountingTableViewCell", for: indexPath) as! CountingTableViewCell
                cell.countLblTop.constant = 5
                cell.vw.layer.borderWidth = 0
                cell.vw.layer.cornerRadius = 0
                cell.topConst.constant = 0
                cell.leadingConstvw.constant = 15
                cell.trailingConstvw.constant = 15
                
                cell.counlbl.textColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)

                cell.counlbl.attributedText = ModalController.setProductStricColor(str: "\(ProductModel.shared.productDecription.count)/\(ProductModel.shared.productDecriptionVal)", str1: "\(ProductModel.shared.productDecription.count)", str2: " /\(ProductModel.shared.productDecriptionVal)", fontsize: 12, fontfamily: "LightFontName", txtcolor: #colorLiteral(red: 97/255, green: 192/255, blue: 136/255, alpha: 1))

                cell.vw.addBorder(.right, color: UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1), thickness: 0.5)
                cell.vw.addBorder(.left, color: UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1), thickness: 0.5)
                cell.vw.addBorder(.bottom, color: .white, thickness: 0.5)
              if ProductModel.shared.productDecription.count == ProductModel.shared.productDecriptionVal
                               {
                                  cell.counlbl.textColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
                                   
                               }
               
                return cell
            case 8:
                let cell = tableView.dequeueReusableCell(withIdentifier: "spacingTableViewCell", for: indexPath) as! spacingTableViewCell
                cell.contentView.backgroundColor = .white
                return cell
            default:
                let cell = tabvw.dequeueReusableCell(withIdentifier: "SelectProductTypeNewTableViewCell", for: indexPath) as! SelectProductTypeNewTableViewCell
               
                  cell.isUserInteractionEnabled = true
                    // cell.btnleading.constant = 25
                cell.outervw.layer.borderWidth = 0.5
                cell.leadingConst.constant = 15
                cell.trailingConst.constant = 15
                cell.leftlbl.text = typeLbl[indexPath.section][1].localized
                cell.lbl.text = typeLbl[indexPath.section][0].localized
                cell.rgtlbl.text = typeLbl[indexPath.section][2].localized
                cell.outervw.clipsToBounds = true
                cell.outervw.layer.cornerRadius = 10
                cell.outervw.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
              
                if isStore
                {
                    cell.rgtbtn.setImage(UIImage(named: "check"), for: .normal)
                }
                else
                {
                      cell.rgtbtn.setImage(UIImage(named: "uncheck"), for: .normal)
                }
                if isOnline
                        {
                        cell.leftbtn.setImage(UIImage(named: "check"), for: .normal)
                        }
                        else
                        {
                        cell.leftbtn.setImage(UIImage(named: "uncheck"), for: .normal)
                            }
                if !isStore && !isOnline
                               {
                                   cell.rgtbtn.setImage(UIImage(named: "check_red_new"), for: .normal)
                                  cell.leftbtn.setImage(UIImage(named: "check_red_new"), for: .normal)

                               }
                cell.leftbtn.tag = 0
                  cell.rgtbtn.tag = 1
                cell.leftbtn.addTarget(self, action: #selector(clickAvailbility(_:)), for: .touchUpInside)
                  cell.rgtbtn.addTarget(self, action: #selector(clickAvailbility(_:)), for: .touchUpInside)
               if isDataBank{
                                  cell.leftbtn.isHidden = true
                                  cell.rgtbtn.isHidden = true
                                  cell.leftlbl.isHidden = true
                                  cell.rgtlbl.isHidden = true
                                  cell.lbl.isHidden = true

                              }
                return cell
            }
        case 2:
            if indexPath.row == 0
            {
                let cell = tabvw.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as! HeaderBranchTableViewCell
                
                cell.rightarrow.isHidden = true
                  cell.innerView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
                cell.leadingConstant.constant = 20
                cell.trailingConstant.constant = 20
                cell.innerView.clipsToBounds = true
                cell.innerView.layer.cornerRadius = 10
                cell.innerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                cell.lbl.text = headerLbl[indexPath.section].localized
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
                cell.lbl.font = UIFont(name:"\(fontNameLight)",size:12)
                cell.btn.setImage(UIImage(named: headerImg[indexPath.section]), for: .normal)
                return cell
            }
            else if indexPath.row == 2
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CountingTableViewCell", for: indexPath) as! CountingTableViewCell
                cell.countLblTop.constant = 10
                cell.vw.layer.borderWidth = 0
                cell.topConst.constant = -10
                cell.trailConst.constant = 40
               
                cell.counlbl.textColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
                
                if imgcount == ProductModel.shared.productImageVal
                                          {
                                             cell.counlbl.textColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
                                              
                                          }
//                cell.counlbl.text = "\(imgcount)/10"
                cell.counlbl.attributedText = ModalController.setProductStricColor(str: "\(imgcount)/10", str1: "\(imgcount)", str2: "/10", fontsize: 12, fontfamily: "LightFontName", txtcolor: #colorLiteral(red: 97/255, green: 192/255, blue: 136/255, alpha: 1))
                return cell
            }
                
            else
            {
                let cell = tabvw.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell", for: indexPath) as! CollectionViewTableViewCell
                cell.delegate = self
                cell.viewcontrol = self
                cell.isDataBank = isDataBank
                cell.view = self.view
                cell.istype = "Product"
                cell.isDataBank = isDataBank || isPurchaseData
              cell.productImgArr = ProductModel.shared.galleryIdImageNew
                cell.collectionVIEW.isScrollEnabled = false
                if let flowLayout =  cell.collectionVIEW.collectionViewLayout as? UICollectionViewFlowLayout {
                    flowLayout.scrollDirection = .vertical
                }
                cell.collectionVIEW.reloadData()
                
                cell.leadingConst.constant = 20
                cell.trailingConst.constant = 20
                
                cell.collectionVIEW.clipsToBounds = true
                cell.collectionVIEW.layer.cornerRadius = 10
                cell.collectionVIEW.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                return cell
            }
        case 3:
            let cell = tabvw.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as! BusinessTableViewCell
             cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
            cell.bordertxt.setAllSideShadowForFields(shadowShowSize: 0.0, sizeFloat:0)
            cell.downarrow.isHidden = true
            cell.txtView.isHidden = true
            cell.widthconst.constant = 0
            cell.ocrtrailing.constant = 20
            cell.nameTextField.isHidden = false
            cell.nameTextField.tag = 100
            cell.nameTextField.placeholder = "www.example.com"
            cell.img.image = UIImage(named:"abc")
            cell.nameTextField.isUserInteractionEnabled = true
            cell.lblk.text = "Video URL".localized
            cell.leadingConstlbl.constant = 35
            cell.leadingConst.constant = 20
            cell.trailingConst.constant = 20
            cell.outerVw.isHidden = true
            cell.ocrbtn.isHidden = true
//            cell.txtView.delegate = self
//            cell.txtView.tag = 100
            cell.txtView.text = ProductModel.shared.videoUrl
            return cell
        default:
            let cell = tabvw.dequeueReusableCell(withIdentifier: "nextTableViewCell", for: indexPath) as! nextTableViewCell
            cell.savedraft.isHidden = false
            if ProductModel.shared.pro_final_status == 1
                       {
                        cell.savedraft.isHidden = true
            }
            if isDataBank
            {
                if pro.productId != ""
                {
                    cell.savedraft.isHidden = true
                }
            }
            if isNextColor
            {
               cell.nextbtn.layer.borderColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1).cgColor
                cell.nextbtn.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
                cell.savedraft.layer.borderColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1).cgColor
                               cell.savedraft.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)

                
            }
            else
            {
                cell.nextbtn.layer.borderColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1).cgColor
                 cell.nextbtn.setTitleColor(UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1), for: .normal)
               cell.savedraft.layer.borderColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1).cgColor
                    cell.savedraft.setTitleColor(UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1), for: .normal)
            }
          
            cell.savedraft.setTitle("Save As Draft".localized, for: .normal)
            cell.nextbtn.setTitle("Next".localized, for: .normal)
            cell.savedraft.tag = 0
            cell.savedraft.addTarget(self, action: #selector(saveClick(_ :)), for: .touchUpInside)
            cell.nextbtn.tag = 1
            cell.nextbtn.addTarget(self, action: #selector(saveClick(_ :)), for: .touchUpInside)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1
        {
            if indexPath.row == 1
            {
              clickBarCode()
            }
           else if indexPath.row == 4
            {
                selectCurrencyCity()
            }
            else if indexPath.row == 2
            {
                let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
                vc.delegate = self
                vc.isfiletr = true
                vc.nameAr = currency as! [String]
                vc.nameArId = currencyid as! [Int]
                vc.namelock = currencyid as! [Int]
                let popupController = MTPopupController(rootViewController: vc)
                popupController.autoAdjustKeyboardEvent = false
                popupController.style = .bottomSheet
                popupController.navigationBarHidden = true
                popupController.hidesCloseButton = false
                let blurEffect = UIBlurEffect(style: .dark)
                popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
                popupController.backgroundView?.alpha = 0.6
                popupController.backgroundView?.onClick {
                    popupController.dismiss()
                }
                popupController.present(in: self)
                
            }
            }
           
        }
    }
    

// delegate
extension CreateProductFirstViewController:UITableViewDelegate,UITextViewDelegate,CollectionViewTableViewCellDelegate,BottomPopupEditProductViewControllerDelegate
{
    func information(Value: String) {
        print("")
    }
    
    func actionPerform(tag: Int, index: Int) {
        print("")
    }
    
    func filterIdval(tag: Int, Value: String, id: Int) {
         productValArr[1] = Value
        ProductModel.shared.currencyId = "\(id)"
            if ProductModel.shared.currencyId.count > 0
                   {
                       borderColor[1] = "#B2B2B2"
                      }
                   else
                   {
                       borderColor[1] = "#EC4A53"
                   }
        tabvw.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    func deleteDoc(tag: Int) {
        print("")
    }
    
    func cancelBtn() {
        imgcount = 0
        for i in 0...ProductModel.shared.galleryId.count - 1 {
                   if "\(ProductModel.shared.galleryId[i])" == ""
                   {
                    
                   }
                   else{
                   imgcount = imgcount + 1
                   }
             
               }
        UITableView.performWithoutAnimation({
             tabvw.reloadRows(at: [IndexPath(row: 2, section: 2)], with: .none)
               })
      
        if "\(ProductModel.shared.galleryId[0])" != ""
        {
          headerImg[2] = "cam_green"
            UITableView.performWithoutAnimation({
                tabvw.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
                
            })
            
        }
        else{
            headerImg[2] = "cameras-1"
        UITableView.performWithoutAnimation({
                       tabvw.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
                       
                   })
        }
       checkMadatory()
    }
    
    func attachedPdf() {
        print("")
    }
    
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(string)
//
//        return true
//
//
//
//
//    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      
        if textView.text.count == 0
        {
            if text == " "
            {
            return false
            }
        }
        var textstr = ""
        if let text1 = textView.text as NSString? {
            let txtAfterUpdate = text1.replacingCharacters(in: range, with: text)
            textstr = txtAfterUpdate
        }
        textView.textAlignment =  ("\(textstr.first)".isArabic ? .right:.left)
        if textView.tag == 10
        {
            if !text.containArabicNumber
                         {
                             return false
                         }
            if textstr.count > ProductModel.shared.productDecriptionVal
            {
                return false
            }
          ProductModel.shared.productDecription = textstr
            productValArr[4] = textstr
              if ((tabvw.indexPathsForVisibleRows?.contains(IndexPath(row: 5, section: 1)))!) {
            let cell = tabvw.cellForRow(at: IndexPath(row: 5, section: 1)) as! BusinessTableViewCell
            if ProductModel.shared.productDecription.count > 0
                       {
                        if !ProductModel.shared.productDecription.containArabicNumber
                        {
                            borderColor[4] = "#EC4A53"
                            cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: borderColor[4]).cgColor
                        }
                        else
                        {
                            borderColor[4] = "#B2B2B2"
                             cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: borderColor[4]).cgColor
                        }
                          
                       }
              
                       else
                       {
                           borderColor[4] = "#EC4A53"
                             cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: borderColor[4]).cgColor
                       }
            }
           UITableView.performWithoutAnimation({
    
                           tabvw.reloadRows(at: [IndexPath(row: 6, section: 1)], with: .none)
                           
                       })
        }
        else
        {
            if text.isArabic
                         {
                             return false
                         }
         ProductModel.shared.videoUrl = textstr
            let cell = tabvw.cellForRow(at: IndexPath(row: 0, section: 3)) as! BusinessTableViewCell
                       if textstr.count > 0
                                  {
                                    
                                    if !textstr.isValidURL()
                                        
                                   {
                                     
                                        cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                   }
                                   else
                                   {
                                     
                                        cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                   }
                                     
                                  }
                                  else
                                  {
                                     
                                        cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                  }
                    
        }
       checkMadatory()
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0
            {
                return 50
            }
            else{
                return 40
            }
        case 1:
            if isDataBank
            {
                switch indexPath.row {
                case 0:
                    return 40
                case 2,4:
                    return 0
                    case 1,3:
                    return 70
                case 5:
                    return 120
                case 6:
                    return 30
                    case 7:
                return 10
                case 8:
                    return 10
                default:
                    return 0
                }
            }
            else{
            switch indexPath.row {
            case 0:
                return 40
            case 1...4:
                return 70
            case 5:
                return 120
            case 6:
                return 30
            case 8:
                return 20
            default:
                return 40
            }
            }
        case 2:
            if indexPath.row == 0
            {
                return 40
            }
            if indexPath.row == 2
            {
                return 30
                
            }
            else{
                return 150
            }
        case 3:
            return 70
        default:
            return 100
        }
    }
}

extension CreateProductFirstViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if !string.containArabicNumber
        {
         return false
        }
        var textstr = ""
        if let text1 = textField.text as NSString? {
            let txtAfterUpdate = text1.replacingCharacters(in: range, with: string)
            textstr = txtAfterUpdate
        }
        if textField.tag == 100
        {
            if string.isArabic
                         {
                             return false
                         }
         ProductModel.shared.videoUrl = textstr
            let cell = tabvw.cellForRow(at: IndexPath(row: 0, section: 3)) as! BusinessTableViewCell
                       if textstr.count > 0
                                  {

                                    if !textstr.isValidURL()
                                        
                                   {
                                     
                                        cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                   }
                                   else
                                   {
                                     
                                        cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                   }
                                     
                                  }
                                  else
                                  {
                                     
                                        cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                  }
            checkMadatory()
            return true
        }
        return true
    }
}
extension CreateProductFirstViewController: BarcodeScannerCodeDelegate,BarcodeScannerErrorDelegate,BarcodeScannerDismissalDelegate {

 func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
    print(error)
    controller.dismiss(animated: true, completion: nil)
  }

  func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
    controller.dismiss(animated: true, completion: nil)
  }

    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        self.QRCodeScanner(str: code)
    controller.dismiss(animated: true, completion: nil)
        }

}
