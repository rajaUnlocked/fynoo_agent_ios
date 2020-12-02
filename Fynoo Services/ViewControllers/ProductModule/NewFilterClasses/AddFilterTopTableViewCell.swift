//
//  AddFilterTopTableViewCell.swift
//  Fynoo Business
//
//  Created by SENDAN on 05/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
protocol addRowsProtocol {
    func addRows(tag:Int)
  
}
class AddFilterTopTableViewCell: UITableViewCell {
    var delegate:addRowsProtocol?

    @IBOutlet weak var featuretypell: UILabel!
    @IBOutlet weak var featurenamelbl: UILabel!
    @IBOutlet weak var featureName: UITextField!
    @IBOutlet weak var featureNameType: UITextField!
    
    @IBOutlet weak var addRows: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        featuretypell.font = UIFont(name:"\(fontNameLight)",size:12)
        featureName.font = UIFont(name:"\(fontNameLight)",size:12)
        featurenamelbl.font = UIFont(name:"\(fontNameLight)",size:12)
         featureNameType.font = UIFont(name:"\(fontNameLight)",size:12)
    }
    @IBAction func addRow(_ sender: Any) {
        delegate?.addRows(tag: 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
