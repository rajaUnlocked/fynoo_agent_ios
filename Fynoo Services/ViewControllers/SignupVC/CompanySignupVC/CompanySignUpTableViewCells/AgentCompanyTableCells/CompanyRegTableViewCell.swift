//
//  CompanyRegTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 02/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol CompanyRegTableViewCellDelegate {
    func selectHeader(tag:Int)
}

class CompanyRegTableViewCell: UITableViewCell {
    var delegate :CompanyRegTableViewCellDelegate?
    
    @IBOutlet var headerBackGroundView: UIView!
    @IBOutlet var editImageView: UIImageView!
    @IBOutlet var serviceNameLabel: UILabel!
    @IBOutlet var arrowBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFontAndTextColor()
    }
        
    func SetFontAndTextColor(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.serviceNameLabel.font = UIFont(name:"\(fontNameLight)",size:12)
         self.serviceNameLabel.textColor = Constant.Black_TEXT_COLOR
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    @IBAction func arrowBtnClicked(_ sender: Any) {
       }
}
