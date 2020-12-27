//
//  BranchListNewViewController.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 13/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import PopupDialog
import MTPopup
import BarcodeScanner
class BranchListNewViewController: UIViewController {
    
    @IBOutlet weak var topHeightConst: NSLayoutConstraint!
    @IBOutlet weak var tabView: UITableView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var headerVw: NavigationView!
    @IBOutlet weak var qrCode: UIButton!
    @IBOutlet weak var search: UIButton!
    var branchmodel = branchsmodel()
    var new_branch_list : NewBranchList?
    var textSTR = ""
     var showImageList:ShowImageList?
    var filterArray : [New_Branch_list]?
    var filterArray1 : [New_Branch_list]?
    var sortType = ""
    var sortVal = ""
    var chooseIndex = 9999
    @IBOutlet weak var backgroundBg: UIImageView!

    var pageNo = 0
    var isMoreData = true
    
    var isFromSort = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabView.delegate = self
        self.tabView.dataSource = self
        self.topHeightConst.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerVw.titleHeader.isHidden = true
        self.headerVw.menuBtn.isHidden = false
        self.headerVw.fynooLogoImage.isHidden = false
        self.headerVw.viewControl = self
        // remove filter
        ProductModel.shared.remove()


        //        let image =  ModalController.rotateImagesOnLanguageMethod(img: UIImage(named: "back_new")!)
        //              backBtn.setImage(image, for: .normal)
//        tabView.allowsSelectionDuringEditing = false
        backgroundBg.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        tabView.separatorStyle = .none
        tabView.register(UINib(nibName: "BranchListStateTableViewCell", bundle: nil), forCellReuseIdentifier: "BranchListStateTableViewCell")
        tabView.register(UINib(nibName: "BranchListNewTableViewCell", bundle: nil), forCellReuseIdentifier: "BranchListNewTableViewCell")
         tabView.register(UINib(nibName: "ProductListTopTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTopTableViewCell")
        tabView.register(UINib(nibName: "spacingTableViewCell", bundle: nil), forCellReuseIdentifier: "spacingTableViewCell")
        
        
//        txtField.addTarget(self, action: #selector(BranchListNewViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
//
        self.tabView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         ModalClass.stopLoadingAllLoaders(self.view)
    }
    
    func BranchListAPI()
    {
        if pageNo == 0 {
        ModalClass.startLoading(self.view)
        }
        branchmodel.sortType = sortType
        branchmodel.sortValue = sortVal
        branchmodel.searchTxt = textSTR
        branchmodel.pageNo = pageNo
        branchmodel.getBranchList { (success, response) in
            if success {
                ModalClass.stopLoadingAllLoaders(self.view)
                self.new_branch_list = response
                
                self.tabView.delegate = self
                self.tabView.dataSource = self
                
                if self.filterArray?.count == nil {
                    self.filterArray = self.new_branch_list?.data?.branch_list
                }
                else if self.pageNo == 0  {
                    self.filterArray = self.new_branch_list?.data?.branch_list
                }
                else{
                    if self.new_branch_list?.data!.branch_list!.count != 0 {
                    self.filterArray = self.filterArray! + (self.new_branch_list?.data!.branch_list)!
                    }
                }
                
                if self.new_branch_list?.data!.branch_list!.count == 0 {
                    self.isMoreData = false
                }else{
                    self.isMoreData = true
                    self.pageNo = self.pageNo + 1
                }
                
                self.tabView.reloadData()
                print(response!)
                
                
            }
        }
    }
    func deleteAllImage()
    {
        var mediaId = ""
        if AddBranch.shared.showImgId.count > 0
        {
            
            for item in AddBranch.shared.showImgId{
                mediaId = "\(item),\(mediaId)"
            }
            mediaId.removeLast()
        }
        branchmodel.mediaId = mediaId
        print("media id \(mediaId)")
        branchmodel.deleteImg { (success, response) in
            ModalClass.stopLoading()
            if success
            {
                print("deleted")
                
            }
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if AddBranch.shared.BranchId == ""
        {
          if AddBranch.shared.showImgId.count > 0
                {
                    self.deleteAllImage()
                }
            }
        
        if isFromSort {
            isFromSort = false
            return
        }
        
        pageNo = 0
        isMoreData = true
         self.BranchListAPI()
    
          
  

    }
   
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
       
        if let textStr = textField.text {
                        textSTR = textStr
            if textStr.count == 0{
                pageNo = 0
                isMoreData = true
                BranchListAPI()
            }
//
            

//            UITableView.performWithoutAnimation {
//                 tabView.reloadSections(IndexSet(integer: 2), with: .none)
            
           
        }
    }
    
    @IBAction func qrcodeclick(_ sender: Any) {
        let vc = QRCOdeViewController(nibName: "QRCOdeViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func searchClick(_ sender: Any) {
      print("searchClick")
    }
 
}
extension BranchListNewViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1{
            return 1
        }
        else {
            if textSTR.count > 0
            {
           //     return filterArray?.count ?? 0
                
                if ((filterArray?.count) != nil) {
                    if isMoreData {
                        return filterArray!.count + 1
                    }else{
                    return filterArray!.count
                    }
                }else{
                    return 0
                }
            }
            else{
           //     return new_branch_list?.data?.branch_list?.count ?? 0
               if ((filterArray?.count) != nil) {
                    if isMoreData {
                        return filterArray!.count + 1
                    }else{
                    return filterArray!.count
                    }
                }else{
                    return 0
                }
                    
                }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0{
            let cell = tabView.dequeueReusableCell(withIdentifier: "ProductListTopTableViewCell", for: indexPath) as! ProductListTopTableViewCell
            cell.sorting.addTarget(self, action: #selector(sortingClicked), for: .touchUpInside)
            cell.headingLbl.text = "Manage Branches".localized
            cell.headerImg.image = #imageLiteral(resourceName: "branch_new")
            cell.widthconst.constant = 35
            cell.barcodeBtn.isHidden = false
            cell.txtField.addTarget(self, action: #selector(BranchListNewViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            cell.delegate = self
            cell.selectionStyle = .none
            
            return cell
        }
        if indexPath.section == 1{
            let cell = tabView.dequeueReusableCell(withIdentifier: "BranchListStateTableViewCell", for: indexPath) as! BranchListStateTableViewCell
            
            let list = new_branch_list?.data
            cell.activeBranchLbl.text = "\(list?.active_branches ?? 0)".localized
            cell.inactiveBranchLbl.text = "\(list?.inactive_branches ?? 0)".localized
            if list?.branch_limit == "UTD" {
                cell.subscriptionBranches.text =  "UNLIMITED".localized
            }
             else {
                cell.subscriptionBranches.text =  list?.branch_limit?.localized
            }
            cell.delegate = self
            cell.selectionStyle = .none
            
            return cell
        }
        else {
            if textSTR.count > 0
                   {
                       filterArray1 = filterArray
                   }
                   else{
               //        filterArray1 = new_branch_list?.data?.branch_list
                filterArray1 = filterArray
                   }
            
            if indexPath.row == self.filterArray1!.count {
                
            let cell = tabView.dequeueReusableCell(withIdentifier: "spacingTableViewCell", for: indexPath) as! spacingTableViewCell
                
//                let spinner = UIActivityIndicatorView(style: .gray)
//                spinner.startAnimating()
//                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

      //          cell.contentView.addSubview(spinner)
                    
                if isMoreData {
                  self.BranchListAPI()
                }
                    
                
                return cell
                
            }
            
            let cell = tabView.dequeueReusableCell(withIdentifier: "BranchListNewTableViewCell", for: indexPath) as! BranchListNewTableViewCell
            cell.delegate = self
            let branchList = filterArray1
            cell.setCellData(list: branchList , indexPath: indexPath.row)
//            cell.switchBtn.tag = indexPath.row
//
//            cell.switchBtn.isOn = filterArray1?[indexPath.row].is_branch_active == 0 ? false : true
//            cell.switchBtn.addTarget(self, action: #selector(switchBtn(_:)), for: .touchUpInside)
            
            cell.switchNewOutlet.tag = indexPath.row
            
            if filterArray1?[indexPath.row].is_branch_active == 0 {
                cell.switchNewOutlet.isSelected = false
            }else{
                cell.switchNewOutlet.isSelected = true
            }
     //       cell.switchNewOutlet.isOn = filterArray1?[indexPath.row].is_branch_active == 0 ? false : true
            cell.switchNewOutlet.addTarget(self, action: #selector(switchBtnNEw), for: .touchUpInside)
            
            
            
            
            cell.tag = indexPath.row
            cell.shareBtn.tag = indexPath.row
            cell.shareBtn.addTarget(self, action: #selector(shareClick(_:)), for: .touchUpInside)
       
              
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if  indexPath.section == 0 {
            return 115
        }
            if  indexPath.section == 1 {
                return 85
            }
        else {
          
      
                 return 95
          
           
        }
        
    }
    func StatusChange_API(tag:Int,status:Bool)
    {
      //  branchmodel.branchid = "\(new_branch_list?.data?.branch_list?[tag].id ?? 0)"
        branchmodel.branchid = "\(filterArray![tag].id ?? 0)"
        branchmodel.status = (status == false ? "1":"0")
        branchmodel.specialbranch = ""
        if new_branch_list?.data?.branch_limit ?? "" == "1"
        {
         branchmodel.specialbranch = "1"
        }
        branchmodel.statusChange { (success, response) in
                          if success {
                            let val = response!
                            if val.value(forKey: "error_code") as! Int == 200
                            {

                                ModalController.showSuccessCustomAlertWith(title:val.value(forKey: "error_description") as! String, msg: "")
                                self.pageNo = 0
                                self.isMoreData = true
                                self.BranchListAPI()
                            }
                             else
                            {

                                ModalController.showNegativeCustomAlertWith(title:val.value(forKey: "error_description") as! String, msg: "")
                            }
                          }
                      }
    }
    
    @objc func sortingClicked(){
        let vc = CommonSortingPopupViewController(nibName: "CommonSortingPopupViewController", bundle: nil)
           vc.delegate = self
        vc.isFilterTypeFrom = "Branch"
        vc.selectedIndex = chooseIndex
        
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
    
    @objc  func switchBtnNEw(_ sender: UIButton) {
        if new_branch_list?.data?.branch_limit ?? "" == "1"
                   {
                    let vc = DeliveryPopupViewController(nibName: "DeliveryPopupViewController", bundle: nil)
                    
                        vc.activateHandler = { result in
                            if result == "true"{
                                self.StatusChange_API(tag:sender.tag,status:sender.isSelected)
                            }else{
                              //  self.tabView.reloadRows(at: [IndexPath(row: sender.tag, section: 1)], with: .none)
                            }
                        }
                        vc.modalPresentationStyle = .overFullScreen
                        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                        self.present(vc, animated: true, completion: nil)
                        tabView.reloadData()
              }
             else
             {
             let vc = ActivateBranchPopUpView(nibName: "ActivateBranchPopUpView", bundle: nil)
             
        
             vc.status = (filterArray1?[sender.tag].is_branch_active)!
             vc.activateHandler = { result in
                 if result == "true"{
                     self.StatusChange_API(tag:sender.tag,status:sender.isSelected)
                 }else{
                   //  self.tabView.reloadRows(at: [IndexPath(row: sender.tag, section: 1)], with: .none)
                 }
             }
             vc.modalPresentationStyle = .overFullScreen
             vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
             self.present(vc, animated: true, completion: nil)
             tabView.reloadData()
             }
    }
    
    @objc func switchBtn(_ sender:UISwitch)
    {
        if new_branch_list?.data?.branch_limit ?? "" == "1"
              {
                let vc = DeliveryPopupViewController(nibName: "DeliveryPopupViewController", bundle: nil)
                   
                       vc.activateHandler = { result in
                           if result == "true"{
                               self.StatusChange_API(tag:sender.tag,status:sender.isOn)
                           }else{
                             //  self.tabView.reloadRows(at: [IndexPath(row: sender.tag, section: 1)], with: .none)
                           }
                       }
                       vc.modalPresentationStyle = .overFullScreen
                       vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                       self.present(vc, animated: true, completion: nil)
                       tabView.reloadData()
         }
        else
        {
        let vc = ActivateBranchPopUpView(nibName: "ActivateBranchPopUpView", bundle: nil)
        
   
        vc.status = (filterArray1?[sender.tag].is_branch_active)!
        vc.activateHandler = { result in
            if result == "true"{
                self.StatusChange_API(tag:sender.tag,status:sender.isOn)
            }else{
              //  self.tabView.reloadRows(at: [IndexPath(row: sender.tag, section: 1)], with: .none)
            }
        }
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.present(vc, animated: true, completion: nil)
        tabView.reloadData()
        }
    }
    

    @available(iOS 11.0, *)

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.section == 2 {
            let action =  UIContextualAction(style: .normal, title: "", handler: { (action,view,completionHandler ) in
                //do stuff
        
                let vc = DeleteBranchPopupViewController(nibName: "DeleteBranchPopupViewController", bundle: nil)
                vc.modalPresentationStyle = .overFullScreen
                vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                 vc.isMain = (self.filterArray1?[indexPath.row].is_main_branch)!
                vc.pro_count = self.filterArray1?[indexPath.row].total_products ?? 0
                vc.branchId = "\(self.filterArray1?[indexPath.row].id ?? 0)"
                vc.delegate = self
                self.present(vc, animated: true, completion: nil)
                completionHandler(true)
            })
            
            action.image = UIImage(named: "delete1")

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
        if indexPath.section == 2 {
        let vc = BranchDetailNewViewController(nibName: "BranchDetailNewViewController", bundle: nil)
               vc.shareUrl = "\(self.filterArray1?[indexPath.row].branch_web_share_url ?? "")"
                    vc.brid = "\(self.filterArray1?[indexPath.row].id ?? 0)"
                   vc.lat = self.filterArray1?[indexPath.row].lat ?? 0.0
                   vc.long = self.filterArray1?[indexPath.row].long ?? 0.0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension BranchListNewViewController: BranchListStateTableViewCellDelegate,BranchListNewTableViewCellDelegate,DeleteBranchPopupViewControllerDelegate,ProductListTopTableViewCellDelegate,CommonSortingPopupViewControllerDelegate,QRCOdeViewControllerDelegate{
    func QRCodeScanner(str: String) {
      
        if ModalController.verifyUrl(urlString: str)
        {
            if str.contains("type")
            {
                let url = URL(string:str)!
                let id = url["type"]!.split(separator: "-")
                branchmodel.contentid = String(id[1])
                branchmodel.contenttype = "BRANCH"
                       ModalClass.startLoading(self.view)
                       branchmodel.getnameapi { (success, response) in
                                  if success {
                                      ModalClass.stopLoading()
                                   let rep:NSDictionary = response?.value(forKey: "data") as! NSDictionary
                                   self.textSTR = rep.value(forKey: "keyword") as! String
                                  }
                              }
            }
            else{
         self.textSTR = str
            }
        }
            else{
                self.textSTR = str
            }
        }
        
    
   
    func sorting(type: String, index: Int) {
        isFromSort = true
        
        if type == "A to Z"{
                   self.sortVal = "ASC"
                   self.sortType = "alpha"
                   chooseIndex = index
            pageNo = 0
            isMoreData = true
                   self.BranchListAPI()
                   
               }else if type == "Z to A"{
                   self.sortVal = "DESC"
                   self.sortType = "alpha"
                   chooseIndex = index
            pageNo = 0
            isMoreData = true
                     self.BranchListAPI()
                   
               }
               else if type == "Highest to Lowest Price"{
                   self.sortVal = "DESC"
                   self.sortType = "price"
                   chooseIndex = index
            pageNo = 0
            isMoreData = true
                     self.BranchListAPI()
                   
               }
               else if type == "Lowest to Highest Price"{
                   self.sortVal = "ASC"
                   self.sortType = "price"
                   chooseIndex = index
            pageNo = 0
            isMoreData = true
                    self.BranchListAPI()
                   
               }
    }
    
    func clearAll() {
        isFromSort = true
        
         self.chooseIndex = 9999
        sortType = ""
               sortVal = ""
        pageNo = 0
        isMoreData = true
        self.BranchListAPI()
    }
    
    func barcodeOpen(tag: Int) {
    let controller = BarcodeScannerViewController()
         controller.codeDelegate = self
                  controller.errorDelegate = self
                  controller.dismissalDelegate = self
       present(controller, animated: true, completion: nil)
    }
    
    func qrcodeOpen(tag: Int) {
        let vc = QRCOdeViewController(nibName: "QRCOdeViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func search(tag: Int) {
         print("")
        
        branchmodel.searchTxt = textSTR
        pageNo = 0
        isMoreData = true
        BranchListAPI()
        
        
    }
    
    func filter(tag: Int) {
         let vc = ListingCommonFilterViewController(nibName: "ListingCommonFilterViewController", bundle: nil)
        vc.sortType = sortType
        vc.sortVal = sortVal
        vc.searchTxt = textSTR
         vc.isFilterType = "BranchFilter"
       vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func branchAdd(tag: Int) {
     AddBranch.shared.removeall()
                 let vc = CreateBranchFirstStepViewController(nibName: "CreateBranchFirstStepViewController", bundle: nil)
        vc.isSubcription = self.new_branch_list?.data?.is_subscription ?? false
        vc.branchlimit = "\(self.new_branch_list?.data?.branch_limit ?? "0")"
         vc.isActive = self.filterArray1?[tag].is_branch_active ?? 0
        vc.branchCount = self.filterArray1?.count ?? 0
        
                 self.navigationController?.pushViewController(vc, animated: true)
        
        
     
    }
    
    func editClick(tag: Int) {
         AddBranch.shared.removeall()
        branchmodel.branchid = "\(self.filterArray1?[tag].id ?? 0)"
            ModalClass.startLoading(self.view)
              branchmodel.branchDetail { (success, response) in
                  if success {
            ModalClass.stopLoading()
                let vc = CreateBranchFirstStepViewController(nibName: "CreateBranchFirstStepViewController", bundle: nil)
                     vc.branchlimit = "\(self.new_branch_list?.data?.branch_limit ?? "0")"
             vc.branchCount = self.filterArray1?.count ?? 0
                    vc.isActive = self.filterArray1?[tag].is_branch_active ?? 0
                     vc.isSubcription = self.new_branch_list?.data?.is_subscription ?? false
            self.navigationController?.pushViewController(vc, animated: true)
                  }
              }
     
    }
    
    func qrcode(tag: Int) {
        print("open QR Code")
        
        let vc = BranchQrCodePopupViewController(nibName: "BranchQrCodePopupViewController", bundle: nil)
        let str = filterArray1?[tag].branch_qr
        vc.url = str!
     
        let strPAss = filterArray1?[tag].branch_web_share_url
        vc.urlPass = strPAss!
        vc.isFromBranch = "yes"
        
        
        let popup = PopupDialog(viewController: vc,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        self.present(popup, animated: true, completion: nil)
        
    }
    
    @objc  func shareClick(_ sender: UIButton) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let business_id = self.filterArray1?[sender.tag].id ?? 0
        let branch_web_share_url = self.filterArray1?[sender.tag].branch_web_share_url
        let branch_name = self.filterArray1?[sender.tag].branch_name
        
        let textToShare = "Check out This Branch \(branch_name!), Click here to know more"
//        let url = "\(Constant.BASE_URL)customer/single_branch/" + "\(business_id)" + "/";
        let url = "\(branch_web_share_url!)"
 //       if let myWebsite = URL(string: url) {//Enter link to your app here
            
            let objectsToShare = [textToShare, url, image ??  #imageLiteral(resourceName: "dataEntryService") ] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            //
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
    //    }
    }
    func reloadPage() {
        isFromSort = true
        
        pageNo = 0
        isMoreData = true
        self.BranchListAPI()
    }
    
    
    
}

extension BranchListNewViewController: BarcodeScannerCodeDelegate,BarcodeScannerErrorDelegate,BarcodeScannerDismissalDelegate {

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
        
        isFromSort = true
        
        pageNo = 0
        isMoreData = true
        self.BranchListAPI()
        }

}
