//
//  purchasedHeaderTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 06/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class purchasedHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var rightLbl: UILabel!
    
    @IBOutlet weak var centerLbl: UILabel!
    @IBOutlet weak var leftLbl: UILabel!
    @IBOutlet weak var bottomLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       centerLbl.isHidden = true
    let fontNameLight = NSLocalizedString("LightFontName", comment: "")
    leftLbl.font = UIFont(name:"\(fontNameLight)",size:15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
