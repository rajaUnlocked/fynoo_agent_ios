//
//  TargetprogressTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 07/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class TargetprogressTableViewCell: UITableViewCell {
    @IBOutlet weak var progressvw: UIProgressView!
    
    @IBOutlet weak var targetimg: UIImageView!
    @IBOutlet weak var countlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
