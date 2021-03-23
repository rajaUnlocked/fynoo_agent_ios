//
//  OtherServicesOrderInformationTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 23/03/21.
//  Copyright © 2021 Sendan. All rights reserved.
//

import UIKit

class OtherServicesOrderInformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var entryName: UIButton!
    @IBOutlet weak var tickImgView: UIImageView!
    @IBOutlet weak var quantityLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.entryName.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
         self.quantityLbl.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.entryName.underline()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension UIButton {
    func underline() {
        guard let title = self.titleLabel else { return }
        guard let tittleText = title.text else { return }
        let attributedString = NSMutableAttributedString(string: (tittleText))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (tittleText.count)))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
