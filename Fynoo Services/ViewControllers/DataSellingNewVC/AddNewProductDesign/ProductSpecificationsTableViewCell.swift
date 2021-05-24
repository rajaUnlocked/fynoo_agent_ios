//
//  ProductSpecificationsTableViewCell.swift
//  Fynoo
//
//  Created by IND-SEN-LP-039 on 06/08/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ProductSpecificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var leftView: UIView!
    
    @IBOutlet weak var sepecificationsValueLbl: UILabel!
    @IBOutlet weak var specificationNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
                      
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.specificationNameLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.sepecificationsValueLbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
