//
//  SimilarProItemCollectionViewCell.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 14/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class SimilarProItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var currLbl: UILabel!
    @IBOutlet weak var proNameLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
     let fontNameLight = NSLocalizedString("LightFontName", comment: "")
         let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
      self.priceLbl.font = UIFont(name:"\(fontNameBold)",size:10)
         self.currLbl.font = UIFont(name:"\(fontNameLight)",size:8)
         self.proNameLbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

}
