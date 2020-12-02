//
//  marketTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 23/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class marketTableViewCell: UITableViewCell {

    @IBOutlet weak var middlelbl: UILabel!
    @IBOutlet weak var toplbl: UILabel!
    @IBOutlet weak var bottomlbl: UILabel!
    @IBOutlet weak var checkbtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       middlelbl.font = UIFont(name:"\(fontNameLight)",size:13)
         toplbl.font = UIFont(name:"\(fontNameLight)",size:13)
         bottomlbl.font = UIFont(name:"\(fontNameLight)",size:13)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
