//
//  PhoneNumberTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 16/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class PhoneNumberTableViewCell: UITableViewCell {
    @IBOutlet weak var toplbl: UILabel!
    
    @IBOutlet weak var rotatevw: UIView!
    @IBOutlet weak var img: UIImageView!
  
    @IBOutlet weak var phoneCode: UILabel!
  
    @IBOutlet weak var cross: UIButton!
    @IBOutlet weak var borderTxt: UITextField!
    @IBOutlet weak var downarrow: UIButton!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var flag: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
           self.borderTxt.setAllSideShadowForFields(shadowShowSize: 1.0, sizeFloat: UIScreen.main.bounds.size.width - 40)
          let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        toplbl.font = UIFont(name:"\(fontNameLight)",size:12)
         phoneCode.font = UIFont(name:"\(fontNameLight)",size:14)
         phoneNumberTextField.font = UIFont(name:"\(fontNameLight)",size:14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
