//
//  SingleButtonViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 14/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class SingleButtonViewCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         self.saveButton.setAllSideShadow(shadowShowSize: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
