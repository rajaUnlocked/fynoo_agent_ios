//
//  DataBankHeader.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 24/03/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class DataBankHeader: UIView {
    
    var view: UIView!
    var viewControl = UIViewController()
    
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var sorting: UIButton!
    @IBOutlet weak var scrollvw: UIScrollView!
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var productDataSale: UIButton!
    @IBOutlet weak var purchasedProduct: UIButton!
    @IBOutlet weak var productDataBank: UIButton!
    
    @IBOutlet weak var barcode: UIButton!
    @IBOutlet weak var txtField: UITextField!
    
    override init(frame: CGRect)
    {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
        sideMenuCode()
    }
    
    @IBAction func backButton(_ sender: Any) {
        viewControl.navigationController?.popViewController(animated: true)
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
       
        self.viewWidth.constant = UIScreen.main.bounds.width
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
    }
    
    func loadViewFromNib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DataBankHeader", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
        
        // Assumes UIView is top level and only object in CustomView.xib file
        //   let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    
}
   
