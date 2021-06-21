//
//  AddInvoiceInformationTableViewCell.swift
//  Fynoo Services
//
//  Created by Apple on 23/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

protocol  AddInvoiceInformationDelegate {
    
     func uploadClicked(_ sender: Any)
    func anyProblemClicked(_ sender: Any)
}

class AddInvoiceInformationTableViewCell: UITableViewCell {
    
    var delegate : AddInvoiceInformationDelegate?
    
    @IBOutlet weak var lblAlmostAmount: UILabel!
    
    @IBOutlet weak var lblAlmostAmountPrice: UILabel!
    
    @IBOutlet weak var lblAddInvoice: UILabel!
    
    @IBOutlet weak var lblUploadInvoice: UILabel!
    
    @IBOutlet weak var tapToBtnUploadInvoice: UIButton!
    @IBOutlet weak var lblTotalAmt: UILabel!
    
    @IBOutlet weak var txtTotalAmtWithoughtVat: UITextField!
    
    @IBOutlet weak var lblCurrencyWtVat: UILabel!
    @IBOutlet weak var lblVatAmt: UILabel!
    
    @IBOutlet weak var txtVatAmt: UITextField!
    
    @IBOutlet weak var lblCurrencyVat: UILabel!
    
    
    @IBOutlet weak var lblTotalAmountwithVat: UILabel!
    
    @IBOutlet weak var txtTotalAmountWithVat: UITextField!
    
    @IBOutlet weak var lblCurrencyWithVat: UILabel!
    
    @IBOutlet weak var imgInvoiceUploaded: UIImageView!
    
    
    @IBOutlet weak var viewForShowHide: UIView!
    
    
    @IBOutlet weak var btnAnyProblem: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func uploadInvoiceClicked(_ sender: Any) {
        self.delegate?.uploadClicked(self)
    }
    
    
    @IBAction func anyProblemClicked(_ sender: Any) {
        
        delegate?.anyProblemClicked(self)
    }
    
}
