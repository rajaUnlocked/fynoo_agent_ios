//
//  ViewAllImagesNewDesignViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya on 11/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import AVKit

class ViewAllImagesNewDesignViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var collectionVw: UICollectionView!
    var cellImagesArray = [UIImage]()
    var selectedIndex = 0
     @IBOutlet weak var mainImageViewBtn: UIButton!
//    var viewAll_review_product_imgs : [reviewImageslist]?
//     var productViewReview_imgs : [Review_img]?
//     var viewAll_review_product_imgs_branch : [reviewImageslist]?
    var isFrom = ""
    var videoPlayed : ((String)->Void)?
    
    override func viewDidLayoutSubviews()
    {
        self.scrollToBottom()
    }
    func scrollToBottom() {
        DispatchQueue.main.async {
            let rect = self.collectionVw.layoutAttributesForItem(at: IndexPath(row: self.selectedIndex , section: 0))?.frame
            self.collectionVw.scrollRectToVisible(rect!, animated: false)
        }
    }
    override func viewDidLoad() {
        self.mainImageViewBtn.isHidden = true
        super.viewDidLoad()
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        headerView.titleHeader.text = "View Images".localized
        self.headerView.viewControl = self
        
        if isFrom == "PRODUCT" {
//            if viewAll_review_product_imgs?.count == 0{
//                ModalController.showNegativeCustomAlertWith(title: "No Image", msg: "")
//                collectionVw.isHidden = true
//            }else{
//                setupUIMethod()
//                collectionVw.delegate = self
//                collectionVw.dataSource = self
//                collectionVw.reloadData()
//            }
        }
        else if isFrom == "PRODUCTVIEW" {
//            if productViewReview_imgs?.count == 0{
//                ModalController.showNegativeCustomAlertWith(title: "No Image", msg: "")
//                collectionVw.isHidden = true
//            }else{
//                setupUIMethod()
//                collectionVw.delegate = self
//                collectionVw.dataSource = self
//                collectionVw.reloadData()
//            }
        }
            
        
        else{
            
//            if viewAll_review_product_imgs_branch?.count == 0{
//                ModalController.showNegativeCustomAlertWith(title: "No Image", msg: "")
//                collectionVw.isHidden = true
//            }else{
//                setupUIMethod()
//                collectionVw.delegate = self
//                collectionVw.dataSource = self
//                collectionVw.reloadData()
//            }
        }
    }
      @IBAction func mainImageViewClicked(_ sender: Any) {
            print("videoClicked")
//            let str = viewAll_review_product_imgs?[selectedIndex].media ?? ""
//                    videoPlayed!(str)

//            let videoURL = URL(string: viewAll_review_product_imgs?[selectedIndex].media ?? "")
//            let player = AVPlayer(url: videoURL!)
//            let playerViewController = AVPlayerViewController()
//            playerViewController.player = player
//            self.present(playerViewController, animated: true) {
//                playerViewController.player!.play()
//            }
        }

    func setupUIMethod(){
        if isFrom == "createproduct"
        {
             productImage.image = cellImagesArray[selectedIndex]
        }
       
//        else if isFrom == "PRODUCT" {
//            if viewAll_review_product_imgs?[selectedIndex].type == "vid" {
//                self.mainImageViewBtn.isHidden = false
//                productImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[selectedIndex].video_thumbnail ?? "", placeholder: "placeholder")
//            }else{
//                self.mainImageViewBtn.isHidden = true
//                productImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[selectedIndex].media ?? "", placeholder: "placeholder")
//            }
//
//        }
//       else if isFrom == "PRODUCTVIEW" {
//            if productViewReview_imgs?[selectedIndex].type == "vid" {
//                self.mainImageViewBtn.isHidden = false
//                productImage.setImageSDWebImage(imgURL: productViewReview_imgs?[selectedIndex].video_thumbnail ?? "", placeholder: "placeholder")
//            }else{
//                self.mainImageViewBtn.isHidden = true
//                productImage.setImageSDWebImage(imgURL: productViewReview_imgs?[selectedIndex].media ?? "", placeholder: "placeholder")
//            }
//
//        }
//        else{
//            if viewAll_review_product_imgs_branch?[selectedIndex].type == "vid" {
//                self.mainImageViewBtn.isHidden = false
//                productImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs_branch?[selectedIndex].video_thumbnail ?? "", placeholder: "placeholder")
//            }else{
//                self.mainImageViewBtn.isHidden = true
//                productImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs_branch?[selectedIndex].image ?? "", placeholder: "placeholder")
//            }
//        }
        collectionVw.register(UINib(nibName: "ViewAllImagesNewDesignCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewAllImagesNewDesignCollectionViewCell")
    }
    
    // MARK: - UICollectionViewMethods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1    //return number of sections in collection view
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFrom == "createproduct"
        {
         return cellImagesArray.count
        }
//        else if isFrom == "PRODUCT" {
//
//            if let value = viewAll_review_product_imgs?.count {
//                return value
//            }
//            return 0
//        }
//        else if isFrom == "PRODUCTVIEW" {
//
//            if let value = productViewReview_imgs?.count {
//                return value
//            }
//            return 0
//        }
//        else{
//            if let value = viewAll_review_product_imgs_branch?.count {
//                return value
//            }
//            return 0
//        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return proImageCell(index: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
          if isFrom == "createproduct" {
        productImage.image = cellImagesArray[selectedIndex]
        }
//        else if isFrom == "PRODUCT" {
//
//            if viewAll_review_product_imgs?[indexPath.row].type == "vid" {
//                self.mainImageViewBtn.isHidden = false
//                productImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[indexPath.row].video_thumbnail ?? "", placeholder: "video-icon")
//
//            }else{
//                self.mainImageViewBtn.isHidden = true
//                productImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[indexPath.row].media ?? "", placeholder: "placeholder")
//            }
//        }
//        else if isFrom == "PRODUCTVIEW" {
//
//            if productViewReview_imgs?[indexPath.row].type == "vid" {
//                self.mainImageViewBtn.isHidden = false
//                productImage.setImageSDWebImage(imgURL: productViewReview_imgs?[indexPath.row].video_thumbnail ?? "", placeholder: "video-icon")
//
//            }else{
//                self.mainImageViewBtn.isHidden = true
//                productImage.setImageSDWebImage(imgURL: productViewReview_imgs?[indexPath.row].media ?? "", placeholder: "placeholder")
//            }
//        }
        
//        else{
//            if viewAll_review_product_imgs_branch?[indexPath.row].type == "vid" {
//                self.mainImageViewBtn.isHidden = false
//                productImage.setImageSDWebImage(imgURL: productViewReview_imgs?[indexPath.row].video_thumbnail ?? "", placeholder: "video-icon")
//
//            }else{
//                self.mainImageViewBtn.isHidden = true
//                productImage.setImageSDWebImage(imgURL: productViewReview_imgs?[indexPath.row].media ?? "", placeholder: "placeholder")
//            }
//        }
        
        self.collectionVw.reloadData()
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
            let size = CGSize(width: 96 , height: 96 )
            if let layout = self.collectionVw.collectionViewLayout as? UICollectionViewFlowLayout{
                let width = UIScreen.main.bounds.width
                layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 20
            }
            return size
    }

    func proImageCell(index : IndexPath) -> UICollectionViewCell {
        let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: "ViewAllImagesNewDesignCollectionViewCell", for: index) as! ViewAllImagesNewDesignCollectionViewCell
      if isFrom == "createproduct" {
         cell.proImage.image = cellImagesArray[index.row]
        }
//        else if isFrom == "PRODUCT" {
//            if viewAll_review_product_imgs?[index.row].type == "vid" {
//                cell.proImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[index.row].video_thumbnail ?? "", placeholder: "video-icon")
//            }else{
//                cell.proImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[index.row].media ?? "", placeholder: "placeholder")
//            }
//        }
//        else if isFrom == "PRODUCTVIEW" {
//            if productViewReview_imgs?[index.row].type == "vid" {
//                cell.proImage.setImageSDWebImage(imgURL: productViewReview_imgs?[index.row].video_thumbnail ?? "", placeholder: "video-icon")
//            }else{
//                cell.proImage.setImageSDWebImage(imgURL: productViewReview_imgs?[index.row].media ?? "", placeholder: "placeholder")
//            }
//        }
        
//        else{
//            if viewAll_review_product_imgs_branch?[index.row].type == "vid" {
//                cell.proImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs_branch?[index.row].video_thumbnail ?? "", placeholder: "video-icon")
//            }else{
//                cell.proImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs_branch?[index.row].image ?? "", placeholder: "placeholder")
//            }
//        }
        
        if index.item == selectedIndex{
            cell.bgView.layer.borderWidth = 3
            cell.bgView.layer.borderColor = UIColor(red:236/255, green:74/255, blue:83/255, alpha: 1).cgColor
        }
        else {
            cell.bgView.layer.borderWidth = 0
            //   cell.bgView.layer.borderColor = UIColor.red
        }
        return cell
        
        //productplaceholder  // PLACEHOLDER IMAGE TO USE HERE
    }
}
