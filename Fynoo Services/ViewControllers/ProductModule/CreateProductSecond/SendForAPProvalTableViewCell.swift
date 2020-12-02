//
//  SendForAPProvalTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 26/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class SendForAPProvalTableViewCell: UITableViewCell {
    @IBOutlet weak var approvalbtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        approvalbtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
