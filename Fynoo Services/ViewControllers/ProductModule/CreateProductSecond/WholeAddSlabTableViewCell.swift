//
//  WholeAddSlabTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 14/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class WholeAddSlabTableViewCell: UITableViewCell {
    @IBOutlet weak var addSlab: UIButton!
    
    @IBOutlet weak var slablbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        slablbl.font = UIFont(name:"\(fontNameLight)",size:6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
