//
//  otherTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 23/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class otherTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var addresstxtfield: UITextField!
    @IBOutlet weak var nametxtfield: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
       let fontNameLight = NSLocalizedString("LightFontName", comment: "")
      addresstxtfield.font = UIFont(name:"\(fontNameLight)",size:12)
          nametxtfield.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.nametxtfield.attributedPlaceholder = NSAttributedString(string: "Name".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        self.addresstxtfield.attributedPlaceholder = NSAttributedString(string: "Address".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
}
