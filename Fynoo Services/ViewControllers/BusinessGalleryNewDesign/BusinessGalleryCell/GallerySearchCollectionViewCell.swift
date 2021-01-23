//
//  GallerySearchCollectionViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 27/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol GallerySearchCollectionViewCelldelegate {
  
    func add(tag:Int)
    func filter(tag:Int)
}

class GallerySearchCollectionViewCell: UICollectionViewCell {
    var delegate : GallerySearchCollectionViewCelldelegate?
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var addImageLbl: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var txtFiled: UITextField!
    @IBOutlet weak var search: UIImageView!
    @IBOutlet weak var filter: UIButton!
    
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var addBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
          self.addBtn.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        // Initialization code
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        txtFiled.font = UIFont(name:"\(fontNameLight)",size:12)
        addImageLbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    @IBAction func filterClick(_ sender: Any) {
        self.delegate?.filter(tag: self.tag)
    }
    
  
  
    
    @IBAction func add(_ sender: Any) {
         self.delegate?.add(tag: self.tag)
    }
}
