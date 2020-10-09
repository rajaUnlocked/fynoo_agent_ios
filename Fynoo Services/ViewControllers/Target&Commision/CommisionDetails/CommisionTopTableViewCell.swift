//
//  CommisionTopTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 09/10/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class CommisionTopTableViewCell: UITableViewCell {
    @IBOutlet weak var serviceicon: UIImageView!
    @IBOutlet weak var servicename: UILabel!
    
    @IBOutlet weak var percentagelbl: UILabel!
    @IBOutlet weak var detaillbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
