//
//  ViewAllImagesOfProductViewController.swift
//  Fynoo
//
//  Created by SedanMacBookAir on 05/08/21.
//  Copyright © 2021 neerajTiwari. All rights reserved.
//

import UIKit

class ViewAllImagesOfProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var collectionVwUpper : UICollectionView!
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var watermarkCentreConstant: NSLayoutConstraint!
   

    var cellImagesArray = [String]()
    var selectedIndex = Int()
    var checkSelect = false
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        watermarkCentreConstant.constant = -(self.view.frame.width - 285)/2
        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        headerView.titleHeader.text = "View Images".localized
        self.headerView.viewControl = self
        collectionVwUpper.delegate = self
        collectionVwUpper.dataSource = self
        collectionVwUpper.reloadData()
        collectionVwUpper.isPagingEnabled = true
        collectionVwUpper.showsHorizontalScrollIndicator = false
        // collectionVwUpper.translatesAutoresizingMaskIntoConstraints = false
        
        collectionVw.delegate = self
        collectionVw.dataSource = self
        collectionVw.reloadData()
        
        //        cellImagesArray = [#imageLiteral(resourceName: "card-icon"),#imageLiteral(resourceName: "logo_NEW"),#imageLiteral(resourceName: "loginIntro1"),#imageLiteral(resourceName: "tqrcodeSampleImg"),#imageLiteral(resourceName: "suv"),#imageLiteral(resourceName: "loginIntro3")]
        registerNib()
//        if cellImagesArray.count>1 {
//            cellImagesArray.removeFirst()
//            cellImagesArray.removeFirst()
//        }
        //cellImagesArray.reverse()
    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        let indpath = IndexPath(item: selectedIndex, section: 0)
        self.collectionVw.scrollToItem(at: indpath, at: .centeredHorizontally, animated: true)
     }
    
    func registerNib(){
        collectionVw.register(UINib(nibName: "ViewAllImagesNewDesignCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewAllImagesNewDesignCollectionViewCell")
        
        collectionVwUpper.register(UINib(nibName: "ViewAllImgOfProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ViewAllImgOfProductCollectionViewCell")
    }
    
    
    // MARK: - UICollectionViewMethods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1    //return number of sections in collection view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionVwUpper {
            return proImageCellUpper(index: indexPath)
        }else
        {
            return proImageCell(index: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionVw {
            checkSelect = true
            selectedIndex = indexPath.item
            print("selected Index = \(selectedIndex)")
            collectionVwUpper.setNeedsLayout()
            collectionVwUpper.layoutIfNeeded()
            collectionVw.reloadData()
            
            self.collectionVwUpper.scrollToItem(at:IndexPath(item: selectedIndex, section: 0), at: .right, animated: false)
            collectionVwUpper.layoutSubviews()
            
            collectionVwUpper.reloadData()
            
          
            
            //            for cell in collectionVw.visibleCells {
            //                   let indexPath = collectionVw.indexPath(for: cell)
            //                   print(indexPath)
            //
            ////                collectionVwUpper.scrollToItem(
            ////                    at: NSIndexPath(item:selectedIndex, section: 0) as IndexPath,
            ////                    at:[],
            ////                    animated: false)
            //
            //                self.collectionVwUpper.scrollToItem(at:IndexPath(item: selectedIndex, section: 0), at: .left, animated: false)
            //
            //                collectionVwUpper.reloadData()
            //
            //               }
            
            //            collectionVwUpper.selectItem(at: [0, selectedIndex], animated: false, scrollPosition: .centeredHorizontally)
            
            
        }else
        {
            
            let url = URL(string:cellImagesArray[indexPath.row])
            if let data = try? Data(contentsOf: url!)
            {
                let image: UIImage = UIImage(data: data)!
                let imageInfo = GSImageInfo(image: image, imageMode: .aspectFit)
                let transitionInfo = GSTransitionInfo(fromView: collectionVwUpper)
                let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
                imageViewer.dismissCompletion = {
                    print("dismiss")
                }
                
                present(imageViewer, animated: true)
                
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == collectionVwUpper {
            checkSelect = false
        }else
        {
            checkSelect = true
        }
    }
    
    
    
    // Mark ---collectionviewScroll manage -----
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
        for cell in collectionVwUpper.visibleCells {
            let indexPathh = collectionVwUpper.indexPath(for: cell)
            
            if checkSelect == false {
                self.collectionVw.scrollToItem(at:IndexPath(item: indexPathh?.item ?? 0, section: 0), at: .right, animated: true)
            }
            
            //              for cell in collectionVw.visibleCells {
            //                  let indexPath = collectionVw.indexPath(for: cell)
            //                  if indexPath == indexPathh {
            //                    selectedIndex = indexPathh!.item
            //                    print("selected Index = \(selectedIndex)")
            //
            //                  }else
            //                  {
            //                  }
            //              }
            
            
        }
        let visibleRects = CGRect(origin: collectionVwUpper.contentOffset, size: collectionVwUpper.bounds.size)
        let visiblePoints = CGPoint(x: visibleRects.midX, y: visibleRects.midY)
        
        let visibleIndexPaths = collectionVwUpper.indexPathForItem(at: visiblePoints)
        
        print(" visible = \(visibleIndexPaths!.item)")
        
        selectedIndex = visibleIndexPaths!.item
        collectionVw.reloadData()
        collectionVwUpper.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let width = self.view.frame.width
        if collectionView == collectionVwUpper {
            let size = CGSize(width: screenWidth, height: screenWidth )
            if let layout = self.collectionVwUpper.collectionViewLayout as? UICollectionViewFlowLayout{
             
                let width = UIScreen.main.bounds.width
                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
            }
            return size
        }else
        {
            
            let size = CGSize(width: 96 , height: 96 )
            if let layout = self.collectionVw.collectionViewLayout as? UICollectionViewFlowLayout{
                let width = UIScreen.main.bounds.width
                layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 20
            }
            return size
        }
    }
    
    
    func proImageCellUpper(index : IndexPath) -> UICollectionViewCell {
        let cell = collectionVwUpper.dequeueReusableCell(withReuseIdentifier: "ViewAllImgOfProductCollectionViewCell", for: index) as! ViewAllImgOfProductCollectionViewCell
        
        //        cell.proImage.image = cellImagesArray[index.row]
        
        cell.proImage.sd_setImage(with: URL(string: cellImagesArray[index.row]), placeholderImage: UIImage(named: "banner_placeholder"))
        
        
        if checkSelect == true {
            
            cell.proImage.sd_setImage(with: URL(string: cellImagesArray[selectedIndex]), placeholderImage: UIImage(named: "banner_placeholder"))
            
        }
        
        
        return cell
        
        //productplaceholder  // PLACEHOLDER IMAGE TO USE HERE
    }
    
    
    func proImageCell(index : IndexPath) -> UICollectionViewCell {
        let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: "ViewAllImagesNewDesignCollectionViewCell", for: index) as! ViewAllImagesNewDesignCollectionViewCell
        
        cell.proImage.sd_setImage(with: URL(string: cellImagesArray[index.row]), placeholderImage: UIImage(named: "banner_placeholder"))
        
        
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
