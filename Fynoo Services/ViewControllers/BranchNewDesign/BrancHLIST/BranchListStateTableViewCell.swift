//
//  BranchListStateTableViewCell.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 13/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit


protocol BranchListStateTableViewCellDelegate {
    func branchAdd(tag:Int)
}
class BranchListStateTableViewCell: UITableViewCell {

    var delegate: BranchListStateTableViewCellDelegate?
    
    
    @IBOutlet weak var img1Top: NSLayoutConstraint!
    
    @IBOutlet weak var viewTop: NSLayoutConstraint!
    @IBOutlet weak var subscriptionBranches: UILabel!
    @IBOutlet weak var activeBranchLbl: UILabel!
    @IBOutlet weak var inactiveBranchLbl: UILabel!
    @IBOutlet weak var addBranch: UIButton!
    
    @IBOutlet weak var subscitpionLbl: UILabel!
    
    @IBOutlet weak var addLbl: UILabel!
    
    @IBOutlet weak var inactiveLbl: UILabel!
   
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var activeLbl: UILabel!
    
    @IBOutlet weak var height: NSLayoutConstraint!
    
    @IBOutlet weak var addLblTop: NSLayoutConstraint!
    @IBOutlet weak var imgTop: NSLayoutConstraint!
    @IBOutlet weak var imgLeading: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var img3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        addLbl.font = UIFont(name:"\(fontNameLight)",size:6)
        subscitpionLbl.font = UIFont(name:"\(fontNameLight)",size:13)
        activeLbl.font = UIFont(name:"\(fontNameLight)",size:13)
        inactiveLbl.font = UIFont(name:"\(fontNameLight)",size:13)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addBranch(_ sender: Any) {
        self.delegate?.branchAdd(tag: self.tag)
    }
    
    
}
