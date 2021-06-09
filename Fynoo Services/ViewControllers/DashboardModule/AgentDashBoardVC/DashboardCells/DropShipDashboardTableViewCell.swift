//
//  DropShipDashboardTableViewCell.swift
//  Fynoo Services
//
//  Created by Aishwarya on 17/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class DropShipDashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var currencycode: UILabel!
    @IBOutlet weak var commisionprice: UILabel!
    @IBOutlet weak var soldprice: UILabel!
    @IBOutlet weak var proprice: UILabel!
    @IBOutlet weak var commisionlbl: UILabel!
    @IBOutlet weak var soldproductlbl: UILabel!
    @IBOutlet weak var productlbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        self.bgView.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: (screenWidth - 40))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
