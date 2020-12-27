//
//  addrowTableViewCell.swift
//  Fynoo Business
//
//  Created by Sendan IT on 19/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
protocol addrowssDelegate {
    func addrow(tag:Int,tag1:Int)
    func slot1(tag:Int,btn:UIButton,row:Int)
}

class addrowTableViewCell: UITableViewCell {
    var delegate:addrowssDelegate?
    var plusbtntag:Int?
    var isflag = true
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var checkbtn: UIButton!
    
    @IBOutlet weak var frombtn: UIButton!
    @IBOutlet weak var tobtn: UIButton!
    @IBOutlet weak var plusbtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       days.font = UIFont(name:"\(fontNameLight)",size:13)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addrow(_ sender: Any) {
        self.delegate?.addrow(tag:self.tag, tag1: plusbtntag!)
    }
    @IBAction func tobtnAction(_ sender: UIButton) {
        self.delegate?.slot1(tag: self.tag, btn: tobtn, row: self.plusbtntag!)
    }
    @IBAction func frombtnAction(_ sender: UIButton) {
        self.delegate?.slot1(tag: self.tag, btn: frombtn, row: self.plusbtntag!)
    }
}
