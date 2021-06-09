//
//  ProductListTableViewCell.swift
//  Fynoo Services
//
//  Created by Apple on 23/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblQty: UIImageView!
    @IBOutlet weak var lblPriceAlmost: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnReduceQuantity: UIButton!
    @IBOutlet weak var btnCart: UIButton!
    
   
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    
}
