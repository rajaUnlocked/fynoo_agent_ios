//
//  spacingTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 26/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class spacingTableViewCell: UITableViewCell {

    @IBOutlet weak var leftborder: UILabel!
    
    @IBOutlet weak var rightborder: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
