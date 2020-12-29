//
//  nextTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 03/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
protocol NextBtnDelegate {
    func nextBtn()
}
class nextTableViewCell: UITableViewCell {
  
    var delegate:NextBtnDelegate?

    @IBOutlet weak var savedraft: UIButton!
    @IBOutlet weak var nextbtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
         self.savedraft.setAllSideShadow(shadowShowSize: 3.0)
         self.nextbtn.setAllSideShadow(shadowShowSize: 3.0)
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        savedraft.titleLabel?.font =  UIFont(name: "\(fontNameLight)", size: 12)
        nextbtn.titleLabel?.font =  UIFont(name: "\(fontNameLight)", size: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
