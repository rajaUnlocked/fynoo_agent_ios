//
//  ProductVarientNewTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 19/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductVarientNewTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let CellReuseId = "ProductVarientNewCollectionViewCell"
    var totalRow = [ "1","2","3"]
     var parent = UIViewController()
    var varientCustomerProductList:viewCustomerProductDetailNew?
     var varientProductList:viewProductDetailNew?
     var isTypeFrom = ""
    @IBOutlet weak var heightConst: NSLayoutConstraint!
        override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionViewFrame()
        
        //————————register the xib for collection view cell————————————————
        let cellNib = UINib(nibName: "ProductVarientNewCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: CellReuseId)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func collectionViewFrame(){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
      
     flowLayout.itemSize = CGSize(width: screenWidth/2, height: 50)
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        self.collectionView.collectionViewLayout = flowLayout
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        if isTypeFrom == "CustomerProDetail" {
         
          return  self.varientCustomerProductList?.data?.pro_variant?.count ?? 0
        }
        else{
        return  self.varientProductList?.data?.pro_variant?.count ?? 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseId, for: indexPath) as! ProductVarientNewCollectionViewCell
        if isTypeFrom == "CustomerProDetail" {
            
            let varientList = varientCustomerProductList?.data?.pro_variant![indexPath.item]
            
            cell.leftImageView.sd_setImage(with: URL(string: varientList?.filter_icon ?? ""), placeholderImage: UIImage(named: "varient"))
            cell.firstNameLbl.text = varientList?.filter
            cell.secondNameLbl.text = varientList?.filter_value
            
            let varientCount = self.varientCustomerProductList?.data?.pro_variant?.count ?? 0
            if (varientCount) >= 1 {
                if  varientCount % 2 != 0  {
                    let totalRows = collectionView.numberOfItems(inSection: indexPath.section)
                    if indexPath.row == totalRows - 1 {
                        cell.firstNameLbl.textAlignment = .left
                        cell.secondNameLbl.textAlignment = .left
                    }else{
                        cell.firstNameLbl.textAlignment = .center;                   cell.secondNameLbl.textAlignment = .center;
                    }
                }else{
                    cell.firstNameLbl.textAlignment = .center;               cell.secondNameLbl.textAlignment = .center;
                }
            }
        }
        else {
            
            let varientList = varientProductList?.data?.pro_variant![indexPath.item]
            
            cell.leftImageView.sd_setImage(with: URL(string: varientList?.filter_icon ?? ""), placeholderImage: UIImage(named: "varient"))
            cell.firstNameLbl.text = varientList?.filter
            cell.secondNameLbl.text = varientList?.filter_value
            
            let varientCount = self.varientProductList?.data?.pro_variant?.count ?? 0
            if (varientCount) >= 1 {
                if  varientCount % 2 != 0  {
                    let totalRows = collectionView.numberOfItems(inSection: indexPath.section)
                    if indexPath.row == totalRows - 1 {
                        cell.firstNameLbl.textAlignment = .left
                        cell.secondNameLbl.textAlignment = .left
                    }else{
                        cell.firstNameLbl.textAlignment = .center;                   cell.secondNameLbl.textAlignment = .center;
                    }
                }else{
                    cell.firstNameLbl.textAlignment = .center;               cell.secondNameLbl.textAlignment = .center;
                }
            }
        }
        cell.tag = indexPath.row
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let flowLayout = UICollectionViewFlowLayout()

        
        if isTypeFrom == "CustomerProDetail"{

            let varientCount = self.varientCustomerProductList?.data?.pro_variant?.count ?? 0
            if (varientCount) >= 1 {
                if  varientCount % 2 != 0  {
                    let totalRows = collectionView.numberOfItems(inSection: indexPath.section)
                    if indexPath.row == totalRows - 1 {
                    flowLayout.itemSize = CGSize(width: screenWidth, height: 50)
                    }else{
                        flowLayout.itemSize = CGSize(width: screenWidth/2, height: 50)
                    }
                }else{
                    flowLayout.itemSize = CGSize(width: screenWidth/2, height: 50)
                }
             }
        }
        else{

            let varientCount = self.varientProductList?.data?.pro_variant?.count ?? 0
            if (varientCount) >= 1 {
                if  varientCount % 2 != 0  {
                    let totalRows = collectionView.numberOfItems(inSection: indexPath.section)
                    if indexPath.row == totalRows - 1 {
                    flowLayout.itemSize = CGSize(width: screenWidth, height: 50)
                    }else{
                        flowLayout.itemSize = CGSize(width: screenWidth/2, height: 50)
                    }
                }else{
                    flowLayout.itemSize = CGSize(width: screenWidth/2, height: 50)
                }
             }
        }
        
        return flowLayout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isTypeFrom == "CustomerProDetail"{
            let vc = VariantPRoductsViewController(nibName: "VariantPRoductsViewController", bundle: nil)
                  vc.productId = "\(self.varientCustomerProductList?.data?.pro_id ?? 0)"
                parent.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = VariantPRoductsViewController(nibName: "VariantPRoductsViewController", bundle: nil)
            vc.productId = "\(self.varientProductList?.data?.pro_id ?? 0)"
            parent.navigationController?.pushViewController(vc, animated: true)
        }
     
    }
}
