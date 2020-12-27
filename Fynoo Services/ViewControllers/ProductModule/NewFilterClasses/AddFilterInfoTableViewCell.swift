//
//  AddFilterInfoTableViewCell.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 03/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class AddFilterInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var whallbl: UILabel!
    
    @IBOutlet weak var info: UIButton!
    @IBOutlet weak var save: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.save.setAllSideShadow(shadowShowSize: 3.0)
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       save.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        info.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func infoClick(_ sender: Any) {
    }
    @IBAction func saveClick(_ sender: Any) {
    }
    
    
    
    
}
