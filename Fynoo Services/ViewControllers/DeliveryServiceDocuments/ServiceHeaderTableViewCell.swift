//
//  ServiceHeaderTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 23/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ServiceHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var deliverysercicedoc: UILabel!
    @IBOutlet weak var clickednewcar: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        deliverysercicedoc.font = UIFont(name:"\(fontNameLight)",size:16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
