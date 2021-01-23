//
//  UploadBottomTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 26/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class UploadBottomTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    var choosenOption : ((Int) -> Void)?

    @IBOutlet weak var imageNameLbl: UILabel!
    
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var selectType: UIButton!
 
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedIndex = 0
    var img = [UIImage]()
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        imageNameLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        name.font = UIFont(name:"\(fontNameLight)",size:12)
        typeLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        value.font = UIFont(name:"\(fontNameLight)",size:12)
        
        collectionView.register(UINib(nibName: "SEPhotographyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SEPhotographyCollectionViewCell");
        collectionView.delegate = self
        collectionView.dataSource = self
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return img.count
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SEPhotographyCollectionViewCell", for: indexPath) as! SEPhotographyCollectionViewCell
            cell.imgView.layer.borderWidth = 0
            cell.imgView.cornerRadius = 0
            cell.checkBtn.tag = indexPath.row
            cell.checkBtn.isHidden = true
            cell.imgView.image = img[indexPath.row].blurred(radius: 1.0, iterations: 1, ratio: 0.5, blendColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), blendMode: .hardLight)
//             cell.imgView.image = img[indexPath.row]
         
            if selectedIndex == indexPath.row{
                cell.imgView.layer.borderWidth = 3
                cell.imgView.layer.borderColor = UIColor.init(red: 28/255, green: 157/255, blue: 213/255, alpha: 1).cgColor
              cell.imgView.image = img[indexPath.row]
                 
            }

            return cell
        }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
          collectionView.reloadData()
        choosenOption!(indexPath.row)
      
     
    }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenSize = collectionView.frame.width
            
            let size = CGSize(width: (screenSize - 40)/4  , height: (screenSize - 40)/4)
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

    }
