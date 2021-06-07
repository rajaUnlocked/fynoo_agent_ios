//
//  BankListTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 31/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

protocol BankListTableViewCellDelegate: class {
    func editBankClicked(tag:Int)
    func deleteBankClicked(_ sender: Any)
    func transferBtnClicked(_ sender: Any)
}

class BankListTableViewCell: UITableViewCell {
    var delegate:BankListTableViewCellDelegate?
    @IBOutlet weak var bankSelect: UIButton!
    @IBOutlet weak var nameHolder: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var transferRequest: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var accountNoLbl: UILabel!
    @IBOutlet weak var ibanLbl: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var shortName: UILabel!
    @IBOutlet weak var fullName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.transferRequest.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 50)
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
    nameHolder.font = UIFont(name:"\(fontNameLight)",size:12)
        bankNameLbl.font = UIFont(name:"\(fontNameLight)",size:11)
        accountNoLbl.font = UIFont(name:"\(fontNameLight)",size:11)
        transferRequest.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:15)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editBtn(_ sender: Any) {
        self.delegate?.editBankClicked(tag: self.tag)
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        self.delegate?.deleteBankClicked(self)
    }
    
    @IBAction func transferBtn(_ sender: Any) {
        self.delegate?.transferBtnClicked(self)
    }
}
