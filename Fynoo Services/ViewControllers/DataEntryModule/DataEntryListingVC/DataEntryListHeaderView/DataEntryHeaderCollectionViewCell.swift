//
//  DataEntryHeaderCollectionViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 01/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var leftImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bottomLbl: UILabel!
    
    @IBOutlet weak var clickedBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
        
      
    }
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.nameLbl.font = UIFont(name:"\(fontNameLight)",size:16)
    }
          

}
