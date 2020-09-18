//
//  DashboardWalletTableViewCell.swift
//  Fynoo Services
//
//  Created by Aishwarya on 16/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class DashboardWalletTableViewCell: UITableViewCell {

    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var holdingLBl: UILabel!
    @IBOutlet weak var inprocessLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
