//

//  ProfileEnteriesTableViewCell.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 25/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import iOSDropDown
class ProfileEnteriesTableViewCell: UITableViewCell {
   
    @IBOutlet weak var genderHorizantal: NSLayoutConstraint!
    @IBOutlet weak var genderWidth: NSLayoutConstraint!
    @IBOutlet weak var codeBtnWidth: NSLayoutConstraint!
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var widthImg: NSLayoutConstraint!
    
    @IBOutlet weak var genderView: DropDown!
    @IBOutlet weak var mobileCodeWidth: NSLayoutConstraint!
    @IBOutlet weak var mobileCode: UILabel!
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!
    
    @IBOutlet weak var rotateVw: UIView!
    @IBOutlet weak var eyeButton: UIButton!
    
    @IBOutlet weak var headingLbl: UITextField!
    //  @IBOutlet weak var headingLbl: UITextField!
    
    @IBOutlet weak var entryLbl: UILabel!
    
    @IBOutlet weak var underLine: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        flagImg.isHidden = true
        mobileCode.isHidden = true
        mobileCodeWidth.constant = 0
        widthImg.constant = 0
        codeBtn.isHidden = true
        codeBtnWidth.constant = 0
        genderView.arrowSize = 0.0
        genderWidth.constant = 0
             genderHorizantal.constant = 0
        headingLbl.keyboardType = .default
        // cell.headingLbl.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        headingLbl.keyboardType = .default
        headingLbl.isHidden = false
        
        
        //  SetFont()
    }
    
    func SetFont() {
        self.headingLbl.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            self.mobileCode.font = UIFont(name:"\(fontNameLight)",size:13)
            self.entryLbl.font = UIFont(name:"\(fontNameLight)",size:12)
           self.headingLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.genderView.font = UIFont(name:"\(fontNameLight)",size:11)
            
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
