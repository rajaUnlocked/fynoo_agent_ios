//
//  TripAchievementViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 23/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class TripAchievementViewCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var attitudeName: UILabel!
    @IBOutlet weak var attitudeImg: UIImageView!
    @IBOutlet weak var aboveCount: UILabel!
    @IBOutlet weak var aboveLbl: UILabel!
    @IBOutlet weak var aboveImg: UIImageView!
    @IBOutlet weak var helpfulImg: UIImageView!
    @IBOutlet weak var helpfulCount: UILabel!
    @IBOutlet weak var helpful: UILabel!
    @IBOutlet weak var attitudeCount: UILabel!
    @IBOutlet weak var excellentImg: UIImageView!
    @IBOutlet weak var excellentService: UILabel!
    @IBOutlet weak var excellentCount: UILabel!
    
    
    @IBOutlet weak var tripAchivementLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
     var tripAchivementData : [trips_achievements]?
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       tripAchivementLbl.font = UIFont(name:"\(fontNameLight)",size:16)

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "TripAchivementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TripAchivementCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          guard let value = tripAchivementData?.count else{
              return 0
          }
          return value
      }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripAchivementCollectionViewCell", for: indexPath) as! TripAchivementCollectionViewCell
        
        cell.serviceNameLbl.text = tripAchivementData?[indexPath.row].trip_text
        cell.serviceImageView.sd_setImage(with: URL(string: tripAchivementData?[indexPath.row].trip_icon ?? ""), placeholderImage: UIImage(named: "flag_placeholder.png"))
        cell.serviceCountLbl.text = "\(tripAchivementData?[indexPath.row].trip_count ?? 0)"
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let size = CGSize(width: (screenWidth / 4) , height: (screenWidth / 4 + 20))
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let width = UIScreen.main.bounds.width
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
        return size
    }
      
    
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return 0
      }
}
