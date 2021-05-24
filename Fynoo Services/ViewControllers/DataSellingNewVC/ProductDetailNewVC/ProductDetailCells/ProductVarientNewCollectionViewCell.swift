//
//  ProductVarientNewCollectionViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 19/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductVarientNewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var leadingLbl: UILabel!
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var firstNameLbl: UILabel!
    
    @IBOutlet weak var secondNameLbl: UILabel!
    
    @IBOutlet weak var varientRightLbl: UIImageView!
    
    @IBOutlet weak var collectionUpperLbl: UILabel!
    
    @IBOutlet weak var collectionLowerLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }
        
    func SetFont(){
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.firstNameLbl.font = UIFont(name:"\(fontNameLight)",size:11)
        self.secondNameLbl.font = UIFont(name:"\(fontNameLight)",size:11)
    }

}
