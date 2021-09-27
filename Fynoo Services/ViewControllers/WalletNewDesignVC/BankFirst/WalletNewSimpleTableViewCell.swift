//
//  WalletNewSimpleTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya on 21/11/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class WalletNewSimpleTableViewCell: UITableViewCell {

    @IBOutlet weak var underline: UILabel!
    @IBOutlet weak var viewInvoice: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var transactionLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var transIcon: UIImageView!
    @IBOutlet weak var transHeight: NSLayoutConstraint!
    @IBOutlet weak var walletIcon: UIImageView!
    @IBOutlet weak var holdingLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       titleLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        transactionLbl.font = UIFont(name:"\(fontNameLight)",size:11)
        holdingLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        orderIdLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        priceLbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
