//
//  DECancellationTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 20/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DECancellationTableViewCell: UITableViewCell {

    @IBOutlet weak var cancelReasonLbl: UILabel!
    @IBOutlet weak var SelctionImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.cancelReasonLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
