//
//  BankHeader.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 19/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class InvoicingHeader: UIView {

  var view: UIView!
        
    @IBOutlet weak var filterCountLbl: UILabel!
    @IBOutlet weak var filterBtnOutlet: UIButton!
    @IBOutlet weak var btnInvoice: UIButton!
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var btnDebitNotes: UIButton!
    @IBOutlet weak var secondLbl: UILabel!
    
    @IBOutlet weak var btnCreditNotes: UIButton!
    @IBOutlet weak var firstLbl: UILabel!
    
    @IBOutlet weak var searchField: UITextField!
//    @IBOutlet weak var searchBtnOutlet: UIButton!
    
    
    @IBOutlet weak var bankVw: UIView!
    @IBOutlet weak var searchBtnOutlet: UIButton!
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
            btnInvoice.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
            btnDebitNotes.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
            btnCreditNotes.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
            addSubview(view)
            
        }
        
        func loadViewFromNib() -> UIView{
            let bundle = Bundle(for: type(of: self))
            let nib = UINib(nibName: "InvoicingHeader", bundle: bundle)
            let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
            
            return view

            // Assumes UIView is top level and only object in CustomView.xib file
         //   let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        }
    
    
    }
