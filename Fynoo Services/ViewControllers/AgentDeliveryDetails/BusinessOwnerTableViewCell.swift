//
//  BusinessOwnerTableViewCell.swift
//  Fynoo Services
//
//  Created by Apple on 20/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import Cosmos
class BusinessOwnerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblBoName : UILabel!
    @IBOutlet weak var lblBoAddress : UILabel!
    @IBOutlet weak var bo_rating : UILabel!
    @IBOutlet weak var bo_total_rating : UILabel!
    @IBOutlet weak var imgbo_pic : UIImageView!
    @IBOutlet weak var ratingCosmosView: CosmosView!

    @IBOutlet weak var btnNavWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
