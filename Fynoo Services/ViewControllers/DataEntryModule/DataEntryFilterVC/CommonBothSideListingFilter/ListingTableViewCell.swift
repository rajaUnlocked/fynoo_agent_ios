//
//  ListingTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 04/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        nameLbl.font = UIFont(name:"\(fontNameLight)",size:12)

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
