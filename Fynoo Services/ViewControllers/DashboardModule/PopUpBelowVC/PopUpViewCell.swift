//
//  PopUpViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 28/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class PopUpViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }
    func SetFont(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.lbl.font = UIFont(name:"\(fontNameLight)",size:13)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
