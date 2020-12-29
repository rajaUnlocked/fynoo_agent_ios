//
//  BussinessGalleryViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 25/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import MTPopup
import BSImagePicker
import Photos

protocol BussinessGalleryViewControllerDelegate {
    func gallerySave(img : [UIImage],id:NSMutableArray,imgurl:NSMutableArray)
}

class BussinessGalleryViewController: UIViewController{
    var delegate : BussinessGalleryViewControllerDelegate?
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var headerVw: NavigationView!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var topHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancel: UIButton!
    var gallery_list_model = BusinessGalleryNewModel()
    var gallery_list : BusinessGalleryList?
    var delete_gallery : DeleteBusinessGallery?
    var images:NSMutableArray = NSMutableArray()
    var textSTR = ""
    var ischeck = false
    var img_ids = ""
    var img_id : NSMutableArray = NSMutableArray()
     var img_name_ar : NSMutableArray = NSMutableArray()
    var filterArray :  [Gallery_list_new]?
    var filterArray1 :  [Gallery_list_new]?
    var selectedVl = 1000
    var selectedIndex = 0
    var imgType = ""
     var selectedImg = 999
    var isTypeFrom = ""
    var longGesture = UILongPressGestureRecognizer()
    var imgName: NSMutableArray = NSMutableArray()
   var imagess = [UIImage]()
   var imgArr = NSMutableArray()
        var isDataLoading = false
    var allGalleryList = [Gallery_list_new]()
    var branchImgCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
         img_id.removeAllObjects()
        if HeaderHeightSingleton.shared.LanguageSelected == "EN"{
                
                  headerVw.titleHeader.text = "Welcome, Let's Select Your Gallery".localized
                 
             }else{
                 
                 headerVw.titleHeader.text = "معرض الصور الخاص بك"
             }
              
         self.topHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        headerVw.viewControl = self
        self.navigationController?.navigationBar.isHidden = true
         self.save.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
          self.cancel.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        collectionVw.register(UINib(nibName: "GalleryItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryItemCollectionViewCell")
        collectionVw.register(UINib(nibName: "GalleryHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryHeaderCollectionViewCell")
        collectionVw.register(UINib(nibName: "GallerySearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GallerySearchCollectionViewCell")
         collectionVw.register(UINib(nibName: "NodatafoundCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NodatafoundCollectionViewCell")
        collectionVw.register(UINib(nibName: "NewGalleryHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:"NewGalleryHeader")
        collectionVw.delegate = self
        collectionVw.dataSource = self
        if isTypeFrom != ""{
            self.save.isHidden = false
            self.cancel.isHidden = false
        }
//          imgType = "Profile"
//        GalleryList()
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        if img_id.count == 0 {
            ModalController.showNegativeCustomAlertWith(title: "Please Select Image", msg: "")
            return 
        }

        
        if img_name_ar.count > 0 {
            
            for i in 0...img_name_ar.count - 1 {
                let url = URL(string:img_name_ar[i] as! String ) 
                if let data = try? Data(contentsOf: url!)
                          {
                              let image: UIImage = UIImage(data: data)!
                              self.imgArr.add(image)
                              
                          }
            }
          
        }
        
 
        print(imgArr)
        print(imgArr.count)
        self.delegate?.gallerySave(img: imgArr as! [UIImage],id:img_id,imgurl:img_name_ar)
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension BussinessGalleryViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
          
    return 3
    
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 || section == 1{
            return 1
        }
      
        else {
            if selectedIndex == 0 {
              
                if textSTR.count > 0
                {
                    return filterArray?.count ?? 0
                }
              
                else{

                    return allGalleryList.count
                        ?? 0
                }
            }
            else {
                return 1
            }

            
        }
        
    
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

      
        if indexPath.section == 0 {
            let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: "GalleryHeaderCollectionViewCell", for: indexPath) as! GalleryHeaderCollectionViewCell
            
            return cell
        }
        if indexPath.section == 1 {
            let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: "GallerySearchCollectionViewCell", for: indexPath) as! GallerySearchCollectionViewCell
              cell.addBtn.isUserInteractionEnabled = true
            if isTypeFrom != ""{
                cell.addBtn.isUserInteractionEnabled = false
            }
            cell.txtFiled.addTarget(self, action: #selector(BussinessGalleryViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            cell.delegate = self
            
            if img_id.count == 0 {
                selectedImg = 999
            }
            if selectedImg != 999{
                cell.searchVw.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)

            }
            else {
                cell.searchVw.borderColor = .lightGray

            }
            
            return cell
        }
        else {
            if selectedIndex == 0 {
                
               
                if textSTR.count > 0
                {
                    filterArray1 = filterArray
                }
            
                else{
                    
                    filterArray1 = allGalleryList
                    
                }
                let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell
               

                cell.firstImg.sd_setImage(with: URL(string: filterArray1?[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "category_placeholder"))
              
                longGesture = UILongPressGestureRecognizer(target: self, action: #selector(selectedLongImg(_ :)))

                longGesture.minimumPressDuration = 0.5
                cell.firstImg.isUserInteractionEnabled = true
                cell.firstImg.addGestureRecognizer(longGesture)
                longGesture.view?.tag = indexPath.row
       
              if img_id.contains((filterArray1?[indexPath.row].id)!)
              {
                  cell.check.isSelected = true
                  cell.secondImg.isHidden = false
                  cell.firstImg.isHidden = true
                  cell.secondImg.sd_setImage(with: URL(string: filterArray1?[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "category_placeholder"))
                  cell.contentView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9254901961, blue: 0.9254901961, alpha: 1)
              }
              else
              {
                  cell.check.isSelected = false
                  cell.firstImg.isHidden = false
                  cell.secondImg.isHidden = true
                  cell.firstImg.sd_setImage(with: URL(string: filterArray1?[indexPath.row].image ?? ""), placeholderImage: UIImage(named: "category_placeholder"))
              }
                
                
                cell.check.tag = indexPath.row
                cell.check.addTarget(self, action: #selector(checkClicked(_ :)), for: .touchUpInside)
                
                if img_id.count == 0 {
                    selectedImg = 999
                }
                if selectedImg != 999{
                    cell.check.isHidden = false
                                 
                }
                else{
                      cell.check.isHidden = true
                }
              

                
                return cell
            }
            else {
                let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: "NodatafoundCollectionViewCell", for: indexPath) as! NodatafoundCollectionViewCell
           
                return cell
            }
        }
   
   
}
    @objc func selectedLongImg(_ sender : UILongPressGestureRecognizer){
        
         if sender.state == .ended {
                   selectedImg = sender.view!.tag
                    img_id.add((self.filterArray1?[sender.view!.tag].id!)!)
                    img_name_ar.add((self.filterArray1?[sender.view!.tag].image!)!)
            
            if isTypeFrom == "Branch" {
                    if branchImgCount <= img_id.count {
                      
                        ModalController.showNegativeCustomAlertWith(title: "You can select maximum \(branchImgCount) images", msg: "")
                        return
                    }
                if img_id.contains((self.filterArray1?[sender.view!.tag].id!)!)
                {
                    
                }
                else
                {
                  img_id.add((self.filterArray1?[sender.view!.tag].id!)!)
                    img_name_ar.add((self.filterArray1?[sender.view!.tag].image!)!)
                }
                   
               
                  
                }
            
            if isTypeFrom == "Profile" || isTypeFrom == "BranchLogo" || isTypeFrom == "Product" {
               
                       img_id.removeAllObjects()
                  img_name_ar.removeAllObjects()
                      img_id.add((self.filterArray1?[sender.view!.tag].id!)!)
                  img_name_ar.add((self.filterArray1?[sender.view!.tag].image!)!)
                   }
                   
            if img_id.count > 0 {
                         self.save.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                         self.save.setTitleColor(#colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), for: .normal)
                     }
                     
            
                   collectionVw.reloadData()
                   //Do Whatever You want on End of Gesture

               }
    


        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
 
        
        
     if let textStr = textField.text {
           textSTR = textStr
         if self.allGalleryList.count == 0{
          
             return
         }
        
        
         
         if textField.text!.count == 0{
             selectedIndex = 0
             filterArray?.removeAll()
           
         }
//         textSTR = textStr
         print("t5y7iglujkgm")

//        if textField.text!.count > 0 {
        filterArray =  self.allGalleryList.filter{($0.name.lowercased() as AnyObject).contains(textStr.lowercased())}
        
        if filterArray?.count == 0 {
            selectedIndex = 1
        }
        
        if filterArray!.count == 0  && textField.text?.count == 0{
                   selectedIndex = 0
               }
        
        collectionVw.reloadSections(IndexSet(integer: 2))
     }
 
        
        
    }
    @objc func checkClicked(_ sender : UIButton){
        
        
                   
                     
        let touchPoint = sender.convert(CGPoint.zero, to: collectionVw)
           let clickedBtn = collectionVw.indexPathForItem(at: touchPoint)
            let section = Int(clickedBtn!.section)
               print(section, "section")

               if textSTR.count > 0
               {
                   filterArray1 = filterArray
               }
               else{
                   filterArray1 = self.allGalleryList
               }
               if img_id.contains((self.filterArray1?[sender.tag].id!) ?? 0)
                {
                   img_id.remove((self.filterArray1?[sender.tag].id!) ?? 0)
                 img_name_ar.add((self.filterArray1?[sender.tag].image!)!)
                }
               else
                {
                    if isTypeFrom == "Branch" {
                        if branchImgCount <= img_id.count {
                          
                            ModalController.showNegativeCustomAlertWith(title: "You can select maximum \(branchImgCount) images", msg: "")
                            return
                        }
                       
                      
                    }
                   img_id.add((self.filterArray1?[sender.tag].id!)!)
                      img_name_ar.add((self.filterArray1?[sender.tag].image!)!)
                }
      
        
        if isTypeFrom == "Profile" || isTypeFrom == "BranchLogo" {
            img_id.removeAllObjects()
             img_name_ar.removeAllObjects()
           img_id.add((self.filterArray1?[sender.tag].id!)!)
              img_name_ar.add((self.filterArray1?[sender.tag].image!)!)
        }
        
          
        
        
        
        
             collectionVw.reloadData()
//             collectionVw.reloadItems(at: [IndexPath(row: sender.tag, section: section)])


        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        if indexPath.section == 0 {
            let size = CGSize(width: screenWidth , height: 80 )
            return size
        }
        if indexPath.section == 1 {
            let size = CGSize(width: screenWidth , height: 100  )
            return size
        }
     
        
        if selectedIndex ==  1{
            let size = CGSize(width: screenWidth , height: 400  )
                       return size
        }
        let size = CGSize(width: (screenWidth - 60)/4 , height: 82 )
        if let layout = self.collectionVw.collectionViewLayout as? UICollectionViewFlowLayout{
            let width = UIScreen.main.bounds.width
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
        }
        return size
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.section != 0 && indexPath.section != 1{
            if selectedIndex == 1 {
               print("new client")
                return
            }
            if img_id.count > 0{
                    print("")
            print("new client changes")
       //         let touchPoint = sender.convert(CGPoint.zero, to: collectionVw)
         //            let clickedBtn = collectionVw.indexPathForItem(at: touchPoint)
                let section = Int(indexPath.section)
                         print(section, "section")

                         if textSTR.count > 0
                         {
                             filterArray1 = filterArray
                         }
                         else{
                             filterArray1 = self.allGalleryList
                         }
                if img_id.contains((self.filterArray1?[indexPath.item].id!) ?? 0)
                          {
                             img_id.remove((self.filterArray1?[indexPath.item].id!) ?? 0)
                           img_name_ar.add((self.filterArray1?[indexPath.item].image!)!)
                          }
                         else
                          {
                              if isTypeFrom == "Branch" {
                                  if branchImgCount <= img_id.count {
                                    
                                      ModalController.showNegativeCustomAlertWith(title: "You can select maximum \(branchImgCount) images", msg: "")
                                      return
                                  }
                                 
                                
                              }
                             img_id.add((self.filterArray1?[indexPath.item].id!)!)
                                img_name_ar.add((self.filterArray1?[indexPath.item].image!)!)
                          }
                
                  
                  if isTypeFrom == "Profile" || isTypeFrom == "BranchLogo" {
                      img_id.removeAllObjects()
                       img_name_ar.removeAllObjects()
                     img_id.add((self.filterArray1?[indexPath.item].id!)!)
                        img_name_ar.add((self.filterArray1?[indexPath.item].image!)!)
                  }
                  
                       collectionVw.reloadData()
            }
            else{
            let vc = ViewImagesViewController(nibName: "ViewImagesViewController", bundle: nil)
                vc.hidesBottomBarWhenPushed = true
            vc.imageNames = allGalleryList
            vc.img_id = "\( (allGalleryList[indexPath.row].id)!)"
            vc.index = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
            
      
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
            
        case  UICollectionView.elementKindSectionHeader:
            
            let headerVw = collectionVw.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NewGalleryHeader", for: indexPath) as! NewGalleryHeader
            let layout = collectionVw.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionHeadersPinToVisibleBounds = true
           
            if selectedVl == 1000{
                headerVw.firstLbl.isHidden = false
                headerVw.secondLbl.isHidden = true
                headerVw.thirdLbl.isHidden = true
                headerVw.profileBtn.backgroundColor = UIColor.white
                headerVw.branchBtn.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headerVw.productBtn.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headerVw.profileBtn.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
                headerVw.branchBtn.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headerVw.productBtn.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headerVw.profileBtn.titleLabel?.font = UIFont(name: "Gilroy-ExtraBold", size: 12.0)
                headerVw.branchBtn.titleLabel?.font = UIFont(name: "Gilroy-Light", size: 12.0)
                headerVw.productBtn.titleLabel?.font = UIFont(name: "Gilroy-Light", size: 12.0)
                
                headerVw.productBtn.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headerVw.productBtn.borderWidth = 0.2
                
                headerVw.branchBtn.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headerVw.branchBtn.borderWidth = 0.2
                headerVw.profileBtn.borderWidth = 0.0
                
            }else if selectedVl == 1001{
                
                headerVw.firstLbl.isHidden = true
                headerVw.secondLbl.isHidden = false
                headerVw.thirdLbl.isHidden = true
                headerVw.profileBtn.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headerVw.branchBtn.backgroundColor = UIColor.white
                headerVw.productBtn.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headerVw.profileBtn.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headerVw.branchBtn.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
                headerVw.productBtn.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headerVw.profileBtn.titleLabel?.font = UIFont(name: "Gilroy-Light", size: 12.0)
                headerVw.branchBtn.titleLabel?.font = UIFont(name: "Gilroy-ExtraBold", size: 12.0)
                headerVw.productBtn.titleLabel?.font = UIFont(name: "Gilroy-Light", size: 12.0)
                
                headerVw.productBtn.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headerVw.productBtn.borderWidth = 0.2
                
                headerVw.profileBtn.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headerVw.profileBtn.borderWidth = 0.2
                headerVw.branchBtn.borderWidth = 0.0
            }else{
                headerVw.firstLbl.isHidden = true
                headerVw.secondLbl.isHidden = true
                headerVw.thirdLbl.isHidden = false
                headerVw.profileBtn.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headerVw.branchBtn.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                headerVw.productBtn.backgroundColor = UIColor.white
                headerVw.profileBtn.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headerVw.branchBtn.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                headerVw.productBtn.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
                headerVw.profileBtn.titleLabel?.font = UIFont(name: "Gilroy-Light", size: 12.0)
                headerVw.branchBtn.titleLabel?.font = UIFont(name: "Gilroy-Light", size: 12.0)
                headerVw.productBtn.titleLabel?.font = UIFont(name: "Gilroy-ExtraBold", size: 12.0)
                
                headerVw.profileBtn.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headerVw.profileBtn.borderWidth = 0.2
                
                headerVw.branchBtn.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                headerVw.branchBtn.borderWidth = 0.2
                headerVw.productBtn.borderWidth = 0.0
            }
            
            headerVw.profileBtn.addTarget(self, action: #selector(profileImgTab), for: .touchUpInside)
            headerVw.branchBtn.addTarget(self, action: #selector(branchImgtab), for: .touchUpInside)
            headerVw.productBtn.addTarget(self, action: #selector(productImgTab), for: .touchUpInside)
       
            
            if ischeck{
                headerVw.selectAll.isSelected = true
            }
            else {
                headerVw.selectAll.isSelected = false
            }
            
            headerVw.selectAll.tag = indexPath.section
            headerVw.selectAll.addTarget(self, action: #selector(check(_ :)), for: .touchUpInside)
            
            headerVw.cancelAllOutlet.tag = indexPath.section
            headerVw.cancelAllOutlet.addTarget(self, action: #selector(checkCancel(_ :)), for: .touchUpInside)
            

             headerVw.deleteBtn.tag = indexPath.section
            headerVw.deleteBtn.addTarget(self, action: #selector(deleteClick(_ : )), for: .touchUpInside)
            
            
            if img_id.count == 0{
                headerVw.secondVw.isHidden = true
            }
            else {
                headerVw.secondVw.isHidden = false
            }
            
            if isTypeFrom != "" {
               headerVw.secondVw.isHidden = true
            }
//            if img_id.contains(filterArray1?[indexPath.section].id)
//                         {
//
//                         }
//                         else
//                         {
//                             headerVw.secondVw.isHidden = true
//                         }
                           
     
//            if selectedIndex == 1 {
//                 headerVw.secondVw.isHidden = true
//            }
//          if self.delete_gallery?.error_description == "Gallery image deleted successfully"{
//                           headerVw.secondVw.isHidden = true
//                        }
            return headerVw
            
        default:
           fatalError("Unexpected element kind")
        }

   }
    @objc func profileImgTab() {
        selectedVl = 1000
        filterArray?.removeAll()
        allGalleryList.removeAll()
        GalleryList()

        
    }
    @objc func branchImgtab() {
         selectedVl = 1001
       filterArray?.removeAll()
              allGalleryList.removeAll()
        GalleryList()

         
     }
    @objc func productImgTab() {
        selectedVl = 1002
        filterArray?.removeAll()
        allGalleryList.removeAll()
        
        GalleryList()
        
        
    }
  

      func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

          isDataLoading = false
      }
      func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
         
                    if ((collectionVw.contentOffset.y + collectionVw.frame.size.height) >= collectionVw.contentSize.height)
                    {
                        if !isDataLoading{
                         
                            isDataLoading = true
                          gallery_list_model.pageNo=gallery_list_model.pageNo + 1
                        GalleryList()
                         
                          }

                        }
                    

      }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
      
        if section == 2 {
       
            if img_id.count == 0 {
               return  CGSize(width: screenWidth , height: 50 )
            }
             else   if isTypeFrom != "" {
                   return  CGSize(width: screenWidth , height: 50 )
                }
            else {
                   return  CGSize(width: screenWidth , height: 90 )
            }
        }
        else {
              return  CGSize(width: 0 , height: 0 )
        }
    }
  
    }
extension BussinessGalleryViewController : GallerySearchCollectionViewCelldelegate,OpenGalleryDelegate,ViewImagesViewControllerDelegate,GalleryFilterViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UploadImgeViewControllerDelegate{
    
    func reloadData() {
          GalleryList()
    }
    
    func reloadFilteredGallery() {
         GalleryList()
    }
    
    func reloadPage() {
        GalleryList()
    }
    
 
  
    func gallery(img: UIImage, imgtype: String) {
      //  let tempImg = NSMutableArray()
        var tempImg = [UIImage]()
        tempImg = [img]
   //     self.imagess.removeAllObjects()
     //   self.tempImg.add(img)
        self.imagess = tempImg
        sendDta()
        
    }
    
    func sendDta(){
        let vc = UploadImgeViewController(nibName: "UploadImgeViewController", bundle: nil)
        vc.delegate = self
        vc.img = imagess
        if imgName.count == 0 {
            imgName.add("")
            vc.defaultImgName = imgName
        }else{
        vc.defaultImgName = imgName
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
   @objc  func deleteClick(_ sender: UIButton) {
    var id_Left : NSMutableArray = NSMutableArray()
    //filterArray1?[indexPath.row].image
    
        if selectedIndex == 1 {
            ModalController.showNegativeCustomAlertWith(title: "No Product Found".localized, msg: "" )
            return
        }
        if img_id.count > 0
            
        {
            img_ids.removeAll()
            
        
            
            
            
            
            
            
            
// new change
            
            
            var id_toDelete : NSMutableArray = NSMutableArray()
            
            for var i in (0..<img_id.count) {
                
                for var j in (0..<filterArray1!.count) {

                    if img_id.object(at: i) as! Int == filterArray1![j].id! {
                        id_toDelete.add(filterArray1![j].id!)
                    }else{
                        
                        if id_Left.contains(img_id.object(at: i) as! Int){
                            
                        }
                        else{
                        id_Left.add(img_id.object(at: i) as! Int)
                        }
                    }
                    
                }
            }
            
            if id_toDelete.count == 0 {
                ModalController.showNegativeCustomAlertWith(title: "Please select an Image".localized, msg: "" )
                return
            }
            
            for item in id_toDelete{
                img_ids = "\(item),\(img_ids)"
            }
            img_ids.removeLast()
            
            print(img_ids)
            
            
            
//            for item in img_id{
//                img_ids = "\(item),\(img_ids)"
//            }
//            img_ids.removeLast()
            
        }
        else {
            ModalController.showNegativeCustomAlertWith(title: "Please select an Image".localized, msg: "" )
            return
        }
        gallery_list_model.imgIds = img_ids
        gallery_list_model.deleteBusinessGalleryImg { (success, response) in
            if success{
                self.delete_gallery = response
                self.img_id.removeAllObjects()
                self.img_id = id_Left
                self.GalleryList()
            }
        }
        
    }
    
   @objc func check(_ sender: UIButton) {


        if textSTR.count > 0
        {
            filterArray1 = filterArray
        }
        else{
            filterArray1 = self.allGalleryList
        }
        let value = filterArray1?.count
        if  value ?? 0 > 0 {
            for i in 0...value! - 1 {
              
          if img_id.contains((self.filterArray1?[i].id)!)
                           {
    //            ids.remove((self.filterArray1?[i].pro_id)!)
                           }
                           else
                           {
                img_id.add((self.filterArray1?[i].id)!)
                           }
               
            }
            
        
        }
        if sender.isSelected == true {
                ischeck = false
            img_id.removeAllObjects()
            }
            else {
               ischeck = true
            }
       collectionVw.reloadData()

        
    }
    
  @objc func checkCancel(_ sender: UIButton) {


      if textSTR.count > 0
      {
          filterArray1 = filterArray
      }
      else{
          filterArray1 = self.allGalleryList
      }
      let value = filterArray1?.count
      if  value ?? 0 > 0 {
          for i in 0...value! - 1 {
            
        if img_id.contains((self.filterArray1?[i].id)!)
                         {
  //            ids.remove((self.filterArray1?[i].pro_id)!)
                         }
                         else
                         {
              img_id.add((self.filterArray1?[i].id)!)
                         }
             
          }
          
      
      }
 //     if sender.isSelected == true {
              ischeck = false
          img_id.removeAllObjects()
   //       }
//          else {
//             ischeck = true
//          }
     collectionVw.reloadData()

      
  }
    
    func imgaes(){
        let imagePicker = ImagePickerController()
        
       
        
       
            imagePicker.settings.selection.max = 10
        
        
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
            self.imagess = self.getAssetThumbnail(assets: assets)
            
            self.sendDta()
         //   self.UploadProfileImage_API()
            print("hdgjj")
            // User finished selection assets.
        })
    }
    
  
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
        
        var arrayOfImages = [UIImage]()
    
        for asset in assets {

            if let fileName = asset.value(forKey: "filename") as? String{
            print(fileName)
               
                if imgName.contains(fileName){
                    
                }
                else {
                    imgName.add(fileName)
                }
                
            }
          
          print(imgName)
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
    func add(tag: Int) {
        let vc = BranchBottomPopUpController(nibName: "BranchBottomPopUpController", bundle: nil)
        vc.isType = "Gallery"
              vc.choosenOption = { (string) in
            OpenGallery.shared.delegate = self
            OpenGallery.shared.viewControl = self
        
                
          //      ["Take Photo".localized,"Device Gallery".localized,"Fynoo Gallery".localized]
                
                let tk = "Take Photo".localized
                let dg = "Device Gallery".localized
                
            if string == "Take Photo" || string == tk {
                // self.imgaes()
                
                OpenGallery.shared.openCamera()
                
            }else if string == "Device Gallery" || string == dg {
                
             self.imgaes()
            
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
        //
    }
    func  openGallery()
    {
        let imagePicker = UIImagePickerController()
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
 

    func filter(tag: Int) {
        let vc = GalleryFilterViewController(nibName: "GalleryFilterViewController", bundle: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func GalleryList()
    {
        
        if selectedVl == 1000 {
            imgType = "Profile"
        }
        else if selectedVl == 1001 {
             imgType = "Branch"
        }
        else {
             imgType = "Product"
        }
        gallery_list_model.searchText = textSTR
        gallery_list_model.imageType = imgType
        gallery_list_model.getBusinessGalleryList { (success, response) in
              
            if success{
             
                self.gallery_list = response
              
                if self.gallery_list_model.pageNo == 0 {
                    self.allGalleryList.removeAll()
                }
                
                let count  = self.gallery_list?.data?.gallery?.count
                for i in 0..<count!{
                    self.allGalleryList.append((self.gallery_list?.data?.gallery?[i])!)
                    
                }
                print(self.allGalleryList.count,"galleryDta")
                
                if self.allGalleryList.count == 0 {
                  self.selectedIndex = 1
                }
                else{
                    self.selectedIndex = 0
                }
                  self.filterArray = self.allGalleryList
                self.collectionVw.reloadData()
            }
            else {
                
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ModalClass.stopLoading()
        GalleryList()
    }
}


