//
//  BranchImageUploadController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 01/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import MTPopup
import BSImagePicker
import Photos

class BranchImageUploadController: UIViewController,OpenGalleryDelegate {
    
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerVw: NavigationView!
    var showimgInteriorList:ShowImageList?
    var showimgExteriorList:ShowImageList?
    var obj = BranchUploadss()
    var idsExt = ""
    var idsInt = ""
    var TotalCount = 0
    var isEmpty = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerVw.titleHeader.text = "Upload Photo".localized;
        self.headerVw.viewControl = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "HeaderBranchTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderBranchTableViewCell");
     //   tableView.register(UINib(nibName: "CollectionViewTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionViewTableViewCell");
        
        tableView.register(UINib(nibName: "ExteriorTableViewCell", bundle: nil), forCellReuseIdentifier: "ExteriorTableViewCell");
        
        tableView.register(UINib(nibName: "TwoButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "TwoButtonsTableViewCell");
        
        getdata()
    }
    
    
    func getdata(){
        obj.imageType = "Interior"
        obj.showGallery { (success, response) in
            if success{
                self.showimgInteriorList = response
                let val =
                    (self.showimgInteriorList?.data?.images_list!.map{String($0.id!)})!.joined(separator: ",")
                self.idsInt = val
           
                self.TotalCount = self.showimgInteriorList?.data?.images_list!.count  ?? 0
                self.tableView.reloadData()
                
            }
        }
        obj.imageType = "Exterior"
        obj.showGallery { (success, response) in
            if success{
                self.showimgExteriorList = response
                let val = (self.showimgExteriorList?.data?.images_list!.map{String($0.id!)})!.joined(separator: ",")
                self.TotalCount += self.showimgExteriorList?.data?.images_list!.count ?? 0

              
                self.idsExt = val
                self.tableView.reloadData()
                
            }
        }
    }
    var images = [UIImage]()
    
    func imgaes(){
        let imagePicker = ImagePickerController()
        
        let val = showimgInteriorList?.data?.images_list?.count
        let val2 = showimgExteriorList?.data?.images_list?.count
        
        print(val2,"val2",val)
                if (val!+val2!) < 10{
            imagePicker.settings.selection.max = 10 - (val!+val2!)
        }else{
            imagePicker.settings.selection.max = 0
            
        }
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        
        
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset) in
            print("ghg")
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            print("ghg")
            
            
            // User canceled selection.
        }, finish: { (assets) in
            self.images = self.getAssetThumbnail(assets: assets)
            self.UploadProfileImage_API()
            print("hdgjj")
            // User finished selection assets.
        })
    }
    
    func gallery(img: UIImage, imgtype: String) {
        print(imgtype)
        self.images = [img]
        self.UploadProfileImage_API()
        // UploadProfileImage_API(img: img)
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
                image = result!
                arrayOfImages.append(image)
            })
        }

        return arrayOfImages
    }
    var type = "Exterior"
    @objc func cancelClicked(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)

      }
      
      @objc func saveClicked(_ sender:UIButton){

        let val = showimgInteriorList?.data?.images_list?.count
        let val2 = showimgExteriorList?.data?.images_list?.count
        
        if val == 0 && val2 == 0 {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please upload atleast One Image..")
            return
        }

        if idsExt == "" {
            obj.mediaId = "\(idsInt)"
        }else if idsInt == "" {
             obj.mediaId = "\(idsExt)"
        }else{
            obj.mediaId = "\(idsExt),\(idsInt)"
        }
        
        print(obj.mediaId,"ghg")
        obj.saveGallery { (success, response) in
            if success{
                if let str = response?.object(forKey: "error_description") as? String{
                    ModalController.showSuccessCustomAlertWith(title: "", msg: str)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        
    }
    @objc func typeClicked(_ sender: UIButton)
    {
        if sender.tag == 1{
            type = "Exterior"
        }else{
            type = "interior"
        }
        let vc = BranchBottomPopUpController(nibName: "BranchBottomPopUpController", bundle: nil)
        vc.choosenOption = { (string) in
            OpenGallery.shared.delegate = self
            OpenGallery.shared.viewControl = self
            if string == "Take Photo"{
               // self.imgaes()
                
               OpenGallery.shared.openCamera()
                
            }else if string == "Device Gallery"{
                self.imgaes()
//                OpenGallery.shared.viewControl = self
//                OpenGallery.shared.openGallery()
                
            }
            else
            {
                  let vc = BussinessGalleryViewController(nibName: "BussinessGalleryViewController", bundle: nil)
                vc.isTypeFrom = "Branch"
                vc.branchImgCount = 10 - self.TotalCount
                vc.selectedVl = 1001
                    vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
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
    
    func delete(int:Int,str:String){
        if str == "Exterior"{
            obj.mediaId = "\((self.showimgExteriorList?.data?.images_list?[int].id)!)"

        }else{
            obj.mediaId = "\((self.showimgInteriorList?.data?.images_list?[int].id)!)"

        }
        ModalClass.startLoading(self.view)
        obj.deleteImg { (success, response) in
             ModalClass.stopLoading()
             if success
             {
                  self.getdata()
             }
             
         }
    }
     func UploadProfileImage_API()
     {
        let str = "\(Constant.BASE_URL)\(Constant.branchMultipleImageType)"
        
        let param = [
            "user_id":Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"branch_id":obj.branchId,"image_type":type
            ] as [String : Any]
        
        
        print(param)
        
        ModalClass.startLoading(self.view)
        print(self.images.count)
        ServerCalls.fileUploadAPINewMultipleImage(inputUrl: str, parameters: param, imageName: "images[]", imageFile: self.images) { (response, success, resp) in
            
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    ModalController.showNegativeCustomAlertWith(title:" Error", msg: msg)
                }else{
                    self.getdata()
                   // let str  = ((value.object(forKey: "data") as! NSDictionary).object(forKey: "image_url") as! String)
             
                }
            }
            else{
                ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
            }
        }
        
    }

    
}

extension BranchImageUploadController : UITableViewDataSource,BussinessGalleryViewControllerDelegate{
    func gallerySave(img: [UIImage],id:NSMutableArray,imgurl:NSMutableArray) {
      
            var imgid = ""
            if id.count > 0
            {
                
                
                
                imgid.removeAll()
                for item in id{
                    imgid = "\(item),\(imgid)"
                }
                imgid.removeLast()
            }
            var branch = branchsmodel()
            branch.branchfrom = "Branch"
            branch.imgtype = obj.imageType
            branch.galleryid = imgid
            ModalClass.startLoading(view)
            branch.uploadbranchGalleryImage { (success, response) in
                ModalClass.stopLoading()
                
                if success
                {
                    self.getdata()
//                    self.uploadbranchimg = response
//                    self.allimageGallery(imageType: "")
//                    self.allimageGallery(imageType: self.imagetype)
//
                }
                
            }
        
        //        self.images = img
        //        UploadProfileImage_API()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1{
            
                return 60
            
        }
        if indexPath.row == 0{
            return 50

        }else{
            return 150
        }
    }
}

extension BranchImageUploadController : UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 1
        }else{
            
            if isEmpty != ""{
                 return 3
            }else{
                return 2
            }
           
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoButtonsTableViewCell", for: indexPath) as! TwoButtonsTableViewCell
            cell.selectionStyle = .none
            cell.cancel.addTarget(self, action: #selector(cancelClicked(_:)), for: .touchUpInside)
            cell.save.addTarget(self, action: #selector(saveClicked(_:)), for: .touchUpInside)
            cell.save.setAllSideShadow(shadowShowSize: 2.0)
            cell.cancel.isUserInteractionEnabled  = true
            cell.cancel.setAllSideShadow(shadowShowSize: 2.0)
            let val = showimgInteriorList?.data?.images_list?.count ?? 0
            let val2 = showimgExteriorList?.data?.images_list?.count ?? 0
            let count = val+val2
            if count == 0{
                cell.save.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
                cell.save.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            }else{
                cell.save.setTitleColor(#colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1), for: .normal)
                cell.save.borderColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
                
            }
            return cell
        }
         
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as! HeaderBranchTableViewCell
            cell.rgtlbl.isHidden  =  false
            if TotalCount == 0{
                cell.btn.setImage(#imageLiteral(resourceName: "cameras-1"), for: .normal)
            }else{
                cell.btn.setImage(#imageLiteral(resourceName: "camera_icon"), for: .normal)
            }
            
            let val = showimgInteriorList?.data?.images_list?.count ?? 0
            let val2 = showimgExteriorList?.data?.images_list?.count ?? 0
            let count = val+val2
            let str = "\(count)/\(10)"
            if count == 10{
                cell.rgtlbl.attributedText = ModalController.setMultiColorTextStringss(str:str, str1: "\(count)/", str2: "10", color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), color2: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1))
            }else{
                cell.rgtlbl.attributedText = ModalController.setMultiColorTextStringss(str: str, str1: "\(count)/", str2: "10", color: #colorLiteral(red: 0.9496089816, green: 0.3862835169, blue: 0.3978196979, alpha: 1), color2: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
            }
            
            cell.rightarrow.isHidden = true
            cell.lbl.text = "Store Pictures"
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExteriorTableViewCell", for: indexPath) as! ExteriorTableViewCell
            cell.vieww.clipsToBounds = true
            cell.selectionStyle = .none
            cell.status.text = "Exterior"
            cell.viewControl = self
            cell.branchId = obj.branchId
            cell.vieww.layer.cornerRadius = 10
            cell.vieww.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.showimgExteriorList = self.showimgExteriorList
            cell.TypeClicked.tag = indexPath.row
            cell.deleteHandler = { (int,str) in
                self.delete(int: int, str: str)
            }
            let val = showimgInteriorList?.data?.images_list?.count ?? 0
            let val2 = showimgExteriorList?.data?.images_list?.count ?? 0
            let count = val+val2
            if count == 10{
                cell.TypeClicked.isUserInteractionEnabled = false
            }else{
                cell.TypeClicked.isUserInteractionEnabled = true
                
            }
            
            cell.TypeClicked.addTarget(self, action: #selector(typeClicked(_:)), for: .touchUpInside)
            cell.collectionView.reloadData()
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExteriorTableViewCell", for: indexPath) as! ExteriorTableViewCell
            cell.vieww.clipsToBounds = true
            cell.selectionStyle = .none
             cell.viewControl = self
             cell.branchId = obj.branchId
             cell.status.text = "Interior"
            cell.vieww.layer.cornerRadius = 10
            cell.showimgExteriorList = self.showimgInteriorList
            cell.vieww.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.deleteHandler = { (int,str) in
                self.delete(int: int, str: str)
            }
            
            cell.TypeClicked.tag = indexPath.row
            cell.TypeClicked.addTarget(self, action: #selector(typeClicked(_:)), for: .touchUpInside)
            let val = showimgInteriorList?.data?.images_list?.count ?? 0
                      let val2 = showimgExteriorList?.data?.images_list?.count ?? 0
                      let count = val+val2
            if count == 10{
                cell.TypeClicked.isUserInteractionEnabled = false
            }else{
                cell.TypeClicked.isUserInteractionEnabled = true

            }
            cell.collectionView.reloadData()
            return cell

        }
    }
    
    
}
