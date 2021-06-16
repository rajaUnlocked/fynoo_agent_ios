//
//  InformationTableViewCell.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 12/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

class InformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblOrderId : UILabel!
    @IBOutlet weak var lblQty : UILabel!
    @IBOutlet weak var lblOrderDate : UILabel!
    @IBOutlet weak var order_price : UILabel!
    @IBOutlet weak var lblCurrencyCode : UILabel!
    @IBOutlet weak var lblStaticActualtotal : UILabel!
    @IBOutlet weak var imgPaymentIcon : UIImageView!
    @IBOutlet weak var imgbuyer : UIImageView!
    @IBOutlet weak var imgOrder : UIImageView!
    @IBOutlet weak var imgInvoice : UIImageView!
    
    @IBOutlet weak var lblBuyerInformation: UILabel!
    
    @IBOutlet weak var lblOrderInformation: UILabel!
    
    @IBOutlet weak var lblInvoiceCopy: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func SetFont() {

            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")

            let fontNameLight = NSLocalizedString("LightFontName", comment: "")

            

            self.lblBuyerInformation.font = UIFont(name:"\(fontNameLight)",size:12)

            self.lblOrderInformation.font = UIFont(name:"\(fontNameLight)",size:12)

            self.lblInvoiceCopy.font = UIFont(name:"\(fontNameLight)",size:12)
            self.lblStaticActualtotal.font = UIFont(name:"\(fontNameLight)",size:12)

        }
}
