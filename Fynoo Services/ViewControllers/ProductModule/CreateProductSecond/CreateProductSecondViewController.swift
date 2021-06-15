//
//  CreateProductSecondViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 13/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import MTPopup
import MobileCoreServices
import PopupDialog

class CreateProductSecondViewController: UIViewController{
    var isDataBank = false
    var isPurchaseData = false
    var size = 0.0
    var editpronew:EditProductnew?
    var storepayment:StorePayment?
    var retailDimensionalArr = [[Any]]()
    @IBOutlet weak var tabvw: UITableView!
    @IBOutlet weak var headervw: NavigationView!
    @IBOutlet weak var TopHeightConst: NSLayoutConstraint!
    var isDigital = false
    var isCash = true
    var filterlist:ProductFilterList?
    var SelectedRadio = [Bool]()
    var isFilter = false
    var clicktab = 0
    var filterCount = 0
    var cataDict = NSDictionary()
    var min = 0
    var max = 0
    var isVarient = false
    var isSimilar = false
    var isSelected = "retail"
    var checkbtn = ["uncheck","check","uncheck","check"]
    var dimensionArrVal = ["","","","",""]
    var productPolicyArr = ["","","",""]
    var dimensionArr = ["Dimension".localized,"Weight".localized,"Length".localized,"Height".localized,"Width".localized]
    var dimensionArr1 = ["","Grams".localized,"Centimeter".localized,"Centimeter".localized,"Centimeter".localized]
    var ProArr = ["Product Return Policy Retail (Days)".localized,"Product Return Policy Wholesale (Days)".localized,"Stock Qty".localized,"Product Delivery Days".localized]
    var selectArr = [["Sale In".localized,"Retail".localized,"Wholesale".localized],["Payment Mode".localized,"Online".localized,"COD".localized]]
    var instoreNameArr = ["Regular Price".localized,"Discount Price".localized,"Discount Percentage".localized,"Net Selling Price".localized,"Vat Percentage".localized,"Vat Amount".localized,"Final Price".localized,"Max Qty \n That Can be Bought".localized,"Min Qty \n That Can be Bought".localized,"Product Return Policy (Days)".localized]
    var SARArr = ["SAR".localized,"SAR".localized,"%","SAR".localized,"%","SAR".localized,"SAR".localized,"","",""]
    var  onlineretailArr = ["Quantity \n That Can be Bought".localized,"Regular Price".localized,"Discount".localized,"Net Selling Price".localized,"VAT".localized,"Final Price".localized]
    let pro = ProductModel.shared
    var instoreWholeSaleArr = ["0.0","0.0","0.0","0.0","0.0","0.0","0.0","00","00","00"]
    var instoreRetailArr = ["0.0","0.0","0.0","0.0","0.0","0.0","0.0","00","00","00"]
    var productmodel = AddProductModel()
    var paymentSelectedIndex:NSMutableArray = NSMutableArray()
    var OnlineSelectedIndex:NSMutableArray = NSMutableArray()
    var instoreSelectedIndex:NSMutableArray = NSMutableArray()
    var SelectedIndex:NSMutableArray = NSMutableArray()
    var filterArr1:NSMutableArray = NSMutableArray()
    var filterArr:NSMutableArray = NSMutableArray()
    var filterArrVal1:NSMutableArray = NSMutableArray()
    var filterArrVal:NSMutableArray = NSMutableArray()
    var filterArrVallock:NSMutableArray = NSMutableArray()
    var filteridArr:NSMutableArray = NSMutableArray()
    var Selectedtab:NSMutableArray = NSMutableArray()
    var retailMin = 0.0
    var retailMax = 0.0
    var retailReg = 0.0
    var retailDisPrice = 0.0
    var retailDisPercen = 0.0
    var retailnetsell = 0.0
    var retailvat = 0.0
    var retailfinal = 0.0
    var isVat = false
    var docId = NSMutableArray()
    var docImage = NSMutableArray()
    var vatPercent = 0.0
    var fontNameLight = NSLocalizedString("LightFontName", comment: "")
    let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
    var isFromBranch = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        UINibs()
          
       
        let str1 = "Max Qty".localized
        let str2 = "That Can be Bought".localized
        instoreNameArr[7] = "\(str1) \n \(str2)"
        let str3 = "Min Qty".localized
        let str4 = "That Can be Bought".localized
        instoreNameArr[8] = "\(str3) \n \(str4)"
        
        
        self.filterArr.removeAllObjects()
        self.pro.filterIdName.removeAllObjects()
        self.filterArrVal.removeAllObjects()
        self.filterArrVal1.removeAllObjects()
        self.filteridArr.removeAllObjects()
        self.SelectedIndex.removeAllObjects()
        self.filterArrVallock.removeAllObjects()
        UITableView.setAnimationsEnabled(false)
        
        storepayment_API()
        docId = pro.documentId
        docImage = pro.documentImage
        let user:UserData?
        self.tabvw.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        
        user = AuthorisedUser.shared.getAuthorisedUser()
        if ProductModel.shared.isVat == false
        {
            isVat = false
        }
        else
        {
            isVat = true
        }
       
        if pro.filledstep > 2
        {
            if Selectedtab.contains(0)
            {}
            else
            {
                Selectedtab.add(0)
            }
            if pro.isOnline
            {
                if Selectedtab.contains(1)
                {}
                else
                {
                    Selectedtab.add(1)
                }
            }
            
        }
        if pro.filledstep == 2
        {
            if Selectedtab.contains(0)
            {}
            else
            {
                Selectedtab.add(0)
            }
        }
        if pro.filledstep == 3
        {
            if pro.isOnline
            {
                if Selectedtab.contains(1)
                {}
                else
                {
                    Selectedtab.add(1)
                }
            }
        }
        if pro.filledstep == 4
        {
            if Selectedtab.contains(2)
            {}
            else
            {
                Selectedtab.add(2)
            }
        }
        retailDimensionalArr = [[0,0],[0.0],[0.0,0.0],[0.0],[0.0,0.0],[0.0]]
        
        //        if isVat
        //        {
        //            retailDimensionalArr = [[0,0],[0.0],[0.0,0.0],[0.0],[0.0,5.0],[0.0]]
        //            instoreWholeSaleArr = ["0.0","0.0","0.0","0.0","5.0","0.0","0.0","00","00","00"]
        //            instoreRetailArr = ["0.0","0.0","0.0","0.0","5.0","0.0","0.0","00","00","00"]
        //        }
        
        if Int(pro.subcataId) ?? 0 > 0
        {
            dimensionArrVal = ["\(pro.dimension)","\(pro.length)","\(pro.width)","\(pro.height)","\(pro.weight)"]
            filterList_API(val: pro.subcataId)
            
            tabvw.reloadData()
            
        }
        
        if pro.isOnline
        {
            
            retailDimensionalArr = [[pro.OnlineMin,pro.OnlineMax],[pro.OnlineRegular],[pro.Onlinediscount,pro.OnlinediscountPer],[pro.Onlinesell],[pro.OnlineVat,pro.OnlineVatPer],[pro.OnlineFinal]]
            if pro.Onlineretail
            {
                OnlineSelectedIndex.add(0)
            }
            if pro.OnlineWhole
            {
                OnlineSelectedIndex.add(1)
            }
            if pro.Online
            {
                OnlineSelectedIndex.add(2)
            }
            else
            {
                OnlineSelectedIndex.add(2)
                
            }
            if pro.Cash
            {
                OnlineSelectedIndex.add(3)
            }
            productPolicyArr = [pro.OnlineReturnDays == "0" ? "" : pro.OnlineReturnDays,pro.OnlineReturnDays1 == "0" ? "" : pro.OnlineReturnDays1,pro.stockQuan == "0" ? "" : pro.stockQuan,pro.deliveryDays == "0" ? "" : pro.deliveryDays]
            tabvw.reloadData()
        }
        
        if pro.isoffline
        {
            
            isDigital = pro.Online1
            if pro.retail
            {
                instoreSelectedIndex.add(1)
            }
            if pro.Whole
            {
                instoreSelectedIndex.add(2)
            }
            
            
            instoreWholeSaleArr = [pro.RetailProductRegular,pro.RetailProductdiscount,pro.RetailProductdiscountPer,pro.RetailProductsell,pro.RetailProductVatPer,pro.RetailProductVat,pro.RetailProductFinal,pro.RetailProducteMax,pro.RetailProducteMin,pro.RetailReturnDays1]
            instoreRetailArr = [pro.RetailRegular,pro.Retaildiscount,pro.RetaildiscountPer,pro.Retailsell,pro.RetailVatPer,pro.RetailVat,pro.RetailFinal,pro.RetailMax,pro.RetailMin,pro.RetailReturnDays]
            tabvw.reloadData()
        }
        SelectedRadio = [true,false,false,false]
        self.TopHeightConst.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headervw.titleHeader.text = "Manage Your Products".localized;
        self.headervw.viewControl = self
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
      
          ValidateSpecTab1()
        
       
        if isVat
               {
                   
                   let obj = AddWholesaleSlab()
                   obj.getVat { (success, response) in
                       if success{
                           
                           let val = ((response?.object(forKey: "data") as! NSDictionary).object(forKey: "vat") as! Int)
                           
                           self.vatPercent = Double(val)
                        if self.pro.isOnline
                              {
                                  if ( self.retailDimensionalArr[4][1] as! NSString).integerValue == 0
                                  {
                                       self.retailDimensionalArr[4][1] = "\(self.vatPercent)"
                                    self.retailDimensionalArr[4][0] = "\((self.vatPercent * (self.retailDimensionalArr[3][0] as! NSString).doubleValue)/100)"
                                    self.pro.OnlineVatPer = "\(self.retailDimensionalArr[4][1])"
                                    self.pro.OnlineVat = "\(self.retailDimensionalArr[4][0])"
                                  }
                              }
                              if  self.pro.isoffline
                              {
                                  if ( self.instoreRetailArr[4] as NSString).integerValue == 0
                                  {
                                       self.instoreRetailArr[4] = "\(self.vatPercent)"
                                    self.instoreRetailArr[5] = "\((self.vatPercent * (self.instoreRetailArr[3] as NSString).doubleValue)/100)"
                                  }
                                  if ( self.instoreWholeSaleArr[4] as NSString).integerValue == 0
                                  {
                                       self.instoreWholeSaleArr[4] = "\(self.vatPercent)"
                                    self.instoreWholeSaleArr[5] = "\((self.vatPercent * (self.instoreWholeSaleArr[3] as NSString).doubleValue)/100)"
                                  }
                              }
                       }
                   }
                   
                   
               }
      
        
        
        productPolicyArr[2] = pro.stockQuan == "0" ? "" : pro.stockQuan
        checkonlineColor()
        tabvw.reloadData()
        
    }
    func storepayment_API()
    {
        // ModalClass.startLoading(self.view)
        AddProductModel().storePaymentList { (success, response) in
            ModalClass.stopLoading()
            if success {
                self.storepayment = response
                self.tabvw.reloadData()
            }}
    }
    func filterList_API(val : String)
    {
        ModalClass.startLoading(self.view)
        productmodel.subcataid = val
        productmodel.filterlist { (success, response) in
            ModalClass.stopLoading()
            if success
            {
                
                self.filterlist = response
                if self.filterlist?.data?.filter_list?.count ?? 0 > 0
                {
                for (index,item) in (self.filterlist?.data?.filter_list?.enumerated())!
                {
                    self.filterArrVal.add("")
                    self.filterArrVal1.add("")
                    self.filteridArr.add(item.filter_id!)
                    self.pro.filterIdName.add(item.filter_name!)
                    if self.pro.SelectedVarientIndex.contains(item.filter_id!)
                    {
                        self.SelectedIndex.add(index)
                    }
                    
                    
                    let fil = NSMutableArray()
                    let filId = NSMutableArray()
                    let filIdlock = NSMutableArray()
                    for ite in item.filter_value!
                    {
                        if self.pro.filterIdValue.contains(ite.filter_value_id!)
                        {
                            
                            self.filterArrVal.insert(ite.filter_value_name!, at: index)
                            self.filterArrVal1.insert(ite.filter_value_id!, at: index)
                        }
                        
                        if ite.filter_value_status == 1
                        {
                            filIdlock.add(ite.filter_value_id!)
                        }
                        fil.add(ite.filter_value_name!)
                        filId.add(ite.filter_value_id!)
                        
                    }
                    
                    fil.add("Other")
                    filId.add(0)
                    filIdlock.add(0)
                    self.filterArrVallock.insert(filIdlock, at: index)
                    self.filterArr.insert(fil, at: index)
                    self.filterArr1.insert(filId, at: index)
                    
                }
                }
                self.tabvw.reloadData()
                
            }
        }
    }
    
    func UINibs() {
        
        tabvw.register(UINib(nibName: "HeaderBranchTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderBranchTableViewCell")
        tabvw.register(UINib(nibName: "SelectProductTypeNewTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectProductTypeNewTableViewCell")
        tabvw.register(UINib(nibName: "nextTableViewCell", bundle: nil), forCellReuseIdentifier: "nextTableViewCell")
        tabvw.register(UINib(nibName: "spacingTableViewCell", bundle: nil), forCellReuseIdentifier: "spacingTableViewCell")
        tabvw.register(UINib(nibName: "ProductTopTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTopTableViewCell")
        tabvw.register(UINib(nibName: "ProductHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductHeaderTableViewCell")
        tabvw.register(UINib(nibName: "ProductSecondTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductSecondTableViewCell")
        tabvw.register(UINib(nibName: "RetailPriceListViewCell", bundle: nil), forCellReuseIdentifier: "RetailPriceListViewCell")
        tabvw.register(UINib(nibName: "WholesaleListViewCell", bundle: nil), forCellReuseIdentifier: "WholesaleListViewCell")
        tabvw.register(UINib(nibName: "ProductHeader2TableViewCell", bundle: nil), forCellReuseIdentifier: "ProductHeader2TableViewCell")
        tabvw.register(UINib(nibName: "PriceTopTableViewCell", bundle: nil), forCellReuseIdentifier: "PriceTopTableViewCell")
        tabvw.register(UINib(nibName: "WholeAddSlabTableViewCell", bundle: nil), forCellReuseIdentifier: "WholeAddSlabTableViewCell")
        tabvw.register(UINib(nibName: "InstorePaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "InstorePaymentTableViewCell")
        tabvw.register(UINib(nibName: "ProductSpecCatagoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductSpecCatagoryTableViewCell")
        tabvw.register(UINib(nibName: "ProductDimentionTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDimentionTableViewCell")
        tabvw.register(UINib(nibName: "BusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessTableViewCell")
        tabvw.register(UINib(nibName: "CountingTableViewCell", bundle: nil), forCellReuseIdentifier: "CountingTableViewCell")
        tabvw.register(UINib(nibName: "CollectionViewTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionViewTableViewCell")
        tabvw.register(UINib(nibName: "ORTableViewCell", bundle: nil), forCellReuseIdentifier: "ORTableViewCell")
        tabvw.register(UINib(nibName: "SpecificationTableViewCell", bundle: nil), forCellReuseIdentifier: "SpecificationTableViewCell")
        tabvw.register(UINib(nibName: "AddFeatureTableViewCell", bundle: nil), forCellReuseIdentifier: "AddFeatureTableViewCell")
        tabvw.register(UINib(nibName: "SendForAPProvalTableViewCell", bundle: nil), forCellReuseIdentifier: "SendForAPProvalTableViewCell")
        
    }
    
    @objc func createWholesaleSlab(){
        if !pro.OnlineWhole{
            ModalController.showNegativeCustomAlertWith(title: "Please Select WholeSale First", msg: "")
            return
        }
        if pro.Onlineretail
        {
            if (pro.OnlineMax as NSString).integerValue == 0 || (pro.OnlineMin as NSString).integerValue == 0
            {
                ModalController.showNegativeCustomAlertWith(title: "Please fill Retail Min Qty & Max Qty", msg: "")
                            return
            }
            if (pro.OnlineMax as NSString).integerValue < (pro.OnlineMin as NSString).integerValue
                           {
                               ModalController.showNegativeCustomAlertWith(title: "Min Qty Always Less Than Max Qty", msg: "")
                               return
                               
                           }
            if (pro.OnlineMax as NSString).integerValue > 0 && (pro.OnlineMin as NSString).integerValue > 0
            {
                if pro.OnlineQuantityFrom.count == 0
                {
                ProductModel.shared.onlineQuanTo = (pro.OnlineMax as NSString).integerValue + 1
                }
                
               
            }
          
        }
        else
        {
            if pro.OnlineQuantityFrom.count > 0
            {
                ProductModel.shared.onlineQuanTo =  pro.OnlineQuantityto.lastObject as! Int + 1
            }
            else
            {
           ProductModel.shared.onlineQuanTo = 1
            }
        }
        let vc = AddWholeSlabViewController(nibName: "AddWholeSlabViewController", bundle: nil)
        vc.isVat = isVat
        vc.proName = pro.productTitle
        vc.proImage = pro.galleryFeatureImage
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @objc func clikViewBranch(_ sender :UIButton){
        let vc = SelectMultipleBranchesNewDesignViewController(nibName: "SelectMultipleBranchesNewDesignViewController", bundle: nil)
        vc.branch = ProductModel.shared.BranchNamenew as! [String]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickEditSlab(_ sender :UIButton){
        if sender.tag == pro.OnlineQuantityto.count - 1
        {
            let vc = AddWholeSlabViewController(nibName: "AddWholeSlabViewController", bundle: nil)
            vc.isMax = false
            vc.isVat = isVat
            vc.wholesalePrice = pro.OnlineWholeSalePriceFrom[sender.tag] as! Double
            vc.discountPrice = pro.OnlinediscountWhole[sender.tag] as! Double
            vc.netSelling = pro.OnlineWholeSalePriceTo[sender.tag] as! Double
            vc.vatPrice = pro.OnlineVatValue[sender.tag] as! Double
            vc.minQty = pro.OnlineQuantityFrom[sender.tag] as! Int
            vc.maxQty = pro.OnlineQuantityto[sender.tag] as! Int
            vc.slabtag = sender.tag
            vc.isedit = true
            vc.proName = pro.productTitle
            vc.proImage = pro.galleryFeatureImage
            vc.vatPercent = pro.OnlineVatPercent[sender.tag] as! Double
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = AddWholeSlabViewController(nibName: "AddWholeSlabViewController", bundle: nil)
            vc.isMax = true
            vc.isVat = isVat
            vc.wholesalePrice = pro.OnlineWholeSalePriceFrom[sender.tag] as! Double
            vc.discountPrice = pro.OnlinediscountWhole[sender.tag] as! Double
            vc.netSelling = pro.OnlineWholeSalePriceTo[sender.tag] as! Double
            vc.vatPrice = pro.OnlineVatValue[sender.tag] as! Double
            vc.minQty = pro.OnlineQuantityFrom[sender.tag] as! Int
            vc.maxQty = pro.OnlineQuantityto[sender.tag] as! Int
            vc.proName = pro.productTitle
            vc.proImage = pro.galleryFeatureImage
            self.navigationController?.pushViewController(vc, animated: true)
            vc.slabtag = sender.tag
            vc.isedit = true
        }
        
    }
    @objc func clickDeleteSlab(_ sender :UIButton){
        
        pro.onlineQuanTo = pro.OnlineQuantityto[sender.tag ] as! Int + 1
        if sender.tag == 0
        {
            pro.onlineQuanTo = (pro.OnlineMax == "" ? 0 : Int(pro.OnlineMax)!) + 1
        }
        pro.OnlineQuantityFrom.removeLastObject()
        pro.OnlineQuantityto.removeLastObject()
        pro.OnlineWholeSalePriceFrom.removeLastObject()
        pro.OnlineWholeSalePriceTo.removeLastObject()
        pro.OnlinediscountWhole.removeLastObject()
        pro.OnlinediscountWholePercent.removeLastObject()
        pro.OnlineVatValue.removeLastObject()
        pro.OnlineVatPercent.removeLastObject()
        pro.OnlineFinalPrice.removeLastObject()
        tabvw.reloadData()
        
    }
    @objc func clickPayment(tag :Int)
    {
        
        if pro.storePayArr.contains((self.storepayment?.data?.store_payment_option?[tag].id)!)
        {
            pro.storePayArr.remove((self.storepayment?.data?.store_payment_option?[tag].id)!)
        }
        else{
            pro.storePayArr.add((self.storepayment?.data?.store_payment_option?[tag].id)!)
        }
        checkinstoreColor()
        tabvw.reloadData()
    }
    @objc func clickStockUpdate(_ sender :UIButton)
    {
        let vc = InventoryViewController(nibName: "InventoryViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func clickVarientSelect(_ sender :UIButton)
    {
        if SelectedIndex.contains(sender.tag - 2)
        {
            SelectedIndex.remove(sender.tag - 2)
        }
        else
        {
            SelectedIndex.add(sender.tag - 2)
        }
        tabvw.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    @objc func clickRetailCheck(_ sender :UIButton)
    {
        if clicktab == 2
        {
        if instoreSelectedIndex.contains(sender.tag)
        {
            instoreSelectedIndex.remove(sender.tag)
        }
        else
        {
            instoreSelectedIndex.add(sender.tag)
        }
            
         if sender.tag == 1
         {
            if instoreSelectedIndex.contains(1) == false{
             instoreRetailArr = ["0.0","0.0","0.0","0.0","0.0","0.0","0.0","00","00","00"]
pro.RetailRegular = ""
pro.Retaildiscount = ""
pro.RetaildiscountPer = ""
pro.Retailsell = ""
pro.RetailVatPer = ""
pro.RetailVat = ""
pro.RetailFinal = ""
pro.RetailMax = ""
pro.RetailMin = ""
pro.RetailReturnDays = ""
            }
         }
        if sender.tag == 2
        {
            if instoreSelectedIndex.contains(2) == false{
              instoreWholeSaleArr = ["0.0","0.0","0.0","0.0","0.0","0.0","0.0","00","00","00"]
            pro.RetailProductRegular = ""
            pro.RetailProductdiscount = ""
            pro.RetailProductdiscountPer = ""
            pro.RetailProductsell = ""
           pro.RetailProductVatPer = ""
           pro.RetailProductVat = ""
            pro.RetailProductFinal = ""
           pro.RetailProducteMax = ""
         pro.RetailProducteMin = ""
       pro.RetailReturnDays1 = ""
                       }
        }
        if sender.tag == 0
        {
            self.sameAsOnline()
        }
       self.checkinstoreColor()
          tabvw.reloadData()
        }
    }
    @objc func clickOnlineCheck(_ sender :UIButton)
    {
        if clicktab == 1
        {
            
            if OnlineSelectedIndex.contains(sender.tag)
            {
                OnlineSelectedIndex.remove(sender.tag)
            }
            else
            {
                OnlineSelectedIndex.add(sender.tag)
            }
            pro.Onlineretail = OnlineSelectedIndex.contains(0) ? true : false
            pro.OnlineWhole = OnlineSelectedIndex.contains(1) ? true : false
            pro.Online = OnlineSelectedIndex.contains(2) ? true : false
            pro.Cash = OnlineSelectedIndex.contains(3) ? true : false
            if !pro.Onlineretail
            {
               
               pro.OnlineMin = ""
                pro.OnlineMax = ""
                pro.OnlineRegular = ""
                pro.Onlinediscount = ""
                pro.OnlinediscountPer = ""
                pro.Onlinesell = ""
                pro.OnlineVat = ""
                pro.OnlineVatPer = ""
                pro.OnlineFinal = ""
                 retailDimensionalArr = [[pro.OnlineMin,pro.OnlineMax],[pro.OnlineRegular],[pro.Onlinediscount,pro.OnlinediscountPer],[pro.Onlinesell],[pro.OnlineVat,pro.OnlineVatPer],[pro.OnlineFinal]]
            }
            if !pro.OnlineWhole
            {
                        pro.OnlineQuantityFrom.removeAllObjects()
                              pro.OnlineQuantityto.removeAllObjects()
                              pro.OnlineWholeSalePriceFrom.removeAllObjects()
                              pro.OnlineWholeSalePriceTo.removeAllObjects()
                              pro.OnlinediscountWhole.removeAllObjects()
                              pro.OnlinediscountWholePercent.removeAllObjects()
                              pro.OnlineVatValue.removeAllObjects()
                              pro.OnlineVatPercent.removeAllObjects()
                              pro.OnlineFinalPrice.removeAllObjects()
            }
            self.checkonlineColor()
            tabvw.reloadData()
        }
        
    }
    
    @objc func openFilterPopup(_ sender :UIButton)
    {
        let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
        vc.delegate = self
        vc.iswarning = true
        vc.tag1 = sender.tag - 2
        vc.nameAr = filterArr[sender.tag - 2] as! [String]
        vc.nameArId = filterArr1[sender.tag - 2] as! [Int]
        vc.namelock = filterArrVallock[sender.tag - 2] as! [Int]
        vc.isfiletr = true
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
    
    func checkspecColor()
    {
        Selectedtab.remove(0)
        if pro.subcataId == "" || pro.subcataId == "0"
        {
            tabvw.reloadRows(at: [IndexPath(row: filterCount + 14, section: 1)], with: .none)
            return
        }
        if pro.length == 0.0 || pro.height == 0.0 || pro.width == 0.0 || pro.weight == 0.0
        {
            tabvw.reloadRows(at: [IndexPath(row: filterCount + 14, section: 1)], with: .none)
            return
        }
        if pro.descriptions == "" && docId.count == 0
        {
            tabvw.reloadRows(at: [IndexPath(row: filterCount + 14, section: 1)], with: .none)
            return
        }
        Selectedtab.add(0)
        tabvw.reloadRows(at: [IndexPath(row: filterCount + 14, section: 1)], with: .none)
        
    }
    func ValidateSpecTab() {
        
        Selectedtab.remove(0)
        pro.filterId.removeAllObjects()
        pro.filterIdValue.removeAllObjects()
        pro.varientId.removeAllObjects()
        if filterArrVal1.count > 0
        {
            for i in 0...filterArrVal1.count - 1 {
                if "\(filterArrVal1[i])" == ""
                {
                    
                }
                else{
                    pro.filterId.add(filteridArr[i])
                    pro.filterIdValue.add(filterArrVal1[i])
                    if SelectedIndex.contains(i)
                    {
                        pro.varientId.add(filterArrVal1[i])
                    }
                }
                
            }
        }
        if isVarient
        {
            if pro.varientId.count == 0
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Select At Least One filter", msg: "")
                return
            }
        }
        if pro.subcataId == "" || pro.subcataId == "0"
        {
            ModalController.showNegativeCustomAlertWith(title: "Please Select Catagory", msg: "")
            return
        }
        if pro.length == 0.0 || pro.height == 0.0 || pro.width == 0.0 || pro.weight == 0.0
        {
            ModalController.showNegativeCustomAlertWith(title: "Please Fill Dimension Feilds", msg: "")
            return
        }
        
        if pro.descriptions == "" && docId.count == 0
        {
            if docId.count == 0
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Fill Technical Description", msg: "")
                return
            }
            
        }
        if !"\(dimensionArrVal[1])".containArabicNumber || !"\(dimensionArrVal[2])".containArabicNumber || !"\(dimensionArrVal[3])".containArabicNumber || !"\(dimensionArrVal[4])".containArabicNumber
        {
            ModalController.showNegativeCustomAlertWith(title: "Dimension Should not accept Arbic Number", msg: "")
            return
        }
        if pro.descriptions.count > 0
        {
            if !pro.descriptions.containArabicNumber
            {
                ModalController.showNegativeCustomAlertWith(title: "Description Should not accept Arbic Number", msg: "")
                return
            }
        }
        if pro.supportdescriptions.count > 0
        {
            if !pro.supportdescriptions.containArabicNumber
            {
                ModalController.showNegativeCustomAlertWith(title: "Warranty Should not accept Arbic Number", msg: "")
                return
            }
        }
        
        Selectedtab.add(0)
        
        
        
    }
     func ValidateSpecTab1()
    {
        
        Selectedtab.remove(0)
        pro.filterId.removeAllObjects()
        pro.filterIdValue.removeAllObjects()
        pro.varientId.removeAllObjects()
        if filterArrVal1.count > 0
        {
            for i in 0...filterArrVal1.count - 1 {
                if "\(filterArrVal1[i])" == ""
                {
                    
                }
                else{
                    pro.filterId.add(filteridArr[i])
                    pro.filterIdValue.add(filterArrVal1[i])
                    if SelectedIndex.contains(i)
                    {
                        pro.varientId.add(filterArrVal1[i])
                    }
                }
                
            }
        }
        if isVarient
        {
            if pro.varientId.count == 0
            {
//                ModalController.showNegativeCustomAlertWith(title: "Please Select At Least One filter", msg: "")
                return
            }
        }
        if pro.subcataId == "" || pro.subcataId == "0"
        {
//            ModalController.showNegativeCustomAlertWith(title: "Please Select Catagory", msg: "")
            return
        }
        if pro.length == 0.0 || pro.height == 0.0 || pro.width == 0.0 || pro.weight == 0.0
        {
//            ModalController.showNegativeCustomAlertWith(title: "Please Fill Dimension Feilds", msg: "")
            return
        }
        
        if pro.descriptions == "" && docId.count == 0
        {
            if docId.count == 0
            {
//                ModalController.showNegativeCustomAlertWith(title: "Please Fill Technical Description", msg: "")
                return
            }
            
        }
        if !"\(dimensionArrVal[1])".containArabicNumber || !"\(dimensionArrVal[2])".containArabicNumber || !"\(dimensionArrVal[3])".containArabicNumber || !"\(dimensionArrVal[4])".containArabicNumber
        {
//            ModalController.showNegativeCustomAlertWith(title: "Dimension Should not accept Arbic Number", msg: "")
            return
        }
        if pro.descriptions.count > 0
        {
            if !pro.descriptions.containArabicNumber
            {
//                ModalController.showNegativeCustomAlertWith(title: "Description Should not accept Arbic Number", msg: "")
                return
            }
        }
        if pro.supportdescriptions.count > 0
        {
            if !pro.supportdescriptions.containArabicNumber
            {
//                ModalController.showNegativeCustomAlertWith(title: "Warranty Should not accept Arbic Number", msg: "")
                return
            }
        }
        
        Selectedtab.add(0)
        
        
        
    }
    func checkonlineColor()
    {
        Selectedtab.remove(1)
        if pro.Onlineretail == false && pro.OnlineWhole == false
        {
            
            return
        }
        else if pro.Online == false && pro.Cash == false
        {
            
            return
        }
            
        else if pro.stockQuan == ""
        {
            
            return
        }
            
        else if pro.deliveryDays == ""
        {
            
            return
        }
            
        else if pro.Onlineretail
        {
            if (pro.OnlineMin == "" || pro.OnlineMin == "0") || (pro.OnlineMax == "" || pro.OnlineMax == "0") || (pro.OnlineRegular == "" || pro.OnlineRegular == "0.0")
            {
                return
            }
            
        }
        if pro.OnlineWhole
        {
            if pro.OnlineQuantityFrom.count == 0
            {
                return
            }
        }
        
        
        Selectedtab.add(1)
        if ((tabvw.indexPathsForVisibleRows?.contains(IndexPath(row: 0, section: 2)))!) {
            let cell = tabvw.cellForRow(at: IndexPath(row: 0, section: 2)) as! nextTableViewCell
            
            if Selectedtab.contains(1)
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
        }
        return
        
    }
    func ValidateOnlineTab()
    {
        Selectedtab.remove(1)
        if pro.Onlineretail == false && pro.OnlineWhole == false
        {
            ModalController.showNegativeCustomAlertWith(title: "Please Select Retail/WholeSale", msg: "")
            return
        }
        if pro.Online == false && pro.Cash == false
        {
            ModalController.showNegativeCustomAlertWith(title: "Please Select Payment Method", msg: "")
            return
        }
        if pro.OnlineReturnDays != ""
        {
            if !pro.OnlineReturnDays.containArabicNumber
            {
                ModalController.showNegativeCustomAlertWith(title: "Should not accept Arbic Number", msg: "")
                return
            }
            if Int(pro.OnlineReturnDays) ?? 0 < 0  || Int(pro.OnlineReturnDays) ?? 0 > 365
            {
                ModalController.showNegativeCustomAlertWith(title: "Product Retail Return Days should not be greater than 365", msg: "")
                return
            }
            
            
        }
        if pro.OnlineReturnDays1 != ""
        {
            if !pro.OnlineReturnDays1.containArabicNumber
            {
                ModalController.showNegativeCustomAlertWith(title: "Should not accept Arbic Number", msg: "")
                return
            }
            if Int(pro.OnlineReturnDays1) ?? 0 < 0  || Int(pro.OnlineReturnDays1) ?? 0 > 365
            {
                ModalController.showNegativeCustomAlertWith(title: "Product WholeSale Return Days should not be greater than 365", msg: "")
                return
            }
            
            
        }
        if Int(pro.stockQuan) ?? 0 == 0
        {
            ModalController.showNegativeCustomAlertWith(title: "Please Fill Stock Qty", msg: "")
            return
        }
        if pro.stockQuan.count > 15
        {
            if !pro.stockQuan.containArabicNumber
            {
                ModalController.showNegativeCustomAlertWith(title: "Should not accept Arbic Number", msg: "")
                return
            }
            ModalController.showNegativeCustomAlertWith(title: "Maximum 15 digit should be applied ", msg: "")
            return
        }
        if Int(pro.deliveryDays) ?? 0 == 0
        {
            ModalController.showNegativeCustomAlertWith(title: "Please Fill Delivery Days", msg: "")
            return
        }
        if pro.deliveryDays != ""
        { if !pro.deliveryDays.containArabicNumber
        {
            ModalController.showNegativeCustomAlertWith(title: "Should not accept Arbic Number", msg: "")
            return
            }
            if Int(pro.deliveryDays) ?? 0 < 0  || Int(pro.deliveryDays) ?? 0 > 365
            {
                ModalController.showNegativeCustomAlertWith(title: "The value in this field should not be greater than 365", msg: "")
                return
            }
            
        }
        if pro.Onlineretail
        {
            if (pro.OnlineMin == "" || pro.OnlineMin == "0")
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Fill Min Qty", msg: "")
                return
            }
            if (pro.OnlineMax == "" || pro.OnlineMax == "0")
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Fill Max Qty", msg: "")
                return
            }
            if   (pro.OnlineRegular == "" || pro.OnlineRegular == "0.0")
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Fill Regular Price", msg: "")
                return
            }
            if (pro.OnlineMax as NSString).integerValue < (pro.OnlineMin as NSString).integerValue
            {
                ModalController.showNegativeCustomAlertWith(title: "Min Qty Always Less Than Max Qty", msg: "")
                return
                
            }
            
            if isVat
            {
                if (pro.OnlineVatPer == "" || pro.OnlineVatPer == "0.0")
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please Fill Vat Madatory Feild", msg: "")
                    return
                }
            }
            if (pro.OnlineVatPer as NSString).integerValue > 0
            {
                if !pro.OnlineVatPer.containArabicNumber
                {
                    ModalController.showNegativeCustomAlertWith(title: "Vat Should not accept Arbic Number", msg: "")
                    return
                }
            }
            
            if (pro.OnlineVat as NSString).integerValue > 0
            {
                if !pro.OnlineVat.containArabicNumber
                {
                    ModalController.showNegativeCustomAlertWith(title: "Vat Percentage Should not accept Arbic Number", msg: "")
                    return
                }
            }
        }
        if pro.OnlineWhole
        {
            if pro.OnlineQuantityFrom.count == 0
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Create At Least One WholeSale Slab", msg: "")
                return
            }
        }
        
         if pro.Onlineretail &&  pro.OnlineWhole
         {
            if (pro.OnlineQuantityFrom[0] as! Int) - (pro.OnlineMax as NSString).integerValue > 1
            {
                ModalController.showNegativeCustomAlertWith(title: " Retail and Wholesale qty must in continuity", msg: "")
                              return
              
            }
        }
        Selectedtab.add(1)
        
        
        
    }
    func checkinstoreColor()
    {
        pro.Online1 = isDigital
        pro.Cash1 = isCash
        pro.retail = instoreSelectedIndex.contains(1)
        pro.Whole = instoreSelectedIndex.contains(2)
        pro.RetailRegular = instoreRetailArr[0]
        pro.RetailProductRegular = instoreWholeSaleArr[0]
        Selectedtab.remove(2)
        if pro.Online1 == false && pro.Cash1 == false
        {
            tabvw.reloadSections(IndexSet(integer: 3), with: .none)
            return
        }
        else if pro.retail == false && pro.Whole == false
        {
            tabvw.reloadSections(IndexSet(integer: 3), with: .none)
            return
        }
        else if pro.retail
        {
            if pro.RetailRegular == "" || pro.RetailRegular == "0.0"
            {
                tabvw.reloadSections(IndexSet(integer: 3), with: .none)
                return
            }
        }
        else if pro.Whole
        {
            if pro.RetailProductRegular == "" || pro.RetailProductRegular == "0.0"
            {
                tabvw.reloadSections(IndexSet(integer: 3), with: .none)
                return
            }
        }
        if pro.storePayArr.count == 0
        {
            tabvw.reloadSections(IndexSet(integer: 3), with: .none)
            return
        }
        Selectedtab.add(2)
        tabvw.reloadSections(IndexSet(integer: 3), with: .none)
        
    }
    
    func ValidateInstoreTab()
    {
        Selectedtab.remove(2)
        if pro.Online1 == false && pro.Cash1 == false
        {
            return
        }
        if pro.retail == false && pro.Whole == false
        {
            ModalController.showNegativeCustomAlertWith(title: "Please Select Retail/WholeSale", msg: "")
            return
        }
        
        if pro.retail
        {
            if pro.RetailRegular == "" || pro.RetailRegular == "0.0"
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Fill Retail Regular Price", msg: "")
                return
            }
            if isVat
            {
                if pro.RetailVatPer == "" || pro.RetailVatPer == "0.0"
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please Fill Vat", msg: "")
                    return
                }
            }
            if !pro.RetailRegular.containArabicNumber
            {
                ModalController.showNegativeCustomAlertWith(title: "Regular Price Should not accept Arbic Number", msg: "")
                return
            }
            
            if (pro.RetailVat as NSString).integerValue > 0
            {
                if !pro.RetailVat.containArabicNumber
                {
                    ModalController.showNegativeCustomAlertWith(title: "Vat Should not accept Arbic Number", msg: "")
                    return
                }
            }
            if (pro.RetailVatPer as NSString).integerValue > 0
            {
                if !pro.RetailVatPer.containArabicNumber
                {
                    ModalController.showNegativeCustomAlertWith(title: "Vat Percentage Should not accept Arbic Number", msg: "")
                    return
                }
            }
            if (pro.Retaildiscount as NSString).integerValue > 0
            {
                if !pro.Retaildiscount.containArabicNumber
                {
                    ModalController.showNegativeCustomAlertWith(title: "discount  Should not accept Arbic Number", msg: "")
                    return
                }
            }
            if (pro.RetaildiscountPer as NSString).integerValue > 0
            {
                if !pro.RetaildiscountPer.containArabicNumber
                {
                    ModalController.showNegativeCustomAlertWith(title: "discount percentage Should not accept Arbic Number", msg: "")
                    return
                }
            }
            
        }
        if pro.Whole
        {
            if pro.RetailProductRegular == "" || pro.RetailProductRegular == "0.0"
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Fill WholeSale Regular Price", msg: "")
                return
            }
            if isVat
            {
                if pro.RetailProductVatPer == "" || pro.RetailProductVatPer == "0.0"
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please Fill Vat", msg: "")
                    return
                }
            }
            if !pro.RetailProductRegular.containArabicNumber
            {
                ModalController.showNegativeCustomAlertWith(title: "Whole Regular price Should not accept Arbic Number", msg: "")
                return
            }
            
            if (pro.RetailProductVat as NSString).integerValue > 0
            {
                if !pro.RetailProductVat.containArabicNumber
                {
                    ModalController.showNegativeCustomAlertWith(title: "Whole Vat Should not accept Arbic Number", msg: "")
                    return
                }
            }
            if (pro.RetailProductVatPer as NSString).integerValue > 0
            {
                if !pro.RetailProductVatPer.containArabicNumber
                {
                    ModalController.showNegativeCustomAlertWith(title: "Whole Vat Percentage Should not accept Arbic Number", msg: "")
                    return
                }
            }
            
            if (pro.RetailProductdiscount as NSString).integerValue > 0
            {
                if !pro.RetailProductdiscount.containArabicNumber
                {
                    ModalController.showNegativeCustomAlertWith(title: "Whole discount Should not accept Arbic Number", msg: "")
                    return
                }
            }
            if (pro.RetailProductdiscountPer as NSString).integerValue > 0
            {
                if !pro.RetailProductdiscountPer.containArabicNumber
                {
                    ModalController.showNegativeCustomAlertWith(title: "Whole discount Percentage Should not accept Arbic Number", msg: "")
                    return
                }
            }
            
        }
        Selectedtab.add(2)
        
    }
    @objc func saveClick(_ sender :UIButton)
    {
        if clicktab == 0
        {
            
            ValidateSpecTab()
            if Selectedtab.contains(0)
            {
                
                if sender.tag == 0
                {
                    productmodel.isdraft = true
                    productmodel.step = clicktab + 2
                    ModalClass.startLoading(self.view)
                    productmodel.editProductNew { (success, response) in
                        ModalClass.stopLoading()
                        if success
                        {
                            self.editpronew = response
                            
                            if self.isPurchaseData
                            {
                                ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
//                                self.navigationController?.backToViewController(viewController: ProductDataBankController.self)
                                
                            }
                            else
                            {
                                ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
                               self.navigationController?.backToViewController(viewController: DataEntryTypelistingViewController.self)
                            }
                        }
                    }
                }
                else{
                    if ProductModel.shared.pro_final_status == 1
                    {
                        if self.pro.isOnline
                        {
                            
                            self.clicktab = 1
                        }
                        else
                        {
                            self.clicktab = 2
                        }
                        
                        self.tabvw.setContentOffset(.zero, animated: true)
                        self.tabvw.reloadData()
                    }
                    else
                    {
                        
                        productmodel.isdraft = true
                        productmodel.step = clicktab + 2
                        ModalClass.startLoading(self.view)
                        productmodel.editProductNew { (success, response) in
                            ModalClass.stopLoading()
                            if success
                            {
                                if self.pro.isOnline
                                {
                                    
                                    self.clicktab = 1
                                }
                                else
                                {
                                    self.clicktab = 2
                                }
                                self.checkonlineColor()
                                self.tabvw.setContentOffset(.zero, animated: true)
                                self.tabvw.reloadData()
                            }
                        }
                    }
                    
                    
                }
                
            }
            
        }
        else if clicktab == 1
        {            ValidateOnlineTab()
            if Selectedtab.contains(1)
            {
                
                
                if sender.tag == 0
                {
                    productmodel.isdraft = true
                    productmodel.step = clicktab + 2
                    ModalClass.startLoading(self.view)
                    productmodel.editProductNew { (success, response) in
                        ModalClass.stopLoading()
                        if success
                        {
                            self.editpronew = response
                            
                            if self.isPurchaseData
                            {
                                ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
//                                self.navigationController?.backToViewController(viewController: ProductDataBankController.self)
                                
                            }
                            else
                            {
                                ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
                                self.navigationController?.backToViewController(viewController: DataEntryTypelistingViewController.self)
                            }
                            
                        }
                    }
                }
                else{
                    
                    
                    if pro.isoffline
                    {
                        if ProductModel.shared.pro_final_status == 1
                        {
                            self.clicktab = 2
                            self.tabvw.setContentOffset(.zero, animated: true)
                            self.tabvw.reloadData()
                        }
                        else
                        {
                            
                            productmodel.isdraft = true
                            productmodel.step = clicktab + 2
                            ModalClass.startLoading(self.view)
                            productmodel.editProductNew { (success, response) in
                                ModalClass.stopLoading()
                                if success
                                {
                                    self.clicktab = 2
                                    self.tabvw.setContentOffset(.zero, animated: true)
                                    self.tabvw.reloadData()
                                    self.checkinstoreColor()
                                }
                            }
                            
                        }
                    }
                        
                        
                    else
                    {
                        productmodel.isdraft = false
                        productmodel.step = clicktab + 2
                        productmodel.isSimilar = isSimilar
                        productmodel.isVarient = isVarient
                        ModalClass.startLoading(self.view)
                        productmodel.editProductNew { (success, response) in
                            ModalClass.stopLoading()
                            if success
                            {
                                self.editpronew = response
                                self.pro.productId = "\(self.editpronew?.data?.product_id ?? 0)"
                                if ProductModel.shared.pro_final_status == 1
                                {
                                    if self.isFromBranch != ""{
                                        ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
//                                        self.navigationController?.backToViewController(viewController: BranchDetailNewViewController.self)
                                    }
 //                                   else if self.isSimilar || self.isVarient
//                                    {
//                                        let vc = DatabankpopupViewController(nibName: "DatabankpopupViewController", bundle: nil)
//                                        vc.id = self.pro.productId
//                                        vc.delegate = self
//                                        vc.modalPresentationStyle = .overFullScreen
//                                        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//                                        self.present(vc, animated: true, completion: nil)
//                                    }
                                    else{
                                        ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
                                      self.navigationController?.backToViewController(viewController: DataEntryTypelistingViewController.self)
                                    }
                                }
                                else
                                {
                                    
                                    
                                    
                                    if self.isPurchaseData
                                    {
                                        ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
//                                        self.navigationController?.backToViewController(viewController: ProductDataBankController.self)
                                        
                                    }
                     //               else if self.pro.pro_reference_id == ""
                      //              {
//                                        let vc = DatabankpopupViewController(nibName: "DatabankpopupViewController", bundle: nil)
//                                        vc.id = self.pro.productId
//                                        vc.delegate = self
//                                        vc.modalPresentationStyle = .overFullScreen
//                                        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//                                        self.present(vc, animated: true, completion: nil)
  //                                  }
                                    else
                                    {
                                        ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
                                       self.navigationController?.backToViewController(viewController: DataEntryTypelistingViewController.self)
                                    }
                                }
                                
                                
                                
                            }
                        }
                    }
                }
            }
        }
        else
        {
            pro.Online1 = isDigital
            pro.Cash1 = isCash
            pro.retail = instoreSelectedIndex.contains(1)
            pro.Whole = instoreSelectedIndex.contains(2)
            pro.RetailRegular = instoreRetailArr[0]
            pro.Retaildiscount = instoreRetailArr[1]
            pro.RetaildiscountPer = instoreRetailArr[2]
            pro.Retailsell = instoreRetailArr[3]
            pro.RetailVatPer = instoreRetailArr[4]
            pro.RetailVat = instoreRetailArr[5]
            pro.RetailFinal = instoreRetailArr[6]
            pro.RetailMax = instoreRetailArr[7]
            pro.RetailMin = instoreRetailArr[8]
            pro.RetailReturnDays = instoreRetailArr[9]
            pro.RetailProductRegular = instoreWholeSaleArr[0]
            pro.RetailProductdiscount = instoreWholeSaleArr[1]
            pro.RetailProductdiscountPer = instoreWholeSaleArr[2]
            pro.RetailProductsell = instoreWholeSaleArr[3]
            pro.RetailProductVatPer = instoreWholeSaleArr[4]
            pro.RetailProductVat = instoreWholeSaleArr[5]
            pro.RetailProductFinal = instoreWholeSaleArr[6]
            pro.RetailProducteMax = instoreWholeSaleArr[7]
            pro.RetailProducteMin = instoreWholeSaleArr[8]
            pro.RetailReturnDays1 = instoreWholeSaleArr[9]
            ValidateInstoreTab()
            
            if Selectedtab.contains(2)
            {
                if pro.storePayArr.count == 0
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please Select At least One Store Payment", msg: "")
                    return
                }
                if pro.retail
                {
                    if (instoreRetailArr[1] as NSString).doubleValue > (instoreRetailArr[0] as NSString).doubleValue
                    {
                        ModalController.showNegativeCustomAlertWith(title: "Retail Discount Always Less Than Regular Price", msg: "")
                        return
                    }
                    if (instoreRetailArr[2] as NSString).doubleValue > 100
                    {
                        ModalController.showNegativeCustomAlertWith(title: "Retail Discount Percentage Always less than 100", msg: "")
                        return
                    }
                    if (instoreRetailArr[5] as NSString).doubleValue > (instoreRetailArr[3] as NSString).doubleValue
                    {
                        ModalController.showNegativeCustomAlertWith(title: "Retail Vat Amount Always Less Than Regular Price", msg: "")
                        return
                    };
                    
                    if (instoreRetailArr[4] as NSString).doubleValue > 100
                    {
                        ModalController.showNegativeCustomAlertWith(title: "Retail Vat Percentage Always less than 100", msg: "")
                        return
                    }
                    
                    
                }
                if pro.Whole
                {
                    if (instoreWholeSaleArr[1] as NSString).doubleValue > (instoreWholeSaleArr[0] as NSString).doubleValue
                    {
                        ModalController.showNegativeCustomAlertWith(title: "WholeSale Discount Always Less Than Regular Price", msg: "")
                        return
                    }
                    if (instoreWholeSaleArr[2] as NSString).doubleValue > 100
                    {
                        ModalController.showNegativeCustomAlertWith(title: "WholeSale Discount Percentage Always less than 100", msg: "")
                        return
                    }
                    if (instoreWholeSaleArr[5] as NSString).doubleValue > (instoreWholeSaleArr[3] as NSString).doubleValue
                    {
                        ModalController.showNegativeCustomAlertWith(title: "WholeSale Vat Amount Always Less Than Regular Price", msg: "")
                        return
                    };
                    
                    if (instoreWholeSaleArr[4] as NSString).doubleValue > 100
                    {
                        ModalController.showNegativeCustomAlertWith(title: "WholeSale Vat Percentage Always less than 100", msg: "")
                        return
                    }
                    
                }
                
                
                if sender.tag == 0
                {
                    productmodel.isdraft = true
                    productmodel.step = clicktab + 2
                    ModalClass.startLoading(self.view)
                    productmodel.editProductNew { (success, response) in
                        ModalClass.stopLoading()
                        if success
                        {
                            self.editpronew = response
                            ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
                            self.navigationController?.backToViewController(viewController: DataEntryTypelistingViewController.self)
                        }
                    }
                }
                else
                {
                    
                    productmodel.isdraft = false
                    productmodel.step = clicktab + 2
                    productmodel.isSimilar = isSimilar
                    productmodel.isVarient = isVarient
                    ModalClass.startLoading(self.view)
                    productmodel.editProductNew { (success, response) in
                        ModalClass.stopLoading()
                        if success
                        {
                            self.editpronew = response
                            self.pro.productId = "\(self.editpronew?.data?.product_id ?? 0)"
                            if ProductModel.shared.pro_final_status == 1
                            {
                                if self.isFromBranch != ""{
                                    ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
//                                    self.navigationController?.backToViewController(viewController: BranchDetailNewViewController.self)
                                }
              //                  else if self.isSimilar || self.isVarient
              //                  {
//                                    let vc = DatabankpopupViewController(nibName: "DatabankpopupViewController", bundle: nil)
//                                    vc.id = self.pro.productId
//                                    vc.delegate = self
//                                    vc.modalPresentationStyle = .overFullScreen
//                                    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//                                    self.present(vc, animated: true, completion: nil)
        //                        }
                                else{
                                    ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
                                    self.navigationController?.backToViewController(viewController: DataEntryTypelistingViewController.self)
                                }
                                
                                
                            }
                            else
                            {
                                
                                
                                
                                if self.isPurchaseData
                                {
                                    ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
//                                    self.navigationController?.backToViewController(viewController: ProductDataBankController.self)
                                }
     //                           else if self.pro.pro_reference_id == ""
       //                         {
//                                    let vc = DatabankpopupViewController(nibName: "DatabankpopupViewController", bundle: nil)
//                                    vc.id = self.pro.productId
//                                    vc.delegate = self
//                                    vc.modalPresentationStyle = .overFullScreen
//                                    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//                                    self.present(vc, animated: true, completion: nil)
     //                           }
                                else
                                {
                                    ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
                                   self.navigationController?.backToViewController(viewController: DataEntryTypelistingViewController.self)
                                }
                            }
                            
                            
                            
                        }
                    }
                }
            }
        }
    }
    func sameAsOnline()
    {
        
        if pro.Onlineretail
        {
            instoreSelectedIndex.add(1)
            instoreRetailArr = [pro.OnlineRegular,pro.Onlinediscount,pro.OnlinediscountPer,pro.Onlinesell,pro.OnlineVatPer,pro.OnlineVat,pro.OnlineFinal,pro.OnlineMax,pro.OnlineMin,pro.OnlineReturnDays]
            
        }
        if pro.OnlineWhole
        {
            instoreSelectedIndex.add(2)
            instoreWholeSaleArr = ["\(pro.OnlineWholeSalePriceFrom.firstObject ?? "")","\(pro.OnlinediscountWhole.firstObject ?? "")","\(pro.OnlinediscountWholePercent.firstObject ?? "")","\(pro.OnlineWholeSalePriceTo.firstObject ?? "")","\(pro.OnlineVatPercent.firstObject ?? "")","\(pro.OnlineVatValue.firstObject ?? "")","\(pro.OnlineFinalPrice.firstObject ?? "")","\(pro.OnlineQuantityto.firstObject ?? "")","\(pro.OnlineQuantityFrom.firstObject ?? "")",pro.OnlineReturnDays1]
            
        }
        
        tabvw.reloadData()
        
    }
    @objc func clickTab(_ sender:UIButton)
    {
        if sender.tag == 0
        {
            if Selectedtab.contains(0)
            {
                
                
            }
            else
            {
                return
            }
        }
        if sender.tag == 1
        {
            if clicktab == 0
            {
                ValidateSpecTab()
                if Selectedtab.contains(0)
                {
                    
                }
                else
                {
                    return
                }
                tabvw.reloadData()
            }
            if Selectedtab.contains(1)
            {}
            else
            {
                return
            }
        }
        if sender.tag == 2
        {
            if pro.isoffline && pro.isOnline
            {
                ValidateSpecTab()
                if Selectedtab.contains(0)
                {
                    ValidateOnlineTab()
                    if Selectedtab.contains(1)
                    {
                        
                    }
                    else
                    {
                        
                        return
                    }
                }
                else
                {
                    return
                }
                tabvw.reloadData()
            }
            if clicktab == 0
            {
                ValidateSpecTab()
                if Selectedtab.contains(0)
                {
                    
                }
                else
                {
                    return
                }
                tabvw.reloadData()
            }
            else if clicktab == 1
            {
                ValidateOnlineTab()
                if Selectedtab.contains(1)
                {
                    
                }
                else
                {
                    return
                }
                tabvw.reloadData()
            }
            
            //            if Selectedtab.contains(2)
            //            {
            //
            //
            //            }
            //            else
            //            {
            //                return
            //            }
        }
        
        if sender.tag == 0
        {
            clicktab = 0
        }
        else if sender.tag == 1
        {
            clicktab = 1
        }
        else{
            if pro.isoffline
            {
                clicktab = 2
            }
            
        }
        
        tabvw.reloadData()
    }
}
extension CreateProductSecondViewController:UITableViewDelegate,UITableViewDataSource,ProductHeader2Delegate,WholesaleListDelegate,SelectCategoryDelegate,UITextViewDelegate,BottomPopupEditProductViewControllerDelegate,OpenGalleryDelegate,DatabankpopupDelegate
{
    func productsellinfo() {
        print("bfnjbngmn")
        
        if self.isFromBranch != ""{
            
            ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
//            self.navigationController?.backToViewController(viewController: BranchDetailNewViewController.self)
        }else{
            ModalController.showSuccessCustomAlertWith(title:self.editpronew?.error_description ?? "", msg: "")
            self.navigationController?.backToViewController(viewController: DataEntryTypelistingViewController.self)
        }
        
    }
    func productDiscountCategory(categoryDict: NSMutableDictionary, subCategoryDict: NSMutableDictionary?) {
        
    }
    
    func gallery(img: UIImage, imgtype: String) {
        ModalClass.startLoading(view)
        var branch = branchsmodel()
        
        let imgData = img.jpegData(compressionQuality: 1)!
        var imageSize: Int = imgData.count
        size = 0.0
        let siz = Double(imageSize) / (1024 * 1024)
        pro.documentImageSize.add(siz)
        if pro.documentImageSize.count > 0
        {
            for i in 0...(pro.documentImageSize.count - 1)
            {
                let si = pro.documentImageSize[i] as! Double
                size = size + si
            }
        }
        print(".......\(size)")
        // self.fileSize(forURL: img)
        if size > 25
        {
            ModalController.showNegativeCustomAlertWith(title: "Doc Size is large", msg: "")
            return
        }
        branch.imgfile = img
        branch.uploadDocumentImage { (success, response) in
            ModalClass.stopLoading()
            
            if success
            {
                self.docId.add((response?.data?.doc_id)!)
                self.docImage.add((response?.data?.doc_url)!)
                self.checkspecColor()
                self.tabvw.reloadData()
            }
        }
    }
    
    func actionPerform(tag: Int, index: Int) {
        if tag == 0
        {
            if docImage.count <= 1
            {
                OpenGallery.shared.viewControl = self
                OpenGallery.shared.openGallery()
                OpenGallery.shared.delegate = self
            }
        }
        else
        {
            if docImage.count <= 1
            {
                
                let importMenu = UIDocumentPickerViewController(documentTypes: ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String], in: UIDocumentPickerMode.import)
                
                if #available(iOS 11.0, *) {
                    importMenu.allowsMultipleSelection = true
                }
                
                importMenu.delegate = self
                importMenu.modalPresentationStyle = .formSheet
                
                present(importMenu, animated: true)
            }
        }
    }
    
    
    
    func filterIdval(tag: Int, Value: String,id: Int) {
        
        if Value == "Other"
        {
            let vc = AddFilterViewController(nibName: "AddFilterViewController", bundle: nil)
            vc.delegate = self
            vc.filterValue = Int(pro.subcataId) ?? 0
            vc.fetureName = ProductModel.shared.filterIdName[tag] as! String
            let popup = PopupDialog(viewController: vc,
                                    buttonAlignment: .horizontal,
                                    transitionStyle: .bounceDown,
                                    tapGestureDismissal: true,
                                    panGestureDismissal: false)
            
            self.present(popup, animated: true, completion: nil)
            return
        }
        filterArrVal.replaceObject(at: tag, with: Value)
        filterArrVal1.replaceObject(at: tag, with: id)
        tabvw.reloadData()
    }
    
    func information(Value: String) {
        print("")
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if !text.containArabicNumber
        {
            return false
        }
        var textstr = ""
        if let text1 = textView.text as NSString? {
            let txtAfterUpdate = text1.replacingCharacters(in: range, with: text)
            textstr = txtAfterUpdate
        }
        if textView.tag == 10
        {
            
            if textstr.count > pro.descriptionsVal
            {
                return false
            }
            pro.descriptions = textstr
            if ((tabvw.indexPathsForVisibleRows?.contains(IndexPath(row: filterCount + 8, section: 1)))!)
            {
                let cell = tabvw.cellForRow(at: IndexPath(row: filterCount + 8, section: 1)) as! BusinessTableViewCell
                
                if pro.descriptions.count > 0
                {
                    if docId.count > 0
                    {
                        cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                    }
                    else
                    {
                        if !pro.descriptions.containArabicNumber
                        {
                            cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                            
                        }
                        else
                        {
                            cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                            
                        }
                    }
                }
                    
                else
                {
                    if docId.count > 0
                    {
                        cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                    }
                    else
                    {
                        cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                    }
                }
            }
            tabvw.reloadRows(at: [IndexPath(row: filterCount + 9, section: 1)], with: .none)
            tabvw.reloadRows(at: [IndexPath(row: filterCount + 11, section: 1)], with: .none)
            
            self.checkspecColor()
        }
        else
        {
            if textstr.count > pro.supportdescriptionsVal
            {
                return false
            }
            pro.supportdescriptions = textstr
            
            tabvw.reloadRows(at: [IndexPath(row: filterCount + 13, section: 1)], with: .none)
        }
        
        return true
    }
    func cataList(dict: NSDictionary) {
        cataDict = dict
        if cataDict.count > 0
        {
            self.filterArr.removeAllObjects()
            self.pro.filterIdName.removeAllObjects()
            self.filterArrVal.removeAllObjects()
            self.filterArrVal1.removeAllObjects()
            self.filteridArr.removeAllObjects()
            self.SelectedIndex.removeAllObjects()
            self.filterArrVallock.removeAllObjects()
            pro.cataId = "\(cataDict.value(forKey: "cat_id") as! String)"
            pro.subcataId = "\(cataDict.value(forKey: "sub_cat_id") as! String)"
            pro.cataImage = cataDict.value(forKey: "cat_image") as! String
            pro.subcataImage = cataDict.value(forKey: "sub_cat_image") as! String
            pro.cataIdname = cataDict.value(forKey: "cat_name") as! String
            pro.subcataIdName = cataDict.value(forKey: "sub_cat_name") as! String
            filterList_API(val: pro.subcataId)
            self.checkspecColor()
        }
        tabvw.reloadData()
    }
    
    func contentborder(vw:UIView)
    {
        vw.addBorder(.left, color: UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1), thickness: 0.5)
        vw.addBorder(.right, color: UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1), thickness: 0.5)
    }
    func editSlab(tag: Int) {
        print("edit")
    }
    
    func deleteSlab(tag: Int) {
        print("delete")
    }
    
    func retail(tag: Int) {
        
        isSelected = "retail"
        tabvw.reloadData()
        
        
    }
    
    func whole(tag: Int) {
        isSelected = "wholesale"
        tabvw.reloadData()
        
    }
    
    @objc func clickaddfilter()
    {
        if pro.subcataId == ""
        {
            return
        }
        let vc = AddFilterViewController(nibName: "AddFilterViewController", bundle: nil)
        vc.delegate = self
        vc.filterValue = Int(pro.subcataId) ?? 0
        let popup = PopupDialog(viewController: vc,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        self.present(popup, animated: true, completion: nil)
        
    }
    @objc func clickfilterDetail()
    {
        isFilter = !isFilter
        tabvw.reloadData()
        
        
    }
    
    @objc private func retailDidChange(_ textField: UITextField)
    {
        if clicktab == 2
        {
            
            let touchPoint = textField.convert(CGPoint.zero, to: tabvw)
            let clickedBtn = tabvw.indexPathForRow(at: touchPoint)
            let row = Int(clickedBtn!.row)
            if textField.tag == 0
            {
                instoreRetailArr[row - 2] = textField.text!
                if row - 2 == 0
                {
                    
                    instoreRetailArr[1] = "\(((instoreRetailArr[0] as NSString).doubleValue/100) * (instoreRetailArr[2] as NSString).doubleValue)"
                    instoreRetailArr[3] = "\((instoreRetailArr[0] as NSString).doubleValue - (instoreRetailArr[1] as NSString).doubleValue)"
                    instoreRetailArr[5] = "\(((instoreRetailArr[3] as NSString).doubleValue/100) * (instoreRetailArr[4] as NSString).doubleValue)"
                    tabvw.reloadRows(at: [IndexPath(row: 3, section: 1)], with: .none)
                    tabvw.reloadRows(at: [IndexPath(row: 7, section: 1)], with: .none)
                    
                }
                else if row - 2 == 1
                {
                    
                    let per = ((instoreRetailArr[1] as NSString).doubleValue/(instoreRetailArr[0] as NSString).doubleValue) * 100
                    instoreRetailArr[2] = String(format: "%.2f", per)
                    if (instoreRetailArr[2] as NSString).doubleValue > 100
                    {
                        instoreRetailArr[1] = "0.0"
                        instoreRetailArr[2] = "0.0"
                        tabvw.reloadRows(at: [IndexPath(row: 3, section: 1)], with: .none)
                    }
                    instoreRetailArr[3] = "\((instoreRetailArr[0] as NSString).doubleValue - (instoreRetailArr[1] as NSString).doubleValue)"
                    instoreRetailArr[5] = "\(((instoreRetailArr[3] as NSString).doubleValue/100) * (instoreRetailArr[4] as NSString).doubleValue)"
                    tabvw.reloadRows(at: [IndexPath(row: 7, section: 1)], with: .none)
                    tabvw.reloadRows(at: [IndexPath(row: 4, section: 1)], with: .none)
                }
                else if row - 2 == 2
                {
                    instoreRetailArr[1] = "\(((instoreRetailArr[0] as NSString).doubleValue/100) * (instoreRetailArr[2] as NSString).doubleValue)"
                    if (instoreRetailArr[1] as NSString).doubleValue > (instoreRetailArr[0] as NSString).doubleValue
                    {
                        instoreRetailArr[1] = "0.0"
                        instoreRetailArr[2] = "0.0"
                        tabvw.reloadRows(at: [IndexPath(row: 4, section: 1)], with: .none)
                    }
                    instoreRetailArr[3] = "\((instoreRetailArr[0] as NSString).doubleValue - (instoreRetailArr[1] as NSString).doubleValue)"
                    instoreRetailArr[5] = "\(((instoreRetailArr[3] as NSString).doubleValue/100) * (instoreRetailArr[4] as NSString).doubleValue)"
                    tabvw.reloadRows(at: [IndexPath(row: 7, section: 1)], with: .none)
                    tabvw.reloadRows(at: [IndexPath(row: 3, section: 1)], with: .none)
                }
                else if row - 2 == 4
                {
                    
                    instoreRetailArr[5] = "\(((instoreRetailArr[3] as NSString).doubleValue/100) * (instoreRetailArr[4] as NSString).doubleValue)"
                    if (instoreRetailArr[5] as NSString).doubleValue > (instoreRetailArr[3] as NSString).doubleValue
                    {
                        instoreRetailArr[4] = "0.0"
                        instoreRetailArr[5] = "0.0"
                        tabvw.reloadRows(at: [IndexPath(row: 6, section: 1)], with: .none)
                        
                    }
                    tabvw.reloadRows(at: [IndexPath(row: 7, section: 1)], with: .none)
                    
                }
                else if row - 2 == 5
                {
                    let vatper  = ((instoreRetailArr[5] as NSString).doubleValue/(instoreRetailArr[3] as NSString).doubleValue) * 100
                    
                    instoreRetailArr[4] = String(format: "%.2f", vatper)
                    if (instoreRetailArr[4] as NSString).doubleValue > 100
                    {
                        instoreRetailArr[4] = "0.0"
                        instoreRetailArr[5] = "0.0"
                        tabvw.reloadRows(at: [IndexPath(row: 7, section: 1)], with: .none)
                        
                    }
                    tabvw.reloadRows(at: [IndexPath(row: 6, section: 1)], with: .none)
                    
                }
                
                instoreRetailArr[3] = "\((instoreRetailArr[0] as NSString).doubleValue - (instoreRetailArr[1] as NSString).doubleValue)"
                 instoreRetailArr[6] = "\((instoreRetailArr[0] as NSString).doubleValue - (instoreRetailArr[1] as NSString).doubleValue + (instoreRetailArr[5] as NSString).doubleValue)"
                tabvw.reloadRows(at: [IndexPath(row: 5, section: 1)], with: .none)
                tabvw.reloadRows(at: [IndexPath(row: 8, section: 1)], with: .none)
                
            }
                
            else
            {
                instoreWholeSaleArr[row - 2] = textField.text!
                if row - 2 == 0
                {
                    
                    instoreWholeSaleArr[1] = "\(((instoreWholeSaleArr[0] as NSString).doubleValue/100) * (instoreWholeSaleArr[2] as NSString).doubleValue)"
                    instoreWholeSaleArr[3] = "\((instoreWholeSaleArr[0] as NSString).doubleValue - (instoreWholeSaleArr[1] as NSString).doubleValue)"
                    instoreWholeSaleArr[5] = "\(((instoreWholeSaleArr[3] as NSString).doubleValue/100) * (instoreWholeSaleArr[4] as NSString).doubleValue)"
                    tabvw.reloadRows(at: [IndexPath(row: 3, section: 1)], with: .none)
                    tabvw.reloadRows(at: [IndexPath(row: 7, section: 1)], with: .none)
                    
                }
                else if row - 2 == 1
                {
                    
                    let wholeper = ((instoreWholeSaleArr[1] as NSString).doubleValue/(instoreWholeSaleArr[0] as NSString).doubleValue) * 100
                    
                    instoreWholeSaleArr[2]  = String(format: "%.2f", wholeper)
                    if (instoreWholeSaleArr[2] as NSString).doubleValue > 100
                    {
                        instoreWholeSaleArr[2] = "0.0"
                        instoreWholeSaleArr[1] = "0.0"
                        tabvw.reloadRows(at: [IndexPath(row: 3, section: 1)], with: .none)
                    }
                    instoreWholeSaleArr[3] = "\((instoreWholeSaleArr[0] as NSString).doubleValue - (instoreWholeSaleArr[1] as NSString).doubleValue)"
                    instoreWholeSaleArr[5] = "\(((instoreWholeSaleArr[3] as NSString).doubleValue/100) * (instoreWholeSaleArr[4] as NSString).doubleValue)"
                    tabvw.reloadRows(at: [IndexPath(row: 7, section: 1)], with: .none)
                    tabvw.reloadRows(at: [IndexPath(row: 4, section: 1)], with: .none)
                }
                else if row - 2 == 2
                {
                    
                    instoreWholeSaleArr[1] = "\(((instoreWholeSaleArr[0] as NSString).doubleValue/100) * (instoreWholeSaleArr[2] as NSString).doubleValue)"
                    if (instoreRetailArr[1] as NSString).doubleValue > (instoreRetailArr[0] as NSString).doubleValue
                    {
                        instoreWholeSaleArr[1] = "0.0"
                        instoreWholeSaleArr[2] = "0.0"
                        tabvw.reloadRows(at: [IndexPath(row: 4, section: 1)], with: .none)
                    }
                    instoreWholeSaleArr[3] = "\((instoreWholeSaleArr[0] as NSString).doubleValue - (instoreWholeSaleArr[1] as NSString).doubleValue)"
                    instoreWholeSaleArr[5] = "\(((instoreWholeSaleArr[3] as NSString).doubleValue/100) * (instoreWholeSaleArr[4] as NSString).doubleValue)"
                    tabvw.reloadRows(at: [IndexPath(row: 7, section: 1)], with: .none)
                    tabvw.reloadRows(at: [IndexPath(row: 3, section: 1)], with: .none)
                }
                else if row - 2 == 4
                {
                    
                    instoreWholeSaleArr[5] = "\(((instoreWholeSaleArr[3] as NSString).doubleValue/100) * (instoreWholeSaleArr[4] as NSString).doubleValue)"
                    if (instoreWholeSaleArr[5] as NSString).doubleValue > (instoreWholeSaleArr[3] as NSString).doubleValue
                    {
                        instoreWholeSaleArr[4] = "0.0"
                        instoreWholeSaleArr[5] = "0.0"
                        tabvw.reloadRows(at: [IndexPath(row: 6, section: 1)], with: .none)
                        
                    }
                    tabvw.reloadRows(at: [IndexPath(row: 7, section: 1)], with: .none)
                }
                else if row - 2 == 5
                {
                    
                    let wholevatper = ((instoreWholeSaleArr[5] as NSString).doubleValue/(instoreWholeSaleArr[3] as NSString).doubleValue) * 100
                    instoreWholeSaleArr[4]  = String(format: "%.2f", wholevatper)
                    if (instoreWholeSaleArr[4] as NSString).doubleValue > 100
                    {
                        instoreWholeSaleArr[4] = "0.0"
                        instoreWholeSaleArr[5] = "0.0"
                        tabvw.reloadRows(at: [IndexPath(row: 7, section: 1)], with: .none)
                        
                    }
                    tabvw.reloadRows(at: [IndexPath(row: 6, section: 1)], with: .none)
                }
                
                instoreWholeSaleArr[3] = "\((instoreWholeSaleArr[0] as NSString).doubleValue - (instoreWholeSaleArr[1] as NSString).doubleValue)"
               instoreWholeSaleArr[6] = "\((instoreWholeSaleArr[0] as NSString).doubleValue - (instoreWholeSaleArr[1] as NSString).doubleValue + (instoreWholeSaleArr[5] as NSString).doubleValue)"
                 
                tabvw.reloadRows(at: [IndexPath(row: 5, section: 1)], with: .none)
                tabvw.reloadRows(at: [IndexPath(row: 8, section: 1)], with: .none)
                
            }
          self.checkinstoreColor()
        }
       
    }
    
    @objc private func textFieldDidChangeOnline(_ textField: UITextField)
    {
        if clicktab == 1
        {
            productPolicyArr[textField.tag - 3] = textField.text!
            
            pro.OnlineReturnDays = productPolicyArr[0]
            pro.OnlineReturnDays1 = productPolicyArr[1]
            pro.stockQuan = productPolicyArr[2]
            pro.deliveryDays = productPolicyArr[3]
            if textField.tag == 5 || textField.tag == 6
            {
                
                if productPolicyArr[textField.tag - 3].count > 0
                {
                    
                    let cell = tabvw.cellForRow(at: IndexPath(row: textField.tag, section: 1)) as! ProductSecondTableViewCell
                    if !productPolicyArr[textField.tag - 3].containArabicNumber
                    {
                        cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                        
                    }
                    else
                    {
                        if textField.tag == 6
                        {
                            if (textField.text! as NSString).integerValue > 365
                            {
                                cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                            }
                            else
                            {
                                cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                            }
                        }
                        else
                        {
                            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                        }
                    }
                    
                    
                    
                }
                else
                {
                    let cell = tabvw.cellForRow(at: IndexPath(row: textField.tag, section: 1)) as! ProductSecondTableViewCell
                    cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                }
            }
            if textField.tag == 3 || textField.tag == 4
            {
                
                if productPolicyArr[textField.tag - 3].count > 0
                {
                    
                    let cell = tabvw.cellForRow(at: IndexPath(row: textField.tag, section: 1)) as! ProductSecondTableViewCell
                    if !productPolicyArr[textField.tag - 3].containArabicNumber
                    {
                        cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                        
                    }
                    else
                    {
                        
                        if (textField.text! as NSString).integerValue > 365
                        {
                            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                        }
                            
                            
                        else
                        {
                            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                        }
                    }
                    
                    
                    
                }
                else
                {
                    let cell = tabvw.cellForRow(at: IndexPath(row: textField.tag, section: 1)) as! ProductSecondTableViewCell
                    cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                }
            }
            self.checkonlineColor()
        }
        
        
    }
    
    @objc private func clickSendApproval(_ textField: UITextField)
    {
//        productmodel.approvallistupdate { (success, response) in
//            if success
//            {
//                self.navigationController?.backToViewController(viewController: ProductDataBankController.self)
//            }
//        }
    }
    @objc private func textFieldDidChange(_ textField: UITextField)
    {
        if clicktab == 0
        {
            dimensionArrVal[textField.tag] = textField.text!
            let v1 = (dimensionArrVal[2] as NSString).doubleValue
            let v2 = (dimensionArrVal[3] as NSString).doubleValue
            let v3 = (dimensionArrVal[4] as NSString).doubleValue
            dimensionArrVal[0] = String(format: "%.2f", (v1 * v2 * v3))
            pro.dimension = (dimensionArrVal[0] as NSString).doubleValue
            pro.length = (dimensionArrVal[2] as NSString).doubleValue
            pro.height = (dimensionArrVal[3] as NSString).doubleValue
            pro.width = (dimensionArrVal[4] as NSString).doubleValue
            pro.weight = (dimensionArrVal[1] as NSString).doubleValue
            
            if ((tabvw.indexPathsForVisibleRows?.contains(IndexPath(row: filterCount + 3, section: 1)))!) {
                let cell = tabvw.cellForRow(at: IndexPath(row: filterCount + 3, section: 1)) as! ProductDimentionTableViewCell
                cell.rgtlbl.text = "\(dimensionArrVal[0]) cm³"
                
            }
            
            self.checkspecColor()
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if clicktab == 0
        {
            return 2
        }
        if clicktab == 1
        {
            return 3
        }
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tabvw.headerView(forSection: 1)?.reloadInputViews()
        
        if clicktab == 0
        {
            if section == 0
            {
                return 2
            }
            else
            {
                if filterlist?.data?.filter_list?.count ?? 0 == 0
                {
                    filterCount = (filterlist?.data?.filter_list?.count ?? 0)
                    return 15
                }
                if filterlist?.data?.filter_list?.count ?? 0 > 0
                {
                    if isFilter
                    {
                        filterCount = (filterlist?.data?.filter_list?.count ?? 0)
                    }
                    else
                    {
                        if filterlist?.data?.filter_list?.count ?? 0 >= 2
                        {
                            filterCount = 2
                        }
                        else
                        {
                            filterCount = (filterlist?.data?.filter_list?.count ?? 0)
                        }
                        
                    }
                    
                }
                
                return 15 + filterCount
            }
            
            
        }
        else if clicktab == 2
        {
            if section == 0
            {
                return 2
            }
            else if section == 1
            {
                return 12
            }
            else if section == 3
            {
                return 1
            }
            else
            {
                return self.storepayment?.data?.store_payment_option?.count ?? 0
            }
        }
        else{
            
            if section == 0
            {
                return 2
            }
            else if section == 1
            {
                if isSelected == "retail"
                {
                    return 16
                }
                return 10 + pro.OnlineQuantityto.count
                
            }
                
            else
            {
                return 1
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1
        {
            let headerview = UIView()
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "ProductHeaderTableViewCell") as! ProductHeaderTableViewCell
            
            headerview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35)
            headerCell.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35)
            headerCell.online.setTitle("Specification".localized, for: .normal)
            headerCell.instore.setTitle("Online".localized, for: .normal)
            headerCell.specification.setTitle("In Store".localized, for: .normal)
            if clicktab == 0
            {
                headerCell.online.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
                headerCell.instore.setTitleColor(UIColor.init(red: 28/255, green: 157/255, blue: 213/255, alpha: 1), for: .normal)
                headerCell.specification.setTitleColor(UIColor.init(red: 28/255, green: 157/255, blue: 213/255, alpha: 1), for: .normal)
                headerCell.leadingConst.constant = 0
            }
            else if clicktab == 1{
                headerCell.online.setTitleColor(UIColor.init(red: 28/255, green: 157/255, blue: 213/255, alpha: 1), for: .normal)
                headerCell.instore.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
                headerCell.specification.setTitleColor(UIColor.init(red: 28/255, green: 157/255, blue: 213/255, alpha: 1), for: .normal)
                headerCell.leadingConst.constant = self.view.frame.width/3
            }
            else{
                headerCell.online.setTitleColor(UIColor.init(red: 28/255, green: 157/255, blue: 213/255, alpha: 1), for: .normal)
                headerCell.instore.setTitleColor(UIColor.init(red: 28/255, green: 157/255, blue: 213/255, alpha: 1), for: .normal)
                headerCell.specification.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
                headerCell.leadingConst.constant = 2*(self.view.frame.width)/3
            }
            
            headerCell.online.tag = 0
            headerCell.instore.tag = 1
            headerCell.specification.tag = 2
            if isDataBank
            {
                headerCell.instore.isHidden = true
                headerCell.specification.isHidden = true
                headerCell.btmlbl.isHidden = true
                headerCell.online.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
            }
            headerCell.specification.addTarget(self, action: #selector(clickTab(_:)), for: .touchUpInside)
            headerCell.online.addTarget(self, action: #selector(clickTab(_:)), for: .touchUpInside)
            headerCell.instore.addTarget(self, action: #selector(clickTab(_:)), for: .touchUpInside)
            headerview.addSubview(headerCell)
            return headerview
        }
        
        
        return nil
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                let cell = tabvw.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as! HeaderBranchTableViewCell
                cell.btn.setImage(UIImage(named: "producticon"), for: .normal)
                cell.innerView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
                 cell.lbl.font = UIFont(name:"\(fontNameLight)",size:16)
               
                cell.btnLeading.constant = 23
                cell.leadingConstant.constant = 0
                cell.trailingConstant.constant = 0
                cell.lbl.text = "Manage Products".localized
                cell.rightarrow.isHidden = true
                cell.selectionStyle = .none
                return cell
            }
            else
            {
                let cell = tabvw.dequeueReusableCell(withIdentifier: "ProductTopTableViewCell", for: indexPath) as! ProductTopTableViewCell
                cell.moredetails.isHidden = true
                if pro.productDecription.count > 80
                {
                     cell.moredetails.isHidden = false
                }
             cell.moredetails.addTarget(self, action: #selector(cilckedmore), for: .touchUpInside)

                cell.pro_img.sd_setImage(with: URL(string: pro.galleryFeatureImage), placeholderImage: UIImage(named: "category_placeholder"))
                cell.pro_name.text = pro.productTitle
                
                if pro.statusActive == 1
                {
                    let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: "\( "Status:  ".localized)\("ACTIVE".localized)")
                    attributedString.setColor(color: UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), forText: "ACTIVE".localized)
                    cell.status.attributedText = attributedString
                }
                if pro.statusActive == 0 && ProductModel.shared.pro_final_status == 1
                {
                    let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: "\( "Status:  ".localized)\("INACTIVE".localized)")
                    attributedString.setColor(color: UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1), forText: "INACTIVE".localized)
                    cell.status.attributedText = attributedString
                }
                if pro.statusActive == 0 && ProductModel.shared.pro_final_status == 0
                {
                    let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: "\( "Status:  ".localized)\("DRAFT".localized)")
                    attributedString.setColor(color: UIColor.init(red: 246/255, green: 181/255, blue: 25/255, alpha: 1), forText: "DRAFT".localized)
                    cell.status.attributedText = attributedString
                }
                if isVarient
                {
                    let attributedString1 : NSMutableAttributedString = NSMutableAttributedString(string: "Status:  Varient")
                    attributedString1.setColor(color: UIColor.init(red: 38/255, green: 38/255, blue: 38/255, alpha: 1), forText: "Varient")
                    cell.status.attributedText = attributedString1
                }
                if isSimilar
                {
                    let attributedString2 : NSMutableAttributedString = NSMutableAttributedString(string: "Status:  Similar")
                    attributedString2.setColor(color: UIColor.init(red: 38/255, green: 38/255, blue: 38/255, alpha: 1), forText: "Similar")
                    cell.status.attributedText = attributedString2
                }
                
                cell.barcode.text = pro.productcode
                cell.currencylbl.text = pro.Currencyname.localized
                cell.nobranchlbl.text = "\("No of Branches".localized) : \(pro.branchIdnew.count)"
                cell.descrip.text = pro.productDecription
                cell.viewbranch.addTarget(self, action: #selector(clikViewBranch), for: .touchUpInside)
                cell.selectionStyle = .none
                return cell
            }
        }
        if clicktab == 0
        {
            switch indexPath.row {
            case 0:
                
                let cell = tabvw.dequeueReusableCell(withIdentifier: "ProductSpecCatagoryTableViewCell", for: indexPath) as! ProductSpecCatagoryTableViewCell
                
                cell.isUserInteractionEnabled = true
                cell.cataimg.sd_setImage(with: URL(string: pro.cataImage), placeholderImage: UIImage(named: "category_placeholder"))
                cell.subcataimg.sd_setImage(with: URL(string: pro.subcataImage), placeholderImage: UIImage(named: "category_placeholder"))
                cell.cataname.text = pro.cataIdname
                cell.subcataname.text = pro.subcataIdName
                cell.selectionStyle = .none
                
                if pro.cataIdname.count > 0 && pro.subcataIdName.count > 0
                {
                    cell.leftvw.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                    cell.rgtvw.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                }
                else
                {
                    cell.leftvw.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                    cell.rgtvw.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                }
                return cell
            case 1...(1+filterCount):
                let cell = tabvw.dequeueReusableCell(withIdentifier: "SpecificationTableViewCell", for: indexPath) as! SpecificationTableViewCell
                cell.trailconst.constant = 100
                cell.dottedline.isHidden = false
                cell.clickCheck.isHidden = false
                cell.varientlbl.isHidden = false
                cell.varientlbl.text = "Varient".localized
                cell.outervw.addBorder(.bottom, color: .lightGray, thickness: 0.5)
                cell.outervw.backgroundColor = UIColor.clear
                cell.lftvw.backgroundColor = UIColor.clear
                
                if indexPath.row == 1
                {
                    cell.outervw.backgroundColor = UIColor.init(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
                    cell.lftvw.layer.borderWidth = 0
                    cell.lftLbl.text = "Specification".localized
                    cell.downarrow.isHidden = true
                    cell.dropdownLbl.isHidden = true
                    cell.lockimg.isHidden = true
                    cell.clickCheck.isHidden = true
                    cell.varientlbl.isHidden = false
                }
                    
                else
                {
                    cell.clickCheck.isUserInteractionEnabled = true
                    if SelectedIndex.contains(indexPath.row - 2)
                    {
                        cell.clickCheck.isSelected = true
                    }
                    else
                    {
                        cell.clickCheck.isSelected = false
                    }
                    if pro.filterIdName.count > 0
                    {
                        cell.lftLbl.text = pro.filterIdName[indexPath.row - 2] as? String
                    }
                    if filterArrVal.count > 0
                    {
                        cell.dropdownLbl.text = filterArrVal[indexPath.row - 2] as? String
                        if filterArrVal[indexPath.row - 2] as? String == ""
                        {
                            cell.clickCheck.isUserInteractionEnabled = false
                        }
                    }
                    
                    
                    if isVarient
                    {
                        cell.clickCheck.isUserInteractionEnabled = false
                    }
                    
                    if self.filterlist?.data?.filter_list?.count ?? 0 > 0
                    {
                        if (self.filterlist?.data?.filter_list?[indexPath.row - 2].filter_status)! == 2
                        {
                            cell.lftvw.backgroundColor = UIColor.white
                            cell.downarrow.isHidden = false
                            cell.dropdownLbl.isHidden = false
                            cell.lockimg.isHidden = false
                            cell.lftvw.layer.borderWidth = 0.5
                            cell.varientlbl.isHidden = true
                            cell.clickCheck.isHidden = true
                            cell.outervw.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
                        }
                        else
                        {
                            
                            cell.lftvw.backgroundColor = UIColor.clear
                            cell.downarrow.isHidden = false
                            cell.dropdownLbl.isHidden = false
                            cell.lockimg.isHidden = true
                            cell.lftvw.layer.borderWidth = 0
                            cell.clickCheck.isHidden = false
                            cell.varientlbl.isHidden = true
                            cell.outervw.backgroundColor = UIColor.white
                        }
                    }
                    
                }
                if isDataBank
                {
                    cell.trailconst.constant = 0
                    cell.dottedline.isHidden = true
                    cell.clickCheck.isHidden = true
                    cell.varientlbl.isHidden = true
                }
                cell.clickCheck.tag = indexPath.row
                cell.downarrow.tag = indexPath.row
                cell.downarrow.addTarget(self, action: #selector(openFilterPopup(_:)), for: .touchUpInside)
                cell.clickCheck.addTarget(self, action: #selector(clickVarientSelect(_:)), for: .touchUpInside)
                cell.selectionStyle = .none
                
                return cell
            case filterCount + 2:
                
                let cell = tabvw.dequeueReusableCell(withIdentifier: "AddFeatureTableViewCell", for: indexPath) as! AddFeatureTableViewCell
                cell.vw.isHidden = false
                cell.addfeturelbl.text = "Add Feature".localized
                cell.whatlbl.text = "What is this?".localized
                if isDataBank
                {
                    cell.vw.isHidden = true
                }
                if isFilter
                {
                    cell.downarrow.image = UIImage(named: "upArror_blue")
                    cell.moredetail.setTitle("Hide Details", for: .normal)
                }
                else{
                    cell.downarrow.image = UIImage(named: "DownArror_blue")
                    cell.moredetail.setTitle("More Details", for: .normal)
                }
                cell.moredetail.addTarget(self, action: #selector(clickfilterDetail), for: .touchUpInside)
                cell.addfilter.addTarget(self, action: #selector(clickaddfilter), for: .touchUpInside)
                cell.selectionStyle = .none
                return cell
            case (filterCount + 3)...(filterCount + 7):
                
                let cell = tabvw.dequeueReusableCell(withIdentifier: "ProductDimentionTableViewCell", for: indexPath) as! ProductDimentionTableViewCell
                
                // cell.txtLeading.constant = -10
                cell.lbl.isHidden = false
                cell.rgtlbl.isHidden = true
                cell.txt.isHidden = false
                cell.txt.delegate = self
                cell.vw.backgroundColor = .clear
                cell.txt.textAlignment = .left
                cell.txt.tag = indexPath.row - (filterCount + 3)
                cell.rgtlbl.text = "\(dimensionArrVal[0]) cm³"
                cell.txt.keyboardType = UIKeyboardType.decimalPad
                cell.txt.text = dimensionArrVal[indexPath.row - (filterCount + 3)]
                cell.txt.addTarget(self, action: #selector(CreateProductSecondViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                
                cell.lftlbl.attributedText = ModalController.setStricColor(str: "\(dimensionArr[indexPath.row - (filterCount + 3)]) *", str1: "\(dimensionArr[indexPath.row - (filterCount + 3)])", str2: "*")
                cell.lbl.text = dimensionArr1[indexPath.row - (filterCount + 3)]
                cell.selectionStyle = .none
                if indexPath.row == (filterCount + 3)
                {
                    cell.lftlbl.text = dimensionArr[indexPath.row - (filterCount + 3)]
                    cell.vw.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
                    cell.lbl.isHidden = true
                    cell.rgtlbl.isHidden = false
                    cell.txt.isHidden = true
                }
                if isDataBank
                {
                    cell.lbl.isHidden = true
                    cell.rgtlbl.isHidden = true
                    cell.txt.isHidden = true
                    cell.lftlbl.isHidden = true
                }
                return cell
                
            case filterCount + 8:
                let cell = tabvw.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as! BusinessTableViewCell
                cell.bordertxt.setAllSideShadowForFields(shadowShowSize: 0.0, sizeFloat: 0)
                cell.lblk.text = "    \("Technical Description".localized)"
                cell.widthconst.constant = 0
                cell.ocrtrailing.constant = 10
                if pro.descriptions.count > 0
                {
                    if !pro.descriptions.containArabicNumber
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
                    
                    cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                }
                if docId.count > 0
                {
                    cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                }
                cell.txtView.delegate = self
                cell.nameTextField.isHidden = true
                cell.leadingConst.constant = 10
                cell.trailingConst.constant = 10
                cell.downarrow.isHidden = true
                cell.txtView.tag = 10
                cell.txtView.text = pro.descriptions
                cell.selectionStyle = .none
                return cell
            case filterCount + 9:
                let cell = tabvw.dequeueReusableCell(withIdentifier: "CountingTableViewCell", for: indexPath) as! CountingTableViewCell
                
                cell.leadingConstvw.constant = 10
                cell.trailingConstvw.constant = 10
                cell.counlbl.text = "\(pro.descriptions.count)/\(pro.descriptionsVal)"
                cell.vw.layer.borderWidth = 0
                cell.selectionStyle = .none
                cell.counlbl.textColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1)
                
                if pro.descriptions.count == pro.descriptionsVal
                {
                    cell.counlbl.textColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
                    
                }
                return cell
                
            case filterCount + 10:
                let cell = tabvw.dequeueReusableCell(withIdentifier: "ORTableViewCell", for: indexPath) as! ORTableViewCell
                cell.count.textColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1)
                cell.techlbl.text = "Technical Description Attachment".localized
                if docId.count == pro.productDocVal
                {
                    cell.count.textColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
                }
                
                cell.count.text = "0\(docId.count)/02"
                cell.selectionStyle = .none
                return cell
            case filterCount + 11:
                let cell = tabvw.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell", for: indexPath) as! CollectionViewTableViewCell
                cell.collectionVIEW.reloadData()
                cell.delegate = self
                cell.isAttach = true
                cell.isAttachImg = docImage
                cell.isdescription = pro.descriptions
                cell.collectionVIEW.isScrollEnabled = true
                if let flowLayout =  cell.collectionVIEW.collectionViewLayout as? UICollectionViewFlowLayout {
                    flowLayout.scrollDirection = .horizontal
                }
                cell.selectionStyle = .none
                cell.collectionVIEW.layer.borderWidth = 0
                cell.collectionVIEW.reloadData()
                return cell
                
                
            case filterCount + 12:
                
                let cell = tabvw.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as! BusinessTableViewCell
                cell.bordertxt.setAllSideShadowForFields(shadowShowSize: 0.0, sizeFloat: 0)
                cell.ocrtrailing.constant = 10
                 cell.widthconst.constant = 0
                cell.nameTextField.isHidden = true
                cell.leadingConst.constant = 10
                cell.trailingConst.constant = 10
                cell.txtView.tag = 100
                cell.txtView.delegate = self
                cell.downarrow.isHidden = true
                cell.lblk.text = "    \("Warranty and Support Section".localized)"
                cell.txtView.text = pro.supportdescriptions
                if isDataBank{
                    cell.lblk.text = ""
                }
                cell.selectionStyle = .none
                return cell
            case filterCount + 13:
                let cell = tabvw.dequeueReusableCell(withIdentifier: "CountingTableViewCell", for: indexPath) as! CountingTableViewCell
                
                cell.selectionStyle = .none
                cell.leadingConstvw.constant = 10
                cell.trailingConstvw.constant = 10
                cell.counlbl.text = "\(pro.supportdescriptions.count)/\(pro.supportdescriptionsVal)"
                cell.vw.layer.borderWidth = 0 ;
                cell.counlbl.textColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1)
                if pro.supportdescriptions.count == pro.supportdescriptionsVal
                {
                    cell.counlbl.textColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
                }
                if isDataBank{
                    cell.counlbl.text = ""
                }
                return cell
            default:
                
                if isDataBank
                {
                    let cell = tabvw.dequeueReusableCell(withIdentifier: "SendForAPProvalTableViewCell", for: indexPath) as! SendForAPProvalTableViewCell
                    cell.approvalbtn.addTarget(self, action: #selector(clickSendApproval), for: .touchUpInside)
                    return cell
                }
                else
                {
                    let cell = tabvw.dequeueReusableCell(withIdentifier: "nextTableViewCell", for: indexPath) as! nextTableViewCell
                    cell.savedraft.isHidden = false
                    
                    if ProductModel.shared.pro_final_status == 1
                    {
                        cell.savedraft.isHidden = true
                    }
                    if Selectedtab.contains(0)
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
                    cell.savedraft.tag = 0
                    cell.nextbtn.setTitle("Next".localized, for: .normal)
                    cell.savedraft.addTarget(self, action: #selector(saveClick(_ :)), for: .touchUpInside)
                    cell.nextbtn.tag = 1
                    cell.nextbtn.addTarget(self, action: #selector(saveClick(_ :)), for: .touchUpInside)
                    cell.selectionStyle = .none
                    return cell
                }
                
            }
            
            
            
            
        }
        else if clicktab == 1
        {
            // self.checkonlineColor()
            
            
            
            if indexPath.section == 1
            {
                switch indexPath.row {
                case 0:
                    let cell = tabvw.dequeueReusableCell(withIdentifier: "spacingTableViewCell", for: indexPath) as! spacingTableViewCell
                    cell.contentView.backgroundColor = .white
                    cell.selectionStyle = .none
                    return cell
                case 1,2:
                    
                    let cell = tabvw.dequeueReusableCell(withIdentifier: "SelectProductTypeNewTableViewCell", for: indexPath) as! SelectProductTypeNewTableViewCell
                    //                    cell.rightBtnLeading.constant = 90
                    cell.lbl.isHidden = false
                    cell.leftlbl.isHidden = false
                    cell.leftbtn.isHidden = false
                    cell.leftLblLeading.constant =  self.view.frame.width/12
                    cell.outervw.backgroundColor = UIColor.init(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
                    cell.outervw.layer.borderWidth = 0.3
                    cell.topConst.constant = 2.5
                    cell.bottomConst.constant = 2.5
                    cell.leadingConst.constant = -1
                    cell.trailingConst.constant = -1
                    cell.lbl.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
                    cell.leftlbl.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
                    cell.rgtlbl.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
                    
                    cell.lbl.text = selectArr[indexPath.row - 1][0]
                    cell.leftlbl.text = selectArr[indexPath.row - 1][1]
                    cell.rgtlbl.text = selectArr[indexPath.row - 1][2]
                    
                    
                    
                    if indexPath.row == 1
                    {
                        cell.leftbtn.isUserInteractionEnabled = true
                        cell.btnleading.constant = 58
                        cell.rightBtnLeading.constant = 61
                        if HeaderHeightSingleton.shared.LanguageSelected == "AR"
                        {
                            cell.btnleading.constant = 25
                            cell.rightBtnLeading.constant = 50
                        }
                        cell.leftbtn.tag = 0
                        cell.rgtbtn.tag = 1
                        if OnlineSelectedIndex.contains(0) || OnlineSelectedIndex.contains(1)
                        {
                            if OnlineSelectedIndex.contains(0)
                            {
                                cell.leftbtn.setImage(UIImage(named: "check"), for: .normal)
                            }
                            else
                            {
                                cell.leftbtn.setImage(UIImage(named: "uncheck"), for: .normal)
                            }
                            if OnlineSelectedIndex.contains(1)
                            {
                                cell.rgtbtn.setImage(UIImage(named: "check"), for: .normal)
                            }
                            else
                            {
                                cell.rgtbtn.setImage(UIImage(named: "uncheck"), for: .normal)
                            }
                        }
                        else
                        {
                            cell.leftbtn.setImage(UIImage(named: "check_red_new"), for: .normal)
                            cell.rgtbtn.setImage(UIImage(named: "check_red_new"), for: .normal)
                        }
                    }
                    else
                    {
                        cell.leftbtn.isUserInteractionEnabled = false
                        cell.rightBtnLeading.constant = 58
                        cell.btnleading.constant = 12
                        cell.leftbtn.tag = 2
                        cell.rgtbtn.tag = 3
                        if OnlineSelectedIndex.contains(2) || OnlineSelectedIndex.contains(3)
                        {
                            if OnlineSelectedIndex.contains(2)
                            {
                                cell.leftbtn.setImage(UIImage(named: "check"), for: .normal)
                            }
                            else
                            {
                                cell.leftbtn.setImage(UIImage(named: "uncheck"), for: .normal)
                            }
                            
                            if OnlineSelectedIndex.contains(3)
                            {
                                cell.rgtbtn.setImage(UIImage(named: "check"), for: .normal)
                            }
                            else
                            {
                                cell.rgtbtn.setImage(UIImage(named: "uncheck"), for: .normal)
                            }
                        }
                        else
                        {
                            cell.leftbtn.setImage(UIImage(named: "check_red_new"), for: .normal)
                            cell.rgtbtn.setImage(UIImage(named: "check_red_new"), for: .normal)
                        }
                    }
                    cell.leftbtn.addTarget(self, action: #selector(clickOnlineCheck(_:)), for: .touchUpInside)
                    
                    cell.rgtbtn.addTarget(self, action: #selector(clickOnlineCheck(_:)), for: .touchUpInside)
                    cell.selectionStyle = .none
                    return cell
                case 3...6:
                    let cell = tabvw.dequeueReusableCell(withIdentifier: "ProductSecondTableViewCell", for: indexPath) as! ProductSecondTableViewCell
                    cell.txt.textAlignment = .center
                    cell.addbtn.isHidden = true
                    cell.txt.isUserInteractionEnabled = true
                    cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                    if indexPath.row == 3
                    {
                        cell.txt.isUserInteractionEnabled = false
                        if OnlineSelectedIndex.contains(0)
                        {
                            cell.txt.isUserInteractionEnabled = true
                        }
                    }
                    if indexPath.row == 4
                    {
                        cell.txt.isUserInteractionEnabled = false
                        if OnlineSelectedIndex.contains(1)
                        {
                            cell.txt.isUserInteractionEnabled = true
                            
                        }
                    }
                    
                    
                    cell.lbl.text = ProArr[indexPath.row - 3]
                    cell.txt.text = productPolicyArr[indexPath.row - 3]
                    if indexPath.row == 5
                    {
                        if pro.pro_final_status == 1
                        {
                            cell.addbtn.isHidden = false
                            cell.txt.isUserInteractionEnabled = false
                            if pro.stockQuan == "" || pro.stockQuan == "0"
                            {
                                cell.txt.isUserInteractionEnabled = true
                                cell.addbtn.isHidden = true
                            }
                        }
                        
                        
                    }
                    cell.txt.tag = indexPath.row
                    if indexPath.row == 5 || indexPath.row == 6
                    {
                        cell.txt.isUserInteractionEnabled = false
                        if OnlineSelectedIndex.contains(0) || OnlineSelectedIndex.contains(1)
                        {
                            cell.txt.isUserInteractionEnabled = true
                        }
                        
                        if productPolicyArr[indexPath.row - 3 ].count > 0
                        {
                            if !productPolicyArr[indexPath.row - 3 ].containArabicNumber
                            {
                                cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                            }
                            else
                            {
                                cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                            }
                            
                        }
                        else
                        {
                            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                        }
                    }
                    cell.txt.delegate = self
                    cell.txt.addTarget(self, action: #selector(CreateProductSecondViewController.textFieldDidChangeOnline(_:)), for: UIControl.Event.editingChanged)
                    cell.addbtn.addTarget(self, action: #selector(clickStockUpdate(_:)), for: .touchUpInside)
                    cell.selectionStyle = .none
                    return cell
                case 7:
                    let cell = tabvw.dequeueReusableCell(withIdentifier: "spacingTableViewCell", for: indexPath) as! spacingTableViewCell
                    cell.contentView.backgroundColor = .white
                    cell.selectionStyle = .none
                    return cell
                case 8:
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductHeader2TableViewCell", for: indexPath) as! ProductHeader2TableViewCell
                    cell.whole.setTitle("Wholesale".localized, for: .normal)
                    cell.retail.setTitle("Retail".localized, for: .normal)
                    cell.delegate = self
                    if isSelected == "retail"{
                        cell.lbl1.backgroundColor = .red
                        cell.lbl2.backgroundColor = .clear
                        cell.retail.setTitleColor(UIColor.init(red: 236/255, green: 73/255, blue: 84/255, alpha: 1), for: .normal);
                        cell.retail.backgroundColor = .white
                        cell.whole.setTitleColor(UIColor.init(red: 28/255, green: 157/255, blue: 213/255, alpha: 1), for: .normal)
                        cell.whole.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
                        
                    }
                        
                    else if isSelected == "wholesale"{
                        cell.lbl1.backgroundColor = .clear
                        cell.lbl2.backgroundColor = .red
                        cell.whole.setTitleColor(UIColor.init(red: 236/255, green: 73/255, blue: 84/255, alpha: 1), for: .normal)
                        cell.whole.backgroundColor = .white
                        cell.retail.setTitleColor(UIColor.init(red: 28/255, green: 157/255, blue: 213/255, alpha: 1), for: .normal)
                        cell.retail.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
                    }
                    
                    cell.selectionStyle = .none
                    return cell
                case 9:
                    
                    if isSelected == "retail"{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTopTableViewCell", for: indexPath) as! PriceTopTableViewCell
                        cell.titleLabel.text = "Retail Pricing".localized
                        cell.selectionStyle = .none
                        cell.topConst.constant = 10
                        return cell
                    }
                    else
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "WholeAddSlabTableViewCell", for: indexPath) as! WholeAddSlabTableViewCell
                        cell.isUserInteractionEnabled = true
                        
                        cell.addSlab.addTarget(self, action: #selector(createWholesaleSlab), for: .touchUpInside)
                        cell.selectionStyle = .none
                        return cell
                    }
                    
                    
                default:
                    
                    if isSelected == "retail"{
                        
                        let cell = tableView.dequeueReusableCell(withIdentifier: "RetailPriceListViewCell", for: indexPath) as! RetailPriceListViewCell
                        cell.isUserInteractionEnabled = false
                        if HeaderHeightSingleton.shared.LanguageSelected == "EN"
                                           {
                                               cell.leadingCurrency.constant = 19.5
                                           }
                        cell.leadingcurrencyconst.constant = 19.5
                        if pro.Onlineretail
                        {
                            cell.isUserInteractionEnabled = true
                        }
                        cell.finalPrice.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
                          cell.currency.font = UIFont(name: fontNameLight, size: 7.0)
                        cell.finalPrice.font = UIFont(name: fontNameLight, size: 12.0)
                        cell.selectionStyle = .none
                     
                        cell.min.isHidden = true
                        cell.max.isHidden = true
                        cell.exchangeImg.isHidden = true
                        cell.currency.isHidden = false
                        cell.percentLabel.isHidden = true
                        cell.currency.text = "SAR".localized
                        cell.greenTick.isHidden = true
                        cell.price.text = ""
                        cell.finalCurrency.isHidden = true
                        cell.currency.isUserInteractionEnabled = false
                        cell.price.isHidden = true
                        cell.titleLblLeading.constant = 18
                       
                        cell.price.isUserInteractionEnabled = true
                        cell.finalPrice.isUserInteractionEnabled = true
                        cell.titleLabel.text = onlineretailArr[indexPath.row - 10]
                          cell.pricewidthConst.constant = 16
                        cell.bottomlbl.backgroundColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2")
                        cell.price.keyboardType = .decimalPad
                        cell.finalPrice.keyboardType = .decimalPad
                     
                        if indexPath.row == 10
                        {
                              cell.currency.font = UIFont(name: fontNameLight, size: 12.0)
                            cell.pricewidthConst.constant = cell.contentView.frame.width/5
                            let str1 = "Quantity".localized
                            let str2 = "That Can be Bought".localized
                            onlineretailArr[0] = "\(str1) \n \(str2)"
                            cell.titleLabel.attributedText = ModalController.setStricColor(str: "\(onlineretailArr[indexPath.row - 10]) *", str1: "\(onlineretailArr[indexPath.row - 10])", str2: "*")
                            cell.min.isHidden = false
                            cell.max.isHidden = false
                            cell.currency.isUserInteractionEnabled = true
                            cell.currency.tag = 0
                            cell.finalPrice.tag = 1
                            cell.currency.text = "\(retailDimensionalArr[indexPath.row - 10][0])"
                            cell.finalPrice.text = "\(retailDimensionalArr[indexPath.row - 10][1])"
                            cell.exchangeImg.isHidden = false
                            cell.currency.keyboardType = .asciiCapableNumberPad
                            cell.finalPrice.keyboardType = .asciiCapableNumberPad
                        }
                        else if indexPath.row == 11 || indexPath.row == 13
                        {
                            if indexPath.row == 11
                            {
                                cell.titleLabel.attributedText = ModalController.setStricColor(str: "\(onlineretailArr[indexPath.row - 10]) *", str1: "\(onlineretailArr[indexPath.row - 10])", str2: "*")
                            }
                            cell.finalPrice.tag = 0
                            cell.finalPrice.text = "\(retailDimensionalArr[indexPath.row - 10][0])"
                            
                        }
                            
                        else if indexPath.row == 12 || indexPath.row == 14
                        {
                            cell.price.text = "\(retailDimensionalArr[indexPath.row - 10][0])"
                            cell.finalPrice.text = "\(retailDimensionalArr[indexPath.row - 10][1])"
                            
                            if indexPath.row == 14
                            {
                                
                                
                                
                                cell.price.isUserInteractionEnabled = false
                                cell.finalPrice.isUserInteractionEnabled = false
                                if isVat
                                {
                                    cell.titleLabel.attributedText = ModalController.setStricColor(str: "\(onlineretailArr[indexPath.row - 10]) *", str1: "\(onlineretailArr[indexPath.row - 10])", str2: "*")
                                    cell.price.isUserInteractionEnabled = true
                                    cell.finalPrice.isUserInteractionEnabled = true
                                    
                                }
                            }
                            
                            cell.price.isHidden = false
                            cell.percentLabel.isHidden = false
                            cell.price.tag = 0;
                            cell.finalPrice.tag = 1
                            
                            
                        }
                        if indexPath.row == 15
                        {
                            cell.greenTick.isHidden = false
                            cell.currency.isHidden = true
                            cell.finalCurrency.isHidden = false
                            cell.finalPrice.tag = 0
                            cell.finalPrice.textColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
                            cell.finalPrice.font = UIFont(name: fontNameBold, size: 12.0)
                            cell.finalPrice.text = "\(retailDimensionalArr[indexPath.row - 10][0])"
                            
                        }
                        
                        cell.price.delegate = self
                        cell.currency.delegate = self
                        cell.finalPrice.delegate = self
                        cell.selectionStyle = .none
                        cell.currency.delegate = self
                        cell.price.delegate = self
                        cell.finalPrice.delegate = self
                        cell.currency.textAlignment = .left
                        cell.price.textAlignment = .left
                        cell.finalPrice.textAlignment = .left
                        cell.currency.addTarget(self, action: #selector(CreateProductSecondViewController.retailOnlineChange(_:)), for: UIControl.Event.editingChanged)
                        cell.price.addTarget(self, action: #selector(CreateProductSecondViewController.retailOnlineChange(_:)), for: UIControl.Event.editingChanged)
                        cell.finalPrice.addTarget(self, action: #selector(CreateProductSecondViewController.retailOnlineChange(_:)), for: UIControl.Event.editingChanged)
                        
                        return cell
                    }else{
                        
                        let cell = tableView.dequeueReusableCell(withIdentifier: "WholesaleListViewCell", for: indexPath) as! WholesaleListViewCell
                        cell.isUserInteractionEnabled = false
                        if pro.OnlineWhole
                        {
                            cell.isUserInteractionEnabled = true
                        }
                        cell.delegate = self
                        
                        cell.minQty.text = "\(pro.OnlineQuantityFrom[indexPath.row-10])"
                        cell.maxQty.text = "\(pro.OnlineQuantityto[indexPath.row-10])"
                        cell.unitPrice.text = "\(pro.OnlineFinalPrice[indexPath.row-10])"
                        cell.discountPrice.text = "\(pro.OnlinediscountWhole[indexPath.row-10])"
                        
                        cell.discountPercent.text = "\(pro.OnlinediscountWholePercent[indexPath.row-10]) %"
                        cell.vatPrice.text = "\(pro.OnlineVatValue[indexPath.row-10])"
                        cell.vatPercent.text = "\(pro.OnlineVatPercent[indexPath.row-10]) %"
                        cell.edit.isHidden = false
                        cell.delete.isHidden = true
                        if indexPath.row == 9 + pro.OnlineQuantityto.count
                        {
                            cell.delete.isHidden = false
                        }
                        
                        cell.slablabel.isHidden = true
                        cell.slabLevalLbl.text = "Slab Level \(indexPath.row-10)"
                        cell.finalPrice.text = "Final Price:\(pro.OnlineFinalPrice[indexPath.row-10])"
                        cell.toplblHeightConst.constant = 35
                        cell.selectionStyle = .none
                        cell.delete.tag = indexPath.row - 10
                        cell.edit.tag = indexPath.row - 10
                        cell.delete.addTarget(self, action: #selector(clickDeleteSlab(_:)), for: .touchUpInside)
                        
                        cell.edit.addTarget(self, action: #selector(clickEditSlab(_:)), for: .touchUpInside)
                        cell.selectionStyle = .none
                        return cell
                    }
                }
                
                
            }
            else
            {
                let cell = tabvw.dequeueReusableCell(withIdentifier: "nextTableViewCell", for: indexPath) as! nextTableViewCell
                cell.savedraft.isHidden = false
                if ProductModel.shared.pro_final_status == 1
                {
                    cell.savedraft.isHidden = true
                }
                if Selectedtab.contains(1)
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
                cell.savedraft.tag = 0
                cell.nextbtn.setTitle("Save".localized, for: .normal)
                if pro.isoffline
                {
                    cell.nextbtn.setTitle("Next".localized, for: .normal)
                }
                cell.savedraft.addTarget(self, action: #selector(saveClick(_ :)), for: .touchUpInside)
                cell.nextbtn.tag = 1
                cell.nextbtn.addTarget(self, action: #selector(saveClick(_ :)), for: .touchUpInside)
                cell.selectionStyle = .none
                return cell
            }
        }
        else
        {
            //self.checkinstoreColor()
            if indexPath.section == 3
            {
                let cell = tabvw.dequeueReusableCell(withIdentifier: "nextTableViewCell", for: indexPath) as! nextTableViewCell
                cell.savedraft.isHidden = false
                if ProductModel.shared.pro_final_status == 1
                {
                    cell.savedraft.isHidden = true
                }
                if Selectedtab.contains(2)
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
                cell.nextbtn.setTitle("Save".localized, for: .normal)
                cell.savedraft.tag = 0
                cell.savedraft.addTarget(self, action: #selector(saveClick(_ :)), for: .touchUpInside)
                cell.nextbtn.tag = 1
                cell.nextbtn.addTarget(self, action: #selector(saveClick(_ :)), for: .touchUpInside)
                cell.selectionStyle = .none
                return cell
            }
            if indexPath.section == 2
            {
                let cell = tabvw.dequeueReusableCell(withIdentifier: "InstorePaymentTableViewCell", for: indexPath) as! InstorePaymentTableViewCell
                cell.txt.text = self.storepayment?.data?.store_payment_option?[indexPath.row].value
                cell.heightConst.constant = 0
                if indexPath.row == 0
                {
                    cell.heightConst.constant = 40
                    cell.paylbl.text = "Payment Mode".localized
                }
                cell.digitalpay.setImage(UIImage(named: "uncheck"), for: .normal)
                if pro.storePayArr.count == 0
                {
                    cell.digitalpay.setImage(UIImage(named: "check_red_new"), for: .normal)
                    
                }
                else
                {
                    
                    if pro.storePayArr.contains((self.storepayment?.data?.store_payment_option?[indexPath.row].id)!)
                    {
                        cell.digitalpay.isSelected = true
                    }
                    else
                    {
                        cell.digitalpay.isSelected = false
                    }
                    
                }
                
                
                //cell.digitalpay.addTarget(self, action: #selector(clickPayment(_:)), for: .touchUpInside)
                
                return cell
            }
            else{
                if indexPath.row == 0 || indexPath.row == 1
                {
                    let cell = tabvw.dequeueReusableCell(withIdentifier: "SelectProductTypeNewTableViewCell", for: indexPath) as! SelectProductTypeNewTableViewCell
                  
                    cell.leftbtn.isUserInteractionEnabled = true
                    cell.outervw.backgroundColor = .clear
                    cell.leadingConst.constant  = 0
                    cell.trailingConst.constant = 0
                    cell.outervw.layer.borderWidth = 0
                    cell.leftbtn.setImage(UIImage(named: "uncheck"), for: .normal)
                    cell.rgtbtn.setImage(UIImage(named: "uncheck"), for: .normal)
                    cell.outervw.addBorder(.bottom, color: UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1), thickness: 0.5)
                    cell.lbl.isHidden = false
                    cell.leftlbl.isHidden = false
                    cell.leftbtn.isHidden = false
                    cell.rgtbtn.isUserInteractionEnabled = true
                      cell.leftLblLeading.constant = 10
                    if HeaderHeightSingleton.shared.LanguageSelected == "AR"
                                           {
                    cell.leftLblLeading.constant = self.view.frame.width/12
                                            
                    }
                    if indexPath.row == 0
                    {
                        cell.btnleading.constant = 30
                        cell.rightBtnLeading.constant = self.view.frame.width/6
                        cell.rgtlbl.text = "Field Same As Online".localized
                        cell.lbl.isHidden = true
                        cell.leftlbl.isHidden = true
                        cell.leftbtn.isHidden = true
                        cell.rgtbtn.tag = 0
                        cell.rgtbtn.isUserInteractionEnabled = false
                        if Selectedtab.contains(1)
                        {
                            cell.rgtbtn.isUserInteractionEnabled = true
                        }
                        if instoreSelectedIndex.contains(indexPath.row)
                        {
                            cell.rgtbtn.setImage(UIImage(named: "check"), for: .normal)
                        }
                        else
                        {
                            cell.rgtbtn.setImage(UIImage(named: "uncheck"), for: .normal)
                        }
                        
                    }
                    else
                    {
                        cell.btnleading.constant = self.view.frame.width/6
                          cell.rightBtnLeading.constant = self.view.frame.width/10
                        if HeaderHeightSingleton.shared.LanguageSelected == "AR"
                        {
                            
                         cell.btnleading.constant = self.view.frame.width/5
                             cell.rightBtnLeading.constant = self.view.frame.width/9
                        }
                        
                      
                        cell.lbl.text = "Sale In".localized
                        cell.rgtlbl.text = "   Wholesale".localized
                        cell.leftlbl.text = "     Retail".localized
                        //cell.leftLblLeading.constant = 20
                        cell.leftbtn.tag = 1
                        cell.rgtbtn.tag = 2
                        if instoreSelectedIndex.contains(1) || instoreSelectedIndex.contains(2)
                        {
                            if instoreSelectedIndex.contains(1)
                            {
                                cell.leftbtn.setImage(UIImage(named: "check"), for: .normal)
                            }
                            else
                            {
                                cell.leftbtn.setImage(UIImage(named: "uncheck"), for: .normal)
                            }
                            if instoreSelectedIndex.contains(2)
                            {
                                cell.rgtbtn.setImage(UIImage(named: "check"), for: .normal)
                            }
                                
                                
                            else
                            {
                                cell.rgtbtn.setImage(UIImage(named: "uncheck"), for: .normal)
                            }
                        }
                        else
                        {
                            cell.leftbtn.setImage(UIImage(named: "check_red_new"), for: .normal)
                            cell.rgtbtn.setImage(UIImage(named: "check_red_new"), for: .normal)
                        }
                    }
                    
                    cell.leftbtn.addTarget(self, action: #selector(clickRetailCheck(_:)), for: .touchUpInside)
                    
                    cell.rgtbtn.addTarget(self, action: #selector(clickRetailCheck(_:)), for: .touchUpInside)
                    return cell
                }
                else
                {
                let cell = tableView.dequeueReusableCell(withIdentifier: "RetailPriceListViewCell", for: indexPath) as! RetailPriceListViewCell
                    if HeaderHeightSingleton.shared.LanguageSelected == "EN"
                    {
                        cell.leadingCurrency.constant = 19.5
                    }
                cell.leadingcurrencyconst.constant = 10
                cell.pricewidthConst.constant = 16
                cell.finalPrice.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
                cell.finalPrice.font = UIFont(name: fontNameLight, size: 12.0)
                cell.price.isUserInteractionEnabled = false
                cell.finalPrice.isUserInteractionEnabled = false
                cell.currency.keyboardType = .decimalPad
                cell.finalPrice.keyboardType = .decimalPad
                cell.isUserInteractionEnabled = true
                if instoreSelectedIndex.contains(1)
                {
                    cell.price.isUserInteractionEnabled = true
                }
                if instoreSelectedIndex.contains(2)
                {
                    cell.finalPrice.isUserInteractionEnabled = true
                }
                cell.finalCurrency.isHidden = true
                cell.currency.isHidden = false
                cell.price.isHidden = false
                cell.finalPrice.isHidden = false
                cell.price.keyboardType = .numberPad
                cell.finalPrice.keyboardType = .numberPad
                cell.rgtvw.backgroundColor = UIColor.clear
                cell.selectionStyle = .none
                cell.titleLblLeading.constant = 15
                cell.currency.text = SARArr[indexPath.row - 2]
                cell.titleLabel.text = instoreNameArr[indexPath.row - 2]
                cell.currency.font = UIFont(name: fontNameLight, size: 7.0)
                    let retail = String(format: "%.2f", (instoreRetailArr[indexPath.row - 2] as NSString).doubleValue)
                let whole = String(format: "%.2f", (instoreWholeSaleArr[indexPath.row - 2] as NSString).doubleValue)
                cell.price.text = retail
                cell.finalPrice.text = whole
                cell.bottomlbl.backgroundColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2")
                cell.currency.isUserInteractionEnabled = false
                cell.exchangeImg.isHidden = true
                cell.greenTick.isHidden = true
                cell.percentLabel.isHidden = true
                cell.min.isHidden = true
                cell.max.isHidden = true
                cell.price.tag = 0
                cell.finalPrice.tag = 1
                cell.price.keyboardType = .decimalPad
                cell.finalPrice.keyboardType = .decimalPad
                if indexPath.row == 2
                {
                    
                    cell.titleLabel.attributedText = ModalController.setStricColor(str: "\(instoreNameArr[indexPath.row - 2]) *", str1: "\(instoreNameArr[indexPath.row - 2])", str2: "*")
                }
                if indexPath.row == 6 ||  indexPath.row == 7
                {
                    cell.price.isUserInteractionEnabled = false
                    cell.finalPrice.isUserInteractionEnabled = false
                    if isVat
                    {
                        cell.titleLabel.attributedText = ModalController.setStricColor(str: "\(instoreNameArr[indexPath.row - 2]) *", str1: "\(instoreNameArr[indexPath.row - 2])", str2: "*")
                        cell.price.isUserInteractionEnabled = true
                        cell.finalPrice.isUserInteractionEnabled = true
                    }
                }
                if indexPath.row == 5 ||  indexPath.row == 8
                {
                    cell.price.isUserInteractionEnabled = false
                    cell.finalPrice.isUserInteractionEnabled = false
                }
                if indexPath.row == 9 ||  indexPath.row == 10 ||  indexPath.row == 11
                {
                    cell.price.keyboardType = .asciiCapableNumberPad
                    cell.finalPrice.keyboardType = .asciiCapableNumberPad
                }
                cell.price.delegate = self
                cell.finalPrice.delegate = self
                cell.currency.textAlignment = .left
                cell.price.textAlignment = .left
                cell.finalPrice.textAlignment = .left
                cell.price.addTarget(self, action: #selector(CreateProductSecondViewController.retailDidChange(_:)), for: UIControl.Event.editingChanged)
                cell.finalPrice.addTarget(self, action: #selector(CreateProductSecondViewController.retailDidChange(_:)), for: UIControl.Event.editingChanged)
                return cell
            }
            }
        }
    }
    //    override func viewWillAppear(_ animated: Bool) {
    //        self.tabBarController?.tabBar.isHidden = false
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if clicktab == 0
        {
            if indexPath.section == 1
            {
                if indexPath.row == 0
                {
                    if isVarient || isSimilar
                    {
                        ModalController.showNegativeCustomAlertWith(title: "Can't Select Category/Subcategory For This Product", msg: "")
                        return
                        
                    }
                    let vc = SelectCategoryViewController(nibName: "SelectCategoryViewController", bundle: nil)
                    vc.delegate = self
                    vc.proName = pro.productTitle
                    vc.hidesBottomBarWhenPushed = true;
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        if clicktab == 2
        {
            if indexPath.section == 2
            {
                self.clickPayment(tag:indexPath.row)
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1
        {
            
            return 35
        }
        
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if clicktab == 0
        {
            if indexPath.section == 0
            {
                if indexPath.row == 0
                {
                    return 50
                }
                return 160
            }
            else
            {
                if isDataBank{
                    switch indexPath.row {
                    case 0:
                        return 45
                    case filterCount + 10:
                        return 110
                    case filterCount + 3...filterCount + 7:
                        return 0
                    case filterCount + 2:
                        return 40
                    case filterCount + 8:
                        return 95
                    case filterCount + 11:
                        return 130
                    case filterCount + 12,filterCount + 13:
                        return 0
                    case filterCount + 14:
                        return 100
                    default:
                        return 35
                    }
                }
                switch indexPath.row {
                case 0:
                    return 45
                case filterCount + 2,filterCount + 10:
                    return 110
                case filterCount + 8,filterCount + 12:
                    return 95
                case filterCount + 11:
                    return 130
                case filterCount + 14:
                    return 100
                default:
                    return 35
                }
            }
        }
        if clicktab == 2
        {
            
            if indexPath.section == 0
            {
                if indexPath.row == 0
                {
                    return 50
                }
                return 160
            }
            if indexPath.section == 2
            {
                if indexPath.row == 0
                {
                    return 80
                }
                return 40
            }
            if indexPath.section == 3
            {
                return 100
            }
            else{
                if indexPath.row == 0 || indexPath.row == 1
                {
                    return 45
                }
                return 60
            }
        }
        else
        {
            if indexPath.section == 0
            {
                if indexPath.row == 0
                {
                    return 50
                }
                return 160
            }
            else  if indexPath.section == 2
            {
                return 100
            }
            switch indexPath.row {
            case 0:
                return 20
            case 1,2:
                return 40
            case 3...6:
                return 50
            case 7:
                return 20
            case 8:
                return 45
            case 9:
                return 80
            default:
                if isSelected == "retail"
                {
                    return 60
                }
                else
                {
                    return 155
                }
            }
        }
        
        
        
        
    }
    
    
    
}



extension CreateProductSecondViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate,CollectionViewTableViewCellDelegate,AddFilterViewControllerDelegate{
    func deleteDoc(tag: Int) {
        self.docImage.removeObject(at: tag - 1)
        self.docId.removeObject(at: tag - 1)
        pro.documentImageSize.removeObject(at: tag - 1)
        checkspecColor()
        tabvw.reloadData()
    }
    
    func addFilter(val: Int) {
        filterList_API(val: "\(val)")
    }
    
    
    func cancelBtn() {
        print("")
    }
    
    func attachedPdf() {
        let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
        vc.delegate = self
        vc.isproduct = true
        vc.iswarning = true
        
        vc.nameAr =  ["Device Gallery","Document"]
        vc.imgAr  = ["galery_Picture","dataEntryService"]
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
    func fileSize(forURL url: Any) -> Double {
        var fileURL: URL?
        var fileSize: Double = 0.0
        if (url is URL) || (url is String)
        {
            if (url is URL) {
                fileURL = url as? URL
            }
            else {
                fileURL = URL(fileURLWithPath: url as! String)
            }
            var fileSizeValue = 0.0
            try? fileSizeValue = (fileURL?.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).allValues.first?.value as! Double?)!
            if fileSizeValue > 0.0 {
                fileSize = (Double(fileSizeValue) / (1024 * 1024))
            }
        }
        return fileSize
    }
    
    @objc func cilckedmore()
    {

//            let vc = ReturnPolicyNewViewController(nibName: "ReturnPolicyNewViewController", bundle: nil)
//
//               vc.datasalestr = pro.productDecription
//          vc.isDatasale = true
//            let popupController = MTPopupController(rootViewController: vc)
//                   popupController.autoAdjustKeyboardEvent = false
//                   popupController.style = .bottomSheet
//                   popupController.navigationBarHidden = true
//                   popupController.hidesCloseButton = false
//                   let blurEffect = UIBlurEffect(style: .dark)
//                   popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
//                   popupController.backgroundView?.alpha = 0.6
//                   popupController.backgroundView?.onClick {
//                       popupController.dismiss()
//                   }
//                   popupController.present(in: self)
        }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        ModalClass.startLoading(self.view)
        let branch = branchsmodel()
        branch.pfurl = urls.first
        size = 0.0
        let siz = fileSize(forURL:  urls.first!)
        pro.documentImageSize.add(siz)
        if pro.documentImageSize.count > 0
        {
            for i in 0...(pro.documentImageSize.count - 1)
            {
                let si = pro.documentImageSize[i] as! Double
                size = size + si
            }
        }
        print(".......\(size)")
        if size > 25
        {
            ModalController.showNegativeCustomAlertWith(title: "Image Size is large", msg: "")
            return
        }
        
        
        branch.uploadPdfImage { (success, response) in
            ModalClass.stopLoading()
            
            if success
            {
                self.docId.add((response?.data?.doc_id)!)
                self.docImage.add((response?.data?.doc_url)!)
                self.checkspecColor()
                self.tabvw.reloadData()
            }
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}


extension CreateProductSecondViewController:DeleteSlabPopupDelegate
{
    func yes(max:String) {
        pro.OnlineQuantityFrom.removeAllObjects()
        pro.OnlineQuantityto.removeAllObjects()
        pro.OnlineWholeSalePriceFrom.removeAllObjects()
        pro.OnlineWholeSalePriceTo.removeAllObjects()
        pro.OnlinediscountWhole.removeAllObjects()
        pro.OnlinediscountWholePercent.removeAllObjects()
        pro.OnlineVatValue.removeAllObjects()
        pro.OnlineVatPercent.removeAllObjects()
        pro.OnlineFinalPrice.removeAllObjects()
        retailDimensionalArr[0][1] = max
          pro.OnlineMax = max
        tabvw.reloadData()
    }
    
    func no() {
        
        tabvw.reloadData()
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField.text! as NSString).integerValue == 0
        {
            textField.text = ""
        }
        return true
    }
    @objc private func retailOnlineChange(_ textField: UITextField)
    {
        if clicktab == 1
        {
            let touchPoint = textField.convert(CGPoint.zero, to: tabvw)
            let clickedBtn = tabvw.indexPathForRow(at: touchPoint)
            let row = Int(clickedBtn!.row)
            
            switch row - 10 {
            case 0:
                if textField.tag == 0
                {
                    if pro.OnlineQuantityto.count > 0
                    {
                        if ((textField.text! as NSString).integerValue) >  pro.OnlineQuantityto.lastObject as! Int
                        {
                            ModalController.showNegativeCustomAlertWith(title: "Retail qty should be less than wholesale qty", msg: "")
                            retailDimensionalArr[0][0] = textField.text!.removeLast()
                            return
                        }
                    }
                    if Int(pro.OnlineMax) ?? 0 > 0
                    {
                        if ((textField.text! as NSString).integerValue) > (pro.OnlineMax as NSString).integerValue
                        {
                            ModalController.showNegativeCustomAlertWith(title: "Min Qty Always Less Than Max Qty", msg: "")
                            tabvw.reloadSections(IndexSet(integer: 1), with: .none)
                            
                        }
                    }
                    
                    pro.OnlineMin = textField.text!
                    retailDimensionalArr[0][0] = textField.text!
                    
                }
                else
                {
                    if  pro.OnlineQuantityFrom.count > 0
                    {
                        if ((textField.text! as NSString).integerValue) >  pro.OnlineQuantityFrom.firstObject as! Int - 1
                        {
                            let vc = DeleteSlabPopupViewController(nibName: "DeleteSlabPopupViewController", bundle: nil)
                            vc.max = textField.text!
                            vc.delegate = self
                            self.present(vc, animated: true, completion: nil)
                            return
                        }
                    }
                    
                    pro.OnlineMax  = textField.text!
                    retailDimensionalArr[0][1] = textField.text!
                    
                }
            case 1,3:
                retailDimensionalArr[row - 10][textField.tag] = textField.text!
                
            case 2,4:
                
                if textField.tag == 1
                {
                    if (textField.text! as NSString).integerValue > 100
                    {
                        let val = (row - 10 == 2) ? "Discount" : "Vat"
                        ModalController.showNegativeCustomAlertWith(title: "\(val) Percentage Always Less Than 100", msg: "")
                        tabvw.reloadSections(IndexSet(integer: 1), with: .none)
                        return
                    }
                    retailDimensionalArr[row - 10][textField.tag] = "\((textField.text! as NSString).doubleValue)"
                    let dispercenet =  ((retailDimensionalArr[row - 11][0] as! NSString).doubleValue/100) * (retailDimensionalArr[row - 10][textField.tag] as!  NSString).doubleValue
                    retailDimensionalArr[row - 10][0] = "\(dispercenet)"
                    if row - 10 == 2
                    {
                        retailDimensionalArr[row - 9][0] = "\((retailDimensionalArr[row - 11][0] as!  NSString).doubleValue -  (retailDimensionalArr[row - 10][0] as! NSString).doubleValue)"
                    }
                    else
                    {
                        retailDimensionalArr[row - 9][0] = "\((retailDimensionalArr[row - 11][0] as! NSString).doubleValue + (retailDimensionalArr[row - 10][0] as! NSString).doubleValue)"
                    }
                    if "\(retailDimensionalArr[row - 10][1])".dropLast().last == "."
                    {
                        retailDimensionalArr[row - 10][1] = "\(retailDimensionalArr[row - 10][1])".dropLast().dropLast()
                    }
                }
                if textField.tag == 0
                {
                    if (textField.text! as NSString).doubleValue > (retailDimensionalArr[1][0] as!  NSString).doubleValue
                    {
                        let val = (row - 10 == 2) ? "Discount" : "Vat"
                        ModalController.showNegativeCustomAlertWith(title: "\(val) Price Always Less Than Regular Price", msg: "")
                        tabvw.reloadSections(IndexSet(integer: 1), with: .none)
                        return
                    }
                    retailDimensionalArr[row - 10][textField.tag] = "\((textField.text! as NSString).doubleValue)"
                    let disprice =  (((retailDimensionalArr[row - 10][textField.tag] as! NSString).doubleValue)/(retailDimensionalArr[row - 11][0] as!  NSString).doubleValue)*100
                    retailDimensionalArr[row - 10][1] = "\(disprice)"
                    if row - 10 == 2
                    {
                        retailDimensionalArr[row - 9][0] = "\((retailDimensionalArr[row - 11][0] as!  NSString).doubleValue - (retailDimensionalArr[row - 10][0] as! NSString).doubleValue)"
                    }
                    else
                    {
                        retailDimensionalArr[row - 9][0] = "\((retailDimensionalArr[row - 11][0] as!  NSString).doubleValue + (retailDimensionalArr[row - 10][0] as! NSString).doubleValue)"
                    }
                    if "\(retailDimensionalArr[row - 10][0])".dropLast().last == "."
                    {
                        retailDimensionalArr[row - 10][0] = "\(retailDimensionalArr[row - 10][0])".dropLast().dropLast()
                    }
                    //tabvw.reloadSections(IndexSet(integer: 1), with: .none)
                    
                }
            default:
                break
            }
            if row - 10 != 2
            {
                retailDimensionalArr[2][0] =  "\(((retailDimensionalArr[1][0] as! NSString).doubleValue/100) * (retailDimensionalArr[2][1] as!  NSString).doubleValue)"
                retailDimensionalArr[2][0] = "\(((retailDimensionalArr[2][0] as! NSString).doubleValue).roundToDecimal(2))"
            }
            
            retailDimensionalArr[3][0] = "\((retailDimensionalArr[1][0] as! NSString).doubleValue - (retailDimensionalArr[2][0] as!  NSString).doubleValue)"
            if row - 10 != 4
            {
                retailDimensionalArr[4][0] =  "\(((retailDimensionalArr[3][0] as! NSString).doubleValue/100) * (retailDimensionalArr[4][1] as!  NSString).doubleValue)"
                retailDimensionalArr[4][0] = "\(((retailDimensionalArr[4][0] as! NSString).doubleValue).roundToDecimal(2))"
            }
            
            retailDimensionalArr[5][0] = "\(((retailDimensionalArr[1][0] as! NSString).doubleValue - (retailDimensionalArr[2][0] as!  NSString).doubleValue) + (retailDimensionalArr[4][0] as!  NSString).doubleValue)"
            if row - 10 == 2 || row - 10 == 4
            {
                retailDimensionalArr[row - 10][textField.tag] = textField.text!
                
                
                retailDimensionalArr[row - 10][textField.tag == 0 ? 1 : 0] = "\(((retailDimensionalArr[row - 10][textField.tag == 0 ? 1 : 0] as! NSString).doubleValue).roundToDecimal(2))"
            }
            retailDimensionalArr[3][0] = "\(((retailDimensionalArr[3][0] as! NSString).doubleValue).roundToDecimal(2))"
            retailDimensionalArr[5][0] = "\(((retailDimensionalArr[5][0] as! NSString).doubleValue).roundToDecimal(2))"
            if  pro.OnlineQuantityFrom.count == 0
            {
                pro.onlineQuanTo = (Int(pro.OnlineMax) ?? 0) + 1
                
            }
            
            //              retailDimensionalArr[0][1] = pro.OnlineMax
            //              retailDimensionalArr[0][0] = pro.OnlineMin
            
            pro.OnlineRegular = "\(retailDimensionalArr[1][0])"
            pro.Onlinediscount = "\(retailDimensionalArr[2][0])"
            pro.Onlinesell = "\(retailDimensionalArr[3][0])"
            pro.OnlineVat = "\(retailDimensionalArr[4][0])"
            pro.OnlineFinal = "\(retailDimensionalArr[5][0])"
            pro.OnlinediscountPer = "\(retailDimensionalArr[2][1])"
            pro.OnlineVatPer = "\(retailDimensionalArr[4][1])"
            for i in 10...15
            {
                if i == row
                {
                    let cell = tabvw.cellForRow(at: IndexPath(row: i, section: 1)) as! RetailPriceListViewCell
                    if HeaderHeightSingleton.shared.LanguageSelected == "EN"
                                       {
                                           cell.leadingCurrency.constant = 19.5
                                       }
                     cell.pricewidthConst.constant = 16
                    cell.currency.textAlignment = .left
                    cell.price.textAlignment = .left
                    cell.finalPrice.textAlignment = .left
                    cell.leadingcurrencyconst.constant = 19.5
                    if i == 10
                    {
                        cell.pricewidthConst.constant = cell.contentView.frame.width/5
                        cell.currency.text = "\(retailDimensionalArr[i - 10][0])"
                        cell.finalPrice.text = "\(retailDimensionalArr[i - 10][1])"
                        
                    }
                    else if i == 12 || i == 14
                    {
                        
                        cell.price.text = "\(retailDimensionalArr[i - 10][0])"
                        cell.finalPrice.text = "\(retailDimensionalArr[i - 10][1])"
                        
                        
                        
                    }
                    else if  i == 11 || i == 13 || i == 15
                    {
                        cell.finalPrice.text = "\(retailDimensionalArr[i - 10][0])"
                    }
                }
                else
                {
                    if ((tabvw.indexPathsForVisibleRows?.contains(IndexPath(row: i, section: 1)))!) {
                        tabvw.reloadRows(at: [IndexPath(row: i, section: 1)], with: .none)
                        
                    }
                }
            }
            self.checkonlineColor()
        }
    }
}

extension CreateProductSecondViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        var textstr = ""
        if let text1 = textField.text as NSString? {
            let txtAfterUpdate = text1.replacingCharacters(in: range, with: string)
            textstr = txtAfterUpdate
        }
        if !string.containArabicNumber
        {
            return false
        }
        if string.contains(".")
        {4
            if textField.text!.contains(".")
            {
                return false
            }
        }
        if textstr.count > 0
        {
            
            if textstr.contains(".")
            {
                let n = textstr
                let n1 =  String((textstr as NSString).integerValue)
                if  n.count - (n1.count + 1) > 2
                {
                    return false
                }
            }
            
        }
        return true
    }
    
}

