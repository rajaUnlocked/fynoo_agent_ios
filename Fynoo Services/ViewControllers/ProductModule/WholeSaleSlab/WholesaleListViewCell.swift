//
//  WholesaleListViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 13/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol WholesaleListDelegate {
    func editSlab(tag:Int)
     func deleteSlab(tag:Int)
}
class WholesaleListViewCell: UITableViewCell {
    
    @IBOutlet weak var vatlbl: UILabel!
    
    @IBOutlet weak var Dislbl: UILabel!
    @IBOutlet weak var Perpricelbl: UILabel!
    @IBOutlet weak var Qtylbl: UILabel!
    @IBOutlet weak var finalPrice: UILabel!
    @IBOutlet weak var vatPercent: UILabel!
    
    @IBOutlet weak var discountPercent: UILabel!
    @IBOutlet weak var vatPrice: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var maxQty: UILabel!
    @IBOutlet weak var minQty: UILabel!
    var delegate:WholesaleListDelegate?
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var slablabel: UILabel!
    @IBOutlet weak var toplblHeightConst: NSLayoutConstraint!
    @IBOutlet weak var slabLevelView: UIView!
    @IBOutlet weak var slabLevalLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       let fontNameLight = NSLocalizedString("LightFontName", comment: "")
      slabLevalLbl.font = UIFont(name:"\(fontNameLight)",size:12)
         slabLevalLbl.font = UIFont(name:"\(fontNameLight)",size:12)
         slabLevalLbl.font = UIFont(name:"\(fontNameLight)",size:12)
         slabLevalLbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
    @IBAction func deleted(_ sender: Any) {
        self.delegate?.deleteSlab(tag:self.tag)
    }
    @IBAction func edit(_ sender: Any) {
        self.delegate?.editSlab(tag:self.tag)
    }
}
