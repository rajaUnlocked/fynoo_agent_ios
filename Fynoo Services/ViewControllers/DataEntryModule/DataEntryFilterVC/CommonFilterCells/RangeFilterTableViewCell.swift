//
//  RangeFilterTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 04/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import TTRangeSlider




class RangeFilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var rangeSlider: TTRangeSlider!
    @IBOutlet weak var like: UIImageView!
    @IBOutlet weak var toprice: UILabel!
    @IBOutlet weak var fromprice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        lbl.font = UIFont(name:"\(fontNameLight)",size:12)
        
        rotateViewForArabic()
        
        
    }
    func rotateViewForArabic()  {
    
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String] {
       if value[0] == "ar" {
              let degrees = 180.0 // or -90, 180 depending on phone's movement.
                
            let rotatedView: UIView = self.rangeSlider
             rotatedView.transform  = CGAffineTransform(rotationAngle: CGFloat(degrees) * CGFloat(M_PI / 180))
            
            }else{
          
            }
        
        }
 
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
