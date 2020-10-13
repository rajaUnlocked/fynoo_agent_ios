//
//  AgentDeliveryTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 22/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import Cosmos
class AgentDeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var clickservicedocument: UIButton!
    @IBOutlet weak var documentStatus: UIImageView!
    @IBOutlet weak var infoClicked: UIButton!
    @IBOutlet weak var switches: UIButton!
    @IBOutlet weak var editAmount: UIButton!
    @IBOutlet weak var delivery: UIImageView!
    @IBOutlet weak var cod: UILabel!
    @IBOutlet weak var earning: UILabel!
    @IBOutlet weak var langugae: UILabel!
    @IBOutlet weak var totalRating: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var avgRating: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var trip: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
