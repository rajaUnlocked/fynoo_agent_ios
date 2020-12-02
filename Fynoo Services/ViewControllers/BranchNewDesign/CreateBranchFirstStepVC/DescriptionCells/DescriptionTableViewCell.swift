//
//  DescriptionTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 16/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit

protocol DescriptionTableViewCellDelegate: class {
    func nextClicked()
    func savedraft()
}

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descrheightConstraints: NSLayoutConstraint!
    @IBOutlet weak var saveDraft: UIButton!
    weak var delegate: DescriptionTableViewCellDelegate?
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nextOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nextOutlet.layer.cornerRadius = 17
         self.saveDraft.layer.cornerRadius = 17
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        self.delegate?.nextClicked()
    }
    @IBAction func saveDrafts(_ sender: Any) {
        self.delegate?.savedraft()
    }
}
