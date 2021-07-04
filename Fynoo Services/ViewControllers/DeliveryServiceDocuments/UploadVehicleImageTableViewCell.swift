//
//  UploadVehicleImageTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 24/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class UploadVehicleImageTableViewCell: UITableViewCell {
    @IBOutlet weak var uploadlbl: UILabel!
    
    @IBOutlet weak var crossclicked: UIButton!
    @IBOutlet weak var uploadsaveVehicle: UIButton!
    @IBOutlet weak var vehicleimage: UIImageView!
    @IBOutlet weak var uploadvehicle: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        uploadlbl.font = UIFont(name:"\(fontNameLight)",size:12)
    uploadsaveVehicle.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
