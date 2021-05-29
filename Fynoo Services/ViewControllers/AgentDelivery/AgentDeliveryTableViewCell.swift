//
//  AgentDeliveryTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 22/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import Cosmos
class AgentDeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var deliveryStatusLbl: UILabel!
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var tripStaticLbl: UILabel!
    @IBOutlet weak var yearStaticLbl: UILabel!
    @IBOutlet weak var earningStaticLbl: UILabel!
    @IBOutlet weak var totalCODStaticLbl: UILabel!
    @IBOutlet weak var deliveryDocumentLbl: UILabel!
    
    @IBOutlet weak var agentProfileImageView: UIImageView!
    
    @IBOutlet weak var clickservicedocument: UIButton!
    @IBOutlet weak var documentStatus: UIImageView!
    @IBOutlet weak var infoClicked: UIButton!
    @IBOutlet weak var switches: UIButton!
    @IBOutlet weak var editAmount: UIButton!
    @IBOutlet weak var delivery: UIImageView!
    @IBOutlet weak var cod: UILabel!
    @IBOutlet weak var earning: UILabel!
    @IBOutlet weak var langugae: UILabel!
    @IBOutlet weak var totalRating: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var avgRating: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var trip: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.deliveryStatusLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.profileLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.trip.font = UIFont(name:"\(fontNameLight)",size:16)
        self.tripStaticLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        self.year.font = UIFont(name:"\(fontNameLight)",size:16)
        self.yearStaticLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        self.earning.font = UIFont(name:"\(fontNameLight)",size:16)
        self.earningStaticLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        self.cod.font = UIFont(name:"\(fontNameLight)",size:16)
        self.totalCODStaticLbl.font = UIFont(name:"\(fontNameLight)",size:16)
         self.deliveryDocumentLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        
        
    }

}
