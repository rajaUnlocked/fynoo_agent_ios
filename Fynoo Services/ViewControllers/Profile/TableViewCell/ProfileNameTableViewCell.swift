//
//  ProfileNameTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 25/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
protocol ProfileNameTableViewCellDelegate {
    func editImage()
}

class ProfileNameTableViewCell: UITableViewCell {
    var delegate:ProfileNameTableViewCellDelegate?
    @IBOutlet weak var cameraIcon: UIImageView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var fynooIdLbl: UILabel!
    @IBOutlet weak var editImageOutlet: UIButton!
    var user: UserData?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        nameLbl.font = UIFont(name:"\(fontNameLight)",size:12)
           fynooIdLbl.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.profileImage.roundCornerNormal(radius: self.profileImage.frame.size.we)
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.cornerRadius = 40
        profileImage.clipsToBounds = true
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editImageBtn(_ sender: Any) {
       self.delegate?.editImage()
    }
}
