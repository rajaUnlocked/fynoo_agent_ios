//
//  ProductDetailNewViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 17/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import BBannerView
import AVKit
import ObjectMapper
import MTPopup
import PopupDialog
import AMShimmer

class ProductDetailNewViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ProductDetailBannerTableViewCellDelegate {
    var productmodel = AddProductModel()
    func BarCodeClicked(tag: Int) {
        let vc = BranchQrCodePopupViewController()
        vc.isFrom = "PRODUCTVIEW"
        vc.url = viewNewPoductDetailData?.data?.pro_qr ?? ""
        let popup = PopupDialog(viewController: vc,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        present(popup, animated: true, completion: nil)
    }
    
    func addProductClicked(tag: Int) {
        let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
                     vc.delegate = self
                      vc.isproductlist = true
                       vc.isVarient = isVarient
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
    func qrCodeClicked(tag: Int) {
        let vc = QRCOdeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    var bbannerView : BBannerView!
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var tableView: UITableView!

   var refreshControl = UIRefreshControl()
    var productdetailmodel = DataBankSellingProductModel()
    var viewNewPoductDetailData: viewProductDetailNew?
    var productID:String = ""
    var isVarient = false
    var isProductOnlineAvailable:Bool = false
    var isProductStoreAvailable:Bool = false
    var isFeature:String = ""
    var isOpenMoreSpecifications:Bool = false
     var isOpenMoreTechSpecifications:Bool = false
    var selectedIndex:String = ""
    var storeTypeStr:String = ""
    var discountedOfferTimer: Timer?
    var timerLabel:String = ""
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        print("isProductOnlineAvailable:-",isProductOnlineAvailable)
        print("isProductInstoreAvailable:-",isProductStoreAvailable)
        print("isFeature:-",isFeature)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        self.setUpUI()
        addUIRefreshToTable()
    }
    
    override func viewWillDisappear (_ animated: Bool) {
        discountedOfferTimer?.invalidate()
        
       }
    override func viewDidAppear(_ animated: Bool) {
                 tableView.isHidden = false
         self.newProductDetailAPI()

    }
    
   
    
   
    func setUpUI(){
        self.tableView.estimatedRowHeight = 170
        self.tableView.rowHeight = UITableView.automaticDimension
        self.headerView.menuBtn.isHidden = false
        self.headerView.titleHeader.text = "Product Details".localized
        self.headerView.viewControl = self
        tableView.register(UINib(nibName: "ProductDetailBannerTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDetailBannerTableViewCell")
       
        tableView.register(UINib(nibName: "ProductVarientNewTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductVarientNewTableViewCell")
        
        
        tableView.register(UINib(nibName: "ProductSpecificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductSpecificationsTableViewCell")
        
        tableView.register(UINib(nibName: "MoreDetailSpecificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "MoreDetailSpecificationsTableViewCell")
        
        tableView.register(UINib(nibName: "ProductTechnicalSpecificationsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTechnicalSpecificationsTableViewCell")
        
        tableView.register(UINib(nibName: "ProductWarrentySupportTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductWarrentySupportTableViewCell")
        
       
        
        tableView.register(UINib(nibName: "SimiilarProductTableViewCell", bundle: nil), forCellReuseIdentifier: "SimiilarProductTableViewCell")
        
         tableView.register(UINib(nibName: "TitleHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleHeaderTableViewCell")
       
         newProductDetailAPI()
    }
  func addUIRefreshToTable() {
          refreshControl = UIRefreshControl()
          tableView.addSubview(refreshControl)
          refreshControl.backgroundColor = UIColor.clear
          refreshControl.tintColor = UIColor.lightGray
          refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
      }
      
      @objc func refreshTable() {
          if self.viewNewPoductDetailData!.error! {
              if self.refreshControl.isRefreshing {
                  self.refreshControl.endRefreshing()
              }
          }else{
            newProductDetailAPI()
          }
      }
       func newProductDetailAPI(){
        ModalClass.startLoading(self.view)
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
        AMShimmer.start(for: self.tableView)
              productdetailmodel.pro_id = productID
              productdetailmodel.productDetail { (success, response) in
                  if success {
                    ModalClass.stopLoadingAllLoaders(self.view)
                      AMShimmer.stop(for: self.tableView)
                                 DispatchQueue.main.async {
                                            AMShimmer.stop(for: self.view)
                                            }
                      self.viewNewPoductDetailData = response
                    self.tableView.delegate = self
                     self.tableView.dataSource = self
                      self.tableView.reloadData()
                  }
              }
          }
}

extension ProductDetailNewViewController : UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int{
        if self.viewNewPoductDetailData?.data?.similar_product?.count ?? 0 == 0
        {
          return 5
        }
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 405
            
        }else if indexPath.section == 1 {
            return 45
        }else if indexPath.section == 2 {
            
            if indexPath.row == 8 {
                return 50
            }else{
                return UITableView.automaticDimension
            }
            
            
      }
        //else if indexPath.section == 3 {
//            return UITableView.automaticDimension
//                     let varientCount = self.viewNewPoductDetailData?.data?.pro_variant?.count ?? 0
//                                          let height = Float(varientCount) / 2
//                                          let IntValue = height.rounded(.toNearestOrAwayFromZero)
//                                          if (varientCount) >= 1 {
//                                          if  varientCount % 2 != 0  {
//                                              return  CGFloat(50 * IntValue)
//                                          }else{
//                                              return  CGFloat(50 * IntValue)
//                                          }
//                                           }else{
//                                          return 0
//                                      }
//        }
        else if indexPath.section == 3 || indexPath.section == 4  {
            
            return UITableView.automaticDimension
            
        }else  {
            
            return 380
            
        }
        
    }
    
    
}

extension ProductDetailNewViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }else if section == 1 {
            let varientCount = self.viewNewPoductDetailData?.data?.pro_variant?.count
            if (varientCount ?? 0) >= 1 {
                return 1
            }else {
                return 0
            }
            
        }else if section == 2 {
            let specificationCount  = self.viewNewPoductDetailData?.data?.pro_specification?.count
            
            if specificationCount ?? 0 > 0 {
                if isOpenMoreSpecifications == true {
                    if (specificationCount ?? 0) > 7 {
                        return (specificationCount ?? 0) + 2
                    }else{
                        return (specificationCount ?? 0) + 1
                    }
                }else{
                    if (specificationCount ?? 0) > 7 {
                        return 9
                    }else{
                        return (specificationCount ?? 0) + 1
                    }
                }
            }else {
                return 0
            }
            
        }
        else{
            return 1
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return productDetailBannerViewCell(index: indexPath)
        }
            
        else if indexPath.section == 1 {
            
            return showProductVarientCell(index: indexPath)
        }
        else if indexPath.section == 2 {
            let specificationCount =    self.viewNewPoductDetailData?.data?.pro_specification?.count
            if isOpenMoreSpecifications == true {
                if indexPath.row  == 0 {
                    return ProductHeaderSpecificationsCell(index: indexPath)
                }else if indexPath.row == specificationCount! + 1 {
                    
                    return ProductMoreSpecificationsCell(index: indexPath)
                }else{
                    return ProductSpecificationsCell(index: indexPath)
                }
            }else {
                if (specificationCount ?? 0) > 7 {
                    if indexPath.row  == 0 {
                        return ProductHeaderSpecificationsCell(index: indexPath)
                    }else if indexPath.row == 8 {
                        
                        return ProductMoreSpecificationsCell(index: indexPath)
                    }else{
                        return ProductSpecificationsCell(index: indexPath)
                    }
                }else{
                    if indexPath.row  == 0 {
                        return ProductHeaderSpecificationsCell(index: indexPath)
                    }else{
                        return ProductSpecificationsCell(index: indexPath)
                    }
                }
            }
        }
            
        else if indexPath.section == 3 {
            return ProductTechnicalSpecificationsCell(index: indexPath)
        }
        else if indexPath.section == 4 {
            return ProductDescriptionSupportCell(index: indexPath)
        }
            
        else  {
             return ProductDescriptionSupportCell(index: indexPath)
            //return ProductSimilarCell(index: indexPath)
        }
        
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          if indexPath.section == 1 {
                  let vc = VariantPRoductsViewController(nibName: "VariantPRoductsViewController", bundle: nil)
            vc.productId = "\(self.viewNewPoductDetailData?.data?.pro_id ?? 0)"
                  self.navigationController?.pushViewController(vc, animated: true)
                  
              }
    }
    func productDetailBannerViewCell(index : IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailBannerTableViewCell", for: index) as! ProductDetailBannerTableViewCell
        cell.selectionStyle = .none
        cell.headerLlbl.textAlignment = .left
        if HeaderHeightSingleton.shared.LanguageSelected == "AR"
        {
            cell.headerLlbl.textAlignment = .right
        }
        cell.headerLlbl.text = self.viewNewPoductDetailData?.data?.pro_name
        cell.dropShippingProBtn.isHidden = true
        cell.addProBtnTrailing.constant = 20
        cell.addProImgTrailing.constant = 20
        //        cell.addProductImageView.isUserInteractionEnabled = true
        //        cell.addProductImageView.addGestureRecognizer(singleTap)
        bbannerView = BBannerView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: cell.bannerView.frame.size.width,
                                                height: cell.bannerView.frame.size.height))
        cell.bannerView.addSubview(bbannerView)
        cell.contentView.insertSubview(cell.addProductImageView, aboveSubview:cell.bannerView )
        
        bbannerView.numberOfItems = { (bannerView: BBannerView) -> Int in
            let imageCount = (self.viewNewPoductDetailData?.data?.pro_image?.count ?? 0)
            
            let url =  self.viewNewPoductDetailData?.data?.pro_video_url ?? ""
            if url == ""{
                return imageCount
            }else{
                return imageCount + 1
            }
        }
        bbannerView.viewForItem = { (bannerView: BBannerView, index: Int) -> UIView in
            
            let imageView = UIImageView(frame: bannerView.bounds)
            imageView.image = UIImage(named: "collection")
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            var url = ""
            
            if index == self.viewNewPoductDetailData?.data?.pro_image?.count {
                
                imageView.image = UIImage(named:"video-icon")
                return imageView
                
            }else{
                if self.viewNewPoductDetailData?.data?.pro_image?.count ?? 0 > 0 {
                    
                    url = self.viewNewPoductDetailData?.data?.pro_image?[index].image ?? ""
                }
                imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
                
                return imageView
            }
        }
        
        bbannerView.tap = { (bannerView: BBannerView, index: Int) in
            print("banner2 tap: %d", index)
            if self.viewNewPoductDetailData?.data?.pro_video_url != ""{
                if (self.viewNewPoductDetailData?.data?.pro_image?.count ?? 0) == index  {
                    if let url = URL(string: self.viewNewPoductDetailData?.data?.pro_video_url ?? ""){
                        let player = AVPlayer(url: url)
                        let avController = AVPlayerViewController()
                        avController.player = player
                        // your desired frame
                        avController.view.frame = cell.bannerView.frame
                        cell.bannerView.addSubview(avController.view)
                        self.addChild(avController)
                        player.play()
                    }
                }
            }
        }
        
        bbannerView.reloadData()
        bbannerView.startAutoScroll(timeIntrval: 3)
        cell.contentView.bringSubviewToFront(cell.ratingView)
        
        cell.delegate = self
        cell.tag = index.row
        return cell
    }
   
    func showProductVarientCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductVarientNewTableViewCell", for: index) as! ProductVarientNewTableViewCell
        cell.selectionStyle = .none
        cell.parent = self
        cell.varientProductList = self.viewNewPoductDetailData
        cell.collectionView.reloadData()
        cell.heightConst.constant = CGFloat(60 * ( self.viewNewPoductDetailData?.data?.pro_variant?.count ?? 0))

        cell.tag = index.row
        return cell
    }
   
    func ProductHeaderSpecificationsCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSpecificationsTableViewCell", for: index) as! ProductSpecificationsTableViewCell
        cell.selectionStyle = .none
        cell.leading.constant = -10
        cell.specificationNameLbl.text = "Specifications".localized
        cell.specificationNameLbl.font = UIFont(name: "Gilroy-ExtraBold", size: 12.0)
        cell.leftView.backgroundColor = .clear
        cell.sepecificationsValueLbl.isHidden = true
        
        cell.tag = index.row
        return cell
    }
    func ProductSpecificationsCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSpecificationsTableViewCell", for: index) as! ProductSpecificationsTableViewCell
        cell.selectionStyle = .none
        
        cell.leftView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        cell.sepecificationsValueLbl.isHidden = false
        
        if isOpenMoreSpecifications == true {
            cell.specificationNameLbl.text = self.viewNewPoductDetailData?.data?.pro_specification![index.row - 1].filter_name
            cell.sepecificationsValueLbl.text = self.viewNewPoductDetailData?.data?.pro_specification![index.row - 1].filter_value_name
        }else {
            cell.specificationNameLbl.text = self.viewNewPoductDetailData?.data?.pro_specification![index.row - 1].filter_name
            cell.sepecificationsValueLbl.text = self.viewNewPoductDetailData?.data?.pro_specification![index.row - 1].filter_value_name
        }
        
        
        cell.tag = index.row
        return cell
    }
    func ProductMoreSpecificationsCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreDetailSpecificationsTableViewCell", for: index) as! MoreDetailSpecificationsTableViewCell
        cell.selectionStyle = .none
        cell.moreDetailBtn.addTarget(self, action: #selector(openMoreSpecification), for: .touchUpInside)
        if isOpenMoreSpecifications == true {
            cell.moreDetailLbl.text = "Hide Details".localized
            cell.downIconImageView.image = UIImage(named: "upArror_blue")
        }else {
            cell.moreDetailLbl.text = "More Details".localized
            cell.downIconImageView.image = UIImage(named: "DownArror_blue")
        }
        
        cell.tag = index.row
        return cell
    }
    func ProductTechnicalSpecificationsCell(index : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTechnicalSpecificationsTableViewCell", for: index) as! ProductTechnicalSpecificationsTableViewCell
        cell.selectionStyle = .none
         cell.descriptionLbl.textAlignment = .left
        if HeaderHeightSingleton.shared.LanguageSelected == "AR"
        {
            cell.descriptionLbl.textAlignment = .right
        }
        cell.moreDetailsBtn.addTarget(self, action: #selector(openMoreTechnicalSpecification), for: .touchUpInside)

        cell.firstDocBtn.addTarget(self, action: #selector(openFirstDocSpecification), for: .touchUpInside)
        cell.secondDocBtn.addTarget(self, action: #selector(openSecondDocSpecification), for: .touchUpInside)

        let proDoc =  self.viewNewPoductDetailData?.data?.pro_pdf?.count
        if proDoc == 0 {
            cell.pdfLbl.isHidden = true
            cell.firstDocBtn.isHidden = true
            cell.secondDocBtn.isHidden = true

        }else if proDoc == 1 {
            cell.pdfLbl.isHidden = false
            cell.firstDocBtn.isHidden = false
            cell.secondDocBtn.isHidden = true
            let btnTxt = self.viewNewPoductDetailData?.data?.pro_pdf![0]
            cell.firstDocBtn.setTitle("[ \(btnTxt?.type ?? "") ]", for: .normal)


        }else if proDoc == 2 {
            cell.pdfLbl.isHidden = false
            cell.firstDocBtn.isHidden = false
            cell.secondDocBtn.isHidden = false

             let btnTxt1 = self.viewNewPoductDetailData?.data?.pro_pdf![0]
            let btnTxt = self.viewNewPoductDetailData?.data?.pro_pdf![1]

            cell.firstDocBtn.setTitle("[ \(btnTxt1?.type ?? "") ]", for: .normal)
            cell.secondDocBtn.setTitle("[ \(btnTxt?.type ?? "") ]", for: .normal)

        }
        
        
        if isOpenMoreTechSpecifications == true {
            cell.descriptionLbl.text = self.viewNewPoductDetailData?.data?.pro_technical_specification ?? ""
            cell.descriptionLbl.isHidden = false
            cell.moreDetailsLbl.text = "Hide Details"
            cell.upDownArrowImageView.image = UIImage(named: "upArror_blue")
        }else {
            cell.descriptionLbl.text = ""
            
            cell.descriptionLbl.isHidden = true
            cell.moreDetailsLbl.text = "More Details"
            cell.upDownArrowImageView.image = UIImage(named: "DownArror_blue")
        }
        
        cell.tag = index.row
        return cell
    }
   
    func ProductDescriptionSupportCell(index : IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ProductWarrentySupportTableViewCell", for: index) as! ProductWarrentySupportTableViewCell
           cell.selectionStyle = .none
        cell.bottomLblHeight.constant  = 5
        cell.headerTxtLbl.text = "Product Description".localized
        cell.warrentyDiscriptionlbl.textAlignment = .left
               if HeaderHeightSingleton.shared.LanguageSelected == "AR"
               {
                   cell.warrentyDiscriptionlbl.textAlignment = .right
               }
        cell.warrentyDiscriptionlbl.text = viewNewPoductDetailData?.data?.pro_description ?? ""
           cell.tag = index.row
           return cell
       }
//       func ProductSimilarCell(index : IndexPath) -> UITableViewCell {
//               let cell = tableView.dequeueReusableCell(withIdentifier: "SimiilarProductTableViewCell", for: index) as! SimiilarProductTableViewCell
//        cell.headerLbl.text = "Similar Product".localized
//        cell.viewAllBtn.setTitle("View All".localized, for: .normal)
//               cell.selectionStyle = .none
//               cell.similarProductList = self.viewNewPoductDetailData
//               cell.collectionView.reloadData()
//            cell.parent = self
//        cell.catID = "\((self.viewNewPoductDetailData?.data?.pro_parent_category_id)!)"
//        cell.subcatID = "\((self.viewNewPoductDetailData?.data?.pro_sub_category_id)!)"
//
//               cell.tag = index.row
//               return cell
//           }
    
    @objc func openMoreSpecification(_ sender:UIButton){
         if self.isOpenMoreSpecifications == true {
             self.isOpenMoreSpecifications = false
         }else{
             self.isOpenMoreSpecifications = true
         }
         self.tableView.reloadData()
         
     }
     @objc func openMoreTechnicalSpecification(_ sender:UIButton) {
            if self.isOpenMoreTechSpecifications == true {
              self.isOpenMoreTechSpecifications = false
            }else{
                 self.isOpenMoreTechSpecifications = true
            }
             self.tableView.reloadData()

        }
     
     @objc func openFirstDocSpecification(_ sender:UIButton) {
       let docUrl = self.viewNewPoductDetailData?.data?.pro_pdf![0]
         guard let url = URL(string: "\(docUrl?.pdf ?? "")") else { return }
         UIApplication.shared.open(url)
         
     }
     @objc func openSecondDocSpecification(_ sender:UIButton) {
         
         let docUrl = self.viewNewPoductDetailData?.data?.pro_pdf![1]
         guard let url = URL(string: "\(docUrl?.pdf ?? "")") else { return }
         UIApplication.shared.open(url)

     }
}
extension ProductDetailNewViewController :  BottomPopupEditProductViewControllerDelegate{
    
     func filterIdval(tag: Int, Value: String, id: Int) {
           print("")
      }
      
      func information(Value: String) {
          print("Information Click")
      }

    func actionPerform(tag: Int, index: Int) {
        if isVarient
        {
            if tag == 0{
                print("Edit Product")
             ProductModel.shared.remove()
                                  ModalClass.startLoading(self.view)
                ProductModel.shared.editproductsell = true
                           productmodel.proid = productID
                                       productmodel.productDetails { (success, response) in
                                           ModalClass.stopLoading()
                   
                                           if success {
                   
                                               let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                                               self.navigationController?.pushViewController(vc, animated: true)
                                           }
                           }
            }else if tag == 1 {
                print("Varient Product")
                 ProductModel.shared.remove()
                                     ModalClass.startLoading(self.view)
                      
                               productmodel.proid = productID
                                          productmodel.productDetails { (success, response) in
                                              ModalClass.stopLoading()
                      
                                              if success {
                      
                                                  let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                                                vc.isVarient = true; self.navigationController?.pushViewController(vc, animated: true)
                                              }
                              }
            }
            else if tag == 2{
                print("Similar Product")
               ProductModel.shared.remove()
                                     ModalClass.startLoading(self.view)
                      
                               productmodel.proid = productID
                                          productmodel.productDetails { (success, response) in
                                              ModalClass.stopLoading()
                      
                                              if success {
                      
                                                  let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                                                vc.isSimilar = true; self.navigationController?.pushViewController(vc, animated: true)
                                              }
                              }
            }
            else {
                ProductModel.shared.remove()
                let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
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
                               productmodel.proid = productID
                                          productmodel.productDetails { (success, response) in
                                              ModalClass.stopLoading()
                      
                                              if success {
                      
                                                  let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                                                self.navigationController?.pushViewController(vc, animated: true)
                                              }
                              }
                }else if tag == 1{
                print("Similar Product")
                 ProductModel.shared.remove()
                                     ModalClass.startLoading(self.view)
                      
                                productmodel.proid = productID
                                          productmodel.productDetails { (success, response) in
                                              ModalClass.stopLoading()
                      
                                              if success {
                      
                                                  let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                                                vc.isSimilar = true; self.navigationController?.pushViewController(vc, animated: true)
                                              }
                              }
            }
            else {
                ProductModel.shared.remove()
                let vc = CreateProductFirstViewController(nibName: "CreateProductFirstViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
}
