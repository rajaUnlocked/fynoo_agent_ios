//
//  BottomPopCellsNewTableViewCell.swift
//  Fynoo
//
//  Created by Aishwarya on 27/04/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class BottomPopCellsNewTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var tickImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFontUI()
    }
    func setFontUI(){
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.lbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
