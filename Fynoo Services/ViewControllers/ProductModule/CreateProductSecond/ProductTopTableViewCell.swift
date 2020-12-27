//
//  ProductTopTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 13/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductTopTableViewCell: UITableViewCell {
    @IBOutlet weak var pro_img: UIImageView!
    @IBOutlet weak var nobranchlbl: UILabel!
    @IBOutlet weak var viewbranch: UIButton!
    
    @IBOutlet weak var moredetails: UIButton!
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var barcode: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var pro_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
         nobranchlbl.font = UIFont(name:"\(fontNameLight)",size:12)
         descrip.font = UIFont(name:"\(fontNameLight)",size:12)
         currencylbl.font = UIFont(name:"\(fontNameLight)",size:12)
         barcode.font = UIFont(name:"\(fontNameLight)",size:12)
         status.font = UIFont(name:"\(fontNameLight)",size:12)
         pro_name.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    
    
    
    
    
}
