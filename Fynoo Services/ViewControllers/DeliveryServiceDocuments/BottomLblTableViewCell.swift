//
//  BottomLblTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 03/10/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class BottomLblTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        lbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
