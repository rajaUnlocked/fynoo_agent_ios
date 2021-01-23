//
//  DateFilterTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 25/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol DateFilterTableViewCellDelegate {
    func fromDate(sender: String)
     func toDate(sender: String)
}
class DateFilterTableViewCell: UITableViewCell {
    var delegate:DateFilterTableViewCellDelegate?
    @IBOutlet weak var fromDtLbl: UILabel!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var toDAte: UIButton!
    @IBOutlet weak var fromDate: UIButton!
     var dat = Date()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func fromDate(_ sender: Any) {
         
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
                   
                   (date) -> Void in
                   
                   if let dt = date {
                       let formatter = DateFormatter()
                       formatter.dateFormat = "yyyy-MM-dd"
                       let date = formatter.string(from: dt)
                       self.fromDtLbl.text = date
                       self.dat = dt
                   }
            self.delegate?.fromDate(sender: self.fromDtLbl.text!)
               }
            
    }
    
    @IBAction func toDate(_ sender: Any) {
          
        DatePickerDialog().show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
                   
                   (date) -> Void in
                   
                   if let dt = date {
                       let formatter = DateFormatter()
                       formatter.dateFormat = "yyyy-MM-dd"
                       let date = formatter.string(from: dt)
                       self.toDateLbl.text = date
                       self.dat = dt
                   }
                  self.delegate?.toDate(sender: self.toDateLbl.text!)
               }
            
    }
}
