//
//  SideMenuTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 23/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTextLbl: UILabel!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    @IBOutlet weak var arrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
  //      arrowImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"right_arrow_new")!)
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        cellTextLbl.font = UIFont(name:"\(fontNameLight)",size:12)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
