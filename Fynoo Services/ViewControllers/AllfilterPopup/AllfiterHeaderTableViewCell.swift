//
//  AllfiterHeaderTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 07/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class AllfiterHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var trailingconstraints: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraints: NSLayoutConstraint!
    @IBOutlet weak var underline: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var leftLbl: UILabel!
 
    @IBOutlet var rightBtn: UIButton!
    
    @IBOutlet var clickBtn: UIButton!
    
    @IBOutlet weak var leftLblLeading: NSLayoutConstraint!
    @IBOutlet weak var rightBtnTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var rightBtnWidth: NSLayoutConstraint!
    
    @IBOutlet weak var rightBtnHeight: NSLayoutConstraint!
    
    @IBOutlet weak var crossBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
   let fontNameLight = NSLocalizedString("LightFontName", comment: "")
   leftLbl.font =  UIFont(name: "\(fontNameLight)", size: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
