//
//  SelectMultipleBranchesNewDesignTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya on 14/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class SelectMultipleBranchesNewDesignTableViewCell: UITableViewCell {

    @IBOutlet weak var branchLogo: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var tickImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        nameLbl.font = UIFont(name:"\(fontNameLight)",size:10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
