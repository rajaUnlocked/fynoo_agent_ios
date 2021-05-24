//
//  ProductWarrentySupportTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 20/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductWarrentySupportTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomLblHeight: NSLayoutConstraint!
    @IBOutlet weak var warrentyDiscriptionlbl: UILabel!
    @IBOutlet weak var headerTxtLbl: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
                                  
    func SetFont() {
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerTxtLbl.font = UIFont(name:"\(fontNameBold)",size:12)
        self.warrentyDiscriptionlbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
