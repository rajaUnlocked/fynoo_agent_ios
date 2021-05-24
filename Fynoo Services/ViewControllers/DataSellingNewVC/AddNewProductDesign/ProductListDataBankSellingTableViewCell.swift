//
//  ProductListNewTableViewCell.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 11/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ProductListDataBankSellingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstSeparatorImg: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var soldDataLbl: UILabel!
    @IBOutlet weak var currLbl: UILabel!
    @IBOutlet weak var currImg: UIImageView!
    @IBOutlet weak var noOfPhotosLbl: UILabel!
    @IBOutlet weak var langLbl: UILabel!
    @IBOutlet weak var subCatlbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var statusl: UILabel!
    @IBOutlet weak var datapricelbl: UILabel!
    @IBOutlet weak var infoimgWidth: NSLayoutConstraint!
    @IBOutlet weak var infoImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
     self.nameLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.categoryLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        self.subCatlbl.font = UIFont(name:"\(fontNameLight)",size:10)
        self.langLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        self.noOfPhotosLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        self.soldDataLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        self.datapricelbl.font = UIFont(name:"\(fontNameLight)",size:10)
         self.currLbl.font = UIFont(name:"\(fontNameLight)",size:10)
         self.dateLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        self.statusl.font = UIFont(name:"\(fontNameLight)",size:10)
        self.statusLbl.font = UIFont(name:"\(fontNameLight)",size:10)
         self.nameLbl.textAlignment = .left
        if HeaderHeightSingleton.shared.LanguageSelected == "AR"
        {
            self.nameLbl.textAlignment = .right
        }
        
    }
    
    func setCellData(productList: [Product_list_data_Bank_Selling]?, index: Int) {
        self.editBtn.isUserInteractionEnabled = true
        self.nameLbl.text = productList?[index].pro_name
        self.datapricelbl.text = "Data Price".localized
        self.statusl.text = "\("Status".localized):"
        let url = productList?[index].pro_image ?? ""
        self.proImg.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"))
        let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: "\( "\("Category".localized):  ")\(productList?[index].pro_category ?? "")")
        attributedString.setColor(color: #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), forText: (productList?[index].pro_category ?? ""))
        self.categoryLbl.attributedText = attributedString
        
      
        self.subCatlbl.isHidden = true
        self.firstSeparatorImg.isHidden = true
        if productList?[index].pro_sub_category != "" {
            self.subCatlbl.isHidden = false
            self.firstSeparatorImg.isHidden = false
            let attributedString1 : NSMutableAttributedString = NSMutableAttributedString(string: "\("\("Sub Category".localized):  ")\(productList?[index].pro_sub_category ?? "")")
            attributedString1.setColor(color: #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), forText: productList?[index].pro_sub_category ?? "")
            self.subCatlbl.attributedText = attributedString1
        }
        
        let attributedString3 : NSMutableAttributedString = NSMutableAttributedString(string: "\("\("No. of Photos".localized):  ")\(productList?[index].pro_photo ?? 0)")
        attributedString3.setColor(color: #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), forText: "\(productList?[index].pro_photo ?? 0)")
        self.noOfPhotosLbl.attributedText = attributedString3
        
        
        let attributedString4 : NSMutableAttributedString = NSMutableAttributedString(string: "\(productList?[index].pro_currency_code ?? "")\(":  ")\(productList?[index].pro_sale_price ?? "")")
        attributedString4.setColor(color: #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), forText: "\(productList?[index].pro_sale_price ?? "")")
        self.currLbl.attributedText = attributedString4
        
        let attributedString5 : NSMutableAttributedString = NSMutableAttributedString(string: "\("\("No. of Sold Data".localized):  ")\(productList?[index].pro_purchase ?? 0)")
        attributedString5.setColor(color: #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), forText: "\(productList?[index].pro_purchase ?? 0)")
        self.soldDataLbl.attributedText = attributedString5
        
        
        let attributedString2 : NSMutableAttributedString = NSMutableAttributedString(string: "\("\("Language".localized):  ")\(productList?[index].pro_language ?? "")")
        attributedString2.setColor(color: #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), forText: "\(productList?[index].pro_language ?? "")")
        self.langLbl.attributedText = attributedString2
        
        let timeSTAMP = "\((productList?[index].pro_added_at_timestamp)!)"
       self.dateLbl.text = ModalController.convertTimeStampIntoDate(timeStamp: timeSTAMP, format: "dd-MMM-yyyy HH:mm a")
          self.statusLbl.text = "\((productList?[index].pro_status_value)!)"
        if productList?[index].pro_status == 0 {
            self.statusLbl.textColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
            self.infoimgWidth.constant = 0
        }
        else if  productList?[index].pro_status == 1 {
            self.statusLbl.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
            self.infoimgWidth.constant = 0
        }
        else if  productList?[index].pro_status == 2 {
            self.infoImg.isHidden = false
            self.infoimgWidth.constant = 16
            self.statusLbl.textColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
          
        }
        else if  productList?[index].pro_status == 3 {
            self.editBtn.isUserInteractionEnabled = false
            self.infoimgWidth.constant = 0
        }
            else if  productList?[index].pro_status == 4 {
                self.editBtn.isUserInteractionEnabled = true
                self.infoimgWidth.constant = 0
            }
        else {
            self.statusLbl.textColor = #colorLiteral(red: 0.9137254902, green: 0.7960784314, blue: 0.01176470588, alpha: 1)
            self.infoimgWidth.constant = 0
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
