//
//  ConfirmToreceiveItemTableViewCell.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 28/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

protocol ConfirmToreceiveItemTableViewCellDelegate {
    func ClickedAnyProblem(_ sender: Any)
    func ClickedReceivedItem(_ sender: Any)
}
class ConfirmToreceiveItemTableViewCell: UITableViewCell {
    
    var delegate : ConfirmToreceiveItemTableViewCellDelegate?
    
    @IBOutlet weak var lblQty: UILabel!
    
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblTextshareOtp: UILabel!
    
    @IBOutlet weak var lblOtp: UILabel!
    
    @IBOutlet weak var btnReceiveItemOutlet: UIButton!
    
    @IBOutlet weak var imgCheck: UIImageView!
    
    @IBOutlet weak var lblIHaveReceivedItem: UILabel!
    
    @IBOutlet weak var btnAnyProblemOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnAnyProblemTapped(_ sender: Any) {
        self.delegate?.ClickedAnyProblem(self)
    }
    
    
    @IBAction func btnReceivedItemTapped(_ sender: Any) {
        self.delegate?.ClickedReceivedItem(self)
    }
}
