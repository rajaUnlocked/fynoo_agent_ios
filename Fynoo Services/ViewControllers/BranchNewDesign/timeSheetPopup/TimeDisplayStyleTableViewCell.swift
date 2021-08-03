//
//  TimeDisplayStyleTableViewCell.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 11/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class TimeDisplayStyleTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLbl: UILabel!

    
    @IBOutlet weak var rightLbl: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       leftLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        rightLbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnClick(_ sender: Any) {
    }
    
}
