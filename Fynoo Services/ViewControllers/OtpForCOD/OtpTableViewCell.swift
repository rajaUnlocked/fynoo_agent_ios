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
    
    @IBOutlet weak var otpMainview: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
  SetFont()
        rotateViewForArabic()
    }
    
    
    func SetFont() {

            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")

            let fontNameLight = NSLocalizedString("LightFontName", comment: "")

            

        self.btnReceivedCodAmt.titleLabel!.font = UIFont(name:"\(fontNameLight)",size:12)

            self.lblReceivedCodAmt.font = UIFont(name:"\(fontNameLight)",size:12)

            self.lblStatictextOtp.font = UIFont(name:"\(fontNameLight)",size:12)
            self.lblStatictextVeryfy.font = UIFont(name:"\(fontNameLight)",size:16)
        
        self.txt1.font = UIFont(name:"\(fontNameLight)",size:12)
        self.txt2.font = UIFont(name:"\(fontNameLight)",size:12)
        self.txt3.font = UIFont(name:"\(fontNameLight)",size:12)
        self.txt4.font = UIFont(name:"\(fontNameLight)",size:12)
        
     
       

        }
    
    func rotateViewForArabic()  {
   
    if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String] {
        if value[0] == "ar" {
            let degrees = 180.0 // or -90, 180 depending on phone's movement.
            let rotatedView: UIView = self.otpMainview
            rotatedView.transform  = CGAffineTransform(rotationAngle: CGFloat(degrees) * CGFloat(M_PI / 180))

            self.txt1.transform = CGAffineTransform(rotationAngle: CGFloat(-(Double.pi / 1.0)))
            self.txt2.transform = CGAffineTransform(rotationAngle: CGFloat(-(Double.pi / 1.0)))
            self.txt3.transform = CGAffineTransform(rotationAngle: CGFloat(-(Double.pi / 1.0)))
            self.txt4.transform = CGAffineTransform(rotationAngle: CGFloat(-(Double.pi / 1.0)))

        }else{

        }
    }
        
}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func receivedCodClicked(_ sender: Any) {
        self.delegate?.selectClicked(self)
    }
  
}
