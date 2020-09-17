//
//  ServiceSingleCollectionViewCell.swift
//  Fynoo Services
//
//  Created by Aishwarya on 16/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ServiceSingleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgVw.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 150)
    }
}
