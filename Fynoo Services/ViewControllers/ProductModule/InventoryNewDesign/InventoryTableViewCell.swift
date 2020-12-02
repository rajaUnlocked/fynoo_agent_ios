 //
//  InventoryTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 14/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import iOSDropDown

 protocol InventoryTableViewCellDelegate {
    func add(tag:Int)
 }
class InventoryTableViewCell: UITableViewCell {
    var delegate : InventoryTableViewCellDelegate?

    @IBOutlet weak var addSubtract: DropDown!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var add: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubtract.optionIds = [0,1]
        self.addSubtract.optionArray = ["+","-"]
        self.addSubtract.textColor = #colorLiteral(red: 0.5058823529, green: 0.5058823529, blue: 0.5058823529, alpha: 1)
        self.addSubtract.text = "+"
        self.addSubtract.font = UIFont(name: "Gilroy-light", size: 22.0)
        self.addSubtract.textAlignment = .center
        self.addSubtract.isSearchEnable = false
        self.addSubtract.listHeight = 500
        self.addSubtract.rowHeight = 30
        self.addSubtract.arrowColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addClick(_ sender: Any) {
        self.delegate?.add(tag: self.tag)
    }
    
}
