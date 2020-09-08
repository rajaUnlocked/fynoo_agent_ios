//
//  ServiceListTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 08/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ServiceListTableViewCell: UITableViewCell {

    @IBOutlet weak var clickvideo: UIButton!
    @IBOutlet weak var serviceimg: UIImageView!
    @IBOutlet weak var descriprange: UILabel!
    @IBOutlet weak var servicedescrip: UILabel!
    @IBOutlet weak var servicename: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
