//
//  ConfirmToreceiveItemTableViewCell.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 28/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

protocol ConfirmToreceiveItemTableViewCellDelegate {
    func ClickedAnyProblem(_ sender: Any)
    func ClickedReceivedItem(_ sender: Any)
}
class ConfirmToreceiveItemTableViewCell: UITableViewCell {
    
    var delegate : ConfirmToreceiveItemTableViewCellDelegate?
    
    @IBOutlet weak var lblQty: UILabel!
    
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTextshareOtp: UILabel!
    @IBOutlet weak var lblOtp: UILabel!
    @IBOutlet weak var btnReceiveItemOutlet: UIButton!
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var lblIHaveReceivedItem: UILabel!
    @IBOutlet weak var btnAnyProblemOutlet: UIButton!
    
    @IBOutlet weak var lblStDeliveryPrice : UILabel!
    @IBOutlet weak var lblCurrency : UILabel!
    @IBOutlet weak var lblOrderPrice : UILabel!
    @IBOutlet weak var imgPaymentIcon : UIImageView!
    @IBOutlet weak var lblStExpDelTime : UILabel!
    @IBOutlet weak var lblExpDelTime : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SetFont()
    }
    
    
    func SetFont() {

            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")

            let fontNameLight = NSLocalizedString("LightFontName", comment: "")

            

            self.lblQty.font = UIFont(name:"\(fontNameLight)",size:10)

            self.lblOrderId.font = UIFont(name:"\(fontNameLight)",size:10)

            self.lblDate.font = UIFont(name:"\(fontNameLight)",size:10)
            self.lblTextshareOtp.font = UIFont(name:"\(fontNameBold)",size:16)
        
        
        self.lblOtp.font = UIFont(name:"\(fontNameBold)",size:32)

        self.lblIHaveReceivedItem.font = UIFont(name:"\(fontNameLight)",size:12)
        
        self.btnAnyProblemOutlet.titleLabel!.font = UIFont(name:"\(fontNameBold)",size:14)
        let myNormalAttributedTitle = NSAttributedString(string: "Any Problem?".localized,attributes: [NSAttributedString.Key.foregroundColor : UIColor.AppThemeBlueTextColor(),.underlineStyle: NSUnderlineStyle.single.rawValue,.underlineColor : UIColor.AppThemeBlueTextColor()])
        self.btnAnyProblemOutlet.setAttributedTitle(myNormalAttributedTitle, for: .normal)
        
        //
        
        self.lblStDeliveryPrice.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblCurrency.font = UIFont(name:"\(fontNameLight)",size:8)
        self.lblOrderPrice.font = UIFont(name:"\(fontNameLight)",size:10)
        self.lblStExpDelTime.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblExpDelTime.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblStExpDelTime.text = "Expected Delivery Time :".localized
        self.lblStDeliveryPrice.text = "Delivery Price".localized
    }
        
      override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnAnyProblemTapped(_ sender: Any) {
        self.delegate?.ClickedAnyProblem(self)
    }
    
    
    @IBAction func btnReceivedItemTapped(_ sender: Any) {
        self.delegate?.ClickedReceivedItem(self)
    }
}
