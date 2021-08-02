//
//  ProductImgCollectionViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 12/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol ProductImgDelegate {
    func uploadImg(tag:Int)
    func deleteImg(tag:Int)
}
class ProductImgCollectionViewCell: UICollectionViewCell {
    var delegate:ProductImgDelegate?
    @IBOutlet weak var add: UIButton!
    
    @IBOutlet weak var mainlbl: UILabel!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        mainlbl.font = UIFont(name:"\(fontNameLight)",size:8)
    }

    @IBAction func add(_ sender: Any) {
        self.delegate?.uploadImg(tag: self.tag)
    }
    @IBAction func deleted(_ sender: Any) {
       self.delegate?.deleteImg(tag: self.tag)
    }
}
