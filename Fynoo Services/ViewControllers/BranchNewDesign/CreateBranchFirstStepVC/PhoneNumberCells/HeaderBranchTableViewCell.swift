//
//  HeaderBranchTableViewCell.swift
//  Fynoo Business
//
//  Created by sanjay kumar on 06/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class HeaderBranchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var btnclick: UIButton!
    @IBOutlet weak var btnLeading: NSLayoutConstraint!
    @IBOutlet weak var topConst: NSLayoutConstraint!
    
    @IBOutlet weak var rgtlbl: UILabel!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    @IBOutlet weak var btnWidth: NSLayoutConstraint!
    
    @IBOutlet weak var rightarrow: UIButton!
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var trailingConstant: NSLayoutConstraint!
    @IBOutlet weak var leadingConstant: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
          let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        lbl.font = UIFont(name:"\(fontNameLight)",size:12)
         rgtlbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
