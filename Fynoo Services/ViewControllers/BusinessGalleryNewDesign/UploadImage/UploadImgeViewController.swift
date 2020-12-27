//
//  UploadImgViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 26/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import MTPopup

protocol UploadImgeViewControllerDelegate {
   func reloadData()
}
class UploadImgeViewController: UIViewController, UploadimgTableViewCellDelegate {
    var delegate : UploadImgeViewControllerDelegate?
    var img = [UIImage]()
    var imagArr: NSMutableArray = NSMutableArray()
    var imagType : NSMutableArray = NSMutableArray()
    var defaultImgName : NSMutableArray = NSMutableArray()
    @IBOutlet weak var topHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerVw: NavigationView!
    var currentImageIndex = 1
    var imageNameArr : NSMutableArray = NSMutableArray()
    var imageTypeArr : NSMutableArray = NSMutableArray()
    var offsetVal = CGFloat()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        save.titleLabel?.font =  UIFont(name: "\(fontNameLight)", size: 12)
        cancel.titleLabel?.font =  UIFont(name: "\(fontNameLight)", size: 12)
        
      print(defaultImgName)
        for var i in (0..<img.count) 
        {
            imageNameArr.add(defaultImgName[i])
            imageTypeArr.add("")
            imagArr.add(defaultImgName[i])
            imagType.add("")

        }
        offsetVal = 0.0
        tableView.tableFooterView = UIView()
        tableView.delegate = self 
        tableView.dataSource = self
        if HeaderHeightSingleton.shared.LanguageSelected == "EN"{
                      
                        headerVw.titleHeader.text = "Upload Images".localized
                       
                   }else{
                       
                       headerVw.titleHeader.text = "رفع الصور"
                   }
              
       
        headerVw.viewControl  = self
        self.topHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
          self.save.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
          self.cancel.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        tableView.register(UINib(nibName: "UploadimgTableViewCell", bundle: nil), forCellReuseIdentifier: "UploadimgTableViewCell")
         tableView.register(UINib(nibName: "UploadBottomTableViewCell", bundle: nil), forCellReuseIdentifier: "UploadBottomTableViewCell")
        
        
        // save button
        
      
        
        
        
        
        }
   
    @IBAction func saveClicked(_ sender: Any) {
   
        
        if img.count == 1 {
            if imagArr.contains("") {
                ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Enter  Image Name ")
                return
            }
            if imagType.contains(""){
                ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Select Image Type ")
                return
            }
        }
            
        if imagArr.contains("") {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Enter  Image Name For All Image")
            return
        }
        if imagType.contains(""){
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please Select Image Type For All Image")
                       return
        }
        let indexPath = IndexPath(row: 0, section: 0)
        let cell1: UploadimgTableViewCell = self.tableView.cellForRow(at: indexPath) as! UploadimgTableViewCell
        let indexOld = cell1.scrolledIndexOld
        
        let indexPathNEW = IndexPath(row: 1, section: 0)
        let cell: UploadBottomTableViewCell = self.tableView.cellForRow(at: indexPathNEW) as! UploadBottomTableViewCell
        let name = cell.name.text
        let value = cell.value.text
        imageNameArr.replaceObject(at: indexOld, with:name)
        print(imageNameArr,"ghf")
        imageTypeArr.replaceObject(at: indexOld, with:value)
        var imageName = ""
        var imageType = ""
        for i in 0..<imageNameArr.count{
            if imageNameArr.count == 1{
                imageName += imageNameArr[i] as! String
            }else if imageNameArr.count-1 == i{
                 imageName += imageNameArr[i] as! String
            }
            else{
                imageName += "\(imageNameArr[i] as! String),"
            }
            print(imageName,"img")
            
        }
        
        for k in 0..<imageTypeArr.count{
            if (imageTypeArr.object(at: k) as! String) == "الملف الشخصي" {
                imageTypeArr.replaceObject(at: k, with: "Profile")
            }else if (imageTypeArr.object(at: k) as! String) == "الفرع" {
                imageTypeArr.replaceObject(at: k, with: "Branch")
            }else if (imageTypeArr.object(at: k) as! String) == "منتج" {
                imageTypeArr.replaceObject(at: k, with: "Product")
            }
        }
        
        for i in 0..<imageTypeArr.count{
                 if imageTypeArr.count == 1{
                     imageType += imageTypeArr[i] as! String
                 }else if imageNameArr.count-1 == i{
                      imageType += imageTypeArr[i] as! String
                 }
                 else{
                     imageType += "\(imageTypeArr[i] as! String),"
                 }
                 print(imageType,"img")
                 
             }
        
        
        
      print(imageTypeArr.count,imageNameArr.count)
        
        DispatchQueue.main.async {
            self.getData(imageName: imageName, imageType: imageType)
        }
        
        
     //   let val = (self.imageTypeArr.map{String($0)}).joined(separator: ",")
      //  print(val)
     //   print(imageNameArr,imageTypeArr)
    }
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
  var gallery_model = BusinessGalleryNewModel()

    
    func getData(imageName:String,imageType:String){
        if imageName == ""{
            ModalController.showNegativeCustomAlertWith(title: "Image name is compulsory", msg: "")
            return
        }
        if imageType == ""{
            ModalController.showNegativeCustomAlertWith(title: "Image type is compulsory", msg: "")
            return
        }
       
        ModalClass.startLoading(view)
        gallery_model.imgfile = img
        gallery_model.image_name = imageName
        gallery_model.imageType = imageType
        gallery_model.uploadGalleryImg { (success, response) in
            ModalClass.stopLoading()
            if success{
//                self.delegate?.reloadData()
                ModalController.showSuccessCustomAlertWith(title: "Image Uploaded Successfully", msg: "")
                self.navigationController?.popViewController(animated: true)
            }
            
            
        }
    }
    @objc func SelectTypeClicked(){
        let vc = SelectImageTypePopupViewController(nibName: "SelectImageTypePopupViewController", bundle: nil)
        
        vc.choosenOption = { (string) in
            let indexPath = IndexPath(row: 1, section: 0)
              let cell1: UploadBottomTableViewCell = self.tableView.cellForRow(at: indexPath) as! UploadBottomTableViewCell
             cell1.value.text = string
            
            print(self.self.imageTypeArr,"sd")
            print(self.imageNameArr,"dsd")
            self.imagType.replaceObject(at: self.selectedInt, with: string)
          cell1.selectView.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            
            if self.imagArr.contains("") ||  self.imagType.contains(""){
                self.save.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
                self.save.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
             }else{
                self.save.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                self.save.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
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
    
    func imageSwiped(index: Int) {
        let indexPath = IndexPath(row: 1, section: 0)
        let cell1: UploadBottomTableViewCell = self.tableView.cellForRow(at: indexPath) as! UploadBottomTableViewCell
        cell1.name.text = "\(imageNameArr[index])"
        cell1.value.text = "\(imageTypeArr[index])"
        selectedInt = index
        
        if  cell1.name.text == ""{
            cell1.viewName.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            
        }else{
            cell1.viewName.borderColor = UIColor.gray
            
        }
        if  cell1.value.text == ""{
            cell1.selectView.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            
        }else{
            cell1.selectView.borderColor = UIColor.gray
            
        }
        
        
     
        print(imageNameArr)

    }
    var selectedInt = 0
    func imageBeforeSwipe(index: Int) {
        let indexPath = IndexPath(row: 1, section: 0)
        let cell: UploadBottomTableViewCell = self.tableView.cellForRow(at: indexPath) as! UploadBottomTableViewCell
        selectedInt = index
        let name = cell.name.text
        let value = cell.value.text
        imageNameArr.replaceObject(at: index, with:name)
        imageTypeArr.replaceObject(at: index, with:value)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
         
           let indexPath = IndexPath(row: 1, section: 0)
           let cell: UploadBottomTableViewCell = self.tableView.cellForRow(at: indexPath) as! UploadBottomTableViewCell
         if textField.text == ""{
             cell.viewName.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
             
         }else{
             cell.viewName.borderColor = UIColor.gray
             
         }
         
     }
    @objc func textFieldDidChange(textField: UITextField){
        let indexPath = IndexPath(row: 1, section: 0)
        
        let cell: UploadBottomTableViewCell = self.tableView.cellForRow(at: indexPath) as! UploadBottomTableViewCell
        
        if textField.text == ""{
            cell.viewName.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            save.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            save.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
            imagArr.replaceObject(at:selectedInt, with:  textField.text)
        }else{
        
            cell.viewName.borderColor = UIColor.gray
          
            imagArr.replaceObject(at:selectedInt, with:  textField.text)
            
        }
        
        
        print(imagArr,index,imagType)
        if imagArr.contains("") || imagType.contains(""){
            save.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            
            save.setTitleColor(#colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), for: .normal)
        }else{
            save.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
            save.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
        }
        
        
        
        
        
    }
      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          
          
    
          
         
          return true
      }

}

extension UploadImgeViewController : UITableViewDataSource,UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UploadimgTableViewCell", for: indexPath) as! UploadimgTableViewCell
            cell.delegate = self
       
            cell.imgs = img
            cell.setImagesOnScroll(offset: offsetVal)
            
            cell.selectionStyle  = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UploadBottomTableViewCell", for: indexPath) as! UploadBottomTableViewCell
            cell.collectionView.isHidden = false
            
            cell.name.text = defaultImgName[indexPath.row - 1] as? String
            if img.count == 1 {
                cell.collectionView.isHidden = true
            }
            cell.img = img
            cell.selectType.addTarget(self, action: #selector(SelectTypeClicked), for: .touchUpInside)
          
            cell.name.tag = indexPath.row
            cell.name.delegate = self
            cell.name.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
//
            
            cell.collectionView.reloadData()
            cell.selectionStyle  = .none
            
            cell.choosenOption = { (Int) in
              
                 if ((tableView.indexPathsForVisibleRows?.contains(IndexPath(row: 0, section: 0)))!) {
                      self.selectedInt = Int
                       let indexPath = IndexPath(row: 0, section: 0)
                    let cell1: UploadimgTableViewCell = self.tableView.cellForRow(at: indexPath) as! UploadimgTableViewCell
                      
                      let x = CGFloat(Int) * cell1.scrollView.frame.size.width
                      cell1.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
                 
}

                
            }
            if cell.value.text == "" {
                cell.selectView.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            }
            if cell.name.text == "" {
                cell.viewName.borderColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            }
            return cell
        }
        
    }

    
    
}
    
   
extension UploadImgeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
                 return 300
        }else{

            return 290
        }
   
        
    }
}

