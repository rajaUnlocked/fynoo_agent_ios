//
//  ServiceSingleCollectionViewCell.swift
//  Fynoo Services
//
//  Created by Aishwarya on 16/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

protocol ServiceSingleCollectionViewCellDelegate: class {
    func addServiceClicked(id : Int, name : String, index : Int)
    func activateServiceClicked(id : Int, name : String, index : Int)
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
    var ind = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        nameLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        countLbl.font = UIFont(name:"\(fontNameLight)",size:33)
        inprocessLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        self.bgVw.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: (screenWidth / 2) - 30 )
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"
            {
                nameLbl.textAlignment = .right
            }
            else if value[0]=="en"
            {
                nameLbl.textAlignment = .left
            }
        }
    }
    
    @IBAction func plusBtn(_ sender: Any) {
        self.delegate?.addServiceClicked(id: serviceID, name: nameLbl.text!, index: ind)
    }
    
    @IBAction func serviceclicked(_ sender: Any) {
        self.delegate?.activateServiceClicked(id: serviceID, name: nameLbl.text!, index: ind)
    }
}
