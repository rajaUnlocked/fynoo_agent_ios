//
//  AddProductHeaderTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 06/03/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class AddProductHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var btmConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgLeading: NSLayoutConstraint!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var headerLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
