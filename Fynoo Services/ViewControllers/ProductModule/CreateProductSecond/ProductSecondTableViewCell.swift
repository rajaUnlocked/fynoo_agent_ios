//
//  ProductSecondTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 13/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductSecondTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var txt: UITextField!
    @IBOutlet weak var addbtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       lbl.font = UIFont(name:"\(fontNameLight)",size:12)
        txt.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
