//
//  DashboardWalletTableViewCell.swift
//  Fynoo Services
//
//  Created by Aishwarya on 16/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class DashboardWalletTableViewCell: UITableViewCell {

    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var holdingLBl: UILabel!
    @IBOutlet weak var inprocessLbl: UILabel!
    @IBOutlet weak var arrow1: UIImageView!
    @IBOutlet weak var arrow2: UIImageView!
    @IBOutlet weak var arrow3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        arrow1.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"rightArrow_dash")!)
        arrow2.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"rightArrow_dash")!)
        arrow3.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"rightArrow_dash")!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
