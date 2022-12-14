//
//  SelectProductTypeTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 11/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol SelectProductTypeDelegate {
    func lftbtn(ar:[Bool])
    func rgtbtn(ar:[Bool])
}
class SelectProductTypeTableViewCell: UITableViewCell {
    var delegate:SelectProductTypeDelegate?
    
    @IBOutlet weak var rightBtnLeading: NSLayoutConstraint!
    
    @IBOutlet weak var leftLblLeading: NSLayoutConstraint!
    @IBOutlet weak var topConst: NSLayoutConstraint!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    @IBOutlet weak var rgtbtn: UIButton!
    @IBOutlet weak var leftbtn: UIButton!
    @IBOutlet weak var btnleading: NSLayoutConstraint!
    @IBOutlet weak var rgtlbl: UILabel!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var leftlbl: UILabel!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    @IBOutlet weak var outervw: UIView!
    
    @IBOutlet weak var trailingConst: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        leftlbl.font =  UIFont(name: "\(fontNameLight)", size: 12)
        lbl.font =  UIFont(name: "\(fontNameLight)", size: 12)
        rgtlbl.font =  UIFont(name: "\(fontNameLight)", size: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
   
   
}
