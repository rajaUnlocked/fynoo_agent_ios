//
//  InventoryDetailTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 14/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class InventoryDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLbl: UILabel!
    @IBOutlet weak var rightLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        leftLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        rightLbl.font = UIFont(name:"\(fontNameLight)",size:10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
