//
//  ProductVariantCollectionViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 17/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductVariantCollectionViewCell: UICollectionViewCell {
var arr1 = ["1","2","3","4","5"]
    var arr2 = ["a","b"]
    var aar3 = [String]()
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.SetFont()
    }
                                                 
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.lbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.nameLbl.font = UIFont(name:"\(fontNameLight)",size:8)
        
    }

}
