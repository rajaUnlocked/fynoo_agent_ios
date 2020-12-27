//
//  ViewLocationTableViewCell.swift
//  Fynoo Business
//
//  Created by sanjay kumar on 07/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import GoogleMaps
class ViewLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var mapvw: GMSMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
