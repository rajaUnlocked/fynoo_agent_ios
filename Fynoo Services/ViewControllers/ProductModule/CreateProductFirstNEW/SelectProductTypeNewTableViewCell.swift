//
//  SelectProductTypeNewTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 27/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class SelectProductTypeNewTableViewCell: UITableViewCell {
     @IBOutlet weak var rightBtnLeading: NSLayoutConstraint!
     
     @IBOutlet weak var leftLblLeading: NSLayoutConstraint!
     @IBOutlet weak var topConst: NSLayoutConstraint!
     @IBOutlet weak var bottomConst: NSLayoutConstraint!
     @IBOutlet weak var rgtbtn: UIButton!
     @IBOutlet weak var leftbtn: UIButton!
     @IBOutlet weak var btnleading: NSLayoutConstraint!
     @IBOutlet weak var rgtlbl: UILabel!
     @IBOutlet weak var lbl: UILabel!
     @IBOutlet weak var leftlbl: UILabel!
     @IBOutlet weak var leadingConst: NSLayoutConstraint!
     @IBOutlet weak var outervw: UIView!
     
     @IBOutlet weak var trailingConst: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        lbl.font = UIFont(name:"\(fontNameLight)",size:12)
         leftlbl.font = UIFont(name:"\(fontNameLight)",size:12)
         rgtlbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
