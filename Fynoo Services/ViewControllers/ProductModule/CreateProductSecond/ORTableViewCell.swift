//
//  ORTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 17/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ORTableViewCell: UITableViewCell {

    @IBOutlet weak var orlbl: UILabel!
    @IBOutlet weak var techlbl: UILabel!
    @IBOutlet weak var count: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        techlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        orlbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
