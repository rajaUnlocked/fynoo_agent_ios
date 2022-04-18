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
    
    @IBOutlet weak var StatusLbl: UILabel!
    @IBOutlet weak var statusLeadingConstant: NSLayoutConstraint!
    @IBOutlet weak var backgrounddView:UIView!
    @IBOutlet weak var imgDelete:UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                self.headerTxt.textAlignment = .right
                self.addressLbl.textAlignment = .right
                self.rejectReasonLbl.textAlignment = .right
                self.imgDelete.image = UIImage(named: "reject_arabic")
               
            }else if value[0]=="en"{
                self.headerTxt.textAlignment = .left
                self.addressLbl.textAlignment = .left
                self.rejectReasonLbl.textAlignment = .left
                self.imgDelete.image = UIImage(named: "reject_eng")
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
        self.StatusLbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        animateSwipeHint()

        // Configure the view for the selected state
    }
    
    
   
    
}


extension UITableViewCell{
    
    func animateSwipeHint(bg:UIView) {
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                slideInFromRight(bg:bg)
            }else if value[0]=="en"{
                slideInFromLeft(bg:bg)
            }
        }
    }

    private func slideInFromRight(bg:UIView) {
        UIView.animate(withDuration: 0.80, delay: 0.5, options: [.curveEaseOut], animations: {
            bg.transform = CGAffineTransform(translationX: -80,y: 0)
//            self.backgrounddView.layer.cornerRadius = 10
        }) { (success) in
            UIView.animate(withDuration: 0.8, delay: 0.2, options: [.curveLinear], animations: {
                bg.transform = .identity
            }, completion: { (success) in
                // Slide from left if you have leading swipe actions
              
            })
        }
    }

    private func slideInFromLeft(bg:UIView) {
        UIView.animate(withDuration: 0.80, delay: 0, options: [.curveEaseOut], animations: {
            bg.transform = CGAffineTransform(translationX: 80, y: 0)
        }) { (success) in
            UIView.animate(withDuration: 0.8, delay: 0.3, options: [.curveLinear], animations: {
                bg.transform = .identity
            })
        }
    }
    
}
