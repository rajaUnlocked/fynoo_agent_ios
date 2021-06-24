//
//  CompleteDataEntryListTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 19/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol  CompleteDataEntryListTableViewCellrDelegate {
    
     func ratingClicked(_ sender: Any)
    func callClicked(_ sender: Any)
    func messageClicked(_ sender: Any)
    func navigationClicked(_ sender: Any)
}

class CompleteDataEntryListTableViewCell: UITableViewCell {
    
    var  delegate : CompleteDataEntryListTableViewCellrDelegate?
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var lowerLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var paidTextLbl: UILabel!
    @IBOutlet weak var priceValueLbl: UILabel!
    @IBOutlet weak var amountVatLbl: UILabel!
    @IBOutlet weak var agentProfileImgView: UIImageView!
    @IBOutlet weak var agentNameLbl: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var ratingStrImageView: UIImageView!
    @IBOutlet weak var totalRatingLbl: UILabel!
    @IBOutlet weak var agentAddressLbl: UILabel!
    @IBOutlet weak var socialMediaView: UIView!
    @IBOutlet weak var textMessageBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var giveRatingBtn: UIButton!
    @IBOutlet weak var boLocationBtn: UIButton!
    @IBOutlet weak var locationBtnWidthConstant: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.SetFont()
        
          
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
              if value[0]=="ar"{
                  self.headerLbl.textAlignment = .right
                self.addressLbl.textAlignment = .right
                self.agentNameLbl.textAlignment = .right
                self.agentAddressLbl.textAlignment = .right
                self.priceValueLbl.textAlignment = .right
              }else if value[0]=="en"{
                  self.headerLbl.textAlignment = .left
                self.addressLbl.textAlignment = .left
                self.agentNameLbl.textAlignment = .left
                self.agentAddressLbl.textAlignment = .left
                self.priceValueLbl.textAlignment = .left
              }
          }
    }
        
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.orderIdLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.dateLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.addressLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.paidTextLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.priceValueLbl.font = UIFont(name:"\(fontNameLight)",size:14)
         self.amountVatLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.agentNameLbl.font = UIFont(name:"\(fontNameLight)",size:16)
         self.ratingLbl.font = UIFont(name:"\(fontNameLight)",size:14)
         self.totalRatingLbl.font = UIFont(name:"\(fontNameLight)",size:14)
         self.agentAddressLbl.font = UIFont(name:"\(fontNameLight)",size:14)
//        self.completeTxtLbl.font = UIFont(name:"\(fontNameLight)",size:14)
        self.giveRatingBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:14)

     giveRatingBtn.setTitle("Give Ratings".localized, for: .normal)
      
      let attrs = [
          NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0),
          NSAttributedString.Key.foregroundColor :  UIColor(red: 28/255, green: 157/255, blue: 213/255, alpha: 1.0),
          NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
      let attributedString = NSMutableAttributedString(string:"")
      let buttonTitleStr = NSMutableAttributedString(string:"Give Ratings".localized, attributes:attrs)
      attributedString.append(buttonTitleStr)
      giveRatingBtn.setAttributedTitle(attributedString, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func textMessageClicked(_ sender: Any) {
        self.delegate?.messageClicked(self)
        
    }
    
    @IBAction func callBtnClicked(_ sender: Any) {
        self.delegate?.callClicked(self)
        
    }
    
    @IBAction func giveRatingClicked(_ sender: Any) {
        self.delegate?.ratingClicked(self)
    }
    
    @IBAction func boLocationClicked(_ sender: Any) {
        self.delegate?.navigationClicked(self)
    }
    
}
