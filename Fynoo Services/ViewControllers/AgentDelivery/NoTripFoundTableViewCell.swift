//
//  NoTripFoundTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 01/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

class NoTripFoundTableViewCell: UITableViewCell {
    @IBOutlet weak var notripfoundlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        notripfoundlbl.font = UIFont(name:"\(fontNameBold)",size:20)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
