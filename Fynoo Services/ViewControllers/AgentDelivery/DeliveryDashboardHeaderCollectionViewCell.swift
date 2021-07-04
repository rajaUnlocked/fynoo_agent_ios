//
//  DeliveryDashboardHeaderCollectionViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-040 on 31/01/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

class DeliveryDashboardHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var upperLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var textLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        textLbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

}
