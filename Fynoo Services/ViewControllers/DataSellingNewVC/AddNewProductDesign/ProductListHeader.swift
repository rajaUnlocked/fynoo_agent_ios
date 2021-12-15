//
//  ProductListHeader.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 11/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ProductListHeader: UIView {
      var view: UIView!
    
    
    
    @IBOutlet weak var addproductlbl: UILabel!
    @IBOutlet weak var searchbtn: UIButton!
    
    @IBOutlet weak var scanBtn: Globalsearch!
    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var totalEarning: UILabel!
    @IBOutlet weak var soldData: UILabel!
    @IBOutlet weak var draftData: UILabel!
    
    @IBOutlet weak var filtercount: UILabel!
    override init(frame: CGRect)
      {
          // 1. setup any properties here
          // 2. call super.init(frame:)
          super.init(frame: frame)
          
          // 3. Setup view from .xib file
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
          addSubview(view)
          
      }
      
      func loadViewFromNib() -> UIView{
          let bundle = Bundle(for: type(of: self))
          let nib = UINib(nibName: "ProductListHeader", bundle: bundle)
          let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
          
          return view

          // Assumes UIView is top level and only object in CustomView.xib file
       //   let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
      }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
