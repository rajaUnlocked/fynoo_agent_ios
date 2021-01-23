//
//  NewGalleryHeader.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 26/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class NewGalleryHeader: UICollectionReusableView {
       
    @IBOutlet weak var secondVw: UIView!
    @IBOutlet weak var selectallBtnHght: NSLayoutConstraint!
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var profileBtn: UIButton!
    
    @IBOutlet weak var branchBtn: UIButton!
    
    @IBOutlet weak var productBtn: UIButton!
    
    @IBOutlet weak var selectAll: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var selectAllLbl: UILabel!
    @IBOutlet weak var cancelAllOutlet: UIButton!
    
    override func awakeFromNib() {
           super.awakeFromNib()
          self.cancelAllOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        profileBtn.titleLabel?.font =  UIFont(name: "\(fontNameLight)", size: 12)
        branchBtn.titleLabel?.font =  UIFont(name: "\(fontNameLight)", size: 12)
        productBtn.titleLabel?.font =  UIFont(name: "\(fontNameLight)", size: 12)
        selectAllLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        cancelAllOutlet.titleLabel?.font =  UIFont(name: "\(fontNameLight)", size: 12)
    }
    override init(frame: CGRect) {
          super.init(frame: frame)
          self.backgroundColor = UIColor.purple

          // Customize here

       }

       required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)

       }
       

    // Initialization code
    }
