//
//  ProductDetailBannerTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 17/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import Cosmos
import BBannerView

protocol ProductDetailBannerTableViewCellDelegate {
    func BarCodeClicked(tag:Int)
    func addProductClicked(tag: Int)
    func qrCodeClicked(tag: Int)
    
}
class ProductDetailBannerTableViewCell: UITableViewCell {
     var delegate : ProductDetailBannerTableViewCellDelegate?
   
    @IBOutlet weak var addProBtnTrailing: NSLayoutConstraint!
    @IBOutlet weak var addProImgTrailing: NSLayoutConstraint!
    @IBOutlet weak var dropShippingBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var dropShippingBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var dropShippingProBtn: UIButton!
    @IBOutlet weak var addImgHeight: NSLayoutConstraint!
    @IBOutlet weak var addBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var ratingvwconst: NSLayoutConstraint!
    @IBOutlet weak var imgTop: NSLayoutConstraint!
    @IBOutlet weak var qrcodeBtn: UIButton!
    
    @IBOutlet weak var headerLlbl: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var cosmicRatingView: CosmosView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var totalRatingLbl: UILabel!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var addProductImageView: UIImageView!
    @IBOutlet weak var FavouriteBtn: UIButton!
    @IBOutlet weak var barCodeBtn: UIButton!
    @IBOutlet weak var addProductBtn: UIButton!
    @IBOutlet weak var followersBtn: UIButton!
    @IBOutlet weak var totalFollowersCount: UILabel!
    @IBOutlet weak var sharebtn: UIButton!
    @IBOutlet weak var followerCountCentreConstant: NSLayoutConstraint!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
         self.ratingView.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: 125)
        self.followersCount.textAlignment = .center
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        headerLlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"
            {
                self.followerCountCentreConstant.constant = 8
            }
            else if value[0]=="en"{
             self.followerCountCentreConstant.constant = -5
            }
        }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    @IBAction func openBarCodeClicked(_ sender: Any) {
        self.delegate?.BarCodeClicked(tag: self.tag)
       }
    @IBAction func addProductClicked(_ sender: Any) {
        self.delegate?.addProductClicked(tag: self.tag)
       }
  
   
    @IBAction func qrcode(_ sender: Any) {
    self.delegate?.qrCodeClicked(tag: self.tag)
    
    }
    
//    func configurePageControl() {
//          self.pageControl.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//          self.pageControl.numberOfPages = bannerCount.count
//          self.pageControl.currentPage = 0
//      }
//
//      // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
//      @objc func changePage(sender: AnyObject) -> () {
//          let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
//          scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
//          pageControl.currentPage = Int(x)
//      }
//
//      func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//          let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
//          pageControl.currentPage = Int(pageNumber)
//      }
}
