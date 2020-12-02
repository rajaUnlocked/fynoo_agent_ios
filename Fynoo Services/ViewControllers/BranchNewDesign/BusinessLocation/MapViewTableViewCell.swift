//
//  MapViewTableViewCell.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 08/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewTableViewCell: UITableViewCell {


    @IBOutlet weak var mapView: GMSMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
     
    }
    
}
