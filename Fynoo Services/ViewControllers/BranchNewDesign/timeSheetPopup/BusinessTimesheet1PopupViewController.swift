//
//  timesheet1ViewController.swift
//  Fynoo Business
//
//  Created by Sendan IT on 19/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
import PopupDialog

class BusinessTimesheet1PopupViewController: UIViewController,
addrowssDelegate,deleterowssDelegate {
      var businesstimg:BusinessTimingGet?
     var branch = branchsmodel()
    var displayTYPE:DisplayType?
    var selectedCheck = 0
    var selectedCode = ""
    @IBOutlet weak var hourlbl: UILabel!
    @IBOutlet weak var addlbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var toplevel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
@IBOutlet weak var headerVw: NavigationView!
    var timingId:Int?
    var toolbar = UIToolbar()
    var formatter = DateFormatter()
    var setTime = String()
    var datePicker =  UIDatePicker()
    var bttn:UIButton?
    var tags:Int?
    var btntag:Int?
    var rows : Int?
    var is24Open:Int?
    var isClose:Int?
   var timing =  [Business_timings]()
    var slot =  [SlotArrayList1]()
    var arr:NSMutableArray = NSMutableArray()
   
     var SelectedIndex1:NSMutableArray = NSMutableArray()
    var CurrentHour:Int = 0
    var CurrentMinute:Int = 0
    var EndHour:Int = 24
    var EndMinute:Int = 0
    var updateDate = Date()
@IBOutlet weak var tabview: UITableView!
    var array1:NSMutableDictionary = ["0":[["",""]],"1":[["",""]],"2":[["",""]],"3":[["",""]],
    "4":[["",""]],"5":[["",""]],"6":[["",""]]]
    var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
     var days1 = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    override func viewDidLoad() {
        super.viewDidLoad()
         let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        toplevel.font = UIFont(name:"\(fontNameLight)",size:12)
         addlbl.font = UIFont(name:"\(fontNameLight)",size:16)
         hourlbl.font = UIFont(name:"\(fontNameLight)",size:12)
    self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
//        let name = AddBranch.shared.bName
//        let n1 = "Add your business hours to"
//        let n2 = "Add your business hours to"
//        toplevel.text =  "\(n1) \(name) \(n2)".localized
        let branchname = (AddBranch.shared.bName == "" ? "Branch Name" : AddBranch.shared.bName)
        let businessHours = "Add your business hours to".localized
        let people = "it's easy for people to plan a visit.".localized
        let string = NSMutableAttributedString(string: "\(businessHours) \(branchname) \(people)")
        string.setColor(color: .systemRed, forText: branchname)
        toplevel.attributedText = string
        
        toplevel.textAlignment = .left
        if HeaderHeightSingleton.shared.LanguageSelected == "AR"
        {
            toplevel.textAlignment = .right
        }
         self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        bgImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
       
        self.headerVw.titleHeader.text = "Welcome, Let's Select Your Time".localized;
       self.headerVw.viewControl = self
       tabview.register(UINib(nibName: "TimeDisplayStyleTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeDisplayStyleTableViewCell")
        self.tabview.register(UINib(nibName: "addrowTableViewCell", bundle: nil), forCellReuseIdentifier: "addrowTableViewCell")
        self.tabview.register(UINib(nibName: "deleterowTableViewCell", bundle: nil), forCellReuseIdentifier: "deleterowTableViewCell")
      tabview.register(UINib(nibName: "nextTableViewCell", bundle: nil), forCellReuseIdentifier: "nextTableViewCell")
                tabview.register(UINib(nibName: "CountingTableViewCell", bundle: nil), forCellReuseIdentifier: "CountingTableViewCell")
  

         }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in 0...6
               {
                   if AddBranch.shared.BTimeDict.count > 0
                   {
                       let arrr:Business_timings = AddBranch.shared.BTimeDict[i]
                        if arrr.slotArrayList?.count ?? 0 > 0
                        {
                           SelectedIndex1.add(i)
                       }
                               if arrr.slotArrayList?.count ?? 0 > 0
                               {
                                     var arr1 = [[String]]()
                                   arr1.removeAll()
                            for j in 0...((arrr.slotArrayList?.count ?? 0) - 1)
                                    {
                          let ar:SlotArrayList1 = arrr.slotArrayList![j]
                           let fullName: String = ar.time_slot!
                          let fullNameArr = fullName.components(separatedBy: "-")
                          let firstName: String = fullNameArr[0]
                           let lastName: String = fullNameArr[1]
                             
                               let ar1 = [firstName,lastName]
                              arr1.append(ar1)
                               
                                     
                                   }
                           array1.setValue(arr1, forKey: "\(i)")
                               }
                         
                                   
                                      
                   }
                  
                   tabview.reloadData()
                   
                   
               }
                
               selectedCheck = AddBranch.shared.displayId == 0 ? displayTYPE?.data?.time_display_type?[0].id ?? 0 : AddBranch.shared.displayId
                selectedCode = AddBranch.shared.displaycode == "" ? displayTYPE?.data?.time_display_type?[0].code ?? "" : AddBranch.shared.displaycode
        if selectedCheck != 0
                 {
                     img.image = UIImage(named: "btime_green")
                     
                 }
                 else
                 {
                       img.image = UIImage(named: "btime")
                 }
           
           tabview.separatorStyle = .none
          
           branch.displaytype { (success, response) in
                     ModalClass.stopLoading()
                     if success
                     {
                      self.displayTYPE = response
                       self.selectedCheck = AddBranch.shared.displayId == 0 ? self.displayTYPE?.data?.time_display_type?[0].id ?? 0 : AddBranch.shared.displayId
                        self.selectedCode = AddBranch.shared.displaycode == "" ? self.displayTYPE?.data?.time_display_type?[0].code ?? "" : AddBranch.shared.displaycode
                      self.tabview.reloadData()
                     }
                     
                 }
        
    }
    func deleterow(tag: Int, row: Int) {
          
           var arr1:[[String]]
           arr1 = array1.value(forKey: "\(tag)") as! [[String]]
          for (index,item) in arr1.enumerated()
          {
           if(index == row)
           {
               arr1.remove(at: index)
           }
         
           }
          print(arr1)
           array1.setValue(arr1, forKey: "\(tag)")
    
         tabview.reloadSections(IndexSet(integer: tag + 1), with: .automatic)
       }
       
       func addrow(tag: Int,tag1:Int) {

           var arr1 = [[String]]()
           arr1 = array1.value(forKey: "\(tag)") as! [[String]]
           for (index,item) in arr1.enumerated()
           {
               print(index,item)
         
          if(index == arr1.count-1 )
          {
        
                   if(item[0].count > 1 && item[1].count > 1)
                   {
                       print(item[0])
                   }
                   else
                   {
                    ModalController.showNegativeCustomAlertWith(title: "Please fill the time slot for selected day", msg: "")
                       return
                   }
           
   }
               }
         
           
          arr1 = array1.value(forKey: "\(tag)") as! [[String]]
               let ar = ["",""]
           arr1.append(ar)
           array1.setValue(arr1, forKey: "\(tag)")
        tabview.reloadSections(IndexSet(integer: tag + 1), with: .automatic)
       

       }
       
       @IBAction func back(_ sender: Any) {
          
              self.navigationController?.popViewController(animated: true)
       }
   @objc func saveClick(_ sender :UIButton)
    {
        print("ggkrhnrkm,")
        timing.removeAll()
        for i in 0...6{
            if selectedCode == "ALWAYS_OPEN"
         {
             is24Open = 1
             isClose = 0
              slot = []
         }
        else if selectedCode == "NO_HOURS_AVAILABLE" || selectedCode == "PERMANENTLY_CLOSED"
                {
                    is24Open = 0
                    isClose = 0
                     slot = []
                }
        else
         {
            if SelectedIndex1.count == 0
            {
                ModalController.showNegativeCustomAlertWith(title:"Please select the days and fill the time".localized, msg: "")
                return
               
            }
            if SelectedIndex1.contains(i)
            {
                
             is24Open = 0
             isClose = 0
              let arrr:NSArray = (array1.value(forKey: "\(i)") as! NSArray)
             slot.removeAll()
              for j in 0...arrr.count - 1
               {
                  
                
                       let sl = arrr.object(at: j) as! NSArray
                                  let  slott = "\(sl.object(at: 0))-\(sl.object(at: 1))"
                                  slot.append(SlotArrayList1(time_slot:slott))
                       if  slott == "-"
                       {
                        ModalController.showNegativeCustomAlertWith(title:"Please fill the time slot for selected day".localized, msg: "")
                                     return
                       }
                       if ("\(sl.object(at: 0))" == "" || "\(sl.object(at: 1))" == "" )
                                  {
                        ModalController.showNegativeCustomAlertWith(title:"Please fill the time slot for selected day".localized, msg: "")
                                    
                                      return
                                  }
                }
                       }
                   else
            {
                is24Open = 0
                isClose = 1
                slot = []
            }
                      
                   
             
               }
         
        


         timing.append(Business_timings(dayName: days1[i], is24Open: is24Open, isClose: isClose, slotArrayList: slot))
         
        
         }
        AddBranch.shared.BTimeDict = timing
        AddBranch.shared.SelectedCheck = SelectedIndex1
        AddBranch.shared.displayId = selectedCheck
         AddBranch.shared.displaycode = selectedCode
      self.navigationController?.popViewController(animated: true)
    }
   @objc func cancelClick(_ sender :UIButton)
      {
       self.navigationController?.popViewController(animated: true)
      }
  
  
       
      
}

extension BusinessTimesheet1PopupViewController: UITableViewDelegate,UITableViewDataSource,TimeSheetPOpUpDelegate
{

    func applyToAll(arrr: [[String]]) {
         for i in 0...6
         {
             if SelectedIndex1.contains(i)
             {
                 
             }
             else
             {
                 SelectedIndex1.add(i)
             }
             array1.setValue(arrr, forKey: "\(i)")
         }
         tabview.reloadData()
     }
    @objc func clickedChecked(_ sender:UIButton)
       {
           if SelectedIndex1.contains(sender.tag - 1)
           {
            if  (array1.value(forKey: "\(sender.tag - 1)") as! [[String]]).count > 0
            {
                        
                array1.setValue([["",""]], forKey: "\(sender.tag - 1)")
            }
               SelectedIndex1.remove(sender.tag - 1)
           }
           else
           {
            for i in 0...6
            {
               if  SelectedIndex1.contains(i)
               {
                let arrr:NSArray = (array1.value(forKey: "\(i)") as! NSArray)
                for j in 0...arrr.count - 1
                              {
                                    let sl = arrr.object(at: j) as! NSArray
                                    let  slott = "\(sl.object(at: 0))-\(sl.object(at: 1))"
                                            if  slott == "-"
                                                {

                ModalController.showNegativeCustomAlertWith(title:"please Fill Slot Mandatory Field", msg: "")
                                    return
                                                }
                                if ("\(sl.object(at: 0))" == "" || "\(sl.object(at: 1))" == "" )
                                                            {
                                ModalController.showNegativeCustomAlertWith(title:"please Fill Slot Mandatory Field", msg: "")
                                                                                                   return
                                                 
                                                    }
                }
                }

            }
            if SelectedIndex1.count == 1
            {
                
                 var arr1 = [[String]]()
                let vc = TimeSheetPOpUpViewController(nibName: "TimeSheetPOpUpViewController", bundle: nil)
                   let arrr:NSArray = (array1.value(forKey: "\(SelectedIndex1[0])") as! NSArray)
                         for j in 0...arrr.count - 1
                         {
                             let sl = arrr.object(at: j) as! NSArray
                           let ar1 = ["\(sl.object(at: 0))","\(sl.object(at: 1))"]
                            arr1.append(ar1)
                        }
                         
                         vc.arr = arr1
                          vc.modalPresentationStyle = .overFullScreen
                          vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                          vc.delegate = self
                          self.present(vc, animated: true, completion: nil)
            }
            
            SelectedIndex1.add(sender.tag - 1)
           }
           tabview.reloadSections(IndexSet(integer: sender.tag), with: .none)
       }
    @objc func clickedDisplay(_ sender:UIButton)
          {
            selectedCheck = displayTYPE?.data?.time_display_type?[sender.tag].id ?? 0
            selectedCode = displayTYPE?.data?.time_display_type?[sender.tag].code ?? ""

             if selectedCheck != 0
                         {
                             img.image = UIImage(named: "btype_green")
                             
                         }
                         else
                         {
                               img.image = UIImage(named: "btype")
                         }
              tabview.reloadData()
          }
    func numberOfSections(in tableView: UITableView) -> Int {
           if selectedCode == "OPEN_SELECTED_HOURS"
           {
             return array1.count + 2
          }
        else
           {
           return 2
          }
         
       }
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             let arr1:[[String]]
           if section == 0
           {
                return self.displayTYPE?.data?.time_display_type?.count ?? 0
           }
            else if section == ((selectedCode == "OPEN_SELECTED_HOURS") ? (array1.count + 1) : 1)           {
            return 2
           }
        else
           {
            arr1 = (array1.value(forKey: "\(section - 1)") as! [[String]])
            return arr1.count
        }
        
         
        
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if indexPath.section == 0
           {
                    let cell = tabview.dequeueReusableCell(withIdentifier: "TimeDisplayStyleTableViewCell", for: indexPath) as! TimeDisplayStyleTableViewCell
                     cell.selectionStyle = .none
                     cell.leftLbl.isHidden = false
                     cell.rightLbl.text = self.displayTYPE?.data?.time_display_type?[indexPath.row].value ?? ""
                     if indexPath.row != 0 {
                         cell.leftLbl.isHidden = true
                         
                     }
                     if selectedCode == self.displayTYPE?.data?.time_display_type?[indexPath.row].code ?? ""
                     {
                         cell.btn.isSelected = true
                     }
                     else
                     {
                       cell.btn.isSelected = false
                     }
                     cell.btn.tag = indexPath.row
                      cell.btn.addTarget(self, action: #selector(clickedDisplay(_:)), for: .touchUpInside)
                     return cell

           }
        if  indexPath.section == ((selectedCode == "OPEN_SELECTED_HOURS") ? (array1.count + 1) : 1)
        {
            if indexPath.row == 0
            {
                let cell = tabview.dequeueReusableCell(withIdentifier: "CountingTableViewCell", for: indexPath) as! CountingTableViewCell
                cell.countLblTop.constant = 10
                cell.counlbl.textAlignment = .left
                cell.counlbl.textColor = UIColor.init(red: 56/255, green: 56/255, blue: 56/255, alpha: 1)
                cell.counlbl.numberOfLines = 2
                cell.counlbl.text = " Update Your Business Hours So Search Results Show When Your Location Is Open.".localized
                if HeaderHeightSingleton.shared.LanguageSelected == "AR"
                {
                    cell.counlbl.textAlignment = .right
                    cell.counlbl.text = "قم بتحديث أوقات العمل ليتم إدراج متجرك في قائمة البحث عندما يكون مفتوح";
                }
                        return cell
            }
            else
            {
                let cell = tabview.dequeueReusableCell(withIdentifier: "nextTableViewCell", for: indexPath) as! nextTableViewCell
                              cell.savedraft.addTarget(self, action: #selector(cancelClick(_:)), for: .touchUpInside)
                              cell.nextbtn.addTarget(self, action: #selector(saveClick(_:)), for: .touchUpInside)
                              return cell
            }
        
        }
         else
        {
            if indexPath.row == 0
             {
                  let cell1 = tabview.dequeueReusableCell(withIdentifier: "addrowTableViewCell", for: indexPath) as! addrowTableViewCell
                 var arr1 = [[String]]()
                 arr1 = array1.value(forKey: "\(indexPath.section - 1)") as! [[String]]
                cell1.frombtn.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                cell1.tobtn.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                if SelectedIndex1.contains(indexPath.section - 1)
                {
                    if arr1[indexPath.row][0] == ""
                                   {
                                       cell1.frombtn.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                   }
                                   if arr1[indexPath.row][1] == ""
                                                  {
                                   cell1.tobtn.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor

                                                  }
                }
               
                 cell1.frombtn.setTitle(arr1[indexPath.row][0], for: UIControl.State.normal)
                 cell1.tobtn.setTitle(arr1[indexPath.row][1], for: UIControl.State.normal)
                cell1.days.text = days[indexPath.section - 1].localized
                 cell1.tag  = indexPath.section - 1
                cell1.plusbtntag = indexPath.row
              cell1.checkbtn.tag = indexPath.section
              if SelectedIndex1.contains(indexPath.section - 1)
              {
                  cell1.checkbtn.isSelected = true
              }
              else
              {
                cell1.checkbtn.isSelected = false
              }
              cell1.checkbtn.addTarget(self, action: #selector(clickedChecked(_:)), for: .touchUpInside)
                 cell1.delegate = self
                 return cell1
             }
            else
             {
                 let cell2 = tabview.dequeueReusableCell(withIdentifier: "deleterowTableViewCell", for: indexPath) as! deleterowTableViewCell
                 var arr1 = [[String]]()
                 arr1 = array1.value(forKey: "\(indexPath.section - 1)") as! [[String]]
                cell2.dfrombtn.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                               cell2.dtobtn.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                if SelectedIndex1.contains(indexPath.section - 1)
                {
                               if arr1[indexPath.row][0] == ""
                               {
                                   cell2.dfrombtn.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                               }
                               if arr1[indexPath.row][1] == ""
                                              {
                               cell2.dtobtn.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor

                                              }
                }
                      cell2.dfrombtn.setTitle(arr1[indexPath.row][0], for: UIControl.State.normal)
                     cell2.dtobtn.setTitle(arr1[indexPath.row][1], for: UIControl.State.normal)
                 cell2.tag  = indexPath.section - 1
                  cell2.rows  = indexPath.row
                 cell2.delegate = self
                 return cell2
             }
        }
           
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            if HeaderHeightSingleton.shared.LanguageSelected == "AR"
            {
                return 35
            }
            return 28
        }
       else if indexPath.section == ((selectedCode == "OPEN_SELECTED_HOURS") ? (array1.count + 1) : 1)
        {
            if indexPath.row == 0 {
            return 100
            }else{
                return 50
            }
        }
           return 50
       }
}

//timeslot
extension BusinessTimesheet1PopupViewController
{
    func slot1(tag: Int, btn: UIButton,row:Int) {
          tags = tag
          bttn = btn
          btntag = btn.tag
          rows = row
        if SelectedIndex1.contains(tag)
        {
            
        }
        else
        {
            return
        }
         var arrr = [[String]]()
          arrr = array1.value(forKey: "\(tag)") as! [[String]]
         
         if(btn.tag == 1)
        {
             if(arrr[row][0].count <= 1)
             {
              return
          }
          }
           let arrr1:NSArray = (array1.value(forKey: "\(tag)") as! NSArray)
      
              if(btn.tag == 1)
              {
                      let sl = arrr1.object(at: row) as! NSArray
                      let  slott = "\(sl.object(at: 0))"
                      let fullTime = slott.components(separatedBy: ":")
                     CurrentHour = Int(fullTime[0].trimmingCharacters(in: .whitespacesAndNewlines))!
                    CurrentMinute = Int(fullTime[1].trimmingCharacters(in: .whitespacesAndNewlines))!
                EndHour = 23
                EndMinute = 59
                if arrr1.count  >=  row + 2
                {
                   let s2 = arrr1.object(at: row + 1) as! NSArray
                    if "\(s2.object(at: 0))" != ""
                    {
                        let  slott = "\(s2.object(at: 0))"
                        let fullTime = slott.components(separatedBy: ":")
                    EndHour = Int(fullTime[0].trimmingCharacters(in: .whitespacesAndNewlines))!
                    EndMinute = Int(fullTime[1].trimmingCharacters(in: .whitespacesAndNewlines))!
                    }
                                 
                }
               
              }
              else{
                  if row > 0
                  {
               
                      let sl = arrr1.object(at: row - 1) as! NSArray
                      let  slott = "\(sl.object(at: 1))"
                      let fullTime = slott.components(separatedBy: ":")
                      CurrentHour = Int(fullTime[0].trimmingCharacters(in: .whitespacesAndNewlines))!
                        CurrentMinute = Int(fullTime[1].trimmingCharacters(in: .whitespacesAndNewlines))!
                    EndHour = 23
                    EndMinute = 59
                       let s2 = arrr1.object(at: row) as! NSArray
                      if "\(s2.object(at: 1))" != ""
                      {
                          let  slott = "\(s2.object(at: 1))"
                          let fullTime = slott.components(separatedBy: ":")
                          EndHour = Int(fullTime[0].trimmingCharacters(in: .whitespacesAndNewlines))!
                        EndMinute = Int(fullTime[1].trimmingCharacters(in: .whitespacesAndNewlines))!
                      }
         
                  }
                  else{
                      CurrentHour = 0
                      CurrentMinute = 0
                    EndHour = 23
                    EndMinute = 59
                    let sl = arrr1.object(at: row) as! NSArray
                    if "\(sl.object(at: 1))" != ""
                    {
                        let  slott = "\(sl.object(at: 1))"
                        let fullTime = slott.components(separatedBy: ":")
                       
                        EndHour = Int(fullTime[0].trimmingCharacters(in: .whitespacesAndNewlines))!
                        EndMinute = Int(fullTime[1].trimmingCharacters(in: .whitespacesAndNewlines))!
                    }
                       

                  }
           
          }
         
          tabview.allowsSelection = false
          tabview.isUserInteractionEnabled = false
          datePicker = UIDatePicker.init()
          let date1: NSDate = NSDate()
          let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
          
          let components: NSDateComponents = gregorian.components(([.day]), from: date1 as Date) as NSDateComponents
          components.hour = CurrentHour
          components.minute = CurrentMinute
          let startDate: NSDate = gregorian.date(from: components as DateComponents)! as NSDate
          
          let components1: NSDateComponents = gregorian.components(([.day]), from: date1 as Date) as NSDateComponents
                   components1.hour = EndHour
                   components1.minute = EndMinute
                   let endDate: NSDate = gregorian.date(from: components1 as DateComponents)! as NSDate
          
          datePicker.minimumDate = startDate as Date
        datePicker.maximumDate = endDate as Date
         // datePicker.setDate(startDate as Date, animated: true)
          
          datePicker.autoresizingMask = .flexibleWidth
          datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "en_GB")
          datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.frame = CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.bounds.width, height: 300)
                    
        }
        datePicker.backgroundColor = UIColor.white
          self.view.addSubview(datePicker)
          
          toolbar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
          toolbar.barStyle = .blackTranslucent
          toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
          toolbar.sizeToFit()
          self.view.addSubview(toolbar)
      }
      
      @objc func onDoneButtonClick() {
          tabview.allowsSelection = true
          tabview.isUserInteractionEnabled = true
          toolbar.removeFromSuperview()
          datePicker.removeFromSuperview()
          bttn!.setTitle(setTime, for: .normal)
          let calendar = Calendar.current
          let comp = calendar.dateComponents([.hour, .minute], from: updateDate)
          CurrentHour = comp.hour!
          CurrentMinute = comp.minute!
          var arr1 = [[String]]()
          arr1 = array1.value(forKey: "\(tags!)") as! [[String]]
      
          arr1[rows!][btntag!] = setTime

          array1.setValue(arr1, forKey: "\(tags!)")
         
          tabview.reloadData()
      }
      @objc func dateChanged(_ sender: UIDatePicker?) {
          let dateFormatter = DateFormatter()
          dateFormatter.dateStyle = .none
          dateFormatter.timeStyle = .short
           dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = NSLocale(localeIdentifier: "EN") as Locale
        if let date = sender?.date {
              updateDate = date
            let time = dateFormatter.string(from: date)
            setTime = time
          }
      }
      
}
