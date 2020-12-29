//
//  ExteriorTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 01/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ExteriorTableViewCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var TypeClicked: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var vieww: UIView!
    var showimgInteriorList:ShowImageList?
    var showimgExteriorList:ShowImageList?
    var branchId = ""
    var viewControl = BranchImageUploadController()
    
    var deleteHandler : ((Int,String)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "SEPhotographyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SEPhotographyCollectionViewCell");
        collectionView.delegate = self
        collectionView.dataSource = self
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @objc func deleteImage(_ sender:UIButton)
    {
        print(sender.tag)
        print(status.text)
        deleteHandler!(sender.tag,status.text!)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if showimgExteriorList?.data?.images_list!.count == 0{
            return 0
        }else{
            return showimgExteriorList?.data?.images_list!.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SEPhotographyCollectionViewCell", for: indexPath) as! SEPhotographyCollectionViewCell
        cell.imgView.layer.borderWidth = 0
        cell.checkBtn.tag = indexPath.row
        cell.checkBtn.addTarget(self, action: #selector(deleteImage(_:)), for: .touchUpInside)
        cell.imgView.sd_setImage(with: URL(string: ((showimgExteriorList?.data?.images_list?[indexPath.row].image)!)), placeholderImage: UIImage(named: "category_placeholder"))
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.frame.width
        
        let size = CGSize(width: (screenSize - 40)/4  , height: (screenSize - 40)/4)
        return size
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
}
