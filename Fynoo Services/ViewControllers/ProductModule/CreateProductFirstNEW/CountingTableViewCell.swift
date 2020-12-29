//
//  CountingTableViewCell.swift
//  Fynoo Business
//
//  Created by sanjay kumar on 27/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class CountingTableViewCell: UITableViewCell {

    @IBOutlet weak var countLblTop: NSLayoutConstraint!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    @IBOutlet weak var leadingConstvw: NSLayoutConstraint!
      @IBOutlet weak var trailingConstvw: NSLayoutConstraint!
    @IBOutlet weak var topConst: NSLayoutConstraint!
    @IBOutlet weak var trailConst: NSLayoutConstraint!
    @IBOutlet weak var vw: UIView!
    @IBOutlet weak var counlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
