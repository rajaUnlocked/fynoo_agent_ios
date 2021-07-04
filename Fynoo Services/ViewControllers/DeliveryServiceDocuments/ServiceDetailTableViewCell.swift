//
//  ServiceDetailTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 23/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ServiceDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var topconstant: NSLayoutConstraint!
    @IBOutlet weak var vw: UIView!
    @IBOutlet weak var pswdimg: UIImageView!
    @IBOutlet weak var crossclicked: UIButton!
    @IBOutlet weak var uploadbtn: UIButton!
    @IBOutlet weak var detaillbl: UILabel!
    @IBOutlet weak var uploadimg: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       title.font = UIFont(name:"\(fontNameLight)",size:12)
        uploadbtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
