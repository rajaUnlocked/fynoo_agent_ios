//
//  SelectBusinesstypeTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 22/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

protocol SelectBusinesstypeTableViewCellDelegate: class {
    
   func selectedCheckBox(_ sender: Any)

}
class SelectBusinesstypeTableViewCell: UITableViewCell {
   weak var delegate: SelectBusinesstypeTableViewCellDelegate?
    
    

    @IBOutlet weak var underlineHeight: NSLayoutConstraint!
    
    @IBOutlet weak var underline: UILabel!
    @IBOutlet weak var traillingConstraints: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraints: NSLayoutConstraint!
    @IBOutlet weak var checkbtn: UIButton!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
   
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            lblName.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkbtnAction(_ sender: UIButton) {
        if(sender.isSelected == false)
        {
           checkbtn.setImage(UIImage(named: "selected"), for: .normal)
        }
        else
        {
              checkbtn.setImage(UIImage(named: "untick"), for: .normal)
        }
        sender.isSelected = !sender.isSelected

        self.delegate?.selectedCheckBox(self)
        
    }
}
