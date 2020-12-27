//
//  BusinessLocationTableViewCell.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 07/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol BusinessLocationTableViewCellDelegate {
    func locationSearch(tag: Int)
    func locationCancel(tag: Int)
}
class BusinessLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var separator: UILabel!
    @IBOutlet weak var outerview: UIView!
    @IBOutlet weak var borderVw: UIView!
    @IBOutlet weak var lbl: UILabel!
    var delegate : BusinessLocationTableViewCellDelegate?
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var addressLblheight: NSLayoutConstraint!
    @IBOutlet weak var lblTop: NSLayoutConstraint!
    @IBOutlet weak var borderVwTrailing: NSLayoutConstraint!
    
    
    @IBOutlet weak var cancelTrailing: NSLayoutConstraint!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.txtField.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lbl.font = UIFont(name:"\(fontNameLight)",size:12)
        
        self.outerview.setAllSideShadowForFieldsWithHeight(shadowShowSize: 1.0, sizeFloat: UIScreen.main.bounds.size.width - 20, sizeFloatHeight: 98)
        self.borderVw.setAllSideShadowForFields(shadowShowSize: 1.0, sizeFloat: UIScreen.main.bounds.size.width - 60)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cancelLocation(_ sender: Any) {
        self.delegate?.locationCancel(tag: self.tag)
        
    }
    @IBAction func searchLocation(_ sender: Any) {
         self.delegate?.locationSearch(tag: self.tag)
    }
}
