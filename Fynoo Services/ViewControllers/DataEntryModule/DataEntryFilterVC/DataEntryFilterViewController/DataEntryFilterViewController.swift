//
//  DataEntryFilterViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 11/02/21.
//  Copyright © 2021 Sendan. All rights reserved.
//

import UIKit
import TTRangeSlider


protocol DataEntryFilterDelegate
{
    func filterApplied(filters : [ChooseFilters])
    
}
class DataEntryFilterViewController: UIViewController, TTRangeSliderDelegate, RadioTypeFilterTableViewCellDelegate {
    
    var delegate : DataEntryFilterDelegate?
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTxtLbl: UILabel!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var leftTblView: UITableView!
    @IBOutlet weak var rightTblView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var applyBtn: UIButton!
   
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
     @IBOutlet weak var clearAllLbl: UILabel!
    @IBOutlet weak var filterByLbl: UILabel!
    
    var fromWhere:String = "1"
    var selectedRow = 0
    var dataEntryFilter : [DataEntry_Filter]?
    var choseFilters = [ChooseFilters]()
    var minRangeVal = ""
    var maxRangeVal = ""
    var fromDateTimeStamp = ""
    var toDateTimeStamp = ""
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        
        print("filterData:-", dataEntryFilter as Any)
        
        setupUI()
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        self.clearAllLbl.isUserInteractionEnabled = true
        self.clearAllLbl.addGestureRecognizer(singleTap)
       
    }
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
       }
        @IBAction func applyBtnClicked(_ sender: Any) {
        
        self.delegate?.filterApplied(filters: choseFilters)
        self.navigationController?.popViewController(animated: true)
       }
    
    @objc func tapDetected(){
        choseFilters.removeAll()
        self.delegate?.filterApplied(filters: choseFilters)
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupUI(){
        
        
        navigationView.viewControl = self
        navigationView.menuBtn.isHidden = false
        leftTblView.delegate = self
        leftTblView.dataSource = self
        rightTblView.dataSource = self
        rightTblView.delegate = self
        rightTblView.separatorStyle = .none
        leftTblView.separatorStyle = .none
        
       self.rightTblView.rowHeight = UITableView.automaticDimension
       self.rightTblView.estimatedRowHeight = 105
       
       self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)

        
        var tab =  ""
        if fromWhere == "1" {
            tab = "waiting"
        }else if fromWhere == "2"{
            tab = "Inprocess"
        }else if fromWhere == "3"{
            tab = "Completed"
        }else if fromWhere == "4"{
            tab = "Rejected"
        }
        
        navigationView.titleHeader.text = "Data Entry".localized
        navigationView.menuBtn.isHidden = true
        self.headerTxtLbl.text = "Data Entry \(tab) list".localized
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        self.closeBtn.titleLabel?.font =  UIFont(name:"\(fontNameLight)",size:16)
        self.applyBtn.titleLabel?.font =  UIFont(name:"\(fontNameLight)",size:16)
        headerTxtLbl.font  = UIFont(name:"\(fontNameLight)",size:12)
        clearAllLbl.font  = UIFont(name:"\(fontNameLight)",size:12)
        filterByLbl.font  = UIFont(name:"\(fontNameLight)",size:12)
        
        leftTblView.register(UINib(nibName: "SelectCategoryCell", bundle: nil), forCellReuseIdentifier: "SelectCategoryCell")
        rightTblView.register(UINib(nibName: "ListingTableViewCell", bundle: nil), forCellReuseIdentifier: "ListingTableViewCell")
        rightTblView.register(UINib(nibName: "RadioTypeFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "RadioTypeFilterTableViewCell")
        rightTblView.register(UINib(nibName: "DateRangeFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "DateRangeFilterTableViewCell")
        rightTblView.register(UINib(nibName: "RangeFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "RangeFilterTableViewCell")
        rightTblView.register(UINib(nibName: "DiscountFilterRadioTableViewCell", bundle: nil), forCellReuseIdentifier: "DiscountFilterRadioTableViewCell")
        rightTblView.register(UINib(nibName: "spacingTableViewCell", bundle: nil), forCellReuseIdentifier: "spacingTableViewCell")
        
        if choseFilters.count == 0
        {
            for item in dataEntryFilter!
            {
                choseFilters.append(ChooseFilters(code : item.filter_code!, range : "", type : item.view_type!))
            }
        }
 
}
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        minRangeVal = String(selectedMinimum)
        maxRangeVal = String(selectedMaximum)
        
        
        choseFilters[selectedRow].range = "\((minRangeVal as NSString).integerValue)-\((maxRangeVal as NSString).integerValue)"
        
        print("minRangeVal", minRangeVal)
        print("maxRangeVal", maxRangeVal)
        
    }
    
    func yesClicked(tag: Int,btn:UIButton) {
        
    }
    func noClicked(tag: Int,btn:UIButton) {
        
    }
     

    
}
extension DataEntryFilterViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == leftTblView {
            return 50
        }
            
        else  {
            
            return UITableView.automaticDimension
            
        }
        
    }

}
extension DataEntryFilterViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == leftTblView {
            return dataEntryFilter?.count ?? 0
        }
        else {
            if dataEntryFilter?.count ?? 0 > 0 {
                let branch = dataEntryFilter?[selectedRow]
                if branch?.view_type == "MULTICHECKBOX"
                {
                    return branch?.checkbox_item?.count ?? 0
                }
                
                return 1
            }
            else {
                return 0
            }
            //            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTblView {
            selectedRow = indexPath.row
            minRangeVal = ""
            maxRangeVal = ""
            leftTblView.reloadData()
            rightTblView.reloadData()
            
        }
        else {
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTblView {
            let cell = leftTblView.dequeueReusableCell(withIdentifier: "SelectCategoryCell", for: indexPath) as! SelectCategoryCell
            cell.contentView.backgroundColor = .gray
            cell.imgWidth.constant = 0
            cell.tickIcon.isHidden = true
            
            cell.catTitle.text = dataEntryFilter?[indexPath.row].filter_name
            
            
            if selectedRow == indexPath.row {
                cell.selectedImg.isHidden = false
                cell.catTitle.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
                cell.tickIcon.isHidden = false
                
            }else{
                cell.catTitle.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
                cell.selectedImg.isHidden = true
                cell.tickIcon.isHidden = true
            }
            return cell
            
        }else{
            
            let list = dataEntryFilter?[selectedRow]
            
            if list?.view_type == "RANGE"{
                
                let cell = rightTblView.dequeueReusableCell(withIdentifier: "RangeFilterTableViewCell", for: indexPath) as! RangeFilterTableViewCell
                cell.selectionStyle = .none
                
                
                if list?.range_list?.count ?? 0 > 0 {
                    
                    if (list?.filter_code) == "PRICE_RANGE" {
                        
                        cell.like.isHidden = true
                        cell.lbl.text = "\("Enter") \(list?.filter_name ?? "") \("range")"
                        
                    }else if list?.filter_code == "DES_RATING" {
                        cell.like.isHidden = false
                        cell.img.image = UIImage(named:"star-full_new")
                        cell.lbl.text = "Enter Ratings Range"
                        
                    }
                    
                    let fullName = list?.range_list ?? ""
                    let fullNameArr = fullName.components(separatedBy: "-")
                    
                    cell.rangeSlider.hideLabels = true
                    let filter  = choseFilters[selectedRow]
                    var  minVal = ""
                    var  maxVal = ""
                    
                    if let arr = filter.range.components(separatedBy: "-") as? [String] {
                        
                        if arr.count > 1 {
                            minVal = arr[0]
                            maxVal = arr[1]
                        }
                    }
                    
                    cell.rangeSlider.minValue = Float(fullNameArr[0])!
                    cell.rangeSlider.maxValue = Float(fullNameArr[1])!
                    
                    cell.rangeSlider.selectedMinimum = Float(fullNameArr[0])!
                    cell.rangeSlider.selectedMaximum =  Float(fullNameArr[1])!
                    
                    
                    if minVal == "" {
                        cell.fromprice.text =  "\(fullNameArr[0]) SAR"
                        
                    }else{
                        cell.fromprice.text =  "\(minVal) SAR"
                        cell.rangeSlider.selectedMinimum = Float(minVal)!
                        
                    }
                    
                    if maxVal == "" {
                        cell.toprice.text =  "\(fullNameArr[1]) SAR"
                    }else{
                        cell.toprice.text =  "\(maxVal) SAR"
                        
                        cell.rangeSlider.selectedMaximum = Float(maxVal)!
                    }
                }
                
                cell.rangeSlider.delegate = self
                cell.rangeSlider.tag = indexPath.row
                return cell
                
            }else if list?.view_type == "DATE_RANGE" {
                
                let cell = rightTblView.dequeueReusableCell(withIdentifier: "DateRangeFilterTableViewCell", for: indexPath) as! DateRangeFilterTableViewCell
                cell.selectionStyle = .none
                cell.delegate = self
                cell.headerLbl.text = "\("Enter Date")"
                if list?.range_list?.count ?? 0 > 0  {
                    let fullName = list?.range_list ?? ""
                    let fullNameArr = fullName.components(separatedBy: "-")
                    cell.minTimeStamp = Double(fullNameArr[0])!
                    cell.maxTimeStamp = Double(fullNameArr[1])!
                    
                    cell.strtDateLbl.text = ModalController.convertTimeStampIntoDate(timeStamp: fullNameArr[0], format: "dd/MM/YYYY")
                    cell.toDateLbl.text = ModalController.convertTimeStampIntoDate(timeStamp: fullNameArr[1], format: "dd/MM/YYYY")
                    
                    
                }
                cell.delegate = self
                cell.tag = indexPath.row
                return cell
            }else if list?.view_type == "MULTICHECKBOX" {
                let cell = rightTblView.dequeueReusableCell(withIdentifier: "ListingTableViewCell", for: indexPath) as! ListingTableViewCell
                
                cell.nameLbl.text = ModalController.toString(list?.checkbox_item?[indexPath.row].name as Any)
                
                
                return cell
            }else if list?.view_type == "RADIO" {
                let cell = rightTblView.dequeueReusableCell(withIdentifier: "RadioTypeFilterTableViewCell", for: indexPath) as! RadioTypeFilterTableViewCell
                
                
                
                cell.delegate = self
                return cell
            }else{
                let cell = rightTblView.dequeueReusableCell(withIdentifier: "spacingTableViewCell", for: indexPath) as! spacingTableViewCell
                cell.selectionStyle = .none
                
                return cell
                
            }
        }
    }
}
extension DataEntryFilterViewController: DateRangeFilterTableViewCellDelegate {
    
        func startDateTimeStamp(_ sender: Any, strtDtTimeStamp: String) {
           fromDateTimeStamp = strtDtTimeStamp
        
            if toDateTimeStamp == "" {
                let list = dataEntryFilter?[selectedRow]
                var maxTimeStamp = 0.0
                if list?.range_list?.count ?? 0 > 0  {
                    let fullName = list?.range_list ?? ""
                    let fullNameArr = fullName.components(separatedBy: "-")
                    maxTimeStamp = Double(fullNameArr[1])!
                }
                
                choseFilters[selectedRow].range = fromDateTimeStamp + "-" + ModalController.toString(maxTimeStamp as Any)
                
            }else{
            choseFilters[selectedRow].range = fromDateTimeStamp + "-" + toDateTimeStamp
            }
       }
       
    func endDateTimeStamp( _ sender: Any, endDtTimeStamp: String) {
        toDateTimeStamp = endDtTimeStamp
        
        if fromDateTimeStamp == "" {
            let list = dataEntryFilter?[selectedRow]
            var minTimeStamp = 0.0
            if list?.range_list?.count ?? 0 > 0  {
                let fullName = list?.range_list ?? ""
                let fullNameArr = fullName.components(separatedBy: "-")
                minTimeStamp = Double(fullNameArr[0])!
            }
            
            choseFilters[selectedRow].range = ModalController.toString(minTimeStamp as Any) + "-" + toDateTimeStamp
        }else{
            choseFilters[selectedRow].range = fromDateTimeStamp + "-" + toDateTimeStamp
        }
        
    }
}
