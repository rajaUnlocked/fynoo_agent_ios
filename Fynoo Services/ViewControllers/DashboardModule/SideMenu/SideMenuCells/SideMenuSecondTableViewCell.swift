//
//  SideMenuSecondTableViewCell.swift
//  Fynoo
//
//  Created by Aishwarya on 22/04/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
protocol SideMenuSecondTableViewCellDelegate: class {
    func dropShippingBtnClicked()
    func addProductDataForSaleBtnClicked()
}

class SideMenuSecondTableViewCell: UITableViewCell {

    weak var delegate: SideMenuSecondTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func dropShippingBtn(_ sender: Any) {
        self.delegate?.dropShippingBtnClicked()
    }
    
    @IBAction func addProductDataForSaleBtn(_ sender: Any) {
        self.delegate?.addProductDataForSaleBtnClicked()
    }
}
