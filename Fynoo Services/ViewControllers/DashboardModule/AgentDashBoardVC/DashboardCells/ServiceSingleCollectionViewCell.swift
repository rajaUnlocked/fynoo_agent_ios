//
//  ServiceSingleCollectionViewCell.swift
//  Fynoo Services
//
//  Created by Aishwarya on 16/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

protocol ServiceSingleCollectionViewCellDelegate: class {
    func addServiceClicked(id : Int, name : String)
}

class ServiceSingleCollectionViewCell: UICollectionViewCell {

    weak var delegate: ServiceSingleCollectionViewCellDelegate?
    @IBOutlet weak var bgVw: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var inprocessLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var greenImg: UIImageView!
    @IBOutlet weak var plusImg: UIImageView!
    @IBOutlet weak var plusOutlet: UIButton!
    @IBOutlet weak var totalCountLbl: UILabel!
    var serviceID = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        self.bgVw.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: (screenWidth / 2) - 30 )
    }
    
    @IBAction func plusBtn(_ sender: Any) {
        self.delegate?.addServiceClicked(id: serviceID, name: nameLbl.text!)
    }
    
    @IBAction func serviceclicked(_ sender: Any) {
    
    }
}
