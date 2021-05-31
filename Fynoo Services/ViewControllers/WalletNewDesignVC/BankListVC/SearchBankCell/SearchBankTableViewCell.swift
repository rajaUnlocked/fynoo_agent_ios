//
//  SearchBankTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 31/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

protocol SearchBankTableViewCellDelegate: class {
    func addNewBankClicked(_ sender: Any)
}

class SearchBankTableViewCell: UITableViewCell {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var addNewOutlet: UIButton!
    weak var delegate: SearchBankTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        addNewOutlet.layer.cornerRadius = 16
        self.searchField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addNEwBtn(_ sender: Any) {
        self.delegate?.addNewBankClicked(self)
    }
}
