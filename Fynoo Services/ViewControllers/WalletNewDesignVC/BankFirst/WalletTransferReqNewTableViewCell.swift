//
//  WalletTransferReqNewTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya on 21/11/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class WalletTransferReqNewTableViewCell: UITableViewCell {

    @IBOutlet weak var leadingWalletConst: NSLayoutConstraint!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var transactionLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var transIcon: UIImageView!
    @IBOutlet weak var transHeight: NSLayoutConstraint!
    @IBOutlet weak var walletIcon: UIImageView!
    @IBOutlet weak var holdingLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var reasonVw: UIView!
    @IBOutlet weak var rejectedLbl: UILabel!
    @IBOutlet weak var infoOutlet: UIButton!
    @IBOutlet weak var infoWidth: NSLayoutConstraint!
    @IBOutlet weak var transIconWidth: NSLayoutConstraint!
    
    @IBOutlet weak var statuslbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       titleLbl.font = UIFont(name:"\(fontNameLight)",size:11)
        transactionLbl.font = UIFont(name:"\(fontNameLight)",size:11)
        holdingLbl.font = UIFont(name:"\(fontNameLight)",size:11)
        orderIdLbl.font = UIFont(name:"\(fontNameLight)",size:11)
        priceLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        statuslbl.font = UIFont(name:"\(fontNameLight)",size:11)
        rejectedLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        reasonLbl.font = UIFont(name:"\(fontNameLight)",size:10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func infoBtn(_ sender: Any) {
    }
}
