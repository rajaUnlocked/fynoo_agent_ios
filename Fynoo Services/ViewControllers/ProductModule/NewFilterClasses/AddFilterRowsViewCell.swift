//
//  AddFilterRowsViewCell.swift
//  Fynoo Business
//
//  Created by SENDAN on 05/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class AddFilterRowsViewCell: UITableViewCell {
  
    @IBOutlet weak var featureType: UITextField!
    @IBOutlet weak var minus: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
         let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        featureType.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
