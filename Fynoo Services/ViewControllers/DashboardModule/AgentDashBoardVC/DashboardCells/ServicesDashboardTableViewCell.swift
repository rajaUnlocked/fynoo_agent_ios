//
//  ServicesDashboardTableViewCell.swift
//  Fynoo Services
//
//  Created by Aishwarya on 16/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

protocol ServicesDashboardTableViewCellDelegate: class {
    func addServiceClickedHome(id : Int, name : String, index : Int)
    func activateServiceClickedHome(id : Int, name : String, index : Int)
}


class ServicesDashboardTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ServiceSingleCollectionViewCellDelegate {

    weak var delegate: ServicesDashboardTableViewCellDelegate?
    @IBOutlet weak var collectionVw: UICollectionView!
    var serviceArr = NSMutableArray()
    var parent = UIViewController()
    
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
            
            let opt = "\((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "is_opt") as! NSNumber)"
        
             let serviceCode = ((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_code") as! NSString) as String
      let serviceStatus =  ModalController.toString(((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_status") as Any))
        
        if Int(opt) == 2 {
            
//            if  serviceStatus == "1" {
//                ModalController.showNegativeCustomAlertWith(title: "This service is disabled. Please contact Fynoo Admin for more information.".localized, msg: "")
//            }else{
                let nameStr = ((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_name") as! NSString) as String
                let idInt = Int((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_id") as! NSNumber)
                self.delegate?.addServiceClickedHome(id: idInt, name: nameStr,index: indexPath.item)
           // }
        }else if serviceCode == "DELIVERY" {
                let vc = AgentDeliveryViewController()
                vc.serviceID = ModalController.toString(((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_id") as! NSNumber) as Any) 
                parent.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = DataEntryListingViewController()
                 vc.serviceID = ModalController.toString(((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_id") as! NSNumber) as Any)
                vc.serviceName = ((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_name") as! NSString) as String
                vc.serviceIcon = ((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_icon") as! NSString) as String
                vc.serviceStatus  = ModalController.toString(((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_status") as Any))
                parent.navigationController?.pushViewController(vc, animated: true)
                

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
            let size = CGSize(width: (screenWidth / 2) - 15 , height: 150 )
            if let layout = self.collectionVw.collectionViewLayout as? UICollectionViewFlowLayout{
                let width = UIScreen.main.bounds.width
                layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
            }
            return size
    }

    func categoryCell(index : IndexPath) -> UICollectionViewCell {
        
    let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: "ServiceSingleCollectionViewCell", for: index) as! ServiceSingleCollectionViewCell
        cell.inprocessLbl.text = "Inprocess".localized
        cell.nameLbl.text = "  \((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "service_name") as! String)"
        cell.img.sd_setImage(with: URL(string: "\((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "service_icon") as! String)"), placeholderImage: UIImage(named: "moving-truck"))
        
        cell.countLbl.text = "\((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "inprogress_service_count") as! NSNumber)"
        cell.totalCountLbl.text = "\((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "inprogress_service_count") as! NSNumber)"
        let is_active = "\((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "is_active") as! NSNumber)"
        
        if is_active == "1" {
            cell.greenImg.image = UIImage(named: "green_service")
        }else{
            cell.greenImg.image = UIImage(named: "red_service")
        }
        let opt = "\((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "is_opt") as! NSNumber)"
        
        if Int(opt) == 2 {
            cell.plusImg.isHidden = false
            cell.plusOutlet.isHidden = false
            cell.totalCountLbl.isHidden = true
            cell.img.alpha = 0.4
            cell.nameLbl.alpha = 0.4
            cell.inprocessLbl.isHidden = true
            cell.greenImg.image = UIImage(named: "deactive_gray")
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
        
        
      
        
        cell.serviceID = Int((serviceArr.object(at: index.item) as! NSDictionary).object(forKey: "service_id") as! NSNumber)
        
        cell.delegate = self
        cell.ind = index.item
        return cell
    }
    
    func addServiceClicked(id : Int, name : String, index : Int) {
        self.delegate?.addServiceClickedHome(id: id, name: name,index: index)
    }
    
    func activateServiceClicked(id : Int, name : String, index : Int) {
        
        let opt = "\((serviceArr.object(at: index) as! NSDictionary).object(forKey: "is_opt") as! NSNumber)"
        
        if Int(opt) == 1 {
            self.delegate?.activateServiceClickedHome(id: id, name: name, index: index)
        }
        
    }
}
