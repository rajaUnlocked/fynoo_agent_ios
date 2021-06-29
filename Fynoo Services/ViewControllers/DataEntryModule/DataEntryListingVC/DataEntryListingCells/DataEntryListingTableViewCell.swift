//
//  DataEntryListingTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 02/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataEntryListingTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroungImageView: UIImageView!
    @IBOutlet weak var headerTxt: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var rejectReasonLbl: UILabel!
    @IBOutlet weak var rejectReasonHeightConstant: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                self.headerTxt.textAlignment = .right
                self.addressLbl.textAlignment = .right
                self.rejectReasonLbl.textAlignment = .right
            }else if value[0]=="en"{
                self.headerTxt.textAlignment = .left
                self.addressLbl.textAlignment = .left
                self.rejectReasonLbl.textAlignment = .left
            }
        }
    }
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerTxt.font = UIFont(name:"\(fontNameLight)",size:16)
        self.orderIdLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.dateLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.addressLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.priceLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.rejectReasonLbl.font = UIFont(name:"\(fontNameLight)",size:16)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
