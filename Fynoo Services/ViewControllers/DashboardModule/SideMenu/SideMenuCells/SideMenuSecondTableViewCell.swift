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

    @IBOutlet weak var makemoneylbl: UILabel!
    @IBOutlet weak var dropshippinglbl: UILabel!
    
    @IBOutlet weak var addproductlbl: UILabel!
    weak var delegate: SideMenuSecondTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        addproductlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        makemoneylbl.font = UIFont(name:"\(fontNameLight)",size:12)
       // dropshippinglbl.font = UIFont(name:"\(fontNameLight)",size:12)

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
