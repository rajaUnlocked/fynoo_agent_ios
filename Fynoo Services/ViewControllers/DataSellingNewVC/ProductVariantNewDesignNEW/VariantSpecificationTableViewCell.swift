//
//  VariantSpecificationTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 17/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
class VariantSpecificationTableViewCell: UITableViewCell ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var height2: NSLayoutConstraint!
    
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var underLbl: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var propertyLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var property2: UILabel!
    
    @IBOutlet weak var property2Value: UILabel!
       var varientList: ProductVariantListModel?
    var colorNameArr = ["Blue","Black","Green","Red","White"]
    var sizeArr = ["32 GB","64 GB"]
    var isType = false
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "ProductVariantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductVariantCollectionViewCell")
        self.collectionView.register(UINib.init(nibName: "SecondVariantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SecondVariantCollectionViewCell")
        
        
        
        // Initialization code
        self.SetFont()
    }
                                           
    func SetFont() {
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.propertyLbl.font = UIFont(name:"\(fontNameBold)",size:12)
        self.nameLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.property2.font = UIFont(name:"\(fontNameBold)",size:12)
        self.property2Value.font = UIFont(name:"\(fontNameLight)",size:12)
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
    }
 
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isType  {
            return varientList?.data?.pro_variant?[section].variant_filter_list?.count ?? 0
        }
        else {
            return 5
        }
     
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isType {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondVariantCollectionViewCell", for: indexPath) as! SecondVariantCollectionViewCell
            
            let value = varientList?.data?.pro_variant?[indexPath.section].variant_filter_list
            cell.valLbl.text = value?[indexPath.row ].filter_value
            
            if varientList?.data?.pro_variant?[indexPath.section].filter_value == value?[indexPath.row ].filter_value {
                cell.mainVw.backgroundColor = .clear
            }
            else {
           cell.mainVw.borderColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
                      cell.mainVw.borderWidth = 0.5
                      cell.mainVw.cornerRadius = 2
                      cell.img.isHidden = true
            }
            return cell
        }
        else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductVariantCollectionViewCell", for: indexPath) as! ProductVariantCollectionViewCell
            property2.isHidden = true
            property2Value.isHidden = true
            cell.nameLbl.text = colorNameArr[indexPath.row]
           
            return cell
        }
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isType  {
             return CGSize(width: 60, height: 26)
        }
        return CGSize(width:55, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if isType {
            return 10
        }
        else {
            return 0
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if isType{
          return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}





