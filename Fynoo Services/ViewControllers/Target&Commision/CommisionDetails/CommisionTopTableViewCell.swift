//
//  CommisionTopTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 09/10/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class CommisionTopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var commisionlbl: UILabel!
    @IBOutlet weak var serviceicon: UIImageView!
    @IBOutlet weak var servicename: UILabel!
    
    @IBOutlet weak var commisionrangelbl: UILabel!
    @IBOutlet weak var percentagelbl: UILabel!
    @IBOutlet weak var detaillbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        commisionlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        servicename.font = UIFont(name:"\(fontNameLight)",size:20)
        detaillbl.font = UIFont(name:"\(fontNameLight)",size:12)
        commisionrangelbl.font = UIFont(name:"\(fontNameLight)",size:12)
        commisionrangelbl.font = UIFont(name:"\(fontNameLight)",size:21)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
