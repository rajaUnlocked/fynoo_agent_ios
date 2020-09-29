//
//  DescriptionTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 07/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var topdescripConst: NSLayoutConstraint!
    @IBOutlet weak var topconst: NSLayoutConstraint!
    @IBOutlet weak var descriplbl: UILabel!
    @IBOutlet weak var toplbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
          let fontNameLight = NSLocalizedString("LightFontName", comment: "")
      self.toplbl.font = UIFont(name:"\(fontNameLight)",size:20)
   self.descriplbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
