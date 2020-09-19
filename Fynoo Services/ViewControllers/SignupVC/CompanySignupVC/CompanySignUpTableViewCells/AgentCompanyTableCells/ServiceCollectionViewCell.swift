//
//  ServiceCollectionViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 03/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {
     
    @IBOutlet var checkBoxBtn: UIButton!
    @IBAction func checkBoxBtnClicked(_ sender: Any) {
    }
    
    @IBOutlet var serviceTypeImage: UIImageView!
    
    @IBOutlet var serviceNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.checkBoxBtn.isUserInteractionEnabled = false
        
    }

}
