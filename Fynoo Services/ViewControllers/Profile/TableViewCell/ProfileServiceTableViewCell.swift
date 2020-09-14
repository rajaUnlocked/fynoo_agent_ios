//
//  ProfileServiceTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 09/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ProfileServiceTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
  
    
    @IBOutlet weak var collectionView: UICollectionView!
    var serviceList : [service_list_data]?
    var isForLanguage = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "ProfileServiceViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileServiceViewCell");
        collectionView.delegate = self
        collectionView.dataSource = self


        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            if isForLanguage{
                layout.scrollDirection = .horizontal
                
            }else{
                layout.scrollDirection = .vertical
            }
            
        }

      
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isForLanguage{
            return 4
        }else{
             return serviceList!.count
        }
       
      }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileServiceViewCell", for: indexPath) as! ProfileServiceViewCell
        if isForLanguage {
            
        }else{
            cell.serviceName.text = serviceList?[indexPath.row].service_name ?? ""

        }
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.frame.width
        if isForLanguage{
            let size = CGSize(width: (screenSize - 40)/4  , height: 50)
               return size
        }else{
            let size = CGSize(width: (screenSize - 40)/2  , height: 50)
               return size
        }
   
        
        
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
}
