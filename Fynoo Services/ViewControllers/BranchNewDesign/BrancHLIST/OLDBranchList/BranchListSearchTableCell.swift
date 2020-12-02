//
//  BranchListSearchTableCell.swift
//  Fynoo Business
//
//  Created by SENDAN on 02/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class BranchListSearchTableCell: UITableViewCell {

    @IBOutlet weak var NOOFbranch: UILabel!
    @IBOutlet weak var noBranch: UILabel!
    @IBOutlet weak var addNew: UIButton!
    @IBOutlet weak var more: UIButton!
    @IBOutlet weak var moreView: CardView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var searchtxt: UITextField!
    @IBOutlet weak var filter: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
