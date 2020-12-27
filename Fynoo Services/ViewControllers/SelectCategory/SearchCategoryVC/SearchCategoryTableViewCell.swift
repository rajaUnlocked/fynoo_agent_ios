//
//  SearchCategoryTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 29/05/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class SearchCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var tickImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
