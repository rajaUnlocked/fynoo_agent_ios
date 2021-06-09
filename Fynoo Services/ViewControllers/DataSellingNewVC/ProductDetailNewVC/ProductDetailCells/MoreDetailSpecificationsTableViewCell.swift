//
//  MoreDetailSpecificationsTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 20/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class MoreDetailSpecificationsTableViewCell: UITableViewCell {
    @IBOutlet weak var moreDetailLbl: UILabel!
    @IBOutlet weak var downIconImageView: UIImageView!
    
    @IBAction func moreDetailsClicked(_ sender: Any) {
    }
    
    @IBOutlet weak var moreDetailBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }
                        
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.moreDetailLbl.font = UIFont(name:"\(fontNameLight)",size:8)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
