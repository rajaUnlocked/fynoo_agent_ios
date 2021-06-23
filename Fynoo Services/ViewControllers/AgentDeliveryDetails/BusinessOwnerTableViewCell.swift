//
//  BusinessOwnerTableViewCell.swift
//  Fynoo Services
//
//  Created by Apple on 20/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import Cosmos
class BusinessOwnerTableViewCell: UITableViewCell {
    
    var delegate : AgentServiceListDelegate?
    
    @IBOutlet weak var lblBoName : UILabel!
    @IBOutlet weak var lblBoAddress : UILabel!
    @IBOutlet weak var bo_rating : UILabel!
    @IBOutlet weak var bo_total_rating : UILabel!
    @IBOutlet weak var imgbo_pic : UIImageView!
    @IBOutlet weak var ratingCosmosView: CosmosView!

    @IBOutlet weak var btnNavWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SetFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func SetFont() {

            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")

            let fontNameLight = NSLocalizedString("LightFontName", comment: "")

       

            self.lblBoName.font = UIFont(name:"\(fontNameLight)",size:14)

            self.lblBoAddress.font = UIFont(name:"\(fontNameLight)",size:12)

        self.bo_rating.font = UIFont(name:"\(fontNameLight)",size:12)
        self.bo_total_rating.font = UIFont(name:"\(fontNameLight)",size:12)
      
        }
    
    
    @IBAction func navigationTapped(_ sender: Any) {
        self.delegate?.navigationClicked(self)
    }
    @IBAction func callTapped(_ sender: Any) {
        self.delegate?.callClicked(self)
    }
    @IBAction func messageTapped(_ sender: Any) {
        self.delegate?.messageClicked(self)
        
    }
    
}
