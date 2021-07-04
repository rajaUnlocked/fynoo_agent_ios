//
//  ProfileServiceViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 09/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ProfileServiceViewCell: UICollectionViewCell {

    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        serviceName.font = UIFont(name:"\(fontNameLight)",size:13)
    }

}
