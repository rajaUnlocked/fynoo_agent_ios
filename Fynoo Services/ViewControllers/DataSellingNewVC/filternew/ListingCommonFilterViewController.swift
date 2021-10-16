//
//  ListingCommonFilterViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 04/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import TTRangeSlider
import ObjectMapper
import AMShimmer
protocol ListingCommonFilterViewControllerDelegate {
    func clearFilter()
    func filterAppliedReloadAPI()
}

class ListingCommonFilterViewController: UIViewController, TTRangeSliderDelegate {
    var mallid = ""
    var data_bank_list:DatasellingFilter?
    var fullname = [String]()
    var fullnameval = [String]()
    var  isTrue = false
    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var applybtn: UIButton!
    var DataBankSellingModel = DataBankSellingListModel()
    var filterlist:[Filterssell]?
    @IBOutlet weak var topHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var headerVw: NavigationView!
    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var headerNameLbl: UILabel!
    @IBOutlet weak var leftTabView: UITableView!
    @IBOutlet weak var rightTabView: UITableView!
    
    @IBOutlet weak var filterbylbl: UILabel!
    @IBOutlet weak var clearAllLbl: UILabel!
    var pro = ProductModel.shared
    var delegate :  ListingCommonFilterViewControllerDelegate?
    var tab_from = ""
    var branchId = ""
    var catID = ""
    var subCatId = ""
    var brandid = ""
    var sortType = ""
    var sortVal = ""
    var searchTxt = ""
    var flatAmnt = ""
    var filter_type = ""
    var displaytype:String = "Deals"
    var actiontype = 1
    var selectedRow = 0
    var selectedRow1 = 0
    var selectedRowSecondtable = 0
    var product_list = FilterApi()
    var product_new_list : FilterModel?
    var new_branch_list : FilterModel?
    var isFilterType = ""
    var radioValue = 0
    var fromDateTimeStamp = ""
    var toDateTimeStamp = ""
    var checkedRow = NSMutableArray()
    var minRangeVal = ""
    var maxRangeVal = ""
    var minTimeStamp = ""
    var categoryArr = NSMutableArray()
    var iscategory = false
    var iscat = false
    var orderFilter : orderFilterModel?
    var choosenFilter : ((String) -> Void)?
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        close.setTitle("Close".localized, for: .normal)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        self.clearAllLbl.isUserInteractionEnabled = true
        self.clearAllLbl.addGestureRecognizer(singleTap)
        // Do any additional setup after loading the view.
        
        if isFilterType == "dataSell"
        {
            headerVw.titleHeader.text = "Products".localized
            pro.datapriceselltemp = pro.datapricesell
            pro.numsoldsell = pro.numsoldselltemp
            pro.numphotosell = pro.numphotoselltemp
            pro.statussell = pro.statusselltemp
            pro.cataIdsell = pro.cataIdselltemp
            pro.subcataIdsell = pro.subcataIdselltemp
            if pro.daterangesell.count > 0
            {
                let fullNameArr = pro.daterangesell.components(separatedBy: "-")
                self.fromDateTimeStamp =  fullNameArr[0]
                self.toDateTimeStamp =  fullNameArr[1]
            }
            
        }
            
        else{
            self.pro.price = self.pro.pricetemp
            self.pro.likerange = self.pro.likeRangetemp
            self.pro.cataId = self.pro.cataIdtemp
            self.pro.subcataId = self.pro.subcataIdtemp
            self.pro.availIndex = self.pro.availIndextemp
            self.pro.brandIndex = self.pro.brandIndextemp
            self.pro.discountId = self.pro.discountIdtemp
            self.pro.dropshipingId = self.pro.dropshipingIdtemp
            self.pro.ratingrange =  self.pro.rangetemp
            self.pro.paymentMode = self.pro.paymentModetemp
            
        }
        setupUI()
    }
    func dalasellinglist_API()
    {
        ModalClass.startLoading(self.view)
        DataBankSellingModel.getDataBankSellingFilter { (success, response) in
            ModalClass.stopLoading()
            if success{
                self.data_bank_list = response
                self.pro.primaryKeyss = self.data_bank_list?.data?.primary_primary_keyss ?? ""
                self.leftTabView.reloadData()
                self.rightTabView.reloadData()
                if self.isTrue
                {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else {
                
                
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if isFilterType == "dataSell"
        {
            dalasellinglist_API()
        }
    }
    
    func didEndTouches(in sender: TTRangeSlider!) {
        //
    }
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        minRangeVal = String(selectedMinimum)
        maxRangeVal = String(selectedMaximum)
        //        rightTabView.reloadData()
        
        print(minRangeVal,maxRangeVal,"rNGE")
        if isFilterType == "dataSell"
        {
            let pro = self.data_bank_list?.data?.filters?[selectedRow]
            if (pro?.filter_code)! == "NO_OF_PHOTOS"
            {
                self.pro.numphotosell = "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
            }
            if (pro?.filter_code)! == "NO_OF_SOLD"
            {
                self.pro.numsoldsell = "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
            }
        }
        else if isFilterType == "orderFilter"
        {
            let pro =  orderFilter?.data?.filter_list?[selectedRow]
            if pro?.code == "PRICE"{
                self.pro.PriceOrder =  "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
                
                
            }
            if pro?.code == "QTY_OF_PRODUCTS"{
                self.pro.orderQtyPro =  "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
                print( self.pro.orderQtyPro,"dggd")
            }
        }
            
        else if isFilterType == "BranchFilter"
        {
            let pro =  new_branch_list?.data?.filters?[selectedRow]
            if (pro?.filter_code)! == "RATING_RANGE"
            {
                
                self.pro.rating =  "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
                
            }
            if (pro?.filter_code)! == "FOLLOWER_RANGE"
            {
                self.pro.follower = "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
            }
            if (pro?.filter_code)! == "LIKES_RANGE"
            {
                self.pro.likerangebranch = "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
            }
            if (pro?.filter_code)! == "ITEM_RANGE"
            {
                self.pro.availitembranch = "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
                // cell.like.isHidden = false
            }
        }else{
            let pro = product_new_list?.data?.filters?[selectedRow]
            
            if (pro?.filter_code)! == "ITEMS"
            {
                self.pro.availitem = "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
            }
            if (pro?.filter_code)! == "PRICE"
            {
                self.pro.price = "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
            }
            if (pro?.filter_code)! == "BRANCHES"
            {
                self.pro.numberbranch = "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
            }
            if (pro?.filter_code)! == "LIKES_RANGE"
            {
                self.pro.likerange = "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
                
            }
            if (pro?.filter_code)! == "RATING_RANGE"
            {
                self.pro.ratingrange = "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
                
            }
            
        }
        
        
        rightTabView.reloadData()
    }
    
    @objc func tapDetected(){
        self.delegate?.clearFilter()
        self.navigationController?.popViewController(animated: true)
    }
    func setupUI(){
        
        
        headerVw.viewControl = self
        headerNameLbl.text = "Products".localized
        filterbylbl.text = "Filter by".localized
        clearAllLbl.text = "Clear All".localized
        applybtn.setTitle("Apply".localized, for: .normal)
        close.setTitle("Close".localized, for: .normal)
        headerVw.menuBtn.isHidden = false
        leftTabView.delegate = self
        leftTabView.dataSource = self
        rightTabView.dataSource = self
        rightTabView.delegate = self
        rightTabView.separatorStyle = .none
        leftTabView.separatorStyle = .none
        leftTabView.register(UINib(nibName: "SelectCategoryCell", bundle: nil), forCellReuseIdentifier: "SelectCategoryCell")
        rightTabView.register(UINib(nibName: "ListingnewTableViewCell", bundle: nil), forCellReuseIdentifier: "ListingnewTableViewCell")
        rightTabView.register(UINib(nibName: "RadioTypeFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "RadioTypeFilterTableViewCell")
        rightTabView.register(UINib(nibName: "DateRangeFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "DateRangeFilterTableViewCell")
        rightTabView.register(UINib(nibName: "RangeFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "RangeFilterTableViewCell")
        rightTabView.register(UINib(nibName: "DiscountFilterRadioTableViewCell", bundle: nil), forCellReuseIdentifier: "DiscountFilterRadioTableViewCell")
        
        if isFilterType == "dataSell"{
            
        }
//        else if isFilterType == "BranchFilter"{
//            self.headerImg.image = UIImage(named:"branch_new")
//            headerVw.titleHeader.text = "Manage Branches".localized
//            self.headerNameLbl.text = "Manage Branches".localized
//            self.headerImg.image = UIImage(named:"producticon")
//
//            self.BranchListApi()
//        }
//        else if isFilterType == "orderFilter"{
//            self.headerImg.image = UIImage(named:"branch_new")
//            headerVw.titleHeader.text = "Manage Order"
//            self.headerNameLbl.text = "Manage Order"
//            self.headerImg.image = UIImage(named:"producticon")
//
//            self.OrderFilterApi()
//        }
            
        else{
            headerVw.titleHeader.text = "Products".localized
            self.headerNameLbl.text = "Manage Products".localized
            self.headerImg.image = UIImage(named:"branch_icon")
            
            
            self.productListAPI()
            
        }
        
    }
//    func OrderFilterApi(){
//        print(self.pro.applyDone,"ssd")
//        ModalClass.startLoading(self.view)
//
//        let url = Authentication.orderFilterList
//        var status = ""
//        pro.PriceOrder = pro.PriceOrder.replacingOccurrences(of: "-", with: ",")
//        pro.orderQtyPro = pro.orderQtyPro.replacingOccurrences(of: "-", with: ",")
//        if pro.statusOrder.count > 0
//        {
//            for item in  pro.statusOrder{
//                status = "\(item),\(status)"
//            }
//            status.removeLast()
//        }
//        var date = ""
//        if fromDateTimeStamp != "" {
//            date = "\(fromDateTimeStamp),\(toDateTimeStamp)"
//        }
//        let parameter = ["user_id":"\(AuthorisedUser.shared.user?.data?.id ?? 0)","lang_code":HeaderHeightSingleton.shared.LanguageSelected,"qty_of_product":"\(pro.orderQtyPro)","price_range":"\(pro.PriceOrder)","status":"\(status)","date_range":"\(date)"]
//
//        print(parameter)
//        ServerCalls.postRequest(url, withParameters: parameter) { (response, success) in
//            ModalClass.stopLoading()
//            if success{
//                self.orderFilter = Mapper<orderFilterModel>().map(JSON: response as! [String : Any])
//                if  self.pro.applyDone {
//                    self.pro.applyDone = false
//                    self.choosenFilter!(self.orderFilter?.data?.primary_keys ?? "")
//                }else{
//                    self.leftTabView.reloadData()
//                    self.rightTabView.reloadData()
//                }
//
//
//
//
//
//            }
//        }
//
//
//    }
    
//    func BranchListApi(){
//        ModalClass.startLoading(self.view)
//        let branchModal = BranchModal()
//        branchModal.mallId = mallid
//        branchModal.actionType = "\(actiontype)"
//        // branchModal.fromFilter = true
//        branchModal.filterList { (success, response, filterList) in
//            ModalClass.stopLoading()
//            if success{
//                self.new_branch_list = filterList
//                self.rightTabView.delegate = self
//                self.rightTabView.dataSource = self
//                self.leftTabView.reloadData()
//                self.rightTabView.reloadData()
//
//            }
//        }
//    }
    func productListAPI(){
        ModalClass.startLoading(view)
        //AMShimmer.start(for: self.rightTabView)
       // LoadingShimmer.startCovering(rightTabView, with: nil)
        let productlist = FilterApi()
        productlist.catid = catID
        productlist.subcatid = subCatId
        productlist.branchid = branchId
        productlist.displaytype = displaytype
        productlist.actiontype = "\(actiontype)"
        productlist.brandid = self.brandid
        productlist.discount = self.pro.discountId
        productlist.dropship = self.pro.dropshipingId
        productlist.like = self.pro.likerange
        productlist.avail = self.pro.availIndex
        productlist.payment = self.pro.paymentMode
        productlist.price = self.pro.price
        productlist.filtercatid = self.pro.cataId
        productlist.filtersubcatid = self.pro.subcataId
        productlist.brandarr = self.pro.brandIndex
        productlist.getfilterlist { (success, response) in
            if success == true {
                ModalClass.stopLoading()
                 //AMShimmer.stop(for: self.rightTabView)
               // LoadingShimmer.stopCovering(self.rightTabView)
                self.product_new_list = response
                if self.isTrue
                {
                    self.navigationController?.popViewController(animated: true)
                }
                self.rightTabView.delegate = self
                self.rightTabView.dataSource = self
                self.leftTabView.reloadData()
                self.rightTabView.reloadData()
                
                
            }
        }
        
    }
    
    @IBAction func clearAll(_ sender: Any) {
        self.pro.applyDone = false
        if isFilterType == "dataSell"  {
            pro.datapriceselltemp.removeAllObjects()
            pro.numsoldselltemp.removeAll()
            pro.numphotoselltemp.removeAll()
            pro.statusselltemp.removeAll()
            pro.cataIdselltemp.removeAll()
            pro.subcataIdselltemp.removeAll()
            pro.daterangesell.removeAll()
            pro.primaryKeyss = ""
        }
        else if isFilterType == "orderFilter"{
            self.pro.statusOrder.removeAllObjects()
            self.pro.PriceOrderTemp = ""
            self.pro.PriceOrder = ""
            self.pro.orderQtyPro = ""
            self.pro.orderQtyProTemp = ""
            choosenFilter!("")
        }
        else if isFilterType == "BranchFilter"
        {
            self.pro.activatebranchIndex.removeAllObjects()
            self.pro.platformIndex.removeAllObjects()
            self.pro.busstypeIndex.removeAllObjects()
            self.pro.timestamp = ""
            self.pro.rating = ""
            self.pro.follower = ""
            self.pro.likerangebranch = ""
            self.pro.availitembranch = ""
            //self.pro.timestampBranchRange = ""
            self.pro.ratingTemp = ""
            self.pro.likeRangeBranchTemp = ""
            self.pro.followerTemp = ""
            self.pro.noItemTemp = ""
            self.delegate?.clearFilter()
        }
        else{
            self.pro.pricetemp = ""
            self.pro.likeRangetemp = ""
            self.pro.cataIdtemp = ""
            self.pro.subcataIdtemp = ""
            self.pro.availIndextemp.removeAllObjects()
            self.pro.brandIndextemp.removeAllObjects()
            self.pro.discountIdtemp = ""
            self.pro.dropshipingIdtemp = ""
            self.pro.rangetemp = ""
            self.pro.paymentMode.removeAllObjects()
        }
        
        
        
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func apply(_ sender: Any) {
        if isFilterType == "dataSell"  {
            pro.datapriceselltemp = pro.datapricesell
            pro.numsoldselltemp = pro.numsoldsell
            pro.numphotoselltemp = pro.numphotosell
            pro.statusselltemp = pro.statussell
            pro.cataIdselltemp = pro.cataIdsell
            pro.subcataIdselltemp = pro.subcataIdsell
            let pros = filterlist?[5]
            if pros?.range_list?.count ?? 0 > 0
            {
                let fullName = pros?.range_list ?? ""
                let fullNameArr = fullName.components(separatedBy: "-")
                if self.fromDateTimeStamp != "" || self.toDateTimeStamp != ""
                {
                    pro.daterangesell = "\(self.fromDateTimeStamp == "" ? fullNameArr[0] :self.fromDateTimeStamp )-\(self.toDateTimeStamp == "" ? fullNameArr[1] :self.toDateTimeStamp )"
                }
            }
            isTrue = true
            self.dalasellinglist_API()
        }
//        else if isFilterType == "orderFilter"{
//            self.pro.applyDone = true
//            self.OrderFilterApi()
//            let pros = orderFilter?.data?.filter_list?[selectedRow]
//            if pros?.code == "QTY_OF_PRODUCTS"{
//                self.pro.orderQtyProTemp = self.pro.orderQtyPro
//            }
//            if pros?.code == "PRICE"{
//                self.pro.PriceOrderTemp = self.pro.PriceOrder
//
//            }
//            if pros?.code == "STATUS"{
//                self.pro.statusOrderTemp = self.pro.statusOrder
//            }
//            self.navigationController?.popViewController(animated: true)
//        }
        else if isFilterType == "BranchFilter"  {
            let pros = new_branch_list?.data?.filters?[selectedRow]
            
            if (pros?.filter_code)! == "LIKES_RANGE"{
                self.pro.likeRangeBranchTemp = self.pro.likerangebranch
            }
            
            if (pros?.filter_code)! == "RATING_RANGE"
            {
                self.pro.ratingTemp = self.pro.rating
            }
            if (pros?.filter_code)! == "FOLLOWER_RANGE"
            {
                self.pro.followerTemp = self.pro.follower
            }
            if (pros?.filter_code)! == "ITEM_RANGE"
            {
                self.pro.noItemTemp = self.pro.availitembranch
            }
            self.pro.applyDone = true
            delegate?.filterAppliedReloadAPI()
            self.navigationController?.popViewController(animated: true)
        }
        else{
            self.pro.applyDone = true
            self.pro.pricetemp = self.pro.price
            self.pro.likeRangetemp = self.pro.likerange
            self.pro.cataIdtemp = self.pro.cataId
            self.pro.subcataIdtemp = self.pro.subcataId
            self.pro.cataIdnametemp = self.pro.cataIdname
            self.pro.subcataIdnametemp = self.pro.subcataIdName
            self.pro.availIndextemp = self.pro.availIndex
            self.pro.brandIndextemp = self.pro.brandIndex
            self.pro.discountIdtemp = self.pro.discountId
            self.pro.dropshipingIdtemp = self.pro.dropshipingId
            self.pro.rangetemp =  self.pro.ratingrange
            self.pro.paymentModetemp = self.pro.paymentMode
            isTrue = true
            self.productListAPI()
        }
        
        
        
        
    }
    
    
    
    @IBAction func close(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
extension ListingCommonFilterViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView != leftTabView {
            
            let pro = product_new_list?.data?.filters?[selectedRow]
            
            if pro?.view_type == "COMPLEXMULTICHECKBOX"{
                return (pro?.complexcheckbox_item!.count)!
            }
            
            
        }
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView != leftTabView {
            
            let pro = product_new_list?.data?.filters?[selectedRow]
            if pro?.view_type == "COMPLEXMULTICHECKBOX"{
                let view = UIView()
                view.frame = CGRect(x: 10, y: 0, width: 100, height: 30)
                let label = UILabel()
                label.frame = CGRect(x: 10, y: 0, width: 100, height: 30)
                label.text = pro?.complexcheckbox_item?[section].group_name
                label.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                label.font = UIFont(name: "Gilroy-Light", size: 14)!
                view.addSubview(label)
                return view
            }
            
            
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView != leftTabView {
            let pro = product_new_list?.data?.filters?[selectedRow]
            
            if pro?.view_type == "COMPLEXMULTICHECKBOX"{
                return 30
            }
            
            
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFilterType == "dataSell"{
            if tableView == leftTabView {
                return self.data_bank_list?.data?.filters?.count ?? 0
            } else {
                if self.data_bank_list?.data?.filters?.count ?? 0 > 0 {
                    let pro = self.data_bank_list?.data?.filters?[selectedRow]
                    if pro?.view_type == "CHECKBOX"
                    {
                        return pro?.checkbox_item?.count ?? 0
                    }
                    if pro?.view_type == "COMPLEX_RADIO"
                    {
                        if pro?.complex_radio_list?.count ?? 0 == 0
                        {
                            return 0
                        }
                        if iscategory
                        {
                            return  pro?.complex_radio_list?.count ?? 0
                        }
                        else
                        {
                            for i in 0...(pro?.complex_radio_list?.count ?? 0) - 1
                            {
                                iscat = true
                                if "\((pro?.complex_radio_list?[i].value)!)" == self.pro.cataIdsell
                                {
                                    selectedRow1 = i
                                    return (pro?.complex_radio_list?[i].value_list?.count ?? 0) + 1
                                }
                                
                            }
                            if iscat
                            {
                                return  pro?.complex_radio_list?.count ?? 0
                            }
                        }
                    }
                    if pro?.view_type == "RADIO"
                    {
                        return pro?.radio_list?.count ?? 0
                    }
                    return 1
                }
                else {
                    return 0
                }
            }
        }
        else if isFilterType == "BranchFilter"{
            if tableView == leftTabView {
                return new_branch_list?.data?.filters?.count ?? 0
            } else {
                if new_branch_list?.data?.filters?.count ?? 0 > 0 {
                    let branch = new_branch_list?.data?.filters?[selectedRow]
                    if branch?.view_type == "MULTICHECKBOX"
                    {
                        return branch?.checkbox_item?.count ?? 0
                    }
                    
                    return 1
                }
                else {
                    return 0
                }
            }
        }
            
        else
        {
            if isFilterType == "orderFilter"{
                if tableView == leftTabView {
                    guard let value = orderFilter?.data?.filter_list?.count else{return 0}
                    return value
                } else {
                    if orderFilter?.data?.filter_list?.count ?? 0 > 0 {
                        let filter = orderFilter?.data?.filter_list?[selectedRow]
                        if filter?.extra_value == "MULTICHECKBOX"{
                            return filter?.child?.count ?? 0
                        }
                        return 1
                    }
                    else {
                        return 0
                    }
                }
            }
            
            
            if tableView == leftTabView {
                return product_new_list?.data?.filters?.count ?? 0
            }
            else {
                if  product_new_list?.data?.filters?.count ?? 0 > 0 {
                    let pro = product_new_list?.data?.filters?[selectedRow]
                    if pro?.view_type == "CATEGORYRADIO"{
                        if pro?.cat_radio_list?.count ?? 0 == 0
                        {
                            return 0
                        }
                        if iscategory
                        {
                            return  pro?.cat_radio_list?.count ?? 0
                        }
                        else
                        {
                            
                            for i in 0...(pro?.cat_radio_list?.count ?? 0) - 1
                            {
                                iscat = true
                                if "\((pro?.cat_radio_list?[i].filter_cat_id)!)" == self.pro.cataId
                                {
                                    selectedRow1 = i
                                    self.iscat = false
                                    return (pro?.cat_radio_list?[i].sub_cat_list?.count ?? 0) + 1
                                    
                                }
                                
                            }
                            if iscat
                            {
                                return  pro?.cat_radio_list?.count ?? 0
                            }
                        }
                    }
                    else if pro?.view_type == "COMPLEXMULTICHECKBOX"{
                        return  pro?.complexcheckbox_item?[section].list!.count ?? 0
                    }
                    else if pro?.view_type == "MULTICHECKBOX"
                    {
                        return pro?.checkbox_item?.count ?? 0
                    }
                        
                    else if pro?.view_type == "RADIO"
                    {
                        if pro?.radio_list?.count ?? 0 > 0
                        {
                            return 1
                        }
                        return 0
                    }
                    else if pro?.view_type == "RANGE"
                    {
                        if pro?.range_list?.count ?? 0 > 0
                        {
                            return 1
                        }
                        return 0
                    }
                    return 1
                }
                else {
                    return 0
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTabView {
            let cell = leftTabView.dequeueReusableCell(withIdentifier: "SelectCategoryCell", for: indexPath) as! SelectCategoryCell
            cell.contentView.backgroundColor = .gray
            cell.imgWidth.constant = 0
            if isFilterType == "dataSell"  {
                let filterlist = self.data_bank_list?.data?.filters
                cell.catTitle.text = filterlist?[indexPath.row].filter_name
                cell.tickIcon.isHidden = true
                if filterlist?[indexPath.row].is_selected ?? false
                {
                    cell.tickIcon.isHidden = false
                }
                
                
            }
                
//            else if isFilterType == "orderFilter"  {
//                cell.catTitle.text = orderFilter?.data?.filter_list?[indexPath.row].desc
//
//                if orderFilter?.data?.filter_list?[indexPath.row].code == "PRICE"{
//                    cell.greencheck.isHidden = true
//                    if self.pro.PriceOrder.count > 0{
//                        cell.greencheck.isHidden = false
//                    }
//
//                }
//                else if orderFilter?.data?.filter_list?[indexPath.row].code == "STATUS"{
//                    cell.greencheck.isHidden = true
//                    if self.pro.statusOrder.count > 0{
//                        cell.greencheck.isHidden = false
//                    }
//
//                }
//                else if orderFilter?.data?.filter_list?[indexPath.row].code == "QTY_OF_PRODUCTS"{
//                    cell.greencheck.isHidden = true
//                    if self.pro.orderQtyPro.count > 0{
//                        cell.greencheck.isHidden = false
//                    }
//
//                }
//                else if orderFilter?.data?.filter_list?[indexPath.row].code == "DATE_OF_ORDER"{
//                    cell.greencheck.isHidden = true
//                    if self.pro.platformIndex.count > 0{
//                        cell.greencheck.isHidden = false
//                    }
//
//                }
//            }
                
//            else if isFilterType == "BranchFilter"  {
//                cell.catTitle.text = new_branch_list?.data?.filters?[indexPath.row].filter_name
//
//                if new_branch_list?.data?.filters?[indexPath.row].filter_name == "Platform Type"{
//                    cell.greencheck.isHidden = true
//                    if self.pro.platformIndex.count > 0{
//                        cell.greencheck.isHidden = false
//                    }
//
//                }
//                if new_branch_list?.data?.filters?[indexPath.row].filter_name == "Business Type"{
//                    cell.greencheck.isHidden = true
//                    if self.pro.busstypeIndex.count > 0{
//                        cell.greencheck.isHidden = false
//                    }
//                }
//                if new_branch_list?.data?.filters?[indexPath.row].filter_name == "Ratings"{
//                    cell.greencheck.isHidden = true
//                    if self.pro.ratingTemp.count > 0{
//                        cell.greencheck.isHidden = false
//                    }
//                }
//                if new_branch_list?.data?.filters?[indexPath.row].filter_name == "Followers"{
//                    cell.greencheck.isHidden = true
//                    if self.pro.followerTemp.count > 0{
//                        cell.greencheck.isHidden = false
//                    }
//                }
//                if new_branch_list?.data?.filters?[indexPath.row].filter_name == "Likes"{
//                    cell.greencheck.isHidden = true
//                    if self.pro.likeRangeBranchTemp.count > 0{
//                        cell.greencheck.isHidden = false
//                    }
//                }
//                if new_branch_list?.data?.filters?[indexPath.row].filter_name == "Number of Items"{
//                    cell.greencheck.isHidden = true
//                    if self.pro.noItemTemp.count > 0{
//                        cell.greencheck.isHidden = false
//                    }
//                }
//
//            }else{
//                cell.catTitle.text = product_new_list?.data?.filters?[indexPath.row].filter_name
//                cell.greencheck.isHidden = true
//                if product_new_list?.data?.filters?[indexPath.row].is_selected ?? false
//                {
//                    cell.greencheck.isHidden = false
//                }
           // }
            //cell.greencheck.isHidden = false
            
            
            if selectedRow == indexPath.row {
                cell.selectedImg.isHidden = false
                cell.catTitle.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
                
            }else{
                cell.catTitle.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
                cell.selectedImg.isHidden = true
            }
            return cell
        }
            
        else{
            if isFilterType == "dataSell"
            {
                let pro = self.data_bank_list?.data?.filters?[selectedRow]
                if pro?.view_type == "CHECKBOX"{
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "ListingnewTableViewCell", for: indexPath) as! ListingnewTableViewCell
                    cell.nameLbl.text = pro?.checkbox_item?[indexPath.row].key ?? ""
                    if  pro?.checkbox_item?[indexPath.row].is_selected ?? false
                    {
                        cell.checkBox.setImage(UIImage(named: "check"), for: .normal)
                        
                    }
                    else{
                        cell.checkBox.setImage(UIImage(named: "uncheck"), for: .normal)
                    }
                    
                    
                    
                    return cell
                }
                if  pro?.view_type == "RADIO"{
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "ListingnewTableViewCell", for: indexPath) as! ListingnewTableViewCell
                    cell.nameLbl.text = pro?.radio_list?[indexPath.row].key ?? ""
                    
                    if  pro?.radio_list?[indexPath.row].is_selected ?? false
                    {
                        cell.checkBox.setImage(UIImage(named: "selected"), for: .normal)
                        
                    }
                    else{
                        cell.checkBox.setImage(UIImage(named: "unselected"), for: .normal)
                    }
                    
                    
                    return cell
                }
                
                if pro?.view_type == "RANGE"{
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "RangeFilterTableViewCell", for: indexPath) as! RangeFilterTableViewCell
                    
                    cell.img.isHidden = true
                    if (pro?.filter_code)! == "NO_OF_PHOTOS"
                    {
                        cell.lbl.text = "Select Number Of Photos Range".localized
                        if self.pro.numphotosell.count > 0
                        {
                            fullname =  self.pro.numphotosell.components(separatedBy: "-")
                        }
                    }
                    if (pro?.filter_code)! == "NO_OF_SOLD"
                    {
                        cell.lbl.text = "Select Number Of Sold Range".localized
                        if self.pro.numsoldsell.count > 0
                        {
                            fullname =  self.pro.numsoldsell.components(separatedBy: "-")
                        }
                    }
                    let fullName = pro?.range_list ?? ""
                    var fullNameArr = fullName.components(separatedBy: "-")
                    
                    cell.rangeSlider.hideLabels = true
                    if minRangeVal == "" {
                        if (pro?.filter_code)! == "NO_OF_SOLD"
                        {
                            if self.pro.numsoldsell.count > 0
                            {
                                fullNameArr =  self.pro.numsoldsell.components(separatedBy: "-")
                            }
                            
                        }
                        if (pro?.filter_code)! == "NO_OF_PHOTOS"
                        {
                            if self.pro.numphotosell.count > 0
                            {
                                fullNameArr =  self.pro.numphotosell.components(separatedBy: "-")
                            }
                            
                            
                            
                        }
                        cell.rangeSlider.minValue = Float(fullNameArr[0]) ?? 0
                        cell.fromprice.text =  "\(fullNameArr[0])"
                        cell.rangeSlider.selectedMinimum = Float(fullNameArr[0]) ?? 0
                        cell.rangeSlider.selectedMaximum = Float(fullNameArr[1]) ?? 0
                        cell.toprice.text =  "\(fullNameArr[1])"
                        cell.rangeSlider.maxValue = Float(fullNameArr[1]) ?? 0
                    }
                    
                    print(fullname,"hg")
                    
                    
                    
                    if minRangeVal != "" {
                        
                        cell.fromprice.text = "\(fullname[0])"
                        
                    }
                    if maxRangeVal != "" {
                        cell.toprice.text = "\(fullname[1])"
                    }
                    cell.rangeSlider.delegate = self
                    
                    return cell
                }
                if pro?.view_type == "COMPLEX_RADIO"
                {
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "ListingnewTableViewCell", for: indexPath) as! ListingnewTableViewCell
                    
                    if self.pro.cataIdsell == "" || iscategory
                    {
                        cell.nameLbl.text = pro?.complex_radio_list?[indexPath.row].key ?? ""
                        cell.checkBox.setImage(UIImage(named: "unselected"), for: .normal)
                        
                        if self.pro.cataIdsell ==  "\((pro?.complex_radio_list?[indexPath.row].value)!)"
                        {
                            cell.checkBox .setImage(UIImage(named: "selected"), for: .normal)
                        }
                        else
                        {
                            cell.checkBox.setImage(UIImage(named: "unselected"), for: .normal)
                        }
                        
                        
                    }
                    else{
                        cell.checkBox.setImage(UIImage(named: "unselected"), for: .normal)
                        
                        
                        if indexPath.row == 0
                        {
                            cell.checkBox.setImage(UIImage(named: "cross_blue"), for: .normal)
                            
                            
                            cell.checkBox.isUserInteractionEnabled = true
                            cell.checkBox.addTarget(self, action: #selector(clickCross), for: .touchUpInside)
                            
                            cell.nameLbl.text = pro?.complex_radio_list?[selectedRow1].key ?? ""
                        }
                        else{
                            if self.pro.subcataIdsell ==  "\((pro?.complex_radio_list?[selectedRow1].value_list?[indexPath.row - 1].value)!)"
                            {
                                cell.checkBox.setImage(UIImage(named: "selected"), for: .normal)
                            }
                            else
                            {
                                cell.checkBox.setImage(UIImage(named: "unselected"), for: .normal)
                            }
                            cell.nameLbl.text = pro?.complex_radio_list?[selectedRow1].value_list?[indexPath.row - 1].key
                        }
                        
                    }
                    
                    
                    return cell
                }
                if pro?.view_type == "DATE_RANGE"{
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "DateRangeFilterTableViewCell", for: indexPath) as! DateRangeFilterTableViewCell
                     cell.fromlbl.text = "From".localized
                    cell.tolbl.text = "To".localized
                    cell.delegate = self
                    cell.headerLbl.text = "Select Date Range".localized
                    if pro?.range_list?.count ?? 0 > 0  {
                        let fullName = pro?.range_list ?? ""
                        let fullNameArr = fullName.components(separatedBy: "-")
                        cell.minTimeStamp = Double(fullNameArr[0])!
                        cell.maxTimeStamp = Double(fullNameArr[1])!
                        if self.pro.timestampProductRange == "" {
                            let fullName = pro?.range_list ?? ""
                            let fullNameArr = fullName.components(separatedBy: "-")
                            cell.strtDateLbl.text = (Double(fullNameArr[0])!).getDateStringFromUTC()
                            cell.toDateLbl.text = (Double(fullNameArr[1])! ).getDateStringFromUTC()
                        }
                    }
                    return cell
                }
            }
            else if isFilterType == "orderFilter"{
                let pro = orderFilter?.data?.filter_list?[selectedRow]
                if pro?.extra_value == "MULTICHECKBOX"{
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "ListingnewTableViewCell", for: indexPath) as! ListingnewTableViewCell
                    cell.nameLbl.text = pro?.child?[indexPath.row].value_name
                    
                    if (pro?.code ?? "") == "STATUS"
                    {
                        if  self.pro.statusOrder.contains((pro?.child?[indexPath.row].value)!)
                        {
                            cell.checkBox.setImage(UIImage(named: "check"), for: .normal)
                            
                        }
                        else{
                            cell.checkBox.setImage(UIImage(named: "uncheck"), for: .normal)
                        }
                    }
                    return cell
                }
                
                if pro?.extra_value == "RANGE"{
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "RangeFilterTableViewCell", for: indexPath) as! RangeFilterTableViewCell
                    
                    cell.img.isHidden = true
                    if (pro?.code)! == "PRICE"
                    {
                        cell.img.isHidden = false
                        cell.img.image = UIImage(named:"like_grey")
                          cell.lbl.text = "Select Price Range".localized
                        if self.pro.PriceOrderTemp == "" {
                          
                            fullname = self.pro.PriceOrder.components(separatedBy: "-")
                        }else{
                            fullname = self.pro.PriceOrderTemp.components(separatedBy: "-")
                        }
                    }
                    if (pro?.code)! == "QTY_OF_PRODUCTS"
                    {
                        cell.img.isHidden = false
                        cell.img.image = UIImage(named:"star-full_new")
                        if self.pro.ratingTemp == "" {
                            cell.lbl.text = "\("Enter") \(pro?.desc ?? "") \("Range")"
                            fullname = self.pro.orderQtyPro.components(separatedBy: "-")
                        }else{
                            cell.lbl.text = "\("Enter") \(pro?.desc ?? "") \("Range")"
                            fullname =  self.pro.orderQtyProTemp.components(separatedBy: "-")
                        }
                    }
                    
                    cell.rangeSlider.hideLabels = true
                    if minRangeVal == "" {
                        cell.rangeSlider.minValue = Float((pro?.child?[0].value_min)!)
                        cell.fromprice.text =  "\(pro?.child?[0].value_min ?? 0)"
                        cell.rangeSlider.selectedMinimum = Float((pro?.child?[0].value_min)!)
                    }
                    if maxRangeVal == "" {
                        cell.rangeSlider.selectedMaximum = Float((pro?.child?[0].value_max)!)
                        cell.toprice.text =  "\(pro?.child?[0].value_max ?? 0)"
                        cell.rangeSlider.maxValue = Float((pro?.child?[0].value_max)!)
                        
                    }
                    print(fullname.count,"hg")
                    
                    
                    
                    if minRangeVal != "" {
                        
                        cell.fromprice.text = "\(fullname[0])"
                        
                    }
                    if maxRangeVal != "" {
                        cell.toprice.text = "\(fullname[1])"
                    }
                    cell.rangeSlider.delegate = self
                    
                    return cell
                }
                
                if pro?.code == "DATE_OF_ORDER"{
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "DateRangeFilterTableViewCell", for: indexPath) as! DateRangeFilterTableViewCell
                    cell.delegate = self
                    cell.headerLbl.text = "Select Date Range".localized
                    if pro?.child?.count ?? 0 > 0  {
                        //                        let fullName = pro?.range_list ?? ""
                        //                        let fullNameArr = fullName.components(separatedBy: "-")
                        let val1 = Double(pro?.child?[0].value_min ?? 0)
                        cell.minTimeStamp = (val1/1000)
                        
                        let val2 = Double(pro?.child?[0].value_max ?? 0)
                        cell.maxTimeStamp = (val2/1000)
                        if self.pro.timestampProductRange == "" {
                            cell.strtDateLbl.text = (val1/1000).getDateStringFromUTC()
                            cell.toDateLbl.text = (val2/1000).getDateStringFromUTC()
                        }
                    }
                    return cell
                }
                
            }
                
            else if isFilterType == "BranchFilter"{
                let pro = new_branch_list?.data?.filters?[selectedRow]
                if pro?.view_type == "MULTICHECKBOX"{
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "ListingnewTableViewCell", for: indexPath) as! ListingnewTableViewCell
                    cell.nameLbl.text = pro?.checkbox_item?[indexPath.row].name ?? ""
                    
                    if (pro?.filter_code ?? "") == "PLATFORM_TYPE"
                    {
                        if  self.pro.platformIndex.contains((pro?.checkbox_item?[indexPath.row].id)!)
                        {
                            cell.checkBox.setImage(UIImage(named: "check"), for: .normal)
                            
                        }
                        else{
                            cell.checkBox.setImage(UIImage(named: "uncheck"), for: .normal)
                        }
                    }
                    
                    if (pro?.filter_code ?? "") == "BUSINESS_TYPE"{
                        if  self.pro.busstypeIndex.contains((pro?.checkbox_item?[indexPath.row].id)!)
                        {
                            cell.checkBox.setImage(UIImage(named: "check"), for: .normal)
                            
                        }
                        else{
                            cell.checkBox.setImage(UIImage(named: "uncheck"), for: .normal)
                        }
                    }
                    return cell
                }
                if pro?.view_type == "RANGE"{
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "RangeFilterTableViewCell", for: indexPath) as! RangeFilterTableViewCell
                    
                    cell.img.isHidden = true
                    if (pro?.filter_code)! == "LIKES_RANGE"
                    {
                        cell.img.isHidden = false
                        cell.img.image = UIImage(named:"like_grey")
                         cell.lbl.text = "Select Likes Range".localized
                        if self.pro.likeRangeBranchTemp == "" {
                           
                            fullname = self.pro.likerangebranch.components(separatedBy: "-")
                        }else{
                            fullname = self.pro.likeRangeBranchTemp.components(separatedBy: "-")
                        }
                        
                        // cell.like.isHidden = false
                    }
                    if (pro?.filter_code)! == "RATING_RANGE"
                    {
                        cell.img.isHidden = false
                        cell.img.image = UIImage(named:"star-full_new")
                        cell.lbl.text = "Select Ratings Range".localized
                        if self.pro.ratingTemp == "" {
                           
                            fullname = self.pro.rating.components(separatedBy: "-")
                        }else{
                           
                            fullname =  self.pro.ratingTemp.components(separatedBy: "-")
                        }
                        
                        // cell.like.isHidden = false
                    }
                    if (pro?.filter_code)! == "FOLLOWER_RANGE"
                    {
                         cell.lbl.text = "Select Followers Range".localized
                        if self.pro.followerTemp == "" {
                           
                            fullname = self.pro.follower.components(separatedBy: "-")
                        }else{
                            fullname =  self.pro.followerTemp.components(separatedBy: "-")
                        }
                        
                        // cell.like.isHidden = false
                    }
                    if (pro?.filter_code)! == "ITEM_RANGE"
                    {
                        cell.lbl.text = "Select Number of Items Range".localized
                        if self.pro.noItemTemp == "" {
                            fullname = self.pro.availitembranch.components(separatedBy: "-")
                        }else{
                            fullname =  self.pro.noItemTemp.components(separatedBy: "-")
                        }
                        
                        // cell.like.isHidden = false
                    }
                    
                    let fullName = pro?.range_list ?? ""
                    let fullNameArr = fullName.components(separatedBy: "-")
                    
                    cell.rangeSlider.hideLabels = true
                    if minRangeVal == "" {
                        cell.rangeSlider.minValue = Float(fullNameArr[0])!
                        cell.fromprice.text =  "\(fullNameArr[0])"
                        cell.rangeSlider.selectedMinimum = Float(fullNameArr[0])!
                    }
                    if maxRangeVal == "" {
                        cell.rangeSlider.selectedMaximum = Float(fullNameArr[1])!
                        cell.toprice.text =  "\(fullNameArr[1])"
                        cell.rangeSlider.maxValue = Float(fullNameArr[1])!
                        
                    }
                    print(fullname,"hg")
                    
                    
                    
                    if minRangeVal != "" {
                        
                        cell.fromprice.text = "\(fullname[0])"
                        
                    }
                    if maxRangeVal != "" {
                        cell.toprice.text = "\(fullname[1])"
                    }
                    cell.rangeSlider.delegate = self
                    
                    return cell
                }
                
            }
            else
            {
                
                let pro = product_new_list?.data?.filters?[selectedRow]
                
                if pro?.view_type == "COMPLEXMULTICHECKBOX"{
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "ListingnewTableViewCell", for: indexPath) as! ListingnewTableViewCell
                    
                    cell.nameLbl.text = pro?.complexcheckbox_item?[indexPath.section].list?[indexPath.row].name ?? ""
                    
                    if  pro?.complexcheckbox_item?[indexPath.section].list?[indexPath.row].is_selected ?? false
                    {
                        cell.checkBox.setImage(UIImage(named: "check"), for: .normal)
                        
                    }
                    else{
                        cell.checkBox.setImage(UIImage(named: "uncheck"), for: .normal)
                    }
                    
                    return cell
                }
                
                if pro?.view_type == "CATEGORYRADIO"
                {
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "ListingnewTableViewCell", for: indexPath) as! ListingnewTableViewCell
                    
                    if self.pro.cataId == "" || iscategory
                    {
                        cell.nameLbl.text = pro?.cat_radio_list?[indexPath.row].name ?? ""
                        cell.checkBox.setImage(UIImage(named: "unselected"), for: .normal)
                        
                        if self.pro.cataId ==  "\((pro?.cat_radio_list?[indexPath.row].filter_cat_id)!)"
                        {
                            cell.checkBox .setImage(UIImage(named: "selected"), for: .normal)
                        }
                        else
                        {
                            cell.checkBox.setImage(UIImage(named: "unselected"), for: .normal)
                        }
                        
                        
                    }
                    else{
                        cell.checkBox.setImage(UIImage(named: "unselected"), for: .normal)
                        
                        
                        if indexPath.row == 0
                        {
                            cell.checkBox.setImage(UIImage(named: "cross_blue"), for: .normal)
                            
                            
                            cell.checkBox.isUserInteractionEnabled = true
                            cell.checkBox.addTarget(self, action: #selector(clickCross), for: .touchUpInside)
                            
                            cell.nameLbl.text = pro?.cat_radio_list?[selectedRow1].name ?? ""
                        }
                        else{
                            if self.pro.subcataId ==  "\((pro?.cat_radio_list?[selectedRow1].sub_cat_list?[indexPath.row - 1].filter_sub_cat_id)!)"
                            {
                                cell.checkBox.setImage(UIImage(named: "selected"), for: .normal)
                            }
                            else
                            {
                                cell.checkBox.setImage(UIImage(named: "unselected"), for: .normal)
                            }
                            cell.nameLbl.text = pro?.cat_radio_list?[selectedRow1].sub_cat_list?[indexPath.row - 1].name
                        }
                        
                    }
                    
                    
                    return cell
                }
                if pro?.view_type == "MULTICHECKBOX"
                {
                    
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "ListingnewTableViewCell", for: indexPath) as! ListingnewTableViewCell
                    cell.nameLbl.text = pro?.checkbox_item?[indexPath.row].name
                    if  pro?.checkbox_item?[indexPath.row].is_selected ?? false
                    {
                        cell.checkBox.setImage(UIImage(named: "check"), for: .normal)
                        
                    }
                    else{
                        cell.checkBox.setImage(UIImage(named: "uncheck"), for: .normal)
                    }
                    
                    return cell
                }
                else if pro?.view_type == "RANGE"
                {
                    
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "RangeFilterTableViewCell", for: indexPath) as! RangeFilterTableViewCell
                    cell.like.isHidden = true
                    
                    
                    if pro?.range_list?.count ?? 0 > 0
                    {
                        if (pro?.filter_code)! == "ITEMS"
                        {
                            cell.lbl.text = "\("Enter") \(pro?.filter_name ?? "") \("Range")"
                            fullname = self.pro.availitem.components(separatedBy: "-")
                            
                            
                        }
                        if (pro?.filter_code)! == "PRICE"
                        {
                            cell.lbl.text = "Select Price Range".localized
                            fullname = self.pro.price.components(separatedBy: "-")
                            
                        }
                        
                        if (pro?.filter_code)! == "LIKES_RANGE"
                        {
                            cell.lbl.text = "Select Likes Range".localized
                            fullname = self.pro.likerange.components(separatedBy: "-")
                            
                        }
                        if (pro?.filter_code)! == "RATING_RANGE"
                        {
                          cell.lbl.text = "Select Ratings Range".localized
                            fullname = self.pro.ratingrange.components(separatedBy: "-")
                            
                        }
                        
                        
                        let fullName = pro?.selected_range_list ?? "" == "" ? pro?.range_list ?? "" : pro?.selected_range_list ?? ""
                        let fullNameArr = fullName.components(separatedBy: "-")
                        
                        cell.rangeSlider.hideLabels = true
                        if minRangeVal == "" {
                            cell.rangeSlider.minValue = Float(fullNameArr[0])!
                            cell.fromprice.text =  "\(fullNameArr[0])"
                            cell.rangeSlider.selectedMinimum = Float(fullNameArr[0])!
                        }
                        if maxRangeVal == "" {
                            cell.rangeSlider.selectedMaximum = Float(fullNameArr[1])!
                            cell.toprice.text =  "\(fullNameArr[1])"
                            cell.rangeSlider.maxValue = Float(fullNameArr[1])!
                            
                        }
                        
                        if minRangeVal != "" || fullname.count > 1{
                            
                            cell.fromprice.text = "\(fullname[0])"
                        }
                        if maxRangeVal != "" || fullname.count > 1{
                            
                            cell.toprice.text = "\(fullname[1])"
                        }
                    }
                    cell.rangeSlider.delegate = self
                    
                    return cell
                }
                else if pro?.view_type == "DATE_RANGE"{
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "DateRangeFilterTableViewCell", for: indexPath) as! DateRangeFilterTableViewCell
                    cell.delegate = self
                    cell.headerLbl.text = "\("Enter") \(pro?.filter_name ?? "") \("Range")"
                    if pro?.range_list?.count ?? 0 > 0  {
                        let fullName = pro?.range_list ?? ""
                        let fullNameArr = fullName.components(separatedBy: "-")
                        cell.minTimeStamp = Double(fullNameArr[0])!
                        cell.maxTimeStamp = Double(fullNameArr[1])!
                        if self.pro.timestampProductRange == "" {
                            let fullName = pro?.range_list ?? ""
                            let fullNameArr = fullName.components(separatedBy: "-")
                            cell.strtDateLbl.text = (Double(fullNameArr[0])!).getDateStringFromUTC()
                            cell.toDateLbl.text = (Double(fullNameArr[1])! ).getDateStringFromUTC()
                        }
                            
                        else {
                            let fullName = self.pro.timestampProductRange
                            let fullNameArr = fullName.components(separatedBy: "-")
                            
                            cell.strtDateLbl.text = (Double(fullNameArr[0])!).getDateStringFromUTC()
                            cell.toDateLbl.text = (Double(fullNameArr[1])! ).getDateStringFromUTC()
                        }
                    }
                    
                    
                    return cell
                }
                else
                {
                    let cell = rightTabView.dequeueReusableCell(withIdentifier: "RadioTypeFilterTableViewCell", for: indexPath) as! RadioTypeFilterTableViewCell
                    cell.delegate = self
                    for i in 0...(pro?.radio_list?.count ?? 0) - 1
                    {
                        if i == 0
                        {
                           // cell.noView.isHidden = true
                            cell.yesImg.image = UIImage(named: "unselected")
                            if pro?.radio_list?[i].is_selected ?? false
                            {
                                cell.yesImg.image = UIImage(named: "selected")
                            }
                            cell.yeslbl.text = pro?.radio_list?[i].key ?? ""
                        }
                        else
                        {
                           // cell.noView.isHidden = false
                            cell.noLbl.text = pro?.radio_list?[i].key ?? ""
                            cell.noclick.image = UIImage(named: "unselected")
                            if pro?.radio_list?[i].is_selected ?? false
                            {
                                cell.noclick.image = UIImage(named: "selected")
                            }
                        }
                        
                        
                        
                    }
                    
                    if (pro?.filter_code ?? "") == "DISCOUNT"
                    {
                        cell.lbl.text = "Discount Applicable".localized
                        
                        
                    }
                    
                    
                    if (pro?.filter_code ?? "") == "DROP_SHIPPING"
                    {
                        
                        cell.lbl.text = "Dropshipping Applicable".localized
                        
                        
                        
                    }
                    
                    return cell
                }
                
                
            }
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTabView {
            selectedRow = indexPath.row
            minRangeVal = ""
            maxRangeVal = ""
            
            leftTabView.reloadData()
            rightTabView.reloadData()
            if isFilterType == "dataSell"{
                if isFilterType == "dataSell"
                {
                    dalasellinglist_API()
                }
            }
//            else if isFilterType == "BranchFilter"{
//                self.BranchListApi()
//            }
//            else if isFilterType == "orderFilter"{
//                self.OrderFilterApi()
//            }
            else{
                //                self.productListAPI()
            }
            
        }
            
            
            
            
            
            
            
        else {
            let pro = self.data_bank_list?.data?.filters?[selectedRow]
            if isFilterType == "dataSell"
            {
                
                if  pro?.view_type ?? "" == "CHECKBOX"
                {
                    if  self.pro.datapricesell.contains((pro?.checkbox_item?[indexPath.row].value)!)
                    {
                        self.pro.datapricesell.remove((pro?.checkbox_item?[indexPath.row].value)!)
                        
                    }
                    else{
                        self.pro.datapricesell.add((pro?.checkbox_item?[indexPath.row].value)!)
                    }
                }
                if  pro?.view_type ?? "" == "RADIO"
                {
                    if self.pro.statussell.count > 0
                    {
                        self.pro.statussell = ""
                    }
                    else
                    {
                        self.pro.statussell = "\((pro?.radio_list?[indexPath.row].value)!)"
                    }
                    
                }
                if  pro?.view_type ?? "" == "COMPLEX_RADIO"{
                    if iscategory
                    {
                        self.pro.cataIdsell.removeAll()
                    }
                    iscategory = false
                    if self.pro.cataIdsell == ""
                    {
                        selectedRow1 = indexPath.row
                        self.pro.cataIdsell.removeAll()
                        self.pro.cataIdsell.append("\((pro?.complex_radio_list?[indexPath.row].value)!)")
                    }
                    else{
                        
                        if indexPath.row == 0
                        {
                            if self.pro.cataIdsell.contains("\((pro?.complex_radio_list?[indexPath.row].value)!)")
                            {
                                self.pro.cataIdsell.removeAll()
                            }
                            else
                            {
                                self.pro.cataIdsell.append("\((pro?.complex_radio_list?[indexPath.row].value)!)")
                            }
                        }
                        else{
                            
                            if self.pro.subcataIdsell.contains("\((pro?.complex_radio_list?[selectedRow1].value_list?[indexPath.row - 1].value)!)")
                            {
                                self.pro.subcataIdsell.removeAll()
                            }
                            else
                            {
                                self.pro.subcataIdsell.append("\((pro?.complex_radio_list?[indexPath.row].value)!)")
                            }
                        }
                        
                    }
                    
                    
                }
                dalasellinglist_API()
            }
            else if isFilterType == "orderFilter"
            {
                let pro = orderFilter?.data?.filter_list?[selectedRow]
                if  pro?.extra_value ?? "" == "MULTICHECKBOX"{
                    if (pro?.code)! == "STATUS"{
                        if  self.pro.statusOrder.contains((pro?.child?[indexPath.row].value)!)
                        {
                            self.pro.statusOrder.remove((pro?.child?[indexPath.row].value)!)
                        }
                        else{
                            self.pro.statusOrder.add((pro?.child?[indexPath.row].value)!)
                        }
                        
                    }
                }
            }
                
                
            else if isFilterType == "BranchFilter"
                
                
            {
                
                let pro = new_branch_list?.data?.filters?[selectedRow]
                
                if  pro?.view_type ?? "" == "MULTICHECKBOX"
                {
                    if (pro?.filter_code)! == "ACTIVATION"
                    {
                        if  self.pro.activatebranchIndex.contains((pro?.checkbox_item?[indexPath.row].id)!)
                        {
                            self.pro.activatebranchIndex.remove((pro?.checkbox_item?[indexPath.row].id)!)
                            
                        }
                        else{
                            self.pro.activatebranchIndex.add((pro?.checkbox_item?[indexPath.row].id)!)
                        }
                    }
                    if (pro?.filter_code)! == "PLATFORM_TYPE"
                    {
                        if  self.pro.platformIndex.contains((pro?.checkbox_item?[indexPath.row].id)!)
                        {
                            self.pro.platformIndex.remove((pro?.checkbox_item?[indexPath.row].id)!)
                            
                        }
                        else{
                            self.pro.platformIndex.add((pro?.checkbox_item?[indexPath.row].id)!)
                        }
                    }
                    if (pro?.filter_code)! == "BUSINESS_TYPE"
                    {
                        if  self.pro.busstypeIndex.contains((pro?.checkbox_item?[indexPath.row].id)!)
                        {
                            self.pro.busstypeIndex.remove((pro?.checkbox_item?[indexPath.row].id)!)
                            
                        }
                        else{
                            self.pro.busstypeIndex.add((pro?.checkbox_item?[indexPath.row].id)!)
                        }
                    }
                    
                }
                
                
            }
                
            else  {
                
                let pro = product_new_list?.data?.filters?[selectedRow]
                
                if  pro?.view_type ?? "" == "COMPLEXMULTICHECKBOX"
                {
                    if (pro?.filter_code)! == "PAYMENT_MODE"
                    {
                        
                        if  self.pro.paymentMode.contains((pro?.complexcheckbox_item?[indexPath.section].list?[indexPath.row].id)!)
                        {
                            self.pro.paymentMode.remove((pro?.complexcheckbox_item?[indexPath.section].list?[indexPath.row].id)!)
                            
                        }
                        else{
                            self.pro.paymentMode.add((pro?.complexcheckbox_item?[indexPath.section].list?[indexPath.row].id)!)
                        }
                        //  self.pro.paymentId = "\()"
                    }
                }
                
                if  pro?.view_type ?? "" == "MULTICHECKBOX"
                {
                    if (pro?.filter_code)! == "ACTIVATION"
                    {
                        if  self.pro.activateIndex.contains((pro?.checkbox_item?[indexPath.row].id)!)
                        {
                            self.pro.activateIndex.remove((pro?.checkbox_item?[indexPath.row].id)!)
                            
                        }
                        else{
                            self.pro.activateIndex.add((pro?.checkbox_item?[indexPath.row].id)!)
                        }
                    }
                    if (pro?.filter_code ?? "")! == "AVAILABILITY"
                    {
                        if  self.pro.availIndex.contains((pro?.checkbox_item?[indexPath.row].id)!)
                        {
                            self.pro.availIndex.remove((pro?.checkbox_item?[indexPath.row].id)!)
                            
                        }
                        else{
                            self.pro.availIndex.add((pro?.checkbox_item?[indexPath.row].id)!)
                        }
                    }
                    if (pro?.filter_code ?? "") == "BRANDS"
                    {
                        if  self.pro.brandIndex.contains((pro?.checkbox_item?[indexPath.row].filter_brand_id)!)
                        {
                            
                            self.pro.brandIndex.remove((pro?.checkbox_item?[indexPath.row].filter_brand_id)!)
                            
                        }
                        else{
                            self.pro.brandIndex.add((pro?.checkbox_item?[indexPath.row].filter_brand_id)!)
                        }
                    }
                    if (pro?.filter_code)! == "CURRENCY"
                    {
                        if  self.pro.currencyIndex.contains((pro?.checkbox_item?[indexPath.row].id)!)
                        {
                            self.pro.currencyIndex.remove((pro?.checkbox_item?[indexPath.row].id)!)
                            
                        }
                        else{
                            self.pro.currencyIndex.add((pro?.checkbox_item?[indexPath.row].id)!)
                        }
                    }
                }
                
                if pro?.view_type == "CATEGORYRADIO"{
                    if iscategory
                    {
                        self.pro.cataId.removeAll()
                        self.pro.cataIdname.removeAll()
                    }
                    iscategory = false
                    if self.pro.cataId == ""
                    {
                        selectedRow1 = indexPath.row
                        self.pro.subcataIdName.removeAll()
                        self.pro.subcataId.removeAll()
                        self.pro.cataId.removeAll()
                        self.pro.cataIdname.removeAll();
                        self.pro.cataIdname.append("\((pro?.cat_radio_list?[indexPath.row].name)!)")
                        self.pro.cataId.append("\((pro?.cat_radio_list?[indexPath.row].filter_cat_id)!)")
                    }
                    else{
                        
                        if indexPath.row == 0
                        {
                            if self.pro.cataId.contains("\((pro?.cat_radio_list?[indexPath.row].filter_cat_id)!)")
                            {
                                self.pro.subcataIdName.removeAll()
                                self.pro.subcataId.removeAll()
                                self.pro.cataIdname.removeAll()
                                self.pro.cataId.removeAll()
                            }
                            else
                            {
                                self.pro.subcataIdName.removeAll()
                                self.pro.subcataId.removeAll()
                                self.pro.cataId.append("\((pro?.cat_radio_list?[indexPath.row].filter_cat_id)!)")
                                self.pro.cataIdname.append("\((pro?.cat_radio_list?[indexPath.row].name)!)")
                            }
                        }
                        else{
                            if self.pro.subcataId.contains("\((pro?.cat_radio_list?[selectedRow1].sub_cat_list?[indexPath.row - 1].filter_sub_cat_id)!)")
                            {
                                self.pro.subcataIdName.removeAll()
                                self.pro.subcataId.removeAll()
                            }
                            else
                            {
                                self.pro.subcataId.append("\((pro?.cat_radio_list?[selectedRow1].sub_cat_list?[indexPath.row - 1].filter_sub_cat_id)!)")
                                self.pro.subcataIdName.append("\((pro?.cat_radio_list?[selectedRow1].sub_cat_list?[indexPath.row - 1].name)!)")
                            }
                        }
                        
                    }
                    
                    
                }
                
                
                
                
                if  checkedRow.contains(indexPath.row)
                {
                    checkedRow.remove(indexPath.row)
                    
                }
                    
                else{
                    
                    checkedRow.add(indexPath.row)
                }
                if pro?.view_type == "RADIO"
                {
                    return
                }
                self.productListAPI()
            }
            leftTabView.reloadData()
            rightTabView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == leftTabView {
            return 50
        }
            
        else  {
            
            return UITableView.automaticDimension
            
        }
        
        
        
    }
    @objc func clickCross()
    {
        iscategory = true
        rightTabView.reloadData()
    }
}
extension ListingCommonFilterViewController: RadioTypeFilterTableViewCellDelegate,DateRangeFilterTableViewCellDelegate{
    func startDateTimeStamp(_ sender: Any, strtDtTimeStamp: String) {
        fromDateTimeStamp = strtDtTimeStamp
        leftTabView.reloadData()
    }
    
    func endDateTimeStamp(_ sender: Any, endDtTimeStamp: String) {
         toDateTimeStamp = endDtTimeStamp
               leftTabView.reloadData()
    }
    
    
    
    func yesClicked(tag: Int,btn:UIButton) {
        
        if btn.isSelected
        {
            
            let pro = product_new_list?.data?.filters?[selectedRow]
            
            
            if (pro?.filter_code)! == "DISCOUNT"
            {
                self.pro.discountId = "\((pro?.radio_list?[tag].value)!)"
            }
            if (pro?.filter_code)! == "DROP_SHIPPING"
            {
                self.pro.dropshipingId = "\((pro?.radio_list?[tag].value)!)"
            }
            
        }
        else
        {
            
            let pro = product_new_list?.data?.filters?[selectedRow]
            
            if (pro?.filter_code)! == "DISCOUNT"
            {
                self.pro.discountId = ""
            }
            if (pro?.filter_code)! == "DROP_SHIPPING"
            {
                self.pro.dropshipingId = ""
            }
        }
        productListAPI()
    }
    
    func noClicked(tag: Int,btn:UIButton) {
        
        if btn.isSelected
        {
            
            let pro = product_new_list?.data?.filters?[selectedRow]
            
            
            if (pro?.filter_code)! == "DISCOUNT"
            {
                self.pro.discountId = "\((pro?.radio_list?[tag].value)!)"
            }
            if (pro?.filter_code)! == "DROP_SHIPPING"
            {
                self.pro.dropshipingId = "\((pro?.radio_list?[tag].value)!)"
            }
            
            
            
            
        }
        else
        {
            
            
            let pro = product_new_list?.data?.filters?[selectedRow]
            
            
            if (pro?.filter_code)! == "DISCOUNT"
            {
                self.pro.discountId = ""
            }
            if (pro?.filter_code)! == "DROP_SHIPPING"
            {
                self.pro.dropshipingId = ""
            }
        }
        
        productListAPI()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        // ModalClass.stopLoadingAllLoaders(self.view)
    }
    
    
}

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd/MM/YYYY"
        
        return dateFormatter.string(from: date)
    }
}
