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
    
    @IBOutlet weak var mainImageViewBtn: UIButton!
    
    @IBOutlet weak var collectionVw: UICollectionView!
    var cellImagesArray = [UIImage]()
    var selectedIndex = 0
//     var viewAll_review_product_imgs : [productReviewImageslist]?
//
//    var viewAll_review_branch_imgs : [reviewImageslist]?
     var isFrom = ""
   // var viewAll : [productReviewImageslist]?
    
    override func viewDidLayoutSubviews()
    {
//       self.scrollToBottom()
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let rect = self.collectionVw.layoutAttributesForItem(at: IndexPath(row: self.selectedIndex , section: 0))?.frame
            self.collectionVw.scrollRectToVisible(rect!, animated: false)
        }
    }
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        self.mainImageViewBtn.isHidden = true
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
            
        else if isFrom == "BRANCH"{
//            if viewAll_review_branch_imgs?.count == 0{
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
            if cellImagesArray.count == 0{
                ModalController.showNegativeCustomAlertWith(title: "No Image", msg: "")
                collectionVw.isHidden = true
            }else{
                setupUIMethod()
                collectionVw.delegate = self
                collectionVw.dataSource = self
                collectionVw.reloadData()
            }
        }
    }
    
    @IBAction func mainImageViewClicked(_ sender: Any) {
        print("videoClicked")
        
        
        if isFrom == "PRODUCT"{
//            if viewAll_review_product_imgs?[selectedIndex].type == "vid" {
//                let videoURL = URL(string: viewAll_review_product_imgs?[selectedIndex].media ?? "")
//                let player = AVPlayer(url: videoURL!)
//                let playerViewController = AVPlayerViewController()
//                playerViewController.player = player
//                self.present(playerViewController, animated: true) {
//                    playerViewController.player!.play()
//                }
//                
//                if let url = URL(string: self.viewNewPoductDetailData?.data?.pro_video_url ?? ""){
//                    
//                    let player1 = AVPlayer(url: url)
//                    let vc = AVPlayerViewController()
//                    vc.player = player1
//                    
//                    self.present(vc, animated: true) {
//                        vc.player?.play()
//                    }
//                    return
//                    let player = AVPlayer(url: url)
//                    let avController = AVPlayerViewController()
//                    avController.player = player
//                    // your desired frame
//                    avController.view.frame = self.view.bounds
//                    self.view.addSubview(avController.view)
//                    
//                    player.play()
//                }
// 
                
            //}
        }
        else if isFrom == "BRANCH"{
//              if viewAll_review_branch_imgs?[selectedIndex].media_type != "IMAGE" {
//                let videoURL = URL(string: viewAll_review_branch_imgs?[selectedIndex].image ?? "")
//                let player = AVPlayer(url: videoURL!)
//                let playerViewController = AVPlayerViewController()
//                playerViewController.player = player
//                self.present(playerViewController, animated: true) {
//                    playerViewController.player!.play()
//                }
//
//            }
        }
        else{

//            let videoURL = URL(string: viewAll_review_product_imgs?[selectedIndex].media ?? "")
//            let player = AVPlayer(url: videoURL!)
//            let playerViewController = AVPlayerViewController()
//            playerViewController.player = player
//            self.present(playerViewController, animated: true) {
//                playerViewController.player!.play()
//            }
        }
        
      
        
//        if let url = URL(string: viewAll_review_product_imgs?[selectedIndex].media ?? "") {
//            let player = AVPlayer(url: url)
//            let avController = AVPlayerViewController()
//            avController.player = player
//            // your desired frame
//            avController.view.frame = self.productImage.frame
//            self.productImage.addSubview(avController.view)
//            self.addChild(avController)
//            player.play()
//        }
    }
    
    
    func setupUIMethod(){
        if isFrom == "PRODUCT" {
//            if viewAll_review_product_imgs?[selectedIndex].type == "vid" {
//                self.mainImageViewBtn.isHidden = false
//               productImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[selectedIndex].video_thumbnail ?? "", placeholder: "placeholder")
           // }
       // else{
//                self.mainImageViewBtn.isHidden = true
//               productImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[selectedIndex].media ?? "", placeholder: "placeholder")
           // }
            
        }
            
      else if isFrom == "BRANCH" {
//              if viewAll_review_branch_imgs?[selectedIndex].media_type != "IMAGE" {
//                  self.mainImageViewBtn.isHidden = false
//                 productImage.setImageSDWebImage(imgURL: viewAll_review_branch_imgs?[selectedIndex].image ?? "", placeholder: "placeholder")
//              }else{
//                  self.mainImageViewBtn.isHidden = true
//                 productImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[selectedIndex].image ?? "", placeholder: "placeholder")
//              }
              
          }
        
        else{
            productImage.image = cellImagesArray[selectedIndex]
        }
        collectionVw.register(UINib(nibName: "ViewAllImagesNewDesignCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewAllImagesNewDesignCollectionViewCell")
    }
    
    // MARK: - UICollectionViewMethods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1    //return number of sections in collection view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFrom == "PRODUCT" {
//
//            if let value = viewAll_review_product_imgs?.count {
//                return value
//            }
//            return 0
        }
        else if isFrom == "BRANCH"{
//            if let value = viewAll_review_branch_imgs?.count {
//                           return value
//                       }
//                       return 0
        }
        
        else{
        return cellImagesArray.count
        }
        return cellImagesArray.count
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return proImageCell(index: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        if isFrom == "PRODUCT" {
            
//            if viewAll_review_product_imgs?[indexPath.row].type == "vid" {
//                self.mainImageViewBtn.isHidden = false
//                productImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[indexPath.row].video_thumbnail ?? "", placeholder: "video-icon")
//
//            }else{
//                  self.mainImageViewBtn.isHidden = true
//                productImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[indexPath.row].media ?? "", placeholder: "placeholder")
//            }
            
        }
        else if isFrom == "BRANCH" {
            
//            if viewAll_review_branch_imgs?[indexPath.row].media_type != "IMAGE" {
//                self.mainImageViewBtn.isHidden = false
//                productImage.setImageSDWebImage(imgURL: viewAll_review_branch_imgs?[indexPath.row].image ?? "", placeholder: "video-icon")
//
//            }else{
//                self.mainImageViewBtn.isHidden = true
//                productImage.setImageSDWebImage(imgURL: viewAll_review_branch_imgs?[indexPath.row].image ?? "", placeholder: "placeholder")
//            }
//
        }
        
        else{
            productImage.image = cellImagesArray[selectedIndex]
        }
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
        
        if isFrom == "PRODUCT" {
//            if viewAll_review_product_imgs?[index.row].type == "vid" {
//                cell.proImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[index.row].video_thumbnail ?? "", placeholder: "video-icon")
//            }else{
//                cell.proImage.setImageSDWebImage(imgURL: viewAll_review_product_imgs?[index.row].media ?? "", placeholder: "placeholder")
//            }
        }
        else if isFrom == "BRANCH" {
//            if viewAll_review_branch_imgs?[index.row].media_type == "IMAGE" {
//                cell.proImage.setImageSDWebImage(imgURL: viewAll_review_branch_imgs?[index.row].image ?? "", placeholder: "video-icon")
//            }else{
//                cell.proImage.setImageSDWebImage(imgURL: viewAll_review_branch_imgs?[index.row].image ?? "", placeholder: "placeholder")
//            }
        }
        
        else{
            cell.proImage.image = cellImagesArray[index.row]
            
        }
        
        if index.item == selectedIndex {
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
