//
//  SelectCategoryCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 11/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class SelectCategoryCell: UITableViewCell {

    
    
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    @IBOutlet weak var catImg: UIImageView!
    @IBOutlet weak var catTitle: UILabel!
    @IBOutlet weak var selectedImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       catTitle.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
