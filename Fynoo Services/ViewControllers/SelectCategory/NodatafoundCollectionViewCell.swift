//
//  NodatafoundCollectionViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 20/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class NodatafoundCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var noDataLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        noDataLbl.font = UIFont(name:"\(fontNameBold)",size:20)
    }

}
