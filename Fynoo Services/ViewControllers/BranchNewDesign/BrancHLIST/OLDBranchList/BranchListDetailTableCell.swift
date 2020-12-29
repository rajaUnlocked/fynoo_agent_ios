//
//  BranchListDetailTableCell.swift
//  Fynoo Business
//
//  Created by SENDAN on 02/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
protocol BranchListDetailTableCellDelegate {
    func deleteBranch(tag:Int)
    func changeMain(tag:Int)
    func active(tag:Int)
    func edit(tag:Int)
     func viewGallery(tag:Int)
    func draft(tag:Int)
}
class BranchListDetailTableCell: UITableViewCell {
    var delegate :BranchListDetailTableCellDelegate?
    
    @IBOutlet weak var activelbl: UILabel!
    @IBOutlet weak var deletebtn: UIButton!
    @IBOutlet weak var editbtn: UIButton!
    @IBOutlet weak var draftbtn: UIButton!
    @IBOutlet weak var draftimg: UIImageView!
    @IBOutlet weak var noProduct: UILabel!
    @IBOutlet weak var mainBranchLbl: UILabel!
    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var mainBranch: UIButton!
    @IBOutlet weak var switchs : UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func editBranch(_ sender: UIButton) {
        self.delegate?.edit(tag: self.tag)
    }
    @IBAction func deleteBranch(_ sender: UIButton) {
        self.delegate?.deleteBranch(tag: self.tag)
    }
    
    @IBAction func changeToMain(_ sender: UIButton) {
        self.delegate?.changeMain(tag: self.tag)
    }
    @IBAction func activeBranch(_ sender: UISwitch) {
          self.delegate?.active(tag: self.tag)
    }
    @IBAction func viewgallery(_ sender: UIButton) {
        self.delegate?.viewGallery(tag: self.tag)
    }
    @IBAction func draft(_ sender: UIButton) {
         self.delegate?.draft(tag: self.tag)
    }
}
