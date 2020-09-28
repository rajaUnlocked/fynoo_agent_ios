//
//  VehicleKindTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 28/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class VehicleKindTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var imgvw: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
