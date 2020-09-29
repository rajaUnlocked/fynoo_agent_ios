//
//  BottomPopupTableViewCell.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 28/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol BottomPopupTableViewCellDelegate {
    func info(tag:Int)
}
class BottomPopupTableViewCell: UITableViewCell {

    var delegate: BottomPopupTableViewCellDelegate?
    
    @IBOutlet weak var nameLblLeading: NSLayoutConstraint!
    @IBOutlet weak var infoBtnTrainling: NSLayoutConstraint!
    
    @IBOutlet weak var imgLeading: NSLayoutConstraint!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    @IBOutlet weak var infoBtn: UIButton!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var infoImgWidth: NSLayoutConstraint!
    @IBOutlet weak var infoImgHght: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
           let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        nameLbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func information(_ sender: Any) {
        self.delegate?.info(tag: self.tag)
    }
}
