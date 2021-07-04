//
//  ProgressDashboardTableViewCell.swift
//  Fynoo Services
//
//  Created by Aishwarya on 16/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ProgressDashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var progressVW: UIProgressView!
    @IBOutlet weak var targetStartLbl: UILabel!
    @IBOutlet weak var targetEndLbl: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        targetStartLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        targetEndLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        endDate.font = UIFont(name:"\(fontNameLight)",size:14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
