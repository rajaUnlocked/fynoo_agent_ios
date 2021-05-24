//
//  ProductVariantDetailTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 17/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductVariantDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var avgRatingLbl: UILabel!
    @IBOutlet weak var ratingCountLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var proImg: UIImageView!
    
    @IBOutlet weak var currencyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }
                                       
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.nameLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.ratingCountLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.avgRatingLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.currencyLbl.font = UIFont(name:"\(fontNameLight)",size:8)
        self.priceLbl.font = UIFont(name:"\(fontNameLight)",size:18)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
