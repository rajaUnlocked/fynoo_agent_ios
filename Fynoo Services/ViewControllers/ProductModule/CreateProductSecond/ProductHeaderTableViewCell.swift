//
//  ProductHeaderTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 13/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var online: UIButton!
    @IBOutlet weak var specification: UIButton!
    
    @IBOutlet weak var btmlbl: UILabel!
    @IBOutlet weak var instore: UIButton!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        online.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
          instore.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
          specification.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
