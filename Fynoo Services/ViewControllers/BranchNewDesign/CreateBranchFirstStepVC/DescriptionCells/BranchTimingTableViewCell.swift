//
//  BranchTimingTableViewCell.swift
//  Fynoo Business
//
//  Created by sanjay kumar on 14/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class BranchTimingTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var rgtlbl: UILabel!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    @IBOutlet weak var topConst: NSLayoutConstraint!
    @IBOutlet weak var containVW: UIView!
    @IBOutlet weak var downbtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
          let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       lbl.font = UIFont(name:"\(fontNameLight)",size:14)
         rgtlbl.font = UIFont(name:"\(fontNameLight)",size:14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
