//
//  AddFeatureTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 18/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class AddFeatureTableViewCell: UITableViewCell {
    @IBOutlet weak var downarrow: UIImageView!
    @IBOutlet weak var vw: UIView!
    
    @IBOutlet weak var heighttopConst: NSLayoutConstraint!
    @IBOutlet weak var whatlbl: UILabel!
    @IBOutlet weak var addfeturelbl: UILabel!
    @IBOutlet weak var addfilter: UIButton!
    @IBOutlet weak var moredetail: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        moredetail.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:8)
        whatlbl.font = UIFont(name:"\(fontNameLight)",size:8)
        addfeturelbl.font = UIFont(name:"\(fontNameLight)",size:16)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
