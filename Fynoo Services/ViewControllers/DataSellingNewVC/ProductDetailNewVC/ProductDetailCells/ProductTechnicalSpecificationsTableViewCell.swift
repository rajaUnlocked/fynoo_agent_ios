//
//  ProductTechnicalSpecificationsTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 20/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProductTechnicalSpecificationsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pdfLblTop: NSLayoutConstraint!
    @IBOutlet weak var bottomLblHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomLbl: UILabel!
    @IBOutlet weak var technicalbl: UILabel!
    @IBOutlet weak var pdfLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var moreDetailsBtn: UIButton!
    @IBAction func moreDetailsClicked(_ sender: Any) {
    }
    @IBOutlet weak var moreDetailsLbl: UILabel!
    @IBOutlet weak var upDownArrowImageView: UIImageView!
    @IBOutlet weak var firstDocBtn: UIButton!
    @IBAction func firstDocClicked(_ sender: Any) {
    }
    @IBAction func secondDocClicked(_ sender: Any) {
    }
    @IBOutlet weak var secondDocBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
                               
    func SetFont() {
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.technicalbl.font = UIFont(name:"\(fontNameBold)",size:12)
        self.pdfLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.descriptionLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.moreDetailsLbl.font = UIFont(name:"\(fontNameLight)",size:8)
        self.firstDocBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        self.secondDocBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        
  
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
