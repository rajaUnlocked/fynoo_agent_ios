//
//  BusinessTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 16/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var ocrbtn: UIButton!
    
    @IBOutlet weak var ocrtrailing: NSLayoutConstraint!
    @IBOutlet weak var widthconst: NSLayoutConstraint!
    @IBOutlet weak var imgbtn: UIButton!
    @IBOutlet weak var downarrow: UIButton!
    @IBOutlet weak var outerVw: UIView!
    @IBOutlet weak var bordertxt: UITextField!
    @IBOutlet weak var lblk: UILabel!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    
  @IBOutlet weak var leadingConst: NSLayoutConstraint!
    @IBOutlet weak var trailingConst: NSLayoutConstraint!
    @IBOutlet weak var leadingConstlbl: NSLayoutConstraint!
    
    @IBOutlet weak var imgLeading: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
         self.bordertxt.setAllSideShadowForFields(shadowShowSize: 1.0, sizeFloat: UIScreen.main.bounds.size.width - 40)
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
              lblk.font = UIFont(name:"\(fontNameLight)",size:12)
          nameTextField.font = UIFont(name:"\(fontNameLight)",size:14)
          txtView.font = UIFont(name:"\(fontNameLight)",size:14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
