//
//  ProductDetailSelectTabTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 18/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductDetailSelectTabTableViewCell: UITableViewCell {

    @IBOutlet weak var onlineStoreView: UIView!
    @IBOutlet weak var instoreView: UIView!
    @IBOutlet weak var onlineLeftImageView: UIImageView!
    @IBOutlet weak var onlineStoreLl: UILabel!
    @IBOutlet weak var onlineRightImageView: UIImageView!
    @IBOutlet weak var onlineBottomLbl: UILabel!
    @IBOutlet weak var instoreLeftImageView: UIImageView!
    @IBOutlet weak var instoreLlbl: UILabel!
    @IBOutlet weak var instoreBottomLbl: UILabel!    
    
    @IBOutlet weak var OnlineStoreBtn: UIButton!
    
    @IBOutlet weak var inStoreBtn: UIButton!
    
    @IBOutlet weak var instoreFeatureTagImageView: UIImageView!
    
    @IBOutlet weak var onlineViewWidhtConstant: NSLayoutConstraint!
    @IBOutlet weak var instoreViewWidhtConstant: NSLayoutConstraint!
    @IBOutlet weak var instoreBottomLblWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var onlinebottomLblWidhtConstant: NSLayoutConstraint!
    
    @IBOutlet weak var onlineDeviderLbl: UILabel!    
    @IBOutlet weak var mainLowerLabel: UILabel!
    
     @IBOutlet weak var mainFeatureImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }
    func SetFont(){
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.onlineStoreLl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.instoreLlbl.font = UIFont(name:"\(fontNameLight)",size:16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
