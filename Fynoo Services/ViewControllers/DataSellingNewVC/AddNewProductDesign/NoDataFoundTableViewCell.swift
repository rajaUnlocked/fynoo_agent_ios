//
//  NoDataFoundTableViewCell.swift
//  Fynoo
//
//  Created by IND-SEN-LP-046 on 04/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class NoDataFoundTableViewCell: UITableViewCell {

    @IBOutlet weak var goBackTop: NSLayoutConstraint!
    @IBOutlet weak var gobackBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
