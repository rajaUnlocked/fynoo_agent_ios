//
//  AgentCompanyServicesTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 03/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class AgentCompanyServicesTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    let agentServiceCellReuseId = "ServiceCollectionViewCell"
    var AgentServicesOnCollection:AgentService?
    
    var selectedArray:NSMutableArray = NSMutableArray()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var agentSignUPModal = AgentSignUPModal()
    override func awakeFromNib() {
        super.awakeFromNib()
    //Comment if you set Datasource and delegate in .xib
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
         
        self.collectionViewFrame()
              //————————register the xib for collection view cell————————————————
    let cellNib = UINib(nibName: "ServiceCollectionViewCell", bundle: nil)
    self.collectionView.register(cellNib, forCellWithReuseIdentifier: agentServiceCellReuseId)
        
    }

    func collectionViewFrame(){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let widthColl = self.collectionView.bounds.size.width
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: widthColl/2, height: 30)
//        flowLayout.minimumLineSpacing = 10.0
        flowLayout.minimumInteritemSpacing = 0.0
        self.collectionView.collectionViewLayout = flowLayout

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (AgentServicesOnCollection?.data?.services_list?.count) ?? 0
        
        }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: agentServiceCellReuseId, for: indexPath) as! ServiceCollectionViewCell
        
        let serviceList = AgentServicesOnCollection?.data?.services_list![indexPath.item]
        
        cell.serviceTypeImage.sd_setImage(with: URL(string: serviceList?.service_icon ?? ""), placeholderImage: UIImage(named: "subscription_placeholder.png"))
        
        if selectedArray.count > 0 {
            cell.checkBoxBtn.setImage(UIImage(named: "uncheck") , for: .normal)
        }else{
            cell.checkBoxBtn.setImage(UIImage(named: "uncheck_red"), for: .normal)
        }
        
        if selectedArray.contains(serviceList?.service_id){
            cell.checkBoxBtn.isSelected = true
            
        }else{
            cell.checkBoxBtn.isSelected = false
            
        }
        
        
        
        cell.serviceNameLbl.text = serviceList?.service_name
        
        
        cell.tag = indexPath.row
        return cell
    }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
             let serviceList = AgentServicesOnCollection?.data?.services_list![indexPath.item]
                let array = serviceList?.service_id
            
                  if selectedArray.contains(array){
                        selectedArray.remove(array)
                 }else{
                        selectedArray.add(array)
                }
            appDelegate.selectServiceStr = selectedArray.componentsJoined(by: ",")
             appDelegate.selectServiceStr = selectedArray.componentsJoined(by: ",")
                   
//            if serviceCount.count != 0 {
            
            NotificationCenter.default.post(name: Notification.Name("changeServiceIcon"), object: nil, userInfo: nil)
//            }
                    print("indexPath -", selectedArray)
                   self.collectionView.reloadData()

    }
        
}
