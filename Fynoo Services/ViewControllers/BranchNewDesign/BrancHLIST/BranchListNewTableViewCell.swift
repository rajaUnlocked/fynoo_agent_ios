//
//  BranchListNewTableViewCell.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 13/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol BranchListNewTableViewCellDelegate {
    func editClick(tag: Int)
    func qrcode(tag:Int)
//    func shareClick()
}


class BranchListNewTableViewCell: UITableViewCell {
    var delegate: BranchListNewTableViewCellDelegate?
    
    
    @IBOutlet weak var switchNewOutlet: UIButton!
    
    @IBOutlet weak var creLbl: UILabel!
    @IBOutlet weak var numberProLbl: UILabel!
    @IBOutlet weak var mainBranchDotImage: UIImageView!
    @IBOutlet weak var mainBranchLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var noOfProduct: UILabel!
    @IBOutlet weak var storeOnLbl: UILabel!
    @IBOutlet weak var storeTypeLbl: UILabel!
    @IBOutlet weak var userCount: UILabel!
    @IBOutlet weak var qrBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var switchBtn: UISwitch!
    var city_name = ""
    @IBOutlet weak var createdOn: UILabel!
    @IBOutlet weak var lftImage: UIImageView!
    @IBOutlet weak var rgtImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        mainBranchLbl.font = UIFont(name:"\(fontNameLight)",size:6)
        branchName.font = UIFont(name:"\(fontNameLight)",size:10)
        numberProLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        storeTypeLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        creLbl.font = UIFont(name:"\(fontNameLight)",size:6)
        storeOnLbl.font = UIFont(name:"\(fontNameLight)",size:10)
        
        
//        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
//            if value[0]=="ar"
//            {
//                switchBtn.layer.transform = CATransform3DMakeRotation(CGFloat(DEGREES_TO_RADIANS(ANGLE: 180.0)), 0, 0, 0)
//            }
//            else{
//                switchBtn.layer.transform = CATransform3DMakeRotation(CGFloat(DEGREES_TO_RADIANS(ANGLE: 0.0)), 0, 0, 0)
//            }
//        }
        
        let on_img = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"on-btn")!)
        let off_img = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"off-btn")!)
        
        switchNewOutlet.setImage(off_img, for: .normal)
        switchNewOutlet.setImage(on_img, for: .selected)
    }

    func DEGREES_TO_RADIANS(ANGLE: Double) -> Double {
        ANGLE / 180.0 * .pi
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       switchBtn.transform = CGAffineTransform(scaleX: 0.50, y: 0.50)
        // Configure the view for the selected state
    }
    func setCellData(list : [New_Branch_list]?, indexPath:Int){
        
        if list?[indexPath].branch_city != "" {
                  city_name = list?[indexPath].branch_city ?? ""
               }
               else {
                     city_name = ""
               }
        if list?[indexPath].online_store != "" && list?[indexPath].store_on_map != ""{
            self.rgtImage.isHidden = false
            self.storeOnLbl.isHidden = false
            self.lftImage.setImage(UIImage(named: "cart_new")!)
            self.storeTypeLbl.text = "Online Store".localized
            self.rgtImage.setImage(UIImage(named: "location_new")!)
            self.storeOnLbl.text = "\("Store On Map")\("/")\(city_name)"
        }
        else if list?[indexPath].online_store == ""
        {
            let str = ""
            self.lftImage.setImage(UIImage(named: "location_new")!)
            self.storeTypeLbl.text = "\("Store On Map")\("/")\(city_name)"
           self.rgtImage.isHidden = true
            self.storeOnLbl.isHidden = true
               
        }
        else if list?[indexPath].store_on_map == ""{
            self.lftImage.setImage(UIImage(named: "cart_new")!)
            self.storeTypeLbl.text = "Online Store".localized
                  self.rgtImage.isHidden = true
              self.storeOnLbl.isHidden = true
                     }
      
        self.noOfProduct.text = "\(list?[indexPath].total_products ?? 0)"
        self.branchName.text = "\(list?[indexPath].branch_name ?? "")".localized
        self.userCount.text = "\(list?[indexPath].branch_followers ?? 0)"
        self.img.sd_setImage(with: URL(string: list?[indexPath].branch_logo ?? ""), placeholderImage: UIImage(named: "category_placeholder"))
        self.createdOn.text = "\(formatDate(date: (list?[indexPath].created_date ?? "")))"
      
       
        
        if list?[indexPath].is_main_branch == 0 {
            self.mainBranchLbl.isHidden = true
            self.mainBranchDotImage.isHidden = true
        }
        else{
            self.mainBranchLbl.isHidden = false
            self.mainBranchDotImage.isHidden = false
        }
        if list?[indexPath].is_branch_active == 0 {
            self.switchBtn.isOn = false
            self.switchNewOutlet.isSelected = false
        }
        else {
            self.switchBtn.isOn = true
            self.switchNewOutlet.isSelected = false
        }
    
    
        
    }
    @IBAction func edit(_ sender: Any) {
        self.delegate?.editClick(tag: self.tag)
    }
    
    
    @IBAction func qrcodeClick(_ sender: Any) {
        self.delegate?.qrcode(tag: self.tag)
    }
    
    @IBAction func share(_ sender: Any) {
//        self.delegate?.shareClick()
    }
    
    func formatDate(date: String) -> String {
       let dateFormatterGet = DateFormatter()
       dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .medium
       dateFormatter.timeStyle = .none
       dateFormatter.locale = Locale(identifier: "en_US") //uncomment if you don't want to get the system default format.

       let dateObj: Date? = dateFormatterGet.date(from: date)
        let da = Date()
        print(dateObj!,"Final Date")
        return dateFormatter.string(from: dateObj ?? da)
    }
    
    
}


