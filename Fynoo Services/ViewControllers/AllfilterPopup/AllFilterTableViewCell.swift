//
//  AllFilterTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 07/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

class AllFilterTableViewCell: UITableViewCell {
    @IBOutlet weak var filterName: UILabel!
    
    @IBOutlet weak var filterValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        filterValue.layer.cornerRadius =  5
//        filterValue.layer.borderColor = UIColor.lightGray.cgColor
//        filterValue.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
