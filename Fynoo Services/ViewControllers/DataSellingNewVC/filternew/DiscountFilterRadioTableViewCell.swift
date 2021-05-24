//
//  DiscountFilterRadioTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 10/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol DiscountFilterRadioTableViewCellDelegate {
    func yesClicked(tag: Int,btn:UIButton)
      func noClicked(tag: Int,btn:UIButton)
    func bothClicked(tag: Int,btn:UIButton)
}
class DiscountFilterRadioTableViewCell: UITableViewCell {
    var delegate : DiscountFilterRadioTableViewCellDelegate?
    @IBOutlet weak var bothBtn: UIButton!
    
    @IBOutlet weak var nobtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func yes(_ sender: UIButton) {
        yesBtn.isSelected = !yesBtn.isSelected
             if yesBtn.isSelected
             {
                nobtn.isSelected = false
             }
             print(yesBtn.isSelected)
            self.delegate?.yesClicked(tag: 0, btn: sender)
    }
    
    @IBAction func no(_ sender: UIButton) {
        nobtn.isSelected = !nobtn.isSelected
                print(nobtn.isSelected)
              if nobtn.isSelected
              {
                 yesBtn.isSelected = false
              }
            self.delegate?.noClicked(tag: 1, btn: sender)
    }
    
    
    @IBAction func both(_ sender: UIButton) {
        bothBtn.isSelected = !bothBtn.isSelected
                print(nobtn.isSelected)
              if bothBtn.isSelected
              {
                nobtn.isSelected = false
                 yesBtn.isSelected = false
              }
        self.delegate?.bothClicked(tag: 2, btn: sender)
    }
    
    
    
}
