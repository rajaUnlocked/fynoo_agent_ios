//
//  ReasonForChangeTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 03/10/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ReasonForChangeTableViewCell: UITableViewCell {
    @IBOutlet weak var txtvw: UITextView!
    @IBOutlet weak var upload: UIButton!
   
    @IBOutlet weak var count: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
