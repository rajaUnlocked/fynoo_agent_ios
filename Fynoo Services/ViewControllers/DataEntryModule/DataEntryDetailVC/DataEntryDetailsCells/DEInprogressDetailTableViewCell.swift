//
//  DEInprogressDetailTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 23/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DEInprogressDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var workConfirmtionBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }
                
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.workConfirmtionBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func workConfirmationClicked(_ sender: Any) {
    }
    
    
}
