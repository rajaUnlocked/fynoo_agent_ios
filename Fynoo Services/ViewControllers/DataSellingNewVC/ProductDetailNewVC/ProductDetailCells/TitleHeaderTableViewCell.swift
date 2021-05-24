//
//  TitleHeaderTableViewCell.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 14/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class TitleHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var leaddingconst: NSLayoutConstraint!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
       self.nameLbl.font = UIFont(name:"\(fontNameBold)",size:16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
