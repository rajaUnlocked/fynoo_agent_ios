//
//  AgentProfileImageTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 03/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol AgentProfileImageTableViewCellDelegate {
    func profileImageSelected()
}

class AgentProfileImageTableViewCell: UITableViewCell {
  var delegate :AgentProfileImageTableViewCellDelegate?
    
    @IBOutlet weak var agentprofileImageView: UIImageView!
   
    @IBOutlet var profileImageBtn: UIButton!
    @IBOutlet var headerTxt: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
      agentprofileImageView.layer.borderWidth = 1.0
      agentprofileImageView.layer.masksToBounds = true
      agentprofileImageView.layer.borderColor = UIColor.white.cgColor
      agentprofileImageView.layer.cornerRadius = 50
      agentprofileImageView.clipsToBounds = true
        
        self.SetFontAndTextColor()
    }
    
    func SetFontAndTextColor(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerTxt.font = UIFont(name:"\(fontNameLight)",size:16)
       
        self.headerTxt.textColor = Constant.Black_TEXT_COLOR
                
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func profileImageBtnClicked(_ sender: Any) {
        self.delegate?.profileImageSelected()
       }
}
