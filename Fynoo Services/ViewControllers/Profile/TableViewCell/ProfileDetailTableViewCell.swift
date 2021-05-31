//
//  ProfileDetailTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 25/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
protocol ProfileDetailTableViewCellDelegate {
    func edit()
    func followersClicked()
    func branchesClicked()
    func productsClicked()
    func likesClicked()
}
class ProfileDetailTableViewCell: UITableViewCell {
    var delegate:ProfileDetailTableViewCellDelegate?
    
    @IBOutlet weak var agentimg: UIImageView!
    @IBOutlet weak var editHeight: NSLayoutConstraint!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var BRANCHlBL: UILabel!
    @IBOutlet weak var followerlBL: UILabel!
    @IBOutlet weak var products: UILabel!
    
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var branches: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var editProfileTitle: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
//        BRANCHlBL.font = UIFont(name:"\(fontNameLight)",size:11)
//        likeLbl.font = UIFont(name:"\(fontNameLight)",size:11)
//        productLbl.font = UIFont(name:"\(fontNameLight)",size:11)
//        followerlBL.font = UIFont(name:"\(fontNameLight)",size:11)
//        followers.font = UIFont(name:"\(fontNameLight)",size:16)
//        products.font = UIFont(name:"\(fontNameLight)",size:16)
//
//        likes.font = UIFont(name:"\(fontNameLight)",size:16)
//        branches.font = UIFont(name:"\(fontNameLight)",size:16)
//        editProfileTitle.font = UIFont(name:"\(fontNameLight)",size:13)



        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editBtnn(_ sender: Any) {
        self.delegate?.edit()

    }
    @IBAction func editBtn(_ sender: Any) {

    }
    
    @IBAction func followersClicked(_ sender: Any) {
        self.delegate?.followersClicked()
    }
    @IBAction func branchesClicked(_ sender: Any) {
        self.delegate?.branchesClicked()
    }
    @IBAction func productsClicked(_ sender: Any) {
        self.delegate?.productsClicked()
    }
    @IBAction func likesClicked(_ sender: Any) {
        self.delegate?.likesClicked()
    }
}
