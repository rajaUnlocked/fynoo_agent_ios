//
//  PriceTopTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 12/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class PriceTopTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var titleLblLeading: NSLayoutConstraint!
    @IBOutlet weak var topConst: NSLayoutConstraint!
    
    @IBOutlet weak var TotalPriceLbl: UILabel!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       TotalPriceLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        titleLabel.font = UIFont(name:"\(fontNameLight)",size:16)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
