//
//  MultipleBranchHeader.swift
//  Fynoo Business
//
//  Created by Aishwarya on 14/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class MultipleBranchHeader: UIView {
    var view: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
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
            let nib = UINib(nibName: "MultipleBranchHeader", bundle: bundle)
            let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
            
            return view

            // Assumes UIView is top level and only object in CustomView.xib file
         //   let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        }
}
