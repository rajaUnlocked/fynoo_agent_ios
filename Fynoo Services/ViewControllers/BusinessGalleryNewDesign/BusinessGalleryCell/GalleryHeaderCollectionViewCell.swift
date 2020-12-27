//
//  GalleryHeaderCollectionViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 27/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class GalleryHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        titleLbl.font = UIFont(name:"\(fontNameLight)",size:16)
    }

}
