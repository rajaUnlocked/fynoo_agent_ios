//
//  AgentListTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 07/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class AgentListTableViewCell: UITableViewCell {
    @IBOutlet weak var pricelbl: UILabel!
    
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var starlbl: UILabel!
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var agentname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
          let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            self.agentname.font = UIFont(name:"\(fontNameLight)",size:16)
            self.currencylbl.font = UIFont(name:"\(fontNameLight)",size:8)
            self.pricelbl.font = UIFont(name:"\(fontNameLight)",size:12)
            self.starlbl.font = UIFont(name:"\(fontNameLight)",size:8)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
