//
//  topBranchTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 04/06/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class topBranchTableViewCell: UITableViewCell {

    @IBOutlet weak var toplbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
           let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        toplbl.font = UIFont(name:"\(fontNameLight)",size:16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
