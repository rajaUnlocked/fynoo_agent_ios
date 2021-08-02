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
    
    @IBOutlet weak var viewForBoToAgent: UIView!
    
    
    @IBOutlet weak var lblNoteBo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SetFont()
       
//        if HeaderHeightSingleton.shared.LanguageSelected == "AR"{
//
//                  setTextUnderline()
//
//                }
        
    }
    
 func setTextUnderline()
        {
////            let dummyButton: UIButton = UIButton.init()
            btnAnyProblem.setTitle("Any Problem?".localized, for: .normal)
//    btnAnyProblem.titleLabel?.font = UIFont(name:"\(Constant.FONT_Light)",size:12)
////            dummyButton.sizeToFit()
//        btnAnyProblem.sizeToFit()
//            let dummyHeight = btnAnyProblem.frame.size.height + 3
//
//            let bottomLine = CALayer()
//            bottomLine.frame = CGRect.init(x: (self.frame.size.width - btnAnyProblem.frame.size.width)/2, y: -(self.frame.size.height - dummyHeight), width: btnAnyProblem.frame.size.width, height: 1.0)
//            bottomLine.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
//            self.layer.addSublayer(bottomLine)
    let dummyButton: UIButton = UIButton.init()
           dummyButton.setTitle("Any Problem?".localized, for: .normal)
//           dummyButton.titleLabel?.font = "Any Problem?".localized,.font
           dummyButton.sizeToFit()

           let dummyHeight = dummyButton.frame.size.height + 3

           let bottomLine = CALayer()
           bottomLine.frame = CGRect.init(x: (self.frame.size.width - dummyButton.frame.size.width)/2, y: -(self.frame.size.height - dummyHeight), width: dummyButton.frame.size.width, height: 1.0)
    bottomLine.backgroundColor = self.btnAnyProblem.titleLabel?.textColor.cgColor
           self.layer.addSublayer(bottomLine)
    
        }
    
    func SetFont() {

            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")

            self.lblAlmostAmount.font = UIFont(name:"\(fontNameLight)",size:20)
        self.lblAlmostAmountPrice.font = UIFont(name:"\(fontNameBold)",size:23)
            self.lblTotalAmt.font = UIFont(name:"\(fontNameLight)",size:12)

        self.lblUploadInvoice.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblCurrencyWtVat.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblVatAmt.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblTotalAmountwithVat.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblCurrencyWtVat.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblCurrencyVat.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblCurrencyWithVat.font = UIFont(name:"\(fontNameLight)",size:12)
//        self.btnAnyProblem.titleLabel!.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblAddInvoice.font = UIFont(name:"\(fontNameLight)",size:14)
        
        self.btnAnyProblem.titleLabel!.font = UIFont(name:"\(Constant.FONT_Light)",size:12)

        let myNormalAttributedTitle = NSAttributedString(string: "Any Problem?".localized,attributes: [NSAttributedString.Key.foregroundColor : UIColor.AppThemeBlueTextColor(),.underlineStyle: NSUnderlineStyle.single.rawValue,.underlineColor : UIColor.AppThemeBlueTextColor()])
        
//      self.btnAnyProblem.titleLabel?.text = "Any Problem?".localized
        btnAnyProblem.titleLabel?.textAlignment = NSTextAlignment.center
        self.btnAnyProblem.setAttributedTitle(myNormalAttributedTitle, for: .normal)
        lblAddInvoice.textColor = UIColor.AppThemeGreenTextColor()
        self.lblNoteBo.font = UIFont(name:"\(fontNameLight)",size:11)
        self.lblNoteBo.text = "Note: Please share the OTP with Business Owner which you will receive after Confirm and Upload Invoice' to confirm that you have received all products from Business Owner.".localized
      
        
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
