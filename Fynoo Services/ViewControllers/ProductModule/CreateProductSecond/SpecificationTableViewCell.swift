//
//  SpecificationTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 17/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class SpecificationTableViewCell: UITableViewCell {
    @IBOutlet weak var lftvw: UIView!
    @IBOutlet weak var outervw: UIView!
    @IBOutlet weak var trailconst: NSLayoutConstraint!
    
    @IBOutlet weak var dottedline: UILabel!
    @IBOutlet weak var varientlbl: UILabel!
    @IBOutlet weak var clickCheck: UIButton!
    @IBOutlet weak var downarrow: UIButton!
    @IBOutlet weak var dropdownLbl: UILabel!
    @IBOutlet weak var lockimg: UIImageView!
    @IBOutlet weak var lftLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       varientlbl.font = UIFont(name:"\(fontNameLight)",size:12)
         dropdownLbl.font = UIFont(name:"\(fontNameLight)",size:12)
         lftLbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
