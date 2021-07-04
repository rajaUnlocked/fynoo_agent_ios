//
//  TwoButtonsTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 29/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class TwoButtonsTableViewCell: UITableViewCell {

    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var cancel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        save.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:13)
        cancel.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:13)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
class ButtonWithShadow: UIButton {

    override func draw(_ rect: CGRect) {
        updateLayerProperties()
    }

    func updateLayerProperties() {
        self.layer.shadowColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1);

        //self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0
       
        self.layer.masksToBounds = false
    }

}
