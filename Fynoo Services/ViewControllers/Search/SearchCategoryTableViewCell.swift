//
//  SearchCategoryTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 29/05/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class SearchCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var countryCode: UILabel!{
        didSet {
//            countryCode.textColor = Constant.Grey_TEXT_COLOR
//            countryCode.font = UIFont(name:"\(Constant.FONT_Light)",size:14)
        }
    }
    
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    @IBOutlet weak var catName: UILabel!{
        didSet {
//            catName.textColor = Constant.Grey_TEXT_COLOR
//            catName.font = UIFont(name:"\(Constant.FONT_Light)",size:12)
        }
    }
    
    @IBOutlet weak var tickImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
