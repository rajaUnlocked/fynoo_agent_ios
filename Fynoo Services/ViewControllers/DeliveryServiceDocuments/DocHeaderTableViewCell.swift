//
//  DocHeaderTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 23/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class DocHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerlbl: UILabel!
    @IBOutlet weak var edit: UIImageView!
    @IBOutlet weak var arrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        headerlbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
