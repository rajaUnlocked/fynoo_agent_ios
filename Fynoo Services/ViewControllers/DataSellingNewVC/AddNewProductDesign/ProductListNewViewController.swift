//
//  ProductListNewViewController.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 11/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import MTPopup
import PopupDialog
import SideMenu
import AMShimmer
import BarcodeScanner
class ProductListNewViewController: UIViewController, GlobalsearchDelegate {
    
    var isBool = true
    var isCreate = false
    var productmodel = AddProductModel()
    var isDataLoading = false
    var pageno = 0
    var filterids = ""
    var searchtxt = ""
    var product = ProductApiModel()
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var nodataView: UIView!
    @IBOutlet weak var tabView: UITableView!
    @IBOutlet weak var topheightConstraints: NSLayoutConstraint!
    var DataBankSellingModel = DataBankSellingListModel()
    var data_bank_list : DataBankSellingList?
    var dataselllist = [Product_list_data_Bank_Selling]()
    var refreshControl = UIRefreshControl()
    var textSTR = ""
    var count = 0
    //    @IBOutlet weak var headerVw: NavigationView!
    var rejectTabindex: Int = 10000
    override func viewDidLoad() {
        
        ModalController.watermark(self.view)
        super.viewDidLoad()
        ProductModel.shared.remove()
        setupUI()
        backbtn.setImage(ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"back_new")!), for: .normal)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.isHidden = true
        addUIRefreshToTable()
    }
    
    
    func setupUI(){
        
        tabView.separatorStyle = .none
        tabView.register(UINib(nibName: "ProductListDataBankSellingTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListDataBankSellingTableViewCell")
        tabView.register(UINib(nibName: "AddProductHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "AddProductHeaderTableViewCell")
        tabView.register(UINib(nibName: "NoDataFoundTableViewCell", bundle: nil), forCellReuseIdentifier: "NoDataFoundTableViewCell")
        
        
    }
    func resultscancode(search: String, content: String) {
        print(search,content)
        textSTR = search
        DataBankSellingModel.issearchfrom = content
        self.dataselllist.removeAll()
        pageno = 0
        databankSellingListAPI()
        
    }
    
    @objc func goback(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func sideMenu(_ sender: Any) {
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                
                present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
            }
            else {
                present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
            }
        }else{
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func databankSellingListAPI(){
        
        ModalClass.startLoading(self.view)
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
        AMShimmer.start(for: self.tabView)
        DataBankSellingModel.pageno = "\(pageno)"
        DataBankSellingModel.filterid = ProductModel.shared.primaryKeyss
        DataBankSellingModel.search = textSTR
        DataBankSellingModel.getDataBankSellingList { (success, response) in
            
            if success{
                ModalClass.stopLoadingAllLoaders(self.view)
                AMShimmer.stop(for: self.tabView)
                DispatchQueue.main.async {
                    
                    AMShimmer.stop(for: self.view)
                    
                }
                self.data_bank_list = response
                if self.data_bank_list?.data?.product_list?.count ?? 0 > 0
                {
                    for i in 0...((self.data_bank_list?.data?.product_list?.count ?? 0) - 1)
                    {
                        self.dataselllist.append((self.data_bank_list?.data?.product_list![i])!)
                    }
                }
                
                self.tabView.reloadData()
            }
            else {
                
                self.tabView.reloadData()
            }
            self.tabView.delegate = self
            self.tabView.dataSource = self
            
            
            if self.tabView.visibleCells.count > 0 && self.dataselllist.count != 0 {
                let cell = self.tabView.visibleCells[1] as! ProductListDataBankSellingTableViewCell
                cell.animateSwipeHint(bg: cell.backgrounddView)
            }
        }
    }
}

extension ProductListNewViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else
        {
            if isBool
            {
                return 2
            }
            return self.dataselllist.count == 0 ? 1 : self.dataselllist.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        else {
            if isBool
            {
                return 160
            }
            if self.dataselllist.count == 0 {
                return 300
            }
            else {
                return 160
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tabView.dequeueReusableCell(withIdentifier: "AddProductHeaderTableViewCell", for: indexPath) as! AddProductHeaderTableViewCell
            cell.headerLbl.text = "Manage Products".localized
            cell.headerLbl.font = UIFont(name: NSLocalizedString("LightFontName", comment: ""), size: 12)
            return cell
        }
        else {
            if isBool
            {
                let cell = tabView.dequeueReusableCell(withIdentifier: "ProductListDataBankSellingTableViewCell", for: indexPath) as! ProductListDataBankSellingTableViewCell
                return cell
            }
            if self.dataselllist.count == 0
            {
                let cell = tabView.dequeueReusableCell(withIdentifier: "NoDataFoundTableViewCell", for: indexPath) as! NoDataFoundTableViewCell
                
                let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
                cell.titleLbl.text = "No Data Found".localized
                cell.titleLbl.font =  UIFont(name:"\(fontNameBold)",size:20)
                cell.goBackTop.constant = 10
                cell.gobackBtn.isHidden = true
                cell.gobackBtn.addTarget(self, action: #selector(goback(_ :)), for: .touchUpInside)
                return cell
            }
            else{
                let cell = tabView.dequeueReusableCell(withIdentifier: "ProductListDataBankSellingTableViewCell", for: indexPath) as! ProductListDataBankSellingTableViewCell
                
                
                cell.editBtn.tag = indexPath.row
                cell.editBtn.addTarget(self, action: #selector(editClicked(_ :)), for: .touchUpInside)
                cell.btninfo.tag = indexPath.row
                cell.btninfo.addTarget(self, action: #selector(imageTapped(_ :)), for: .touchUpInside)
                
                
                let product_list = dataselllist
                cell.setCellData(productList: product_list, index: indexPath.row, selectedIndex: rejectTabindex)
                
                return cell
            }
        }
    }
    
    @objc func imageTapped(_ sender :UIButton)
    {
        //        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(sender.tag)
        let indexpath = IndexPath(row: sender.tag, section: 2)
        let data = dataselllist[sender.tag].pro_reject_desc
        print(data)
        rejectTabindex = sender.tag
        //        self.tabView.reloadData()
        
        self.view.showToast(toastMessage: "  \((dataselllist[sender.tag].pro_reject_desc) ?? "")  ", duration: 1.1)
        
        //        let alert = UIAlertController(title: "Subscribed!", message: "\(data ?? "")", preferredStyle: .alert)
        //          let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        //          alert.addAction(okAction)
        //
        //          self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    @objc private func textFieldDidChange(_ textField: UITextField)
    {
        textField.textAlignment =  ("\(textField.text!.first)".isArabic ? .right:.left)
        textSTR = textField.text!
        if textField.text == "" {
            pageno = 0
            dataselllist.removeAll()
            databankSellingListAPI()
            
        }
        
        
    }
    @objc func editClicked(_ sender :UIButton) {
        
        
        
        if (dataselllist[sender.tag].pro_status)! == 4
        {
            ProductModel.shared.remove()
            ModalClass.startLoading(self.view)
            productmodel.proid = "\(dataselllist[sender.tag].pro_id ?? 0)"
            productmodel.databankDetails { (success, response) in
                ModalClass.stopLoading()
                
                if success {
                    
                    let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                    vc.isDataBank = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        else{
            let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
            vc.delegate = self
            vc.isproductlist = true
            
            vc.isVarient = (dataselllist[sender.tag].is_variant_available)!
            vc.index = sender.tag
            let popupController = MTPopupController(rootViewController: vc)
            popupController.autoAdjustKeyboardEvent = false
            popupController.backgroundView?.backgroundColor = .clear
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = ProductListHeader()
            view.searchTxtField.text = textSTR
            view.searchTxtField.textAlignment = .left
            if HeaderHeightSingleton.shared.LanguageSelected == "AR"
            {
                view.searchTxtField.textAlignment = .right
            }
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            view.searchTxtField.font =  UIFont(name:"\(fontNameLight)",size:12)
            view.soldData.font =  UIFont(name:"\(fontNameLight)",size:12)
            view.totalEarning.font =  UIFont(name:"\(fontNameLight)",size:12)
            view.draftData.font =  UIFont(name:"\(fontNameLight)",size:12)
            view.addproductlbl.font =  UIFont(name:"\(fontNameLight)",size:6)
            view.searchTxtField.placeholder = "Search".localized
            view.addproductlbl.text = "Add Products Data".localized
            view.draftData.text = "\("\("Total Draft Data".localized)             ")\(data_bank_list?.data?.total_draft ?? 0)"
            view.soldData.text = "\("\("Total Sold Data".localized)              ")\(data_bank_list?.data?.total_sold ?? 0)"
            view.totalEarning.text = "\("\("Total Earning".localized)                  ")\("SAR") \(data_bank_list?.data?.total_earning ?? 0)"
            view.filtercount.isHidden = true
            if ProductModel.shared.salecount > 0
            {
                view.filtercount.isHidden = false
                view.filtercount.text = "\(ProductModel.shared.salecount)"
            }
            
            view.filter.addTarget(self, action: #selector(filterClicked), for: .touchUpInside)
            view.scanBtn.addTarget(self, action: #selector(scanClicked(_:)), for: .touchUpInside)
            view.add.addTarget(self, action: #selector(addProductClicked), for: .touchUpInside)
            view.searchbtn.addTarget(self, action: #selector(searchclicked), for: .touchUpInside)
            view.searchTxtField.addTarget(self, action: #selector(ProductListNewViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            return view
        }
        
        return UIView()
        
    }
    func addUIRefreshToTable() {
        refreshControl = UIRefreshControl()
        tabView.addSubview(refreshControl)
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }
    
    @objc func refreshTable() {
        if self.data_bank_list!.error! {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }else{
            self.dataselllist.removeAll()
            pageno = 0
            databankSellingListAPI()
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isDataLoading = false
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if Double(self.data_bank_list?.data?.total_records ?? 0) / Double(self.data_bank_list?.data?.page_limit ?? 0) > Double(pageno) + 1.0
        {
            if ((tabView.contentOffset.y + tabView.frame.size.height) >= tabView.contentSize.height)
            {
                if !isDataLoading{
                    
                    isDataLoading = true
                    self.pageno=self.pageno + 1
                    self.databankSellingListAPI()
                    
                }
                
            }
        }
        
    }
    @objc func filterClicked() {
        if self.dataselllist.count == 0
        {
            ModalController.showNegativeCustomAlertWith(title: "filter not applicable because your list is blank", msg: "")
            return
        }
        let vc = ListingCommonFilterViewController(nibName: "ListingCommonFilterViewController", bundle: nil)
        vc.isFilterType = "dataSell"
        //vc.filterlist = self.data_bank_list?.data?.filters
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func scanClicked(_ sender:Globalsearch) {
        sender.delegate = self
        sender.scanqrcode(self)
    }
    @objc func searchclicked()
    {
        pageno = 0
        self.dataselllist.removeAll()
        self.databankSellingListAPI()
    }
    @objc func addProductClicked() {
        ProductModel.shared.remove()
        let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
        vc.isDataBank = true
        self.navigationController?.pushViewController(vc, animated: true)
        //        let controller = BarcodeScannerViewController()
        //       controller.headerViewController.titleLabel.text = "Scan"
        //        controller.headerViewController.closeButton.setTitle("Close", for: .normal)
        //            controller.codeDelegate = self
        //            controller.errorDelegate = self
        //            controller.dismissalDelegate = self
        //             isCreate = true
        //        present(controller, animated: true, completion: nil)
        //        let vc = QRCOdeViewController(nibName: "QRCOdeViewController", bundle: nil)
        //        vc.delegate = self
        //        isCreate = true
        //        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 150
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.section == 1 {
            let action =  UIContextualAction(style: .normal, title: "", handler: { (action,view,completionHandler ) in
                //do stuff
                let vc = DeleteBranchPopupViewController(nibName: "DeleteBranchPopupViewController", bundle: nil)
                vc.isType = "PRODUCT"
                // vc.pro_status = "\(self.filterArray1?[indexPath.row].pro_final_status ?? 0)"
                vc.proId = "\(self.dataselllist[indexPath.row].pro_id ?? 0)"
                vc.delegate = self
                vc.modalPresentationStyle = .overFullScreen
                vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                self.present(vc, animated: true, completion: nil)
                completionHandler(true)
            })
            
            action.image = UIImage(named: "deleteproen")
            if HeaderHeightSingleton.shared.LanguageSelected == "AR"
            {
                action.image = UIImage(named: "deleteproar")
            }
            action.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            let configuration = UISwipeActionsConfiguration(actions: [action])
            return configuration
        }
        else {
            
            let swipeAction = UISwipeActionsConfiguration(actions: [])
            swipeAction.performsFirstActionWithFullSwipe = false // This is the line which disables full swipe
            return swipeAction
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            
            if dataselllist[indexPath.row].pro_status! != 4{
                let vc = ProductDetailNewViewController()
                vc.productID = "\((self.dataselllist[indexPath.row].pro_id)!)"
                vc.isVarient = (self.dataselllist[indexPath.row].is_variant_available)!
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        tabView.isHidden = false
        isBool = false
        pageno = 0
        self.dataselllist.removeAll()
        
        if isCreate
        {
            ProductModel.shared.remove()
            ProductModel.shared.isedit = true
            let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
            vc.isDataBank = true
            self.navigationController?.pushViewController(vc, animated: true)
            isCreate = !isCreate
            return
        }
        else{
            
        }
        self.databankSellingListAPI()
    }
    
}
extension ProductListNewViewController : BottomPopupEditProductViewControllerDelegate, DeleteBranchPopupViewControllerDelegate{
    func reloadPage() {
        pageno = 0
        dataselllist.removeAll()
        databankSellingListAPI()
        
    }
    
    func information(Value: String) {
        
    }
    
    func actionPerform(tag: Int, index: Int)
    {
        if (dataselllist[index].is_variant_available)!
        {
            if tag == 0{
                print("Edit Product")
                ProductModel.shared.remove()
                ModalClass.startLoading(self.view)
                ProductModel.shared.editproductsell = true
                productmodel.proid = "\(dataselllist[index].pro_id ?? 0)"
                productmodel.databankDetails { (success, response) in
                    ModalClass.stopLoading()
                    
                    if success {
                        
                        let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                        vc.isDataBank = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }else if tag == 1 {
                print("Varient Product")
                ProductModel.shared.remove()
                ModalClass.startLoading(self.view)
                
                productmodel.proid = "\(dataselllist[index].pro_id ?? 0)"
                productmodel.databankDetails { (success, response) in
                    ModalClass.stopLoading()
                    
                    if success {
                        
                        let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                        vc.isDataBank = true
                        vc.isVarient = true; self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            else if tag == 2{
                print("Similar Product")
                ProductModel.shared.remove()
                ModalClass.startLoading(self.view)
                
                productmodel.proid = "\(dataselllist[index].pro_id ?? 0)"
                productmodel.databankDetails { (success, response) in
                    ModalClass.stopLoading()
                    
                    if success {
                        
                        let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                        vc.isSimilar = true;
                        vc.isDataBank = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            else {
                ProductModel.shared.remove()
                ProductModel.shared.isedit = true
                let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                vc.isDataBank = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            self.dismiss(animated: true, completion: nil)
        }
        else{
            if tag == 0{
                print("Edit Product")
                ProductModel.shared.remove()
                ModalClass.startLoading(self.view)
                ProductModel.shared.editproductsell = true
                productmodel.proid = "\(dataselllist[index].pro_id ?? 0)"
                productmodel.databankDetails { (success, response) in
                    ModalClass.stopLoading()
                    
                    if success {
                        
                        let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                        vc.isDataBank = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
                
                
            }
            else if tag == 1{
                print("Similar Product")
                ProductModel.shared.remove()
                ModalClass.startLoading(self.view)
                
                productmodel.proid = "\(dataselllist[index].pro_id ?? 0)"
                productmodel.databankDetails { (success, response) in
                    ModalClass.stopLoading()
                    
                    if success {
                        
                        let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                        vc.isSimilar = true;
                        vc.isDataBank = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            else {
                ProductModel.shared.remove()
                ProductModel.shared.isedit = true
                let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                vc.isDataBank = true
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    func filterIdval(tag: Int, Value: String, id: Int) {
        
    }
    
    
}


