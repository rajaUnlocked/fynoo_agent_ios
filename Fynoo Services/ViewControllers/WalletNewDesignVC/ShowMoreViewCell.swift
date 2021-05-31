//
//  ShowMoreViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 03/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ShowMoreViewCell: UITableViewCell {

    @IBOutlet weak var showMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }
                                      
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.showMore.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
