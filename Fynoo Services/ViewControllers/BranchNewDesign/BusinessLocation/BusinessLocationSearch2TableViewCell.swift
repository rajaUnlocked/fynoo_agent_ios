//
//  BusinessLocationSearch2TableViewCell.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 08/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol BusinessLocationSearch2TableViewCellDelegate {
    func checkBox(tag: Int)
}

class BusinessLocationSearch2TableViewCell: UITableViewCell {
    var delegate:BusinessLocationSearch2TableViewCellDelegate?

    @IBOutlet weak var outVw: UIView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.outVw.setAllSideShadowForFieldsWithHeight(shadowShowSize: 1.0, sizeFloat: UIScreen.main.bounds.size.width - 20, sizeFloatHeight: 35)
         let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        lbl.font = UIFont(name:"\(fontNameLight)",size:12)
          txtField.font = UIFont(name:"\(fontNameLight)",size:9)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func checkBoxClick(_ sender: Any) {
        if checkBox.isSelected == false {
            checkBox.isSelected = true
            
        }
        else {
            checkBox.isSelected = false
        }
        self.delegate?.checkBox(tag: self.tag)
        
    }
    
}
