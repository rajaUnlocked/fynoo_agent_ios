//
//  LogoTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 16/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
protocol LogoTableViewCellDelegate {
    func setBranchLogo()
}
class LogoTableViewCell: UITableViewCell {
    var delegate:LogoTableViewCellDelegate?
   
    @IBOutlet weak var hegtConst: NSLayoutConstraint!
    @IBOutlet weak var widthConst: NSLayoutConstraint!
    @IBOutlet weak var addphotoutlet: UIImageView!
    
    @IBOutlet weak var checkMain: UIButton!
    
    @IBOutlet weak var mainbranchlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        addphotoutlet.layer.masksToBounds = true
        addphotoutlet.contentMode = .scaleAspectFill
        addphotoutlet.layer.cornerRadius = 50
        addphotoutlet.clipsToBounds = true
     let fontNameLight = NSLocalizedString("LightFontName", comment: "")
   mainbranchlbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func profileImageUpload(_ sender: Any) {
        self.delegate?.setBranchLogo()
    }
}
