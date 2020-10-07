//
//  TripAchievementViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 23/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class TripAchievementViewCell: UITableViewCell {

    @IBOutlet weak var attitudeName: UILabel!
    @IBOutlet weak var attitudeImg: UIImageView!
    @IBOutlet weak var aboveCount: UILabel!
    @IBOutlet weak var aboveLbl: UILabel!
    @IBOutlet weak var aboveImg: UIImageView!
    @IBOutlet weak var helpfulImg: UIImageView!
    @IBOutlet weak var helpfulCount: UILabel!
    @IBOutlet weak var helpful: UILabel!
    @IBOutlet weak var attitudeCount: UILabel!
    @IBOutlet weak var excellentImg: UIImageView!
    @IBOutlet weak var excellentService: UILabel!
    @IBOutlet weak var excellentCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
