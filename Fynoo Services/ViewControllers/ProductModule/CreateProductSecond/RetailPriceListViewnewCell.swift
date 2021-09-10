//
//  RetailPriceListViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 13/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class RetailPriceListViewnewCell: UITableViewCell {
    
    @IBOutlet weak var bottomlbl: UILabel!
    @IBOutlet weak var percentTrailing: NSLayoutConstraint!
    @IBOutlet weak var imgLeading: NSLayoutConstraint!
    
    @IBOutlet weak var pricewidthConst: NSLayoutConstraint!
    @IBOutlet weak var leadingcurrencyconst: NSLayoutConstraint!
    @IBOutlet weak var titleLblLeading: NSLayoutConstraint!
    @IBOutlet weak var leadingCurrency: NSLayoutConstraint!
    
    @IBOutlet weak var rgtvw: UIView!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var finalPrice: UITextField!
    @IBOutlet weak var finalCurrency: UILabel!
    @IBOutlet weak var greenTick: UIImageView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var exchangeImg: UIImageView!

    @IBOutlet weak var currency: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       titleLabel.font = UIFont(name:"\(fontNameLight)",size:10)
          finalCurrency.font = UIFont(name:"\(fontNameLight)",size:10)
          max.font = UIFont(name:"\(fontNameLight)",size:7)
          min.font = UIFont(name:"\(fontNameLight)",size:7)
          currency.font = UIFont(name:"\(fontNameLight)",size:10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
