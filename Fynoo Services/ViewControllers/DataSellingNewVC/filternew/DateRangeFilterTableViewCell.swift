//
//  DateRangeFilterTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 04/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import DatePickerDialog
protocol DateRangeFilterTableViewCellDelegate {
    func startDateTimeStamp(strtDtTimeStamp: String)
    func endDateTimeStamp(endDtTimeStamp: String)
}


  
class DateRangeFilterTableViewCell: UITableViewCell {
    
    var startDateTimeStamp: String = ""
    var endDateTimeStamp: String = ""
    var startDateInDate: Date? = nil
    
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var fromlbl: UILabel!
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var strtDateLbl: UILabel!
    var minTimeStamp = 0.0
    var maxTimeStamp = 0.0
    var delegate : DateRangeFilterTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
          
        // Configure the view for the selected state
    }
    
    @IBAction func fromDate(_ sender: Any) {
    
        print(minTimeStamp,maxTimeStamp)
        let date = Date(timeIntervalSince1970: minTimeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        
        print(localDate,"dsj")
        let min_date = NSDate(timeIntervalSince1970: minTimeStamp)
       
          let max_date = NSDate(timeIntervalSince1970: maxTimeStamp)
         print(min_date,max_date)
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: min_date as Date,minimumDate: min_date as Date, maximumDate: max_date as Date , datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                let date = formatter.string(from: dt)
                self.strtDateLbl.text = date
                let date1 = formatter.date(from:date)
                self.startDateInDate = date1
                // convert Date to TimeInterval (typealias for Double)
                let timeInterval = date1!.timeIntervalSince1970
                self.startDateTimeStamp = ModalController.toString(timeInterval as Any)
                
                print("startDate:-", date1 as Any)
                print("startDateTimeStamp:-", self.startDateTimeStamp as Any)
                
                self.delegate?.startDateTimeStamp(strtDtTimeStamp: self.startDateTimeStamp)
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
                let date1 = formatter.date(from:date)
                // convert Date to TimeInterval (typealias for Double)
                let timeInterval = date1!.timeIntervalSince1970
                self.endDateTimeStamp = ModalController.toString(timeInterval as Any)
                
                print("endDate:-", date1 as Any)
                print("endDateTimeStamp:-", self.endDateTimeStamp as Any)
                
                self.delegate?.endDateTimeStamp(endDtTimeStamp:   self.endDateTimeStamp)
                
            }
        }
        
    }
    
 
}
