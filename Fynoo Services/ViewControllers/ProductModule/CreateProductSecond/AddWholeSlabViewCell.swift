//
//  AddWholeSlabViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 14/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class AddWholeSlabViewCell: UITableViewCell {
    @IBOutlet weak var wholelbl: UILabel!
    @IBOutlet weak var wholesalelbl: UILabel!
    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var proName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        proName.font = UIFont(name:"\(fontNameLight)",size:12)
        wholelbl.font = UIFont(name:"\(fontNameBold)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
