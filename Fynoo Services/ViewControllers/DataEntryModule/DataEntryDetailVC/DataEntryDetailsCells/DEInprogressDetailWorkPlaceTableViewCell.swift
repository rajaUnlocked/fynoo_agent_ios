//
//  DEInprogressDetailWorkPlaceTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 23/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import GoogleMaps

class DEInprogressDetailWorkPlaceTableViewCell: UITableViewCell {
    @IBOutlet weak var workPlaceHeaderLbl: UILabel!
    @IBOutlet weak var workPlaceTypeLbl: UILabel!
    @IBOutlet weak var mapMainView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapViewHeightConstant: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
        
    }
                         
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.workPlaceHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.workPlaceTypeLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
