//
//  deleterowTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 20/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
protocol deleterowssDelegate {
    func deleterow(tag:Int,row:Int)
    func slot1(tag:Int,btn:UIButton,row:Int)
}
class deleterowTableViewCell: UITableViewCell {
    var delegate:deleterowssDelegate?
    @IBOutlet weak var dfrombtn: UIButton!
    @IBOutlet weak var dtobtn: UIButton!
    var rows:Int?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print(tag,rows as Any)
        // Configure the view for the selected state
    }
    
    @IBAction func deleterows(_ sender: UIButton) {
        self.delegate?.deleterow(tag: self.tag, row: self.rows!)
    }
    @IBAction func dtobtnAction(_ sender: UIButton) {
        self.delegate?.slot1(tag: self.tag, btn: dtobtn, row: self.rows!)
    }
    @IBAction func dfrombtnAction(_ sender: UIButton) {
        self.delegate?.slot1(tag: self.tag, btn: dfrombtn, row: self.rows!)
    }
}
