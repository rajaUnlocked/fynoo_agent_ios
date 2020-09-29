//
//  SideMenuEarningTableViewCell.swift
//  Fynoo Services
//
//  Created by Aishwarya on 16/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

protocol SideMenuEarningTableViewCellDelegate: class {
    func commissionBtnClicked()
    func targetBtnClicked()
}

class SideMenuEarningTableViewCell: UITableViewCell {

    weak var delegate: SideMenuEarningTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func commBtn(_ sender: Any) {
        self.delegate?.commissionBtnClicked()
    }
    
    @IBAction func targetBtn(_ sender: Any) {
        self.delegate?.targetBtnClicked()
    }
}
