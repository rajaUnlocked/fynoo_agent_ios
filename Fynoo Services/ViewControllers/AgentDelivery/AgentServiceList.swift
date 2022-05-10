//
//  AgentServiceList.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 24/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import Cosmos

protocol  AgentServiceListDelegate {
    
     func callClicked(_ sender: Any)
     func messageClicked(_ sender: Any)
     func navigationClicked(_ sender: Any)
}
class AgentServiceList: UITableViewCell,UITableViewDelegate {
   
    
    @IBOutlet weak var widthconst: NSLayoutConstraint!
    var  delegate : AgentServiceListDelegate?
    
    @IBOutlet weak var cosmicRatingView: CosmosView!
    @IBOutlet weak var nexttabbtn: UIButton!
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var totalRate: UILabel!
    @IBOutlet weak var avgRating: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var btnRating: UIButton!
    @IBOutlet weak var ratingCosmosView: CosmosView!
    @IBOutlet weak var navigationBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var almostPriceLbl: UILabel!
    @IBOutlet weak var walletIcon: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
      
    override func awakeFromNib() {
        super.awakeFromNib()
        self.SetFont()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.name.font = UIFont(name:"\(fontNameLight)",size:14)
        self.avgRating.font = UIFont(name:"\(fontNameLight)",size:12)
        self.totalRate.font = UIFont(name:"\(fontNameLight)",size:12)
        self.totalCount.font = UIFont(name:"\(fontNameLight)",size:10)
        self.orderId.font = UIFont(name:"\(fontNameLight)",size:10)
        self.date.font = UIFont(name:"\(fontNameLight)",size:10)
        self.address.font = UIFont(name:"\(fontNameLight)",size:12)
        self.almostPriceLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.price.font = UIFont(name:"\(fontNameLight)",size:12)
        self.statusLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.statusLbl.textColor = UIColor.AppThemeBlackTextColor()
        
    }
    @IBAction func navigationClicked(_ sender: Any) {
        self.delegate?.navigationClicked(self)
  
    }
    @IBAction func callClicked(_ sender: Any) {
        self.delegate?.callClicked(self)
    }
    @IBAction func messageClicked(_ sender: Any) {
        self.delegate?.messageClicked(self)
    }
}
