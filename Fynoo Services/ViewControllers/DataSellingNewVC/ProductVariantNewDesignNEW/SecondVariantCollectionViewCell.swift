//
//  SecondVariantCollectionViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 19/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class SecondVariantCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var mainVw: UIView!
    @IBOutlet weak var valLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.SetFont()
    }
                                                 
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.valLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        
    }

}


