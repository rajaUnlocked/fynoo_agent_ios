//
//  VehicleDescriptionTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 24/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class VehicleDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var topconst: NSLayoutConstraint!
    @IBOutlet weak var downarrow: UIImageView!
    @IBOutlet weak var toplbl: UILabel!
    @IBOutlet weak var txt: UITextField!
    @IBOutlet weak var vw: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        toplbl.font = UIFont(name:"\(fontNameLight)",size:12)
        txt.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
