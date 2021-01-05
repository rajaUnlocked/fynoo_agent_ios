//
//  DataEntryFormWorkPlaceTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 06/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import GoogleMaps

protocol DataEntryFormWorkPlaceTableViewCellDelegate: class {
    
    func workFromOnlineClicked(_ sender: Any)
    func workFromBranchClicked(_ sender: Any)
    
}

class DataEntryFormWorkPlaceTableViewCell: UITableViewCell {
    
    weak var delegate: DataEntryFormWorkPlaceTableViewCellDelegate?
    @IBOutlet weak var headerTxt: UILabel!
    @IBOutlet weak var onlineView: UIView!
    @IBOutlet weak var onlineTxtLbl: UILabel!
    @IBOutlet weak var onlineBtn: CardbUTTON!
    @IBOutlet weak var branchView: UIView!
    @IBOutlet weak var branchTxtLbl: UILabel!
    @IBOutlet weak var branchBtn: CardbUTTON!
    @IBOutlet weak var branchSearchView: UIView!
    @IBOutlet weak var branchSearchTxtFld: UITextField!
  
    @IBOutlet weak var mapOuterView: UIView!
    @IBOutlet weak var branchMapView: GMSMapView!
    @IBOutlet weak var mapViewHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var onlineViewHeightConstant: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.SetFontAndTextColor()
        self.branchSearchTxtFld.setLeftPaddingPoints(5)
        self.branchSearchTxtFld.setRightPaddingPoints(5)
                
    }
        
    func SetFontAndTextColor(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.headerTxt.font = UIFont(name:"\(fontNameLight)",size:16)
        self.onlineTxtLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.branchTxtLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.branchSearchTxtFld.font = UIFont(name:"\(fontNameLight)",size:11)
        
        self.headerTxt.textColor = Constant.Black_TEXT_COLOR
        self.onlineTxtLbl.textColor = Constant.Black_TEXT_COLOR
        self.branchTxtLbl.textColor = Constant.Black_TEXT_COLOR
        self.branchSearchTxtFld.textColor = Constant.Black_TEXT_COLOR
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onlinebtnClicked(_ sender: Any) {
        self.delegate?.workFromOnlineClicked(self)
      }
    @IBAction func branchBtnClicked(_ sender: Any) {
        self.delegate?.workFromBranchClicked(self)
       }
   
}
