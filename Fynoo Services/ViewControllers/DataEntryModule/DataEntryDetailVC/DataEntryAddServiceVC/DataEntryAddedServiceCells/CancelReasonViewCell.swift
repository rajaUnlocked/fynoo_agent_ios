//
//  CancelReasonViewCell.swift
//  Fynoo
//
//  Created by IND-SEN-LP-046 on 16/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

protocol CancelReasonViewCellDelegate: class {
    
    func selectedReason(_ sender: Any)
}
class CancelReasonViewCell: UITableViewCell {
    weak var delegate: CancelReasonViewCellDelegate?

    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var upperLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }
    func SetFont() {
           
           let fontNameLight = NSLocalizedString("LightFontName", comment: "")
           
           self.name.font = UIFont(name:"\(fontNameLight)",size:12)
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func clicked(_ sender: Any) {
        self.delegate?.selectedReason(self)
        
    }
}
