//
//  RadioTypeFilterTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 04/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol RadioTypeFilterTableViewCellDelegate {
    func yesClicked(tag: Int,btn:UIButton)
    func noClicked(tag: Int,btn:UIButton)
   
}
class RadioTypeFilterTableViewCell: UITableViewCell {
    var delegate : RadioTypeFilterTableViewCellDelegate?
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var nobtn: UIButton!
    @IBOutlet weak var yesImg: UIImageView!
    var checkBtnValue: Int? = 0
     
    @IBOutlet weak var yeslbl: UILabel!
    
    @IBOutlet weak var bothLbl: UILabel!
    @IBOutlet weak var bothImg: UIImageView!
    @IBOutlet weak var bothBtn: UIButton!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var noLbl: UILabel!
    @IBOutlet weak var noclick: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func yesBtn(_ sender: UIButton) {
        yesBtn.isSelected = !yesBtn.isSelected
        if yesBtn.isSelected
        {
           nobtn.isSelected = false
        }
        print(yesBtn.isSelected)
       self.delegate?.yesClicked(tag: 0, btn: sender)
       }
    
    @IBAction func noBtn(_ sender: UIButton) {
        nobtn.isSelected = !nobtn.isSelected
          print(nobtn.isSelected)
        if nobtn.isSelected
        {
           yesBtn.isSelected = false
        }
      self.delegate?.noClicked(tag: 1, btn: sender)
         }
    
    
    
}
