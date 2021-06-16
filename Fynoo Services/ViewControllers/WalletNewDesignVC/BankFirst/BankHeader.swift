//
//  BankHeader.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 19/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class BankHeader: UIView {

  var view: UIView!
        
    @IBOutlet weak var filterCountLbl: UILabel!
    @IBOutlet weak var filterBtnOutlet: UIButton!
    @IBOutlet weak var paymentProgress: UIButton!
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var holdingAmount: UIButton!
    @IBOutlet weak var walletBalance: UIButton!
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var availableLbl: UILabel!
    
    @IBOutlet weak var searchField: UITextField!
//    @IBOutlet weak var searchBtnOutlet: UIButton!
    
    @IBOutlet weak var emailBtnOutlet: UIButton!
    @IBOutlet weak var downloadBtnOutlet: UIButton!
    
    @IBOutlet weak var bankVw: UIView!
    @IBOutlet weak var progressBtnOutlet: UIButton!
    @IBOutlet weak var successBtnOutlet: UIButton!
    @IBOutlet weak var searchBtnOutlet: UIButton!
    @IBOutlet weak var bankVwHeight: NSLayoutConstraint!
    @IBOutlet weak var currencylbl: UILabel!
    
    @IBOutlet weak var paymentprogresslbl: UILabel!
    
    @IBOutlet weak var paymentsucceslbl: UILabel!
    override init(frame: CGRect)
        {
            // 1. setup any properties here
            
            // 2. call super.init(frame:)
            super.init(frame: frame)
            
            xibSetup()
        }
        required init?(coder aDecoder: NSCoder)
        {
            // 1. setup any properties here
            
            // 2. call super.init(coder:)
            super.init(coder: aDecoder)
            
            // 3. Setup view from .xib file
            xibSetup()
        }
        
        func xibSetup()
        {
            view = loadViewFromNib()
            
    //        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
    //            if value[0]=="ar"
    //            {
    //                let img = UIImage(named: "back_new")
    //                let image = UIImage(cgImage: (img?.cgImage)!, scale: (img?.scale)!, orientation: UIImage.Orientation.upMirrored)
    //               // backButton.setImage(image, for: .normal)
    //            }
    //            else if value[0]=="en"
    //            {
    //                let image = UIImage(named: "back_new")
    //                //backButton.setImage(image, for: .normal)
    //
    //            }
    //        }
            
            view.frame = bounds
            // Make the view stretch with containing view
            view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
            if HeaderHeightSingleton.shared.LanguageSelected == "AR"
            {
                searchField.textAlignment = .right
            }
            else{
                searchField.textAlignment = .left
            }
            searchField.attributedPlaceholder = NSAttributedString(string: "Recent Transaction".localized,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
                  let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            walletBalance.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
            holdingAmount.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
            paymentProgress.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
            paymentprogresslbl.font = UIFont(name:"\(fontNameLight)",size:12)
            paymentsucceslbl.font = UIFont(name:"\(fontNameLight)",size:12)
            currencylbl.font = UIFont(name:"\(fontNameLight)",size:12)
            totalLbl.font = UIFont(name:"\(fontNameBold)",size:13)
            availableLbl.font = UIFont(name:"\(fontNameLight)",size:12)
            searchField.font = UIFont(name:"\(fontNameLight)",size:12)
            downloadBtnOutlet.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
            emailBtnOutlet.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
            addSubview(view)
            
        }
        
        func loadViewFromNib() -> UIView{
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: "BankHeader", bundle: bundle)
            let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
            
            return view

            // Assumes UIView is top level and only object in CustomView.xib file
         //   let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        }
    
    
    }
