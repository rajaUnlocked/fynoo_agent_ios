//
//  AgentServiceList.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 24/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class AgentServiceList: UITableViewCell {

    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var totalRate: UILabel!
    @IBOutlet weak var avgRating: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
