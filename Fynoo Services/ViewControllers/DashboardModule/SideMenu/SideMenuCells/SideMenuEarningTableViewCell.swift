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

    @IBOutlet weak var earninglbl: UILabel!
    @IBOutlet weak var commisionlbl: UILabel!
    
    @IBOutlet weak var targetlbl: UILabel!
    
    
    weak var delegate: SideMenuEarningTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        earninglbl.font = UIFont(name:"\(fontNameLight)",size:12)
        commisionlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        targetlbl.font = UIFont(name:"\(fontNameLight)",size:12)

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
