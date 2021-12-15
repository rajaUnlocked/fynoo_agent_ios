//
//  NotificationNewsTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 04/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class NotificationNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var msg: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
