//
//  OtpTableViewCell.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 12/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

protocol  OtpTableViewCellDelegate {
    
     func selectClicked(_ sender: Any)
}

class OtpTableViewCell: UITableViewCell {
     
    var delegate : OtpTableViewCellDelegate?

    @IBOutlet weak var lblStatictextVeryfy: UILabel!
    
    @IBOutlet weak var lblStatictextOtp: UILabel!
    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    
    @IBOutlet weak var btnReceivedCodAmt: UIButton!
    
    @IBOutlet weak var imgCheck: UIImageView!
    
    @IBOutlet weak var lblReceivedCodAmt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        txt1.textAlignment = .center
//        txt2.textAlignment = .center
//        txt3.textAlignment = .center
//        txt4.textAlignment = .center
//        txt1.contentVerticalAlignment = .center
//        txt1.contentHorizontalAlignment = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func receivedCodClicked(_ sender: Any) {
        self.delegate?.selectClicked(self)
    }
  
}
