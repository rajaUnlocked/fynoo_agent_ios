//
//  SelectSubCat.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 11/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class SelectSubCat: UICollectionViewCell {
   @IBOutlet weak var innervw: UIImageView!
    
    @IBOutlet weak var subCat: UIImageView!
    @IBOutlet weak var subCatTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
    subCatTitle.font = UIFont(name:"\(fontNameLight)",size:8)
    }

}
