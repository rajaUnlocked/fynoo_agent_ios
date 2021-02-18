//
//  DateRangeFilterTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 04/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol DateRangeFilterTableViewCellDelegate {
    func startDateTimeStamp(_ sender: Any, strtDtTimeStamp: String)
    func endDateTimeStamp( _ sender: Any, endDtTimeStamp: String)
}  
class DateRangeFilterTableViewCell: UITableViewCell {
    
    var startDateTimeStamp: String = ""
    var endDateTimeStamp: String = ""
    var startDateInDate: Date? = nil
    
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var strtDateLbl: UILabel!
    var minTimeStamp = 0.0
    var maxTimeStamp = 0.0
    var delegate : DateRangeFilterTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        headerLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func fromDate(_ sender: Any) {
        
        let min_date = NSDate(timeIntervalSince1970: minTimeStamp)
        let max_date = NSDate(timeIntervalSince1970: maxTimeStamp)
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: min_date as Date,minimumDate: min_date as Date, maximumDate: max_date as Date , datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let date = formatter.string(from: dt)
                self.strtDateLbl.text = date
                //                print( self.strtDateLbl.text,"jhsf")
                //                let date1 = formatter.date(from:date)
                self.startDateInDate = dt
                
                // convert Date to TimeInterval (typealias for Double)
                let timeInterval = dt.timeIntervalSince1970
                let ghj = ModalController.toString(timeInterval as Any)
                
                let fullName  = ghj
                let fullNameArr = fullName.components(separatedBy: ".")
                self.startDateTimeStamp  = fullNameArr[0]
                
                
                
                print("startDate:-", dt as Any)
                print("startDateTimeStamp:-", self.startDateTimeStamp as Any)
                
                self.delegate?.startDateTimeStamp(self, strtDtTimeStamp: self.startDateTimeStamp)
                // sender.setTitle(date, for: .normal)
            }
        }
        
    }
    
    
    @IBAction func toDate(_ sender: Any) {
        
        if  self.strtDateLbl.text == "Enter FromDate" {
            ModalController.showNegativeCustomAlertWith(title: "Please select start date first", msg: "")
            return
        }
        let min_date = NSDate(timeIntervalSince1970: minTimeStamp)
        let max_date = NSDate(timeIntervalSince1970: maxTimeStamp)
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate: min_date as Date,maximumDate: max_date as Date, datePickerMode: .date) {
            //        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let date = formatter.string(from: dt)
                self.toDateLbl.text = date
                // let date1 = formatter.date(from:date)
                // convert Date to TimeInterval (typealias for Double)
                let timeInterval = dt.timeIntervalSince1970
                let ghj = ModalController.toString(timeInterval as Any)
                let fullName  = ghj
                let fullNameArr = fullName.components(separatedBy: ".")
                self.endDateTimeStamp  = fullNameArr[0]
                
                print("endDate:-", dt as Any)
                print("endDateTimeStamp:-", self.endDateTimeStamp as Any)
                
                self.delegate?.endDateTimeStamp(self, endDtTimeStamp:   self.endDateTimeStamp)
                
            }
        }
        
    }
    
    
}
