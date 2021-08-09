//
//  DEInprogressOrderInformationFirstTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 23/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DEInprogressOrderInformationFirstTableViewCell: UITableViewCell {

    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var productDataEntryView: UIView!
    @IBOutlet weak var productDataEntryBtn: UIButton!
    @IBOutlet weak var productDataEntryTickImgeView: UIImageView!
    @IBOutlet weak var productDataEntryCountLbl: UILabel!
    @IBOutlet weak var branchDataEntryView: UIView!
    @IBOutlet weak var branchDataEntryBtn: UIButton!
    @IBOutlet weak var branchDataEntryTickImageView: UIImageView!    
    @IBOutlet weak var branchDataEntryCount: UILabel!
    @IBOutlet weak var productDataEntryHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var branchDataEntryHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var productTxtHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var branchTxtHeightConstant: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFont()
    }
            
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.productDataEntryCountLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.branchDataEntryCount.font = UIFont(name:"\(fontNameLight)",size:12)
       
        productDataEntryBtn.setTitle("Product Data Entry".localized, for: .normal)
        
//        let attrs = [
//            NSAttributedString.Key.font :  UIFont(name:"\(fontNameLight)",size:12),
//            NSAttributedString.Key.foregroundColor :  UIColor(red: 28/255, green: 157/255, blue: 213/255, alpha: 1.0),
//            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
//        let attributedString = NSMutableAttributedString(string:"")
//        let buttonTitleStr = NSMutableAttributedString(string:"Product Data Entry".localized, attributes:attrs)
//        attributedString.append(buttonTitleStr)
//        productDataEntryBtn.setAttributedTitle(attributedString, for: .normal)
//
        branchDataEntryBtn.setTitle("Branch Data Entry".localized, for: .normal)
//
//        let attrs1 = [
//            NSAttributedString.Key.font :  UIFont(name:"\(fontNameLight)",size:12),
//            NSAttributedString.Key.foregroundColor :  UIColor(red: 28/255, green: 157/255, blue: 213/255, alpha: 1.0),
//            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any] as [NSAttributedString.Key : Any]
//        let attributedString1 = NSMutableAttributedString(string:"")
//        let buttonTitleStr1 = NSMutableAttributedString(string:"Branch Data Entry".localized, attributes:attrs1)
//        attributedString1.append(buttonTitleStr1)
//        branchDataEntryBtn.setAttributedTitle(attributedString1, for: .normal)
//
        
        self.productDataEntryBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        self.branchDataEntryBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        
        
        if HeaderHeightSingleton.shared.LanguageSelected == "AR" {
            
            self.productTxtHeightConstant.constant = 19
            self.branchTxtHeightConstant.constant = 19
            
            let lineView = UIView(frame: CGRect(x: 0, y: self.productDataEntryBtn.frame.size.height - 0.6, width: self.productDataEntryBtn.frame.size.width - 20 , height: 0.6))
            lineView.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
            self.productDataEntryBtn.addSubview(lineView)
            
            
            let lineView1 = UIView(frame: CGRect(x: 0, y: self.branchDataEntryBtn.frame.size.height - 0.6, width: self.branchDataEntryBtn.frame.size.width - 20  , height: 0.6))
            lineView1.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
            self.branchDataEntryBtn.addSubview(lineView1)
            
        }else{
            self.productTxtHeightConstant.constant = 17
            self.branchTxtHeightConstant.constant = 17
            
            let lineView = UIView(frame: CGRect(x: 0, y: self.productDataEntryBtn.frame.size.height - 0.6, width: self.productDataEntryBtn.frame.size.width, height: 0.6))
            lineView.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
            self.productDataEntryBtn.addSubview(lineView)
            
            
            let lineView1 = UIView(frame: CGRect(x: 0, y: self.branchDataEntryBtn.frame.size.height - 0.6, width: self.branchDataEntryBtn.frame.size.width , height: 0.6))
            lineView1.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
            self.branchDataEntryBtn.addSubview(lineView1)
            
        }
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
