//
//  BOCustomerTableViewCell.swift
//  Fynoo Services
//
//  Created by Apple on 20/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import Cosmos
class BOCustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCustName : UILabel!
    @IBOutlet weak var lblCustAddress : UILabel!
    @IBOutlet weak var lblCustrating : UILabel!
    @IBOutlet weak var lblCusttotalrating : UILabel!
    @IBOutlet weak var imgCustpic : UIImageView!
    @IBOutlet weak var ratingCosmosView: CosmosView!
    @IBOutlet weak var lblOrderId : UILabel!
    @IBOutlet weak var lblQty : UILabel!
    @IBOutlet weak var lblOrderDate : UILabel!
    @IBOutlet weak var order_price : UILabel!
    @IBOutlet weak var lblCurrencyCode : UILabel!
    @IBOutlet weak var imgPaymentIcon : UIImageView!

   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
