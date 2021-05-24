//
//  TimingShowTableViewCell.swift
//  Fynoo
//
//  Created by IND-SEN-LP-039 on 26/04/21.
//  Copyright © 2021 neerajTiwari. All rights reserved.
//

import UIKit

class TimingShowTableViewCell: UITableViewCell {

    @IBOutlet weak var timinglbl: UILabel!
    @IBOutlet weak var weekname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
