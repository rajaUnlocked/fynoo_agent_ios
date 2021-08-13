//
//  ViewImagesViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 24/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol ViewImagesViewControllerDelegate {
    func reloadPage()
}

class ViewImagesViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout , UIScrollViewDelegate{
    
    var imageNames : [Gallery_list_new]?
    
    @IBOutlet weak var collectionVw: UICollectionView!
    var currentImage = 0
    
    @IBOutlet weak var pageCtrl: UIPageControl!
    var delegate : ViewImagesViewControllerDelegate?
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var headerVw: NavigationView!
    var url = ""
    var img_id = ""
    var gallery_list_model = BusinessGalleryNewModel()
    var delete_gallery : DeleteBusinessGallery?
    var index = 0
    
    override func viewDidLayoutSubviews() {

        self.collectionVw.scrollToItem(at:IndexPath(item: index, section: 0), at: .right, animated: false)
    }

    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        

        
        if HeaderHeightSingleton.shared.LanguageSelected == "EN"{
               
                headerVw.titleHeader.text = "View Images".localized
            self.collectionVw.scrollToItem(at:IndexPath(item: index, section: 0), at: .right, animated: false)
                
            }else{
                
                headerVw.titleHeader.text = "عرض الصورة"
            self.collectionVw.scrollToItem(at:IndexPath(item: index, section: 0), at: .right, animated: false)
            }
       
        headerVw.viewControl = self
        
        
        
        collectionVw.register(UINib(nibName: "ViewImageitemCell", bundle: nil), forCellWithReuseIdentifier: "ViewImageitemCell");
        collectionVw.delegate = self
        collectionVw.dataSource = self
        
        

        // Do any additional setup after loading the view.
    }
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewImageitemCell", for: indexPath) as! ViewImageitemCell
        let str = imageNames![indexPath.row].image ?? ""
         cell.img.sd_setImage(with: URL(string:str ), placeholderImage: UIImage(named: "category_placeholder"))
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionVw.visibleCells {
            let indexPath = collectionVw.indexPath(for: cell)
            index = indexPath!.row
        }
    }
    
    
    @IBAction func deleteClick(_ sender: Any) {
        let alert = UIAlertController(title: "Message", message: "Are you sure you want to delete this image".localized, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "YES".localized, style: .default, handler: { (action) in
            
            self.deleteImage()
        }))
        
        alert.addAction(UIAlertAction(title: "NO".localized, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               let screenSize = collectionView.frame.width
               
            let size = CGSize(width: collectionView.frame.width , height: collectionView.frame.height)
               return size
               
               
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func deleteImage()
    {
        
        print(index)
        img_id = "\(imageNames?[index].id ?? 0)"
        
        gallery_list_model.imgIds = img_id
        gallery_list_model.deleteBusinessGalleryImg { (success, response) in
            if success{
                self.delete_gallery = response
                self.delegate?.reloadPage()
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    @IBAction func share(_ sender: UIButton) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let business_id = Singleton.shared.getUserId()
        let textToShare = "Check Out This Image".localized
        let Url = url
   //     if let myWebsite = URL(string: Url) {//Enter link to your app here
            
            let objectsToShare = [textToShare, Url, image ??  #imageLiteral(resourceName: "dataEntryService") ] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            //
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
//        }
        
    }
}
