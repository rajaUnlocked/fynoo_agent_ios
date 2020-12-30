//
//  DataEntryTypeListingTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 27/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryTypeListingTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var tickImageView: UIImageView!
    @IBOutlet weak var productTxtLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
