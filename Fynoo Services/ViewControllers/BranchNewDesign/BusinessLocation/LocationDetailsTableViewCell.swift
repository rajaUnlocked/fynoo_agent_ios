//
//  LocationDetailsTableViewCell.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 10/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class LocationDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var loclbl: UILabel!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var characterCount: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var outVw: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
  self.outVw.setAllSideShadowForFieldsWithHeight(shadowShowSize: 1.0, sizeFloat: UIScreen.main.bounds.size.width - 20, sizeFloatHeight: 120)
         let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        loclbl.font = UIFont(name:"\(fontNameLight)",size:12)
         txtView.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
