//
//  SectionHeader.swift
//  
//
//  Created by IND-SEN-LP-046 on 09/09/20.
//

import UIKit

class SectionHeader: UIView {

    @IBOutlet weak var sectionText: UILabel!
    var view: UIView!
     
     override init(frame: CGRect)
     {
         // 1. setup any properties here
         // 2. call super.init(frame:)
         super.init(frame: frame)
         
         // 3. Setup view from .xib file
         xibSetup()
         sideMenuCode()
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
          //let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        
         
         view.frame = bounds
         // Make the view stretch with containing view
         view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
         addSubview(view)
         
     }
     
     func loadViewFromNib() -> UIView{
         let bundle = Bundle(for: type(of: self))
         let nib = UINib(nibName: "SectionHeader", bundle: bundle)
         let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
         
         return view

         // Assumes UIView is top level and only object in CustomView.xib file
      //   let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
     }
}
