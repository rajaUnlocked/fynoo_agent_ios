//
//  ProductSpecCatagoryTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 17/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductSpecCatagoryTableViewCell: UITableViewCell {
    @IBOutlet weak var bootomLbl: UILabel!
    
    @IBOutlet weak var forwardImg: UIImageView!
    @IBOutlet weak var categoriesLbl: UILabel!
    @IBOutlet weak var rgtvw: UIView!
    @IBOutlet weak var leftvw: UIView!
    
    @IBOutlet weak var cataname: UILabel!
    
    @IBOutlet weak var subcataname: UILabel!
    @IBOutlet weak var subcataimg: UIImageView!
    @IBOutlet weak var cataimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
      let fontNameLight = NSLocalizedString("LightFontName", comment: "")
     categoriesLbl.font = UIFont(name:"\(fontNameLight)",size:15)
     cataname.font = UIFont(name:"\(fontNameLight)",size:8)
     subcataname.font = UIFont(name:"\(fontNameLight)",size:8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
