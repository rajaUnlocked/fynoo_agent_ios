//
//  WalletFilterNewViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya on 07/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import TTRangeSlider
import DatePickerDialog

protocol WalletFilterNewViewControllerDelegate: class {
    func clearAllClicked()
    func applyFilerClicked(min: Double, max: Double, fromD: String, toD: String)
}

class WalletFilterNewViewController: UIViewController, TTRangeSliderDelegate {

    weak var delegate: WalletFilterNewViewControllerDelegate?
    @IBOutlet weak var headerVw: NavigationView!
    @IBOutlet weak var topheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var downImage: UIImageView!
    @IBOutlet weak var rangeSlider: TTRangeSlider!
    @IBOutlet weak var greenAmount: UIImageView!
    @IBOutlet weak var tickAmount: UIImageView!
    @IBOutlet weak var greenDate: UIImageView!
    @IBOutlet weak var tickDate: UIImageView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var fromDateOutlet: UIButton!
    @IBOutlet weak var toDateOutlet: UIButton!
    var minAmount = 0.0
    var maxAmount = 0.0
    
    @IBOutlet weak var walletlbl: UILabel!
    
    @IBOutlet weak var filterby: UILabel!
    
    @IBOutlet weak var clearalllbl: UIButton!
    
    @IBOutlet weak var enterdatelbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var amounlbl: UILabel!
    
    @IBOutlet weak var transactionlbl: UILabel!
    
    @IBOutlet weak var closeout: UIButton!
    @IBOutlet weak var applybnout: UIButton!
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var fromlbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        closeout.setTitle("Cancel".localized, for: .normal)
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
      walletlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        filterby.font = UIFont(name:"\(fontNameLight)",size:12)
        clearalllbl.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        enterdatelbl.font = UIFont(name:"\(fontNameLight)",size:12)
        datelbl.font = UIFont(name:"\(fontNameLight)",size:12)
        amounlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        transactionlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        tolbl.font = UIFont(name:"\(fontNameLight)",size:12)
        fromlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        applybnout.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        closeout.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        
        downImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        self.navigationController?.navigationBar.isHidden = true
        self.topheightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerVw.viewControl = self
        self.headerVw.titleHeader.text = "Manage Your Wallet".localized
        
        self.dateView.isHidden = true
        self.tickAmount.isHidden = true
        self.tickDate.isHidden = true
        self.greenDate.isHidden = true
    }
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
           
            print("minRangeVal", selectedMinimum)
            print("maxRangeVal", selectedMaximum)
            minAmount = Double(selectedMinimum)
            maxAmount = Double(selectedMaximum)
            self.tickAmount.isHidden = false
       }
    
    @IBAction func clearAllBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
        self.delegate?.clearAllClicked()
    }
    
    @IBAction func amountClicked(_ sender: Any) {
        self.dateView.isHidden = true
        self.sliderView.isHidden = false
        
        self.greenAmount.isHidden = false
        self.greenDate.isHidden = true
    }
    
    @IBAction func dateClicked(_ sender: Any) {
        self.dateView.isHidden = false
        self.sliderView.isHidden = true
        
        self.greenAmount.isHidden = true
        self.greenDate.isHidden = false
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyBtn(_ sender: Any) {
        if self.minAmount == 0.0 && self.maxAmount == 0.0 && self.toDateOutlet.titleLabel!.text == nil && self.fromDateOutlet.titleLabel!.text == nil {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "No filter selected.")
        }else{
            
            var mi = 0.0
            var ma = 0.0
            var fr = ""
            var to = ""
            
            if self.minAmount != 0.0 {
                mi = minAmount
            }
            if self.maxAmount != 0.0 {
                 ma = maxAmount
            }
            
            if self.toDateOutlet.titleLabel!.text != nil {
                fr = self.fromDateOutlet.titleLabel!.text!
                to = self.toDateOutlet.titleLabel!.text!
            }
            
            self.navigationController?.popViewController(animated:true)
            self.delegate?.applyFilerClicked(min: mi, max: ma, fromD: fr, toD: to)
            
        }
    }
    
    @IBAction func fromDateBtn(_ sender: Any) {
        
        var curr_date = Date()
        if self.toDateOutlet.titleLabel!.text == nil {
            curr_date = Calendar.current.date(byAdding: .year, value: 0, to: Date())!
        }else{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            curr_date = formatter.date(from: self.toDateOutlet.titleLabel!.text!)!
        }
        
        DatePickerDialog().show("Select Date".localized, doneButtonTitle: "Done".localized, cancelButtonTitle: "Cancel".localized, maximumDate: curr_date, datePickerMode: .date) {
                  (date) -> Void in
                  if let dt = date {
                   
                      let formatter = DateFormatter()
                   formatter.locale = Locale(identifier: "en_US_POSIX")
                      formatter.dateFormat = "dd/MM/yyyy"
                      let date = formatter.string(from: dt)
                    self.fromDateOutlet.setTitle("\(date)", for: .normal)
                  }
              }
        
    }
    
    @IBAction func toDateBtn(_ sender: Any) {
        
        print(self.fromDateOutlet.titleLabel!.text)
        if self.fromDateOutlet.titleLabel!.text == nil {
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please select from date first.")
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let minFromDate = formatter.date(from: self.fromDateOutlet.titleLabel!.text!)
        
        let curr_date = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        DatePickerDialog().show("Select Date".localized, doneButtonTitle: "Done".localized, cancelButtonTitle: "Cancel".localized, minimumDate: minFromDate, maximumDate: curr_date, datePickerMode: .date) {
                  (date) -> Void in
                  if let dt = date {
                   
                      let formatter = DateFormatter()
                   formatter.locale = Locale(identifier: "en_US_POSIX")
                      formatter.dateFormat = "dd/MM/yyyy"
                      let date = formatter.string(from: dt)
                    self.toDateOutlet.setTitle("\(date)", for: .normal)
                    self.tickDate.isHidden = false
                  }
              }
        
    }
}
