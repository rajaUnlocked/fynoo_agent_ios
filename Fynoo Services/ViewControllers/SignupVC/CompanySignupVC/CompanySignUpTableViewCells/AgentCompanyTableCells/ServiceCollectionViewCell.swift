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
        
        self.SetFontAndTextColor()
    }
            
    func SetFontAndTextColor(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.serviceNameLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.serviceNameLbl.textColor = Constant.Black_TEXT_COLOR
        
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                self.serviceNameLbl.textAlignment = .right
            }else if value[0]=="en"{
                self.serviceNameLbl.textAlignment = .left
             
            }
        }

        
    }
}
