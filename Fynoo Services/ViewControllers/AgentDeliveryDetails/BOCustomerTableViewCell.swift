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
    
    var  delegate : AgentServiceListDelegate?
    
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
    @IBOutlet weak var lblTotalAcceptedOrder: UILabel!
    @IBOutlet weak var lblTotalOrder: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    
    @IBOutlet weak var lblStItem: UILabel!
    
    @IBOutlet weak var lblStExpectedelivery: UILabel!
    @IBOutlet weak var lblStAlmosttoalPrice: UILabel!
    
    @IBOutlet weak var viewForHideExpectedDelivery: NSLayoutConstraint!
    
    @IBOutlet weak var btnNavWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        SetFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
        func SetFont() {
    
                let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
    
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
    
           
    
                self.lblCustAddress.font = UIFont(name:"\(fontNameLight)",size:12)
    
                self.lblCustName.font = UIFont(name:"\(fontNameLight)",size:14)
    
            self.lblQty.font = UIFont(name:"\(fontNameLight)",size:10)
            self.lblOrderId.font = UIFont(name:"\(fontNameBold)",size:10)
            self.lblOrderDate.font = UIFont(name:"\(fontNameLight)",size:8)
            self.lblCustrating.font = UIFont(name:"\(fontNameLight)",size:12)
            self.lblCusttotalrating.font = UIFont(name:"\(fontNameLight)",size:12)
            self.lblTotalOrder.font = UIFont(name:"\(fontNameLight)",size:12)
            self.lblTotalAcceptedOrder.font = UIFont(name:"\(fontNameLight)",size:10)
    
            self.lblStAlmosttoalPrice.font = UIFont(name:"\(fontNameLight)",size:10)
            self.lblCurrencyCode.font = UIFont(name:"\(fontNameLight)",size:8)
            self.order_price.font = UIFont(name:"\(fontNameLight)",size:12)
            self.lblStExpectedelivery.font = UIFont(name:"\(fontNameLight)",size:12)
    
            self.lblTime.font = UIFont(name:"\(fontNameBold)",size:12)
            self.lblStItem.font = UIFont(name:"\(fontNameLight)",size:14)
          
            }
    
    @IBAction func navigationTapped(_ sender: Any) {
        self.delegate?.navigationClicked(self)
    }
    @IBAction func callTapped(_ sender: Any) {
        self.delegate?.callClicked(self)
    }
    @IBAction func messageTapped(_ sender: Any) {
        self.delegate?.messageClicked(self)
        
    }
    
}
