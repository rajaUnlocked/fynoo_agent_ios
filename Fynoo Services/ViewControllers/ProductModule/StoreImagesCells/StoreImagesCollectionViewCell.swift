//
//  StoreImagesCollectionViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 16/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class StoreImagesCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var cancelbtn: UIButton!
    @IBOutlet weak var btypeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        btypeLbl.layer.masksToBounds = true
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        btypeLbl.font = UIFont(name:"\(fontNameLight)",size:10)
    }
   
}
