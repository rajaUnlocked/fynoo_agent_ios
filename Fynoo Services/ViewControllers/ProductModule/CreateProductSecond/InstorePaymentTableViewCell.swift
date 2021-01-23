//
//  InstorePaymentTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 17/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class InstorePaymentTableViewCell: UITableViewCell {
    @IBOutlet weak var digitalpay: UIButton!
    @IBOutlet weak var paylbl: UILabel!
    
    @IBOutlet weak var txt: UILabel!
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
       let fontNameLight = NSLocalizedString("LightFontName", comment: "")
      txt.font = UIFont(name:"\(fontNameLight)",size:12)
        paylbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
}
