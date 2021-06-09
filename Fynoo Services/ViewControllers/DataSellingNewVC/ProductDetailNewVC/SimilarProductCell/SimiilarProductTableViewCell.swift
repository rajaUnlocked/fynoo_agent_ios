//
//  SimiilarProductTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 20/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import MTPopup
import AMShimmer

class SimiilarProductTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var catID = ""
    var subcatID = ""
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewAllBtn: UIButton!
    var parent = UIViewController()
    var cartmodel = CartModel()
    var similarProductList:viewProductDetailNew?
    var similarProductListCustomer:viewCustomerProductDetailNew?
    var istypeFrom = ""
    var actionType = 1
    var vw = UIViewController()
    var views = UIView()
    var favouriteClickModel: LikeAddProductWishlist?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.setupUI()
        
        self.SetFont()
    }
    
    func SetFont() {
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        
        self.headerLbl.font = UIFont(name:"\(fontNameBold)",size:12)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func viewAllClicked(_ sender: Any) {

        let vc = ViewAllSimilarProductViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.catid = catID
        vc.subcatid = subcatID
        self.parent.navigationController?.pushViewController(vc, animated: true)

    }
    func setupUI(){
        
        collectionView.register(UINib(nibName: "ProductInBranchDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductInBranchDetailCollectionViewCell")
        
        collectionView.register(UINib(nibName: "SimilarProItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SimilarProItemCollectionViewCell")
        
    }
    // MARK: - UICollectionViewMethods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1    //return number of sections in collection view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if istypeFrom == "CustomerProDetail" {
            return self.similarProductListCustomer?.data?.similar_product?.count ?? 0
        }
        else{
            return self.similarProductList?.data?.similar_product?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return proCell(index: indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        vc.isProductOnlineAvailable = (val?.pro_list?[row - 1].pro_online_available)!
//        vc.isProductStoreAvailable = (val?.pro_list?[row - 1].pro_store_available)!
//        vc.isFeature = (val?.pro_list?[row - 1].min_price_at)!
//
        if istypeFrom == "CustomerProDetail" {
            let value = self.similarProductListCustomer?.data?.similar_product![indexPath.row]
            let dict:[String: String] = ["selectedSimilarProductID": "\(value?.pro_id ?? 0)", "onlineAvailable": "\(value?.pro_online ?? 0)", "instoreAvailable": "\(value?.pro_store ?? 0)", "feature": "\(value?.min_price_at ?? "")"]
            
            NotificationCenter.default.post(name: Notification.Name("refreshSimilarProductView"), object: nil, userInfo: dict)
            
            print("productID:-","\(value?.pro_id ?? 0)" )
            
        }
        else{
            let value = self.similarProductList?.data?.similar_product![indexPath.row]
            let dict:[String: String] = ["selectedSimilarProductID": "\(value?.pro_id ?? 0)"]
            NotificationCenter.default.post(name: Notification.Name("refreshSimilarProductView"), object: nil, userInfo: dict)
            
            print("productID:-","\(value?.pro_id ?? 0)" )
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let size = CGSize(width: ((screenWidth - 30 )/2), height: 281 )
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let width = UIScreen.main.bounds.width
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 10
        }
        return size
        
    }
    
    func proCell(index : IndexPath) -> UICollectionViewCell {
        
        if istypeFrom  == "CustomerProDetail"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductInBranchDetailCollectionViewCell", for: index) as! ProductInBranchDetailCollectionViewCell
            cell.delegate = self
            cell.tag = index.row
            cell.index = index.section
            AMShimmer.stop(for: cell.likeOutlet)
             AMShimmer.stop(for: cell.buyOnlineVw)
            
            if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
                if value[0]=="ar"
                {
                    cell.productNameLbl.textAlignment = .right
                }else if value[0]=="en"{
                    cell.productNameLbl.textAlignment = .left
                    
                }
            }
            
            let value = self.similarProductListCustomer?.data?.similar_product![index.row]
            
            cell.productNameLbl.text = value?.pro_name
            cell.productImage.sd_setImage(with: URL(string: value?.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            
            cell.ratingLbl.text = "\(value?.pro_avg_rating ?? 0.0)"
            cell.ratingCountLbl.text = "\("(") \(value?.pro_raters ?? "0") \(")")"
            
            
            cell.specialVw.isHidden = false
            if value?.is_special == 0 {
                cell.specialVw.isHidden = true
            }
            cell.likeOutlet.isSelected = true
            if value?.is_favrt == 0 {
                cell.likeOutlet.isSelected = false
            }
            
            if value?.pro_vat_perc == "0" || value?.pro_vat_perc == "0.00" {
                cell.vatIncludedLbl.isHidden = true
            }
            else {
                cell.vatIncludedLbl.isHidden = false
                cell.vatIncludedLbl.text = "(Vat Included)".localized
            }
            
            if value?.pro_dis_perc == "0.00" {
                cell.oldPriceLbl.isHidden = true
                cell.offLbl.isHidden = true
                cell.newPriceLbl.text = "\(value?.pro_currency_code ?? "SAR")  \(value?.pro_main_price ?? "0.0")"
            }else {
                cell.oldPriceLbl.isHidden = false
                cell.offLbl.isHidden = false
                cell.offLbl.text = "\(value?.pro_dis_perc ?? "0.0")\("%") \("OFF".localized)"
                cell.newPriceLbl.text = "\("SAR".localized)  \(value?.pro_main_price ?? "0.0")"
                
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(value?.pro_currency_code ?? "") \(value?.pro_cut_price ?? "")")
                    attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                    cell.oldPriceLbl.attributedText = attributeString
                
            }
            
            let pro_online_available = value?.pro_online
            let pro_store_available = value?.pro_store
            
            let wid = cell.contentView.bounds.size.width
            if pro_online_available == true && pro_store_available == true {
                cell.buyOnlineVw.isHidden = false
                cell.goToStoreVw.isHidden = false
                cell.onlineWidthConstraint.constant = wid / 2
                cell.storeWidth.constant = wid / 2
                cell.blueImageGoToStore.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"blue_rect")!)
                cell.greenImageCart.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"green_rect")!)
            }
            else if pro_online_available == true && pro_store_available == false {
                cell.buyOnlineVw.isHidden = false
                cell.goToStoreVw.isHidden = true
                cell.onlineWidthConstraint.constant = wid
                cell.storeWidth.constant = 0
                //                cell.blueImageGoToStore.image = UIImage(named: "blue_rect")
                cell.greenImageCart.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"green_rect_full")!)
            }
            else if pro_online_available == false && pro_store_available == true {
                cell.buyOnlineVw.isHidden = true
                cell.goToStoreVw.isHidden = false
                cell.onlineWidthConstraint.constant = 0
                cell.storeWidth.constant = wid
                cell.blueImageGoToStore.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"blue_rect_full")!)
            }
            
            cell.likeOutlet.tag = index.item
            cell.likeOutlet.addTarget(self, action: #selector(favouriteClicked(sender:)), for: .touchUpInside)
            
            let isLiked = ModalController.toString(value?.is_favrt as Any)
            
            if isLiked == "0" {
                cell.likeOutlet.isSelected = false
            }else if isLiked == "1" {
                cell.likeOutlet.isSelected = true
            }
            
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarProItemCollectionViewCell", for: index) as! SimilarProItemCollectionViewCell
            let value = self.similarProductList?.data?.similar_product![index.row]
            
            cell.proNameLbl.text = value?.pro_name
            cell.productImage.sd_setImage(with: URL(string: value?.image ?? ""), placeholderImage: UIImage(named: "pro_test"))
            cell.priceLbl.text = "\(value?.pro_price ?? 0.0)"
            cell.currLbl.text = value?.pro_currency ?? ""
            
            cell.tag = index.row
            return cell
        }
    }
}
extension SimiilarProductTableViewCell:addTocart,addressSelectionData,addAddressClicked
{
    func openStorePro(sender: Int, section: Int, proID: Int, goBool: Bool) {
        if HeaderHeightSingleton.shared.latitude == 0.0 && HeaderHeightSingleton.shared.longitude == 0.0{
            
            ModalController.showNegativeCustomAlertWith(title: "Please select location first", msg: "")
            return
        }else{
            let value = self.similarProductListCustomer?.data?.similar_product![sender]
            
            if value?.pro_branch_availability == true {
                
                let pro_id = "\(value?.pro_id ?? 0)"
                let vc = BranchDetailOnMapViewController(nibName: "BranchDetailOnMapViewController", bundle: nil)
                vc.productId = ModalController.toString(pro_id as Any)
                vc.hidesBottomBarWhenPushed = true
                self.vw.navigationController?.pushViewController(vc, animated: true)
            }else{
                ModalController.showNegativeCustomAlertWith(title: "No nearby store found", msg: "")
                
            }
        }
    }
    
    func productLike(sender: Int, section: Int, proID: Int) {
        
    }
    
    func addressSelected(addr: Address_list) {
           cartmodel.addressid = "\((addr.address_id)!)"
             ModalClass.startLoading(self.views)
             cartmodel.changeaddressincart { (success, response) in
               ModalClass.stopLoadingAllLoaders(self.views)
                 if success
                 {
                   ModalController.showSuccessCustomAlertWith(title: response?.value(forKey: "error_description") as! String, msg: "")
               }
       }
       
       }
       
       func addAddress() {
           clickChangeAddress()
       }
       @objc func clickChangeAddress()
       {
           let vc = AddressPopUpSelection(nibName: "AddressPopUpSelection", bundle: nil)
          vc.isCart = true
           vc.delgate = self
           vc.isFrom = "hgjh"
           vc.addressClicked = { (str) in
               let vc = AddNewAddressViewController(nibName: "AddNewAddressViewController", bundle: nil)
               vc.delegate = self
            self.vw.navigationController?.pushViewController(vc, animated: true)
           }
           //        vc.sender = sender
           //        vc.section = section
            //vc.delegate = self
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
        popupController.present(in: self.vw)
           
       }
    func addToCartClicked(sender: Int, section: Int, proID: Int, boID: Int) {
        if AuthorisedUser.shared.isAuthorised{
            let value = self.similarProductListCustomer?.data?.similar_product![sender]
            let pro_id = "\(value?.pro_id ?? 0)"
            let bo_id = Singleton.shared.getUserId()
            let param = ["cus_id":"\(AuthorisedUser.shared.user?.data?.id ?? 0)","bo_id":bo_id,"pro_id":pro_id,"lang_code":"\(HeaderHeightSingleton.shared.LanguageSelected)","cus_address_id":"\(CartAndLike.addressSelected)","combo_pro_id":""]
            
            print(param)
            CartAndLike.addToCart(param: param) { (success, response) in
                if success{
                    if let val = response?.object(forKey: "error_description") as? String{
                        ModalController.showSuccessCustomAlertWith(title: "", msg: val)
                    }
                    
                }else{
                    if let error = response?.object(forKey: "error_code") as? Int{
                        if error == 101{
                            let vc = AddressPopUpSelection(nibName: "AddressPopUpSelection", bundle: nil)
                              vc.isCart = true
                            vc.addressClicked = { (str) in
                                let vc = AddNewAddressViewController(nibName: "AddNewAddressViewController", bundle: nil)
                                vc.delegate = self
                                self.vw.navigationController?.pushViewController(vc, animated: true)
                            }
                            vc.sender = sender
                            vc.section = section
                            vc.delegate = self
                            vc.delgate = self
                            vc.delgate = self
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
                            popupController.present(in: self.vw)
                            
                        }
                    }
                }
                
            }
        }else{
            let vc = LoginNewDesignViewController(nibName: "LoginNewDesignViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController:vc)
            navVC.isNavigationBarHidden = true
            navVC.modalPresentationStyle = .fullScreen
            self.vw.present(navVC, animated: true, completion:nil)
            
        }
    }
    
     @objc func favouriteClicked(sender:UIButton) {
      
        if AuthorisedUser.shared.isAuthorised {
             let value = self.similarProductListCustomer?.data?.similar_product![sender.tag]
            let obj = ProductLikeAddWishlist()
            obj.productId = "\(value?.pro_id ?? 0)"
            obj.customerId = Singleton.shared.getUserId()
            
            if sender.isSelected == false {
                
                obj.actionType = "1"
                obj.productLikeAddToWishList { (success, response) in
                    if success {
                        self.favouriteClickModel = response
                        ModalController.showSuccessCustomAlertWith(title: self.favouriteClickModel?.error_description ?? "", msg: "")
                        sender.isSelected = false
                        
                        ModalController.showSuccessCustomAlertWith(title: self.favouriteClickModel?.error_description ?? "", msg: "")
                        
                        let   cell = self.collectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! ProductInBranchDetailCollectionViewCell
                        
                        cell.likeOutlet.isSelected = true
                        self.similarProductListCustomer?.data?.similar_product![sender.tag].is_favrt = 1
                        
                        self.collectionView.reloadData()
                    }
                }
            }else{
                obj.actionType = "0"
                obj.productLikeAddToWishList { (success, response) in
                    if success {
                        self.favouriteClickModel = response
                           sender.isSelected = true
                        
                        ModalController.showSuccessCustomAlertWith(title: self.favouriteClickModel?.error_description ?? "", msg: "")
                        
                        let   cell = self.collectionView.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! ProductInBranchDetailCollectionViewCell
                        
                        cell.likeOutlet.isSelected = false
                       self.similarProductListCustomer?.data?.similar_product![sender.tag].is_favrt = 0
                         self.collectionView.reloadData()
                    }
                }
            }
        }else{
            let vc = LoginNewDesignViewController(nibName: "LoginNewDesignViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController:vc)
            navVC.isNavigationBarHidden = true
            navVC.modalPresentationStyle = .fullScreen
            self.vw.present(navVC, animated: true, completion:nil)
            
            print("Notlogin")

        }
    }
}
