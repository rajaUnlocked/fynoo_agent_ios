//
//  WalletAvailableTopCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 19/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class WalletAvailableTopCell: UITableViewCell {

    @IBOutlet weak var sendmoneylbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var availableLbl: UILabel!
    @IBOutlet weak var sendMoney: UIButton!
    
    @IBOutlet weak var totalamtlbl: UILabel!
    @IBOutlet weak var currencylbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
              let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       totalamtlbl.font = UIFont(name:"\(fontNameLight)",size:16)
        currencylbl.font = UIFont(name:"\(fontNameLight)",size:12)
        totalLbl.font = UIFont(name:"\(fontNameBold)",size:15)
        availableLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        sendMoney.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        sendmoneylbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
