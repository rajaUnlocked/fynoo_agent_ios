//
//  ProductHeader2TableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 14/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol ProductHeader2Delegate {
    func retail(tag:Int)
       func whole(tag:Int)
}
class ProductHeader2TableViewCell: UITableViewCell {
    @IBOutlet weak var retail: UIButton!
    
    @IBOutlet weak var whole: UIButton!
    var delegate:ProductHeader2Delegate?
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let BoldFontName = NSLocalizedString("BoldFontName", comment: "")
       retail.titleLabel?.font = UIFont(name:"\(BoldFontName)",size:12)
         whole.titleLabel?.font = UIFont(name:"\(BoldFontName)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func whole(_ sender: UIButton) {
        self.delegate?.whole(tag: sender.tag)
    }
    
    @IBAction func retail(_ sender: UIButton) {
          self.delegate?.retail(tag: sender.tag)
    }
}
