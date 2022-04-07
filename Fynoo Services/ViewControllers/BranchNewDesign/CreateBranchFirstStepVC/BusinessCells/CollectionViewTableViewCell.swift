//
//  CollectionViewTableViewCell.swift
//  Fynoo Business
//
//  Created by sanjay kumar on 06/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import MobileCoreServices
import MTPopup
import Photos
import BSImagePicker
import AVKit
protocol CollectionViewTableViewCellDelegate {
    func cancelBtn()
    func attachedPdf()
    func deleteDoc(tag:Int)
}
class CollectionViewTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ProductImgDelegate {
  
    
    @IBOutlet weak var circleimg: UIImageView!
    var images = [UIImage]()
     // var uploadimg:UploadImage?
    var uploadimage:GalleryMultiple?
    var isdescription = ""
    var tag1 = 0
    var delegate:CollectionViewTableViewCellDelegate?
    var SelectedINdex = 0
    var productImgArr = [UIImage]()
    @IBOutlet weak var outervw: UIView!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    @IBOutlet weak var trailingConst: NSLayoutConstraint!
    var showimgList:ShowImageList?
    var branch = branchsmodel()
       var width:CGFloat = 0
    @IBOutlet weak var topConst: NSLayoutConstraint!
    @IBOutlet weak var collview: UIView!
    var viewcontrol = UIViewController()
      var view = UIView()
     var istype = ""
     var isAttach = false
    var isAttachImg = NSMutableArray()
    var isType = false
    var SelectedName = NSMutableArray()
    var SelectedId = NSMutableArray()
    var heighConst = 1
    var isDataBank = false
    @IBOutlet weak var collectionVIEW: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        if ProductModel.shared.productId == ""
//        {
//          productImgArr = [#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder"),#imageLiteral(resourceName: "category_placeholder")]
//        }
        circleimg.image = UIImage(named: "redcircle")
        collectionVIEW.register(UINib(nibName: "StoreImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoreImagesCollectionViewCell");
        collectionVIEW.register(UINib(nibName: "SEPhotographyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SEPhotographyCollectionViewCell");
         collectionVIEW.register(UINib(nibName: "ProductImgCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductImgCollectionViewCell");
        collectionVIEW.delegate = self
        collectionVIEW.dataSource = self
        
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isAttach
        {
            return isAttachImg.count + 1
        }
        if istype == "Product"
              {
            return ProductModel.shared.galleryIdImage.count
              }
        
        if isType
        {
            return SelectedName.count 
        }
        return showimgList?.data?.images_list?.count ?? 0
    }
    func checkedImg(tag: Int)
    {
        if  ProductModel.shared.galleryFeatureId == ProductModel.shared.galleryId[tag] as! Int
        {
            ProductModel.shared.galleryFeatureId = 0
            ProductModel.shared.galleryFeatureImage = ""
        }
        else
        {
            ProductModel.shared.galleryFeatureId = ProductModel.shared.galleryId[tag] as! Int
            ProductModel.shared.galleryFeatureImage = ProductModel.shared.galleryIdImage[tag] as! String

        }
        
        self.delegate?.cancelBtn()
        collectionVIEW.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          if istype == "Product"
        {
           let cell = collectionVIEW.dequeueReusableCell(withReuseIdentifier: "ProductImgCollectionViewCell", for: indexPath) as! ProductImgCollectionViewCell
              circleimg.image = UIImage(named: "redcircle")
              if ProductModel.shared.galleryFeatureId > 0
              {
                  circleimg.image = UIImage(named: "pro_img")
              }
          cell.tag = indexPath.row
          cell.delegate = self
           cell.mainlbl.isHidden = true
           cell.add.isHidden = true
          cell.delete.isHidden = false
            cell.checkbtn.isHidden = false
          cell.mainlbl.text = "Main".localized
            if ProductModel.shared.galleryId.count > 0
          {
             // cell.add.isHidden = false
               cell.delete.isHidden = false
          }
            cell.checkbtn.setImage(UIImage(named: "check_red_small"), for: .normal)
           // cell.checkbtn.isSelected = false
         if ProductModel.shared.galleryFeatureId > 0
            {
            if ProductModel.shared.galleryId[indexPath.row] as! Int == ProductModel.shared.galleryFeatureId
            {
                //cell.checkbtn.isSelected = true
                cell.checkbtn.setImage(UIImage(named: "check"), for: .normal)
            }
            else
            {
                cell.checkbtn.setImage(UIImage(named: "uncheck"), for: .normal)
            }
         }
            cell.img.setImageSDWebImage(imgURL:  ProductModel.shared.galleryIdImage[indexPath.row] as! String, placeholder: "category_placeholder")
         
          return cell
      }
        if isAttach
               {
                   let cell = collectionVIEW.dequeueReusableCell(withReuseIdentifier: "SEPhotographyCollectionViewCell", for: indexPath) as! SEPhotographyCollectionViewCell

                cell.imgView.layer.borderWidth = 0.5
            cell.addlbl.text = "Add".localized
                
                 cell.checkBtn.isHidden = false
                cell.imgName.isHidden = false
                if indexPath.row == 0
                {
                    if isAttachImg.count > 0 || isdescription.count > 0
                                   {
                                cell.imgView.layer.borderColor = ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                   }
                                   else
                                   {
                                         cell.imgView.layer.borderColor = ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                    
                                   }
                    cell.checkBtn.isHidden = true
                     cell.imgName.isHidden = true
                    cell.imgView.image = UIImage(named: "")
                  
                }
                else
                {
                  cell.imgView.layer.borderColor = ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                    cell.imgView.sd_setImage(with: URL(string: "\(isAttachImg[indexPath.row - 1])"), placeholderImage: UIImage(named: "category_placeholder"))
                }
                cell.checkBtn.tag = indexPath.row
                //cell.addbtn.addTarget(self, action: #selector(attachDocument), for: .touchUpInside)
                cell.checkBtn.addTarget(self, action: #selector(deleteDocument(_:)), for: .touchUpInside)
                   return cell
               }
        if isType
        {
            let cell = collectionVIEW.dequeueReusableCell(withReuseIdentifier: "StoreImagesCollectionViewCell", for: indexPath) as! StoreImagesCollectionViewCell
            cell.btypeLbl.text = SelectedName[indexPath.row] as? String
                   cell.cancelbtn.tag = indexPath.row
             cell.cancelbtn.addTarget(self, action: #selector(cancelbtn(_:)), for: .touchUpInside)
            return cell
        }
        else
        {
            let cell = collectionVIEW.dequeueReusableCell(withReuseIdentifier: "SEPhotographyCollectionViewCell", for: indexPath) as! SEPhotographyCollectionViewCell
            cell.imgView.layer.borderWidth = 0
            cell.checkBtn.tag = indexPath.row
            cell.checkBtn.addTarget(self, action: #selector(deleteImage(_:)), for: .touchUpInside)
            cell.imgView.sd_setImage(with: URL(string: ((showimgList?.data?.images_list?[indexPath.row].image)!)), placeholderImage: UIImage(named: "category_placeholder"))
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isAttach
        {
            if indexPath.row == 0
            {
                attachDocument()
            }
        }
         if istype == "Product"
         {
             if  ProductModel.shared.galleryIdImage.count > 0
                   {
                        
                      
                   let vc = ViewAllImagesOfProductViewController(nibName: "ViewAllImagesOfProductViewController", bundle: nil)
                                //vc.hidesBottomBarWhenPushed = true
                 vc.cellImagesArray = ProductModel.shared.galleryIdImage as! [String]
                 vc.selectedIndex = indexPath.row
                 vc.checkSelect = true
                    viewcontrol.navigationController?.pushViewController(vc, animated: true)
                  }
          
        }
    }
    @IBAction func AddProductClicked(_ sender: UIButton) {
        let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
                         vc.delegate = self
                       vc.isproduct = true
                      vc.iswarning = true
                      vc.isproduct = true
                       vc.index = tag1
             vc.nameAr =  ["Camera".localized, "Device Gallery".localized]
                        vc.imgAr  = ["camera_picture", "galery_Picture"]
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
                                popupController.present(in: viewcontrol)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.frame.width
        if istype == "Product"
                 {
            return CGSize(width: (screenSize - 40)/5, height: 70)
        }
       else if isType
       {
     
        let widths = ModalController.textWidth(text: (SelectedName[indexPath.row] as? String)!, font: UIFont(name: "Gilroy", size: 10))
        width = width + widths + 40
      
        let size = CGSize(width: widths + 35 , height: 60)
  
              return size
        }
       
             else if isAttach
             {
                      let size = CGSize(width: (screenSize - 40)/4  , height: (screenSize - 40)/4 + 10)
                            return size

             }
       else{
        let size = CGSize(width: (screenSize - 40)/4  , height: (screenSize - 40)/4)
                     return size
        }
       
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if istype == "Product"
                       {
            return UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20)
        }
        if isAttach
                       {
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 5)
        }
        if isType
             {
           return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
        return UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         if isAttach
         {
           return 10
        }
      return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if istype == "Product"
                             {
                                return 0
                  }
       
        return 5
    }
    func uploadImg(tag: Int) {
             tag1 = tag
           let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
                            vc.delegate = self
                          vc.isproduct = true
                         vc.iswarning = true
                         vc.isproduct = true
                          vc.index = tag1
        vc.nameAr =  ["Camera".localized, "Device Gallery".localized]
                           vc.imgAr  = ["camera_picture", "galery_Picture"]
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
                                   popupController.present(in: viewcontrol)
                
    }

    
    func deleteImg(tag: Int) {
        ProductModel.shared.galleryId.removeObjects(at: IndexSet(integer: tag))
        ProductModel.shared.galleryIdImage.removeObjects(at: IndexSet(integer: tag))
        if   !ProductModel.shared.galleryId.contains(ProductModel.shared.galleryFeatureId)
        {
            ProductModel.shared.galleryFeatureId = 0
        }
        if ProductModel.shared.galleryFeatureId == 0
        {
            circleimg.image = UIImage(named: "redcircle")
        }
        self.delegate?.cancelBtn()
        collectionVIEW.reloadData()
    }
    
    @objc func deleteImage(_ sender:UIButton)
    {
        self.delegate?.deleteDoc(tag: (self.showimgList?.data?.images_list?[sender.tag].id)!)
    }
    @objc func cancelbtn(_ tag: UIButton) {
           SelectedName.removeObject(at: tag.tag)
           SelectedId.removeObject(at: tag.tag)
        self.delegate?.cancelBtn()
           collectionVIEW.reloadData()
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension CollectionViewTableViewCell:OpenGalleryDelegate,BottomPopupEditProductViewControllerDelegate,BussinessGalleryViewControllerDelegate
{
    func gallerySave(img: [UIImage],id:NSMutableArray,imgurl:NSMutableArray) {
//
//                  if tag1 == 0
//                  {
//                      branch.isproduct = true
//                  }
//           branch.branchfrom = "Product"
//          if isDataBank
//         {
//          branch.branchfrom = "Databank"
//         }
//
//                  branch.imgfile = img[0]
//                  branch.indeximg = tag1
//               branch.fromgallery = true
//        branch.galleryid = "\(id[0])"
//           ModalClass.startLoading(view)
//                               branch.uploadGalleryImage { (success, response) in
//                                   ModalClass.stopLoading()
//                                   self.uploadimg = response
//                                   if success
//                                   {
//                                      ProductModel.shared.galleryId.replaceObject(at: self.tag1, with: (self.uploadimg?.data?.image_id)!)
//
//                                      self.productImgArr[self.tag1] = img[0]
//                                  ProductModel.shared.galleryIdImageNew[self.tag1] = img[0]
//                                      if self.tag1 == 0
//                                      {
//                                          ProductModel.shared.galleryFeatureImage = self.uploadimg?.data?.image_url ?? ""
//                                      }
//                                       self.delegate?.cancelBtn()
//                                      self.collectionVIEW.reloadData()
//
//                                   }else{
//                                      self.productImgArr[self.tag1] = #imageLiteral(resourceName: "category_placeholder")
//                                        self.collectionVIEW.reloadData()
//                                       ModalController.showNegativeCustomAlertWith(title: self.uploadimg!.error_description!, msg: "")
//                                   }
//
//                               }
              
    }
    func imgaes(){
        
        let imagePicker = ImagePickerController()

      
        if ProductModel.shared.galleryIdImage.count < 10{
            
            imagePicker.settings.selection.max = 10 - ProductModel.shared.galleryIdImage.count
            
        }else{
            
            imagePicker.settings.selection.max = 0
       
            
        }
        
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        
        viewcontrol.presentImagePicker(imagePicker, select: { (asset) in
            
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
            
        }, deselect: { (asset) in
            
            print("ghg")
            
            // User deselected an asset. Cancel whatever you did when asset was selected.
            
        }, cancel: { (assets) in
            
            print("ghg")
            
           
            // User canceled selection.
            
        }, finish: { (assets) in
            
            self.images = self.getAssetThumbnail(assets: assets)
            
            let param = ["lang_code":"en","user_id":Singleton.shared.getUserId()]
            var url = "\(Constant.BASE_URL)\(Constant.uploadproductImages)"
            if self.isDataBank
            {
             url = "\(Constant.BASE_URL)\(Constant.uploaddatasaleImage)"
            }
            ModalClass.startLoading(self.view)
            self.branch.uploadProductImage(url: url, imageFile: self.images, param: param) { success, respose in
                ModalClass.stopLoading()
                if success
                {
                    self.uploadimage = respose
                    ModalController.showSuccessCustomAlertWith(title: self.uploadimage!.error_description!, msg: "")
                    if self.uploadimage?.data?.count ?? 0 > 0
                    {
                    for item in (self.uploadimage?.data)!
                        {
                        ProductModel.shared.galleryId.add(item.image_id ?? 0)
                        ProductModel.shared.galleryIdImage.add(item.image_url ?? "")
                        self.collectionVIEW.reloadData()
                    }
                  
                        self.delegate?.cancelBtn()
                
                    }
                }
            }
            
            // User finished selection assets.
            
        })
        
    }
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
        
        var arrayOfImages = [UIImage]()
        
        for asset in assets {
            
            let manager = PHImageManager.default()
            
            let option = PHImageRequestOptions()
            
            option.deliveryMode = .highQualityFormat
            
            option.resizeMode = .exact
            
            var image = UIImage()
            
            option.isSynchronous = true
            
            manager.requestImage(for: asset, targetSize: CGSize(width: 800, height: 800), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                
                guard let img = result else { return  }
               

                arrayOfImages.append(img)
                
            })
        }
        return arrayOfImages
    }
    func information(Value: String) {
        
    }
    
    func actionPerform(tag: Int, index: Int) {
     
        OpenGallery.shared.delegate = self
        if tag == 0{
            
            OpenGallery.shared.viewControl = viewcontrol
                   OpenGallery.shared.imgType = "Product"
            
            OpenGallery.shared.openCamera()
            
        }else if tag == 1{
            imgaes()
        }
        else
        {
            let vc = BussinessGalleryViewController(nibName: "BussinessGalleryViewController", bundle: nil)
             vc.isTypeFrom = "Profile"
                vc.selectedVl = 1002
                vc.delegate = self
            viewcontrol.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func filterIdval(tag: Int, Value: String, id: Int) {
        print("")
    }
    
    func gallery(img: UIImage, imgtype: String) {
        if imgtype == "Product"{
            if tag1 == 0{
                branch.isproduct = true
            }
            ModalClass.startLoading(view)
            branch.imageType = ""
            branch.branchfrom = "Product"
            if isDataBank
            {
                branch.branchfrom = "DataBank"
            }
            AddBranch.shared.BranchId = ""
            branch.imgfile = img
            self.images.removeAll()
            self.images.append(img)
            let param = ["lang_code":"en","user_id":Singleton.shared.getUserId()]
        
            var url = "\(Constant.BASE_URL)\(Constant.uploadproductImages)"
            if isDataBank
            {
             url = "\(Constant.BASE_URL)\(Constant.uploaddatasaleImage)"
            }
            self.branch.uploadProductImage(url: url, imageFile: self.images, param: param) { success, respose in
                ModalClass.stopLoading()
                if success
                {
                    self.uploadimage = respose
                    ModalController.showSuccessCustomAlertWith(title: self.uploadimage!.error_description!, msg: "")
                    if self.uploadimage?.data?.count ?? 0 > 0
                    {
                    for item in (self.uploadimage?.data)!
                        {
                        ProductModel.shared.galleryId.add(item.image_id ?? 0)
                        ProductModel.shared.galleryIdImage.add(item.image_url ?? "")
                        self.collectionVIEW.reloadData()
                    }
                        self.delegate?.cancelBtn()
                
                
                    }
                }
            }
        }
    }
    func attachDocument()
    {
        self.delegate?.attachedPdf()
    }
    @objc func deleteDocument(_ sender:UIButton)
       {
        self.delegate?.deleteDoc(tag: sender.tag)
       }
}

