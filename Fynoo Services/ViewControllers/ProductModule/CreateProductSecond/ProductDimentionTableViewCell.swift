//
//  ProductDimentionTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 17/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductDimentionTableViewCell: UITableViewCell {
    @IBOutlet weak var bottomlbl: UILabel!
    
    @IBOutlet weak var txtLeading: NSLayoutConstraint!
    @IBOutlet weak var rgtlbl: UILabel!
    @IBOutlet weak var vw: UIView!
    @IBOutlet weak var lftlbl: UILabel!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var txt: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       rgtlbl.font = UIFont(name:"\(fontNameLight)",size:16)
         lftlbl.font = UIFont(name:"\(fontNameLight)",size:12)
         lbl.font = UIFont(name:"\(fontNameLight)",size:8)
         txt.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
