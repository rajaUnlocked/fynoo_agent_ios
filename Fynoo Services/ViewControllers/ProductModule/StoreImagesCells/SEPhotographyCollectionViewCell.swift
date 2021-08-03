//
//  SEPhotographyCollectionViewCell.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 10/12/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class SEPhotographyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var addbtn: UIButton!
    
    @IBOutlet weak var addlbl: UILabel!
    @IBOutlet weak var imgName: UILabel!
    @IBOutlet weak var outervw: UIView!
    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var outerViewLeading: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        addlbl.font = UIFont(name:"\(fontNameLight)",size:12)
      
    }
    
    

}
