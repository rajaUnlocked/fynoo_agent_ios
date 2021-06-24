//
//  InformationTableViewCell.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 12/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

protocol  InformationTableViewCellDelegate {
    
    func buyerInformationClicked(_ sender: Any)
    func orderInformationClicked(_ sender: Any)
    func invoiceClicked(_ sender: Any)
}


class InformationTableViewCell: UITableViewCell {
    
    var delegate : InformationTableViewCellDelegate?
    
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
        
        
        self.lblOrderId.font = UIFont(name:"\(fontNameLight)",size:10)

        self.lblQty.font = UIFont(name:"\(fontNameLight)",size:10)
        self.lblOrderDate.font = UIFont(name:"\(fontNameLight)",size:8)
        
        self.order_price.font = UIFont(name:"\(fontNameLight)",size:12)

        self.lblCurrencyCode.font = UIFont(name:"\(fontNameLight)",size:8)
        self.lblStaticActualtotal.font = UIFont(name:"\(fontNameLight)",size:12)
        
       

        }
    
    
    @IBAction func btnTappedBuyerInformation(_ sender: Any) {
        self.delegate?.buyerInformationClicked(self)
    }
    
    @IBAction func btnTappedOrderInformation(_ sender: Any) {
        self.delegate?.orderInformationClicked(self)
    }
    
    
    @IBAction func btnInvoiceTapped(_ sender: UIButton) {
        self.delegate?.invoiceClicked(self)
    }
    
}
