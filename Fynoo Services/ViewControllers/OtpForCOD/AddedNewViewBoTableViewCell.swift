//
//  AddedNewViewBoTableViewCell.swift
//  Fynoo Agent
//
//  Created by SedanMacBookAir on 09/09/21.
//  Copyright © 2021 NeerajTiwari. All rights reserved.
//

import UIKit

class AddedNewViewBoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblOrderId : UILabel!
    @IBOutlet weak var lblBoxQty : UILabel!
    @IBOutlet weak var lblSize : UILabel!
    @IBOutlet weak var order_price : UILabel!
    @IBOutlet weak var lblCurrencyCode : UILabel!
    @IBOutlet weak var lblStDelivery : UILabel!
    @IBOutlet weak var imgPaymentIcon : UIImageView!
    @IBOutlet weak var lblStExpDelTime : UILabel!
    @IBOutlet weak var lblExpDelTime : UILabel!
   
    @IBOutlet weak var lblExptViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackUpperConstant: NSLayoutConstraint!
    @IBOutlet weak var viewExptDel : UIView!
    @IBOutlet weak var lblstCancelReason : UILabel!
    @IBOutlet weak var lblCancelReason : UILabel!
    
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
        
            self.lblStExpDelTime.font = UIFont(name:"\(fontNameLight)",size:12)
            self.lblExpDelTime.font = UIFont(name:"\(fontNameLight)",size:12)
            self.lblCancelReason.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblStExpDelTime.text = "Expected Delivery Time :".localized
        self.lblStDelivery.text = "Delivery Price".localized
        
        self.lblOrderId.font = UIFont(name:"\(fontNameLight)",size:10)
        self.lblBoxQty.font = UIFont(name:"\(fontNameLight)",size:10)
        self.lblSize.font = UIFont(name:"\(fontNameLight)",size:10)
        self.order_price.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblCurrencyCode.font = UIFont(name:"\(fontNameLight)",size:8)
        self.lblStDelivery.font = UIFont(name:"\(fontNameLight)",size:12)
        
       

        }
    
}
