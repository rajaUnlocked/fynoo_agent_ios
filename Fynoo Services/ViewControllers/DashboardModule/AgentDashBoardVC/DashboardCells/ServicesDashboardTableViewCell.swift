//
//  ServicesDashboardTableViewCell.swift
//  Fynoo Services
//
//  Created by Aishwarya on 16/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

protocol ServicesDashboardTableViewCellDelegate: class {
    func addServiceClickedHome(id : Int, name : String)
}


class ServicesDashboardTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ServiceSingleCollectionViewCellDelegate {

    weak var delegate: ServicesDashboardTableViewCellDelegate?
    @IBOutlet weak var collectionVw: UICollectionView!
    var serviceArr = NSMutableArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCollectionVw() {
        collectionVw.register(UINib(nibName: "ServiceSingleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceSingleCollectionViewCell")
        self.collectionVw.delegate = self
        self.collectionVw.dataSource = self
    }
    
    // MARK: - UICollectionViewMethods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1    //return number of sections in collection view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serviceArr.count
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return categoryCell(index: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
            let size = CGSize(width: (screenWidth / 2) - 30 , height: 150 )
            if let layout = self.collectionVw.collectionViewLayout as? UICollectionViewFlowLayout{
                let width = UIScreen.main.bounds.width
                layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
            }
            return size
    }

    func categoryCell(index : IndexPath) -> UICollectionViewCell {
    let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: "ServiceSingleCollectionViewCell", for: index) as! ServiceSingleCollectionViewCell
        
        cell.nameLbl.text = "  \((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "service_name") as! String)"
        cell.img.sd_setImage(with: URL(string: "\((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "service_icon") as! String)"), placeholderImage: UIImage(named: "moving-truck"))
        
        cell.countLbl.text = "\((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "inprogress_service_count") as! NSNumber)"
        cell.totalCountLbl.text = "\((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "inprogress_service_count") as! NSNumber)"
        
        let opt = "\((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "is_opt") as! NSNumber)"
        
        if Int(opt) == 2 {
            cell.plusImg.isHidden = false
            cell.plusOutlet.isHidden = false
            cell.totalCountLbl.isHidden = true
            cell.img.alpha = 0.4
            cell.nameLbl.alpha = 0.4
            cell.inprocessLbl.isHidden = true
        }else{
            cell.img.alpha = 1.0
            cell.nameLbl.alpha = 1.0
            cell.plusImg.isHidden = true
            cell.plusOutlet.isHidden = true
            let serCount = "\((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "inprogress_service_count") as! NSNumber)"
            
            if serCount == "0" {
                cell.totalCountLbl.isHidden = true
                cell.inprocessLbl.isHidden = true
            }else{
                cell.totalCountLbl.isHidden = false
                cell.inprocessLbl.isHidden = false
            }
        }
        
        
        let is_active = "\((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "is_active") as! NSNumber)"
        
        if is_active == "1" {
            cell.greenImg.image = UIImage(named: "green_service")
        }else{
            cell.greenImg.image = UIImage(named: "red_service")
        }
        
        cell.serviceID = Int((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "service_id") as! NSNumber)
        
        cell.delegate = self
        return cell
    }
    
    func addServiceClicked(id : Int, name : String) {
        self.delegate?.addServiceClickedHome(id: id, name: name)
    }
}
