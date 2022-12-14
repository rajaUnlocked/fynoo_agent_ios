//
//  DeliveryDocumentViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 23/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import MTPopup
import PDFKit
import MobileCoreServices
class DeliveryDocumentViewController: UIViewController,BottomPopupEditProductViewControllerDelegate,OpenGalleryDelegate,UIDocumentPickerDelegate,UITextFieldDelegate,CommonPopupViewControllerDelegate,UITextViewDelegate {
    var fdate = Date()
    var reasonforvehicle = ""
    var tag1 = 0
    var primaryid = 0
    var isReasonForVehicle = false
    var upload:ServiceUpload?
    var topArr = ["Full Name","Date of Birth","National ID / Iqama ID","Expiry Date"]
    var headertitlearr = ["Upload National Id / Iqama","Upload Driving License Front","Upload Vehicle Registration","Upload Vehicle Insurance","Upload Driving Authorization(Not Required for the Owner)".localized,"Upload Vehicle Description"]
    var toptxtArr = ["","","",""]
    var txtArr = ["","","","","","","",""]
    
    @IBOutlet weak var submit: UIButton!
    var txtIdArr = [0,0,0,0,0,0,0,0]
    var imgArr = [String]()
    var imgIdUploadedArr = [Bool]()
    var imgIdArr = [Bool]()
    var imglocalArr = [UIImage?]()
    var documentlocalArr = [URL?]()
    var descriparr = [String]()
    var registrationtypeArr = [String]()
    var vehiclebrandArr = [String]()
    var vehiclenameArr = [String]()
    var vehiclenameidArr = [Int]()
    var vehiclekindArr = [String]()
    var vehiclekindidArr = [Int]()
    var vehiclekindimageArr = [String]()
    var vehicleColorArr = [String]()
    var registrationtypeidArr = [Int]()
    var vehiclebrandidArr = [Int]()
    var vehicleColoridArr = [Int]()
    var vehicledescriparr = ["Registration Type","Vehicle Brand","Vehicle Name","Production Year","Vehicle Color","Vehicle kind","Maximum Load (Kgs)","Plate Number"]
    var service = ServiceModel()
    var headerarr = ["National Id / Iqama","Driving License Front","Vehicle Registration","Vehicle Insurance","Driving Authorization","Vehicle Description","Reason For Vehicle Change"]
    var vehiclenamelist:VehicleName?
    var servicelist:SeviceDocument?
    var typecolorlist:TypeBrandColor?
    var vehiclekind:VehicleKind?
    @IBOutlet weak var tabvw: UITableView!
    @IBOutlet weak var headervw: NavigationView!
    var SelectedIndex = NSMutableArray()
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        headervw.viewControl = self
        headervw.titleHeader.text = "Delivery Services".localized
        tabvw.delegate = self
        tabvw.dataSource = self
        registernibs()
        //self.tabvw.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        imglocalArr = [nil,nil,nil,nil,nil,nil,nil]
        documentlocalArr = [nil,nil,nil,nil,nil,nil]
        imgIdArr = [false,false,false,false,false,false,false]
        imgIdUploadedArr = [false,false,false,false,false,false,false]
        servicetypeColor_API()
        
    }
   
    func fileSize(forURL url: Any) -> Double {
        var fileURL: URL?
        var fileSize: Double = 0.0
        if (url is URL) || (url is String)
        {
            if (url is URL) {
                fileURL = url as? URL
            }
            else {
                fileURL = URL(fileURLWithPath: url as! String)
            }
            var fileSizeValue = 0.0
            try? fileSizeValue = (fileURL?.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).allValues.first?.value as! Double?)!
            if fileSizeValue > 0.0 {
                fileSize = (Double(fileSizeValue) / (1024 * 1024))
            }
        }
        return fileSize
    }
    func NationalselectDOB(tag:Int){
        
        if tag == 1
               {
          self.toptxtArr[3] = ""
        }
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
                          components.year = -18
                          components.month = 0
        var maxDate : Date?
        maxDate = calendar.date(byAdding: components, to: currentDate)!
        var minDate = Date()
        
        minDate = Calendar.current.date(from: DateComponents(year: 1900 , month: 1, day: 1))!
        var title = "Select - Date of Birth".localized
        if tag == 3
        {
            if self.toptxtArr[1] == ""
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Select DOB First ", msg: "")
                return
            }
            title = "Select - Date of Expiry".localized
            components.year = 0
            components.month = 0
            components.day = self.servicelist?.data?.document_expiry_day ?? 0
            minDate =  calendar.date(byAdding: components, to: currentDate)!
            maxDate = nil
        }
        print(minDate as Any)
       
       
        DatePickerDialog().show("\(title)".localized, doneButtonTitle: "Done".localized, cancelButtonTitle: "Cancel".localized,  minimumDate: minDate, maximumDate: maxDate,  datePickerMode: .date){
            (date) -> Void in
            if let dt = date {
               
                if tag == 1
                {
                    self.fdate = dt
                }
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "MMM dd, yyyy"
                print(formatter.string(from: dt))
                self.toptxtArr[tag] = formatter.string(from: dt)
                self.tabvw.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .none)
            }
        }
    }
    
    
    func vehicleKind_API(brandid:Int)
    {
        txtArr[5] = ""
        ModalClass.startLoading(self.view)
        service.vehicleId = 10
        service.restrationid = brandid
        service.getvehicleKind { (success, response) in
            ModalClass.stopLoading()
            if success
            {
                self.vehiclekind = response
                self.vehiclekindArr.removeAll()
                self.vehiclekindidArr.removeAll()
                self.vehiclekindimageArr.removeAll()
                self.vehiclenameArr.removeAll()
                self.vehiclenameidArr.removeAll()
                for i in 0...(self.vehiclekind?.data?.vehicle_kind?.count ?? 0) - 1
                {
                    self.vehiclekindArr.append(self.vehiclekind?.data?.vehicle_kind?[i].name ?? "")
                    self.vehiclekindidArr.append(self.vehiclekind?.data?.vehicle_kind?[i].id ?? 0)
                    self.vehiclekindimageArr.append(self.vehiclekind?.data?.vehicle_kind?[i].image ?? "")
                }
                self.tabvw.reloadData()
            }
        }
    }
    func vehicleName_API(brandid:Int)
    {
        txtArr[2] = ""
        ModalClass.startLoading(self.view)
        service.vehicleId = brandid
        service.getvehicleName { (success, response) in
            ModalClass.stopLoadingAllLoaders(self.view)
            if success
            {
                self.vehiclenamelist = response
                self.vehiclenameArr.removeAll()
                self.vehiclenameidArr.removeAll()
                for i in 0...(self.vehiclenamelist?.data?.vehicle_kind?.count ?? 0) - 1
                {
                    self.vehiclenameArr.append(self.vehiclenamelist?.data?.vehicle_kind?[i].name ?? "")
                    self.vehiclenameidArr.append(self.vehiclenamelist?.data?.vehicle_kind?[i].id ?? 0)
                }
                self.tabvw.reloadData()
            }
        }
    }
    func servicetypeColor_API()
    {
         ModalClass.startLoading(self.view)
        service.getservicetypecolor { (success, response) in
            ModalClass.stopLoadingAllLoaders(self.view)
            if success
            {
                self.typecolorlist = response
                for i in 0...(self.typecolorlist?.data?.registration_type?.count ?? 0) - 1
                {
                    self.registrationtypeArr.append(self.typecolorlist?.data?.registration_type?[i].name ?? "")
                    self.registrationtypeidArr.append(self.typecolorlist?.data?.registration_type?[i].id ?? 0)
                }
                for i in 0...(self.typecolorlist?.data?.brand?.count ?? 0) - 1
                {
                    self.vehiclebrandArr.append(self.typecolorlist?.data?.brand?[i].name ?? "")
                    self.vehiclebrandidArr.append(self.typecolorlist?.data?.brand?[i].id ?? 0)
                }
                for i in 0...(self.typecolorlist?.data?.vehicle_color?.count ?? 0) - 1
                {
                    self.vehicleColorArr.append(self.typecolorlist?.data?.vehicle_color?[i].name ?? "")
                    self.vehicleColoridArr.append(self.typecolorlist?.data?.vehicle_color?[i].id ?? 0)
                }
                self.servicedocList_API()
            }
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
     
        if servicelist?.data?.status ?? 0 == 1
               {
                   ModalController.showNegativeCustomAlertWith(title: " You cannot edit the form when it is pending for approval", msg: "")
            
                                  return false
               }
        let touchPoint = textView.convert(CGPoint.zero, to: tabvw)
        let clickedBtn = tabvw.indexPathForRow(at: touchPoint)
        let row = Int(clickedBtn!.row)
        let section = Int(clickedBtn!.section)
        var textstr = ""
        if let text1 = textView.text as NSString? {
            let txtAfterUpdate = text1.replacingCharacters(in: range, with: text)
            textstr = txtAfterUpdate
        }
        textView.textAlignment =  ("\(textstr.first)".isArabic ? .right:.left)
        let cell = tabvw.cellForRow(at: IndexPath(row: row, section: section)) as! ReasonForChangeTableViewCell
        
        
        if textstr.count > 0{
            
            cell.txtvw.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
        }else{
            cell.txtvw.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
        }
        reasonforvehicle = textstr
        service.reasonchange = reasonforvehicle
        tabvw.reloadRows(at: [IndexPath(row: 0, section: section)], with: .none)
        return true
    }
    
    func yesBtnClicked(name: String, id: Int) {
        if name == "-100"
        {
            imglocalArr[id] = nil
            documentlocalArr[id] = nil
            imgIdUploadedArr[id] = false
            let param = ["type":id+1,"primary_id":service.primaryid,"lang_code":HeaderHeightSingleton.shared.LanguageSelected] as [String : Any]
            print(param)
            ModalClass.startLoading(self.view)
            ServerCalls.postRequest("\(Constant.BASE_URL)agentapi/v1/delete_vehicle_service_document/", withParameters: param) { response, suceess, resp in
                ModalClass.stopLoading()
                if suceess
                {
                    self.imgIdArr[id] = false
                    
                    let imageUrl = URL(string: ((response as! NSDictionary).object(forKey: "data") as! NSDictionary).object(forKey: "placeholder") as! String)!
        
                    do {
                        let imageData = try Data(contentsOf: imageUrl)
                        self.imglocalArr[id] = UIImage(data: imageData)
                        self.tabvw.reloadData()
                    }
                    catch{
                        self.imglocalArr[id] = nil
                    }
                  
                }
            }
            return

        }
          submit.tag = 8
         clickuploadclicked(submit)
       }
       
       func yesBtnForActivate(name: String, id: Int, forActivate: Bool) {
              print("noooo")
       }
    @IBAction func sendforApproval(_ sender: Any)
       {
        if servicelist?.data?.status ?? 0 == 1
               {
                   ModalController.showNegativeCustomAlertWith(title: " You cannot edit the form when it is pending for approval", msg: "")
            
                                  return
               }
        if self.servicelist?.data?.show_iqama_section ?? false
        {
        if !imgIdArr[0]
        {
           ModalController.showNegativeCustomAlertWith(title: "Please click 'Upload and Save' on National ID/Iqama ID section", msg: "")
            return
        }
        }
        if !imgIdArr[1]
        {
           ModalController.showNegativeCustomAlertWith(title: "Please click 'Upload and Save' on Driving License Front section", msg: "")
             return
        }
        if !imgIdArr[2]
        {
           ModalController.showNegativeCustomAlertWith(title: "Please click 'Upload and Save' on Vehicle Registration section", msg: "")
             return
        }
        if !imgIdArr[3]
        {
           ModalController.showNegativeCustomAlertWith(title: "Please click 'Upload and Save' on Vehicle Insurance section", msg: "")
             return
        }
        if !imgIdArr[5]
        {
           ModalController.showNegativeCustomAlertWith(title: "Please click 'Upload and Save' on Vehicle Description section", msg: "")
             return
        }
            
//        else if self.servicelist?.data?.reason_for_change ?? "" == ""
//        {
//            if self.servicelist?.data?.new_upload_enable ?? false
//            {
//                ModalController.showNegativeCustomAlertWith(title: "Please filled Vehicle Description", msg: "")
//                           return
//            }
//
//        }
        
          if self.servicelist?.data?.switch_vehicle ?? false{
                let vc = CommonPopupViewController(nibName: "CommonPopupViewController", bundle: nil)
                        vc.modalPresentationStyle = .overFullScreen
                        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                        vc.delegate =  self
                        vc.isDoc = true
            //            vc.name = name
            //            vc.serviceID = id
            //            vc.imgURL = "\((self.servicesArray.object(at: index) as! NSDictionary).object(forKey: "service_icon") as! String)"
                        vc.setUI()
                        self.present(vc, animated: true, completion: nil)
              }
          else{
                 submit.tag = 8
                   clickuploadclicked(submit)
        }
        }
       
    func servicedocList_API()
    {
        ModalClass.startLoading(self.view)
        service.primaryid = primaryid
        service.getservicedocument { (success, response) in
            
            if success
            {
                self.servicelist = response
                ModalClass.stopLoadingAllLoaders(self.view)
                if self.servicelist?.data?.front_side ?? "" != ""{
                    self.vehicleKind_API(brandid: (self.servicelist?.data?.registration_type_id)!)
                    self.vehicleName_API(brandid: (self.servicelist?.data?.vehicle_brand_id)!)

                }
                self.reasonforvehicle = self.servicelist?.data?.reason_for_change ?? ""
                self.imgArr = [self.servicelist?.data?.national_id ?? "",self.servicelist?.data?.driving_license ?? "",self.servicelist?.data?.registration ?? "",self.servicelist?.data?.insurance ?? "",self.servicelist?.data?.authorization ?? "",self.servicelist?.data?.front_side ?? ""]
                for i in 0...self.imgArr.count - 1
                {
                    if self.imgArr[i] != ""
                    {
                        let imageUrl = URL(string: self.imgArr[i])!
            
                        do {
                            let imageData = try Data(contentsOf: imageUrl)
                            self.imglocalArr[i] = UIImage(data: imageData)
                            if self.imglocalArr[i] == nil{
                                self.documentlocalArr[i] = imageUrl
                            }
                        }
                        catch{
                            self.imglocalArr[i] = nil
                        }

                       
                    }
                    else
                    {
                        self.imglocalArr[i] = nil
                    }
                }
               
                
                self.imgIdArr = [self.servicelist?.data?.national_id_uploaded ?? false,self.servicelist?.data?.driving_license_uploaded ?? false,self.servicelist?.data?.registration_uploaded ?? false,self.servicelist?.data?.insurance_uploaded ?? false,self.servicelist?.data?.authorization_uploaded ?? false,self.servicelist?.data?.front_side ?? "" == "" ? false : true,false]
                self.descriparr = [self.servicelist?.data?.national_id_content ?? "", "",self.servicelist?.data?.registration_content ?? "", "",self.servicelist?.data?.authorization_content ?? ""]
                self.toptxtArr = [self.servicelist?.data?.full_name ?? "",self.servicelist?.data?.dob ?? "",self.servicelist?.data?.iqama_no ?? "",self.servicelist?.data?.doe ?? ""]
                self.txtArr = [self.servicelist?.data?.registration_type ?? "",self.servicelist?.data?.vehicle_brand ?? "",self.servicelist?.data?.vehicle_name ?? "",self.servicelist?.data?.production_year ?? "",self.servicelist?.data?.vehicle_color ?? "",self.servicelist?.data?.vehicle_kind ?? "",self.servicelist?.data?.maximum_load ?? "",self.servicelist?.data?.plate_no ?? ""]
                self.txtIdArr = [self.servicelist?.data?.registration_type_id ?? 0,self.servicelist?.data?.vehicle_brand_id ?? 0 ,self.servicelist?.data?.vehicle_name_id ?? 0,0,self.servicelist?.data?.vehicle_color_id ?? 0,self.servicelist?.data?.vehicle_kind_id ?? 0,0,0]
                self.submit.setTitle("Submit for approval".localized, for: .normal)
                self.submit.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                if self.servicelist?.data?.status ?? 0 == 1
                {
                    self.submit.backgroundColor = .lightGray
                    self.submit.setTitle("Pending for approval".localized, for: .normal)
                }
              
              
                self.tabvw.reloadData()
               
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        if servicelist?.data?.status ?? 0 == 1
               {
                   ModalController.showNegativeCustomAlertWith(title: " You cannot edit the form when it is pending for approval", msg: "")
            
                                  return false
               }
        let touchPoint = textField.convert(CGPoint.zero, to: tabvw)
        let clickedBtn = tabvw.indexPathForRow(at: touchPoint)
        let row = Int(clickedBtn!.row)
        let section = Int(clickedBtn!.section)
        var textstr = ""
        if let text1 = textField.text as NSString? {
            let txtAfterUpdate = text1.replacingCharacters(in: range, with: string)
            textstr = txtAfterUpdate
        }
        textField.textAlignment =  ("\(textstr.first)".isArabic ? .right:.left)
        let cell = tabvw.cellForRow(at: IndexPath(row: row, section: section)) as! VehicleDescriptionTableViewCell
        if section == 1
        {
            if row == 1
            {
                if !ModalController.isValidName(title: textstr)
                {
                    return false
                }
               
               if !textstr.containArabicNumber
               {
                   return false
               }
               if textstr.count > 0
               {
                   
                   cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
               }
               
               else
               {
                   cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
               }
           }
            else if row == 3
           {

            if textstr.count > self.servicelist?.data?.iqama_length ?? 0
            {
                return false
            }
            if !textstr.containArabicNumber
            {
                return false
            }
            if textstr.count > 0
                       {
                           if !textstr.containArabicNumber
                           {
                               cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                           }
                           else
                           {
                             if textstr.count == self.servicelist?.data?.iqama_length ?? 0
                             {
                             cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                            }
                             else{
                             cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                            }
                              
                           }
                       }
                       else
                       {
                           
                           cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                       }
            }
             toptxtArr[row - 1] = textstr
        }
        else{
            if row == 4
            {
                
                if textField.text!.count == 0{
                            if string == " " || string == "0"
                            {
                            return false
                            }
                        }
                if textstr.count > 0
                {
                    
                    if textstr.count > 4
                    {
                        return false
                    }
                    if !textstr.containArabicNumber
                    {
                        cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                    }
                    else
                    {
                        if textstr.count == 4
                        {
                            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                        }
                        else{
                            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                        }
                    }
                    
                }
                    
                else
                {
                    
                    cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                }
                txtArr[row - 1] = textstr
                
            }
            if  row == 7
            {
                if textField.text!.count == 0
                {
                            if string == " " || string == "0"
                            {
                            return false
                            }
                }
                if textstr.count > 0
                {
                    
                    if textstr.count > self.servicelist?.data?.maximum_load_allowed ?? 0
                    {
                        return false
                    }
                    if !textstr.containArabicNumber
                    {
                        cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                    }
                    else
                    {
                        
                            
                            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                        
//                        if textstr.count == self.servicelist?.data?.maximum_load_allowed ?? 0
//                        {
//                            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
//                        }
//                        else{
//                            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
//                        }
                    }
                    
                }
                    
                else
                {
                    
                    cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                }
                txtArr[row - 1] = "\(textstr)"
                
            }
            if row == 8
            {
                if textstr.count > 0
                {
                    if !ModalController.isValidPlatenumber(title: textstr)
                    {
                        return false
                    }
                    if textstr.count > self.servicelist?.data?.plate_no_max_length ?? 0
                    {
                        return false
                    }
                    if textField.text == "00000"
                    {
                        textField.text = ""
                        cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                        ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter valid plate number".localized)
                        return false
                    }
                    if !textstr.containArabicNumber
                    {
                        cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                    }
                    else
                    {
                        if textstr.count <= self.servicelist?.data?.plate_no_max_length ?? 0 && textstr.count >= self.servicelist?.data?.plate_no_min_length ?? 0
                        {
                            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                        }
                        else{
                            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                        }
                    }
                    
                }
                    
                else
                {
                    
                    cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                }
                txtArr[row - 1] = "\(textstr.uppercased())"
              
            }
        }
        return true
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField){
        
        let touchPoint = textField.convert(CGPoint.zero, to: tabvw)
        let clickedBtn = tabvw.indexPathForRow(at: touchPoint)
        let row = Int(clickedBtn!.row)
        let section = Int(clickedBtn!.section)
        let cell = tabvw.cellForRow(at: IndexPath(row: row, section: section)) as! VehicleDescriptionTableViewCell
        if row == 8
        {
            if textField.text == "000000"
            {
                textField.text = ""
                cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter valid plate number".localized)
                return
            }
        }
    }
//    if textField.text == "000 000 000 000 000"{
//        textField.text = ""
//        ModalController.showNegativeCustomAlertWith(title: "", msg: "Please enter valid vat number".localized)
//        return
//    }
//    func textFieldDidEndEditing(_ textField: UITextField)
//    {
//        let touchPoint = textField.convert(CGPoint.zero, to: tabvw)
//        let clickedBtn = tabvw.indexPathForRow(at: touchPoint)
//        let row = Int(clickedBtn!.row)
//        let section = Int(clickedBtn!.section)
//        let cell = tabvw.cellForRow(at: IndexPath(row: row, section: section)) as! VehicleDescriptionTableViewCell
//        if row == 8
//        {
//            if textField.text == "00000000" || textField.text == "0000000" || textField.text == "000000"
//            {
//                textField.text = ""
//                cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
//                return
//            }
//        }
//    }
    func registernibs() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        submit.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:16)
        tabvw.register(UINib(nibName: "ServiceHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ServiceHeaderTableViewCell")
        tabvw.register(UINib(nibName: "DocHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "DocHeaderTableViewCell")
        tabvw.register(UINib(nibName: "ServiceDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ServiceDetailTableViewCell")
        tabvw.register(UINib(nibName: "VehicleDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "VehicleDescriptionTableViewCell")
        tabvw.register(UINib(nibName: "UploadVehicleImageTableViewCell", bundle: nil), forCellReuseIdentifier: "UploadVehicleImageTableViewCell")
        tabvw.register(UINib(nibName: "ReasonForChangeTableViewCell", bundle: nil), forCellReuseIdentifier: "ReasonForChangeTableViewCell")
        tabvw.register(UINib(nibName: "BottomLblTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomLblTableViewCell")
        
    }
    func gallery(img: UIImage, imgtype: String) {
        
        imglocalArr[tag1] = img
        imgIdUploadedArr[tag1] = true
        tabvw.reloadData()
    }
    func information(Value: String) {
        print("")
    }
    
    func actionPerform(tag: Int, index: Int) {
        tag1 = index
        if tag == 0
        {
            
            OpenGallery.shared.viewControl = self
            OpenGallery.shared.openGallery()
            OpenGallery.shared.delegate = self
            
        }
        else
        {
            
            let importMenu = UIDocumentPickerViewController(documentTypes: ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String], in: UIDocumentPickerMode.import)
            
            if #available(iOS 11.0, *) {
                importMenu.allowsMultipleSelection = true
            }
            
            importMenu.delegate = self
            importMenu.modalPresentationStyle = .formSheet
            
            present(importMenu, animated: true)
        }
        
    }
    
    func filterIdval(tag: Int, Value: String, id: Int) {
        txtArr[tag] = Value
        txtIdArr[tag] = id
        if tag == 0
        {
            vehicleKind_API(brandid: id)
        }
        if tag == 1
        {
            vehicleName_API(brandid: id)
        }
        tabvw.reloadData()
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let siz = fileSize(forURL:  urls.first!)
        
        print(".......\(siz)")
        if siz > 2
        {
            ModalController.showNegativeCustomAlertWith(title: "Image Size is large", msg: "")
            return
        }
        documentlocalArr[tag1] = urls.first
        imglocalArr[tag1] = nil
        imgIdUploadedArr[tag1] = true
        tabvw.reloadData()
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    @objc func clickcrossed(_ sender:UIButton)
    {
        if servicelist?.data?.status ?? 0 == 1
               {
                   ModalController.showNegativeCustomAlertWith(title: " You cannot edit the form when it is pending for approval", msg: "")
                                  return
               }
        let vc = CommonPopupViewController(nibName: "CommonPopupViewController", bundle: nil)
                vc.modalPresentationStyle = .overFullScreen
                vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                vc.delegate =  self
                vc.isRemove = true
        vc.serviceID = sender.tag
                vc.setUI()
                self.present(vc, animated: true, completion: nil)
        
    }
    @objc func clickremoveimage(_ sender:UIButton)
       {
        if servicelist?.data?.status ?? 0 == 1
               {
                   ModalController.showNegativeCustomAlertWith(title: " You cannot edit the form when it is pending for approval", msg: "")
                                  return
               }
        imglocalArr[sender.tag] = nil
               // imgArr[sender.tag] = ""
        imgIdUploadedArr[tag1] = false
                tabvw.reloadData()

     
       
    }
    @objc func clickedaddnewcar()
    {
            let vc = DeliveryDocumentViewController(nibName: "DeliveryDocumentViewController", bundle: nil)
            vc.primaryid = self.servicelist?.data?.new_upload_id ?? 0
        vc.isReasonForVehicle = true
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func clickuploadclicked(_ sender:UIButton)
    {
        service.docfilereg.removeAll()
        service.imagefile.removeAll()
        if servicelist?.data?.status ?? 0 == 1
        {
            ModalController.showNegativeCustomAlertWith(title: " You cannot edit the form when it is pending for approval", msg: "")
            return
        }
        if sender.tag == 0
        {
            if toptxtArr[0] == ""
            {
                ModalController.showNegativeCustomAlertWith(title: "Please enter full name", msg: "")
                return
            }
            if toptxtArr[1] == ""
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Select DOB", msg: "")
                return
            }
            if toptxtArr[2] == ""
            {
                
                ModalController.showNegativeCustomAlertWith(title: "Please Enter National ID", msg: "")
                return
            }
            if toptxtArr[2].count > 0
            {
                if toptxtArr[2].count != (self.servicelist?.data?.iqama_length ?? 0)
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please Check National ID", msg: "")
                    return
                }
            }
            if toptxtArr[3] == ""{
                ModalController.showNegativeCustomAlertWith(title: "Please select date of expiry", msg: "")
                return
            }
            
            service.username = toptxtArr[0]
            service.dob = toptxtArr[1]
            service.iqmano = toptxtArr[2]
            service.edob = toptxtArr[3]
            service.isType = sender.tag + 1
            if !imgIdArr[sender.tag]
            {
                if !imgIdUploadedArr[sender.tag]
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please upload nation id/Iqama by clicking on Sample image", msg: "")
                    return
                }
            }
            if imglocalArr[sender.tag] == nil{
                
                service.docfilereg.append(documentlocalArr[sender.tag]!)
            }
            else{
                
                service.imagefile.append(imglocalArr[sender.tag]!)
            }
            service.sendforapproval = "0"
        }
        else if sender.tag == 5
        {
            if txtArr[0] == ""
            {
                ModalController.showNegativeCustomAlertWith(title: "Please select registration type".localized, msg: "")
                return
            }
            if txtArr[1] == ""
            {
                ModalController.showNegativeCustomAlertWith(title: "Please select vehicle brand".localized, msg: "")
                return
            }
            if txtArr[2] == ""
            {
                ModalController.showNegativeCustomAlertWith(title: "Please select vehicle name".localized, msg: "")
                return
            }
            if txtArr[3] == ""{
                ModalController.showNegativeCustomAlertWith(title: "Please enter production year".localized, msg: "")
                return
            }
            if txtArr[3].count > 0
            {
                if txtArr[3].count != 4{
                    ModalController.showNegativeCustomAlertWith(title: "Please Check Production Year", msg: "")
                    return
                }
            }
            if txtArr[4] == ""{
                ModalController.showNegativeCustomAlertWith(title: "Please select vehicle color".localized, msg: "")
                return
            }
            if txtArr[5] == ""{
                ModalController.showNegativeCustomAlertWith(title: "Please select vehicle kind".localized, msg: "")
                return
            }
            //            if txtArr[6] == ""{
            //                ModalController.showNegativeCustomAlertWith(title: "Maximum Load".localized, msg: "")
            //                return
            //            }
            if txtArr[6].count > 0
            {
                if txtArr[6].count != (self.servicelist?.data?.maximum_load_allowed ?? 0){
                    ModalController.showNegativeCustomAlertWith(title: "Please Check Maximum Load ", msg: "")
                    return
                }
            }
            if txtArr[7] == ""{
                ModalController.showNegativeCustomAlertWith(title: "Please enter plat number".localized, msg: "")
                return
            }
            if txtArr[7].count > 0
            {
                print("vnknnjjknk \(self.servicelist?.data?.plate_no_min_length ?? 0)")
                if txtArr[7].count < (self.servicelist?.data?.plate_no_min_length ?? 0)  {
                    ModalController.showNegativeCustomAlertWith(title: "Please Check Plat Number", msg: "")
                    return
                }
            }
            
            
            if !imgIdArr[sender.tag]
            {
                if !imgIdUploadedArr[sender.tag]
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please upload vehicle front side photo", msg: "")
                    return
                }
            }
            service.regtype = "\(txtIdArr[0])"
            service.vehicleBrand = "\(txtIdArr[1])"
            service.vehiclename = "\(txtIdArr[2])"
            service.productionyear = txtArr[3]
            service.vehiclecolor = "\(txtIdArr[4])"
            service.VehicleKind = "\(txtIdArr[5])"
            service.maxload = txtArr[6]
            service.platnumber = txtArr[7]
            
            service.isType = 6
            if imglocalArr[sender.tag] == nil{
                if documentlocalArr[sender.tag] != nil
                {
                    service.docfilereg.append(documentlocalArr[sender.tag]!)
                }
                else{
                    ModalController.showNegativeCustomAlertWith(title: "Please upload vehicle front side photo", msg: "")
                    return
                }
            }
            else{
                service.imagefile.append(imglocalArr[sender.tag]!)
                
            }
            service.sendforapproval = "0"
        }
        else if sender.tag == 7
        {
            service.sendforapproval = "0"
            service.isType = 7
            if reasonforvehicle == ""
            {
                ModalController.showNegativeCustomAlertWith(title: "Please Fill Reason For Vehicle Change", msg: "")
                return
            }
            service.reasonchange = reasonforvehicle
        }
        else if sender.tag == 8
        {
            service.sendforapproval = "1"
            service.isType = 8
        }
        else if sender.tag == 4
        {
            
            if !imgIdArr[2]
            {
                if !imgIdUploadedArr[2]
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please upload Vehicle Registration by clicking on Sample image", msg: "")
                    return
                }
                
            }
            //  if !imgIdArr[4]
            //            {
            //            if !imgIdUploadedArr[4]
            //            {
            //                    ModalController.showNegativeCustomAlertWith(title: "Upload Driving Authorization ", msg: "")
            //                    return
            //            }
            //            }
            
            service.isType = sender.tag + 1
            service.sendforapproval = "0"
            imglocalArr[2] == nil ? service.docfilereg.append(documentlocalArr[2]!) :  service.imagefile.append(imglocalArr[2]!)
            if imgIdUploadedArr[4]
            {
                imglocalArr[4] == nil ? service.docfilereg.append(documentlocalArr[4]!) :  service.imagefile.append(imglocalArr[4]!)
            }
        }
        else
        {
            if !imgIdArr[sender.tag]
            {
                if  !imgIdUploadedArr[sender.tag]
                {
                    if sender.tag == 1
                    {
                        ModalController.showNegativeCustomAlertWith(title: "Please upload driving license font by clicking on Sample image", msg: "")
                        return
                    }
                    if sender.tag == 2
                    {
                        ModalController.showNegativeCustomAlertWith(title: "Please upload Vehicle Registration by clicking on Sample image", msg: "")
                        return
                    }
                    if sender.tag == 3
                    {
                        ModalController.showNegativeCustomAlertWith(title: "Please upload Vehicle Insurance by clicking on Sample image", msg: "")
                        return
                    }
                    
                    else{
                        ModalController.showNegativeCustomAlertWith(title: "Upload Driving Authorization ", msg: "")
                        return
                    }
                }
            }
            service.isType = sender.tag + 1
            service.sendforapproval = "0"
            if imglocalArr[sender.tag] == nil{
                
                service.docfilereg.append(documentlocalArr[sender.tag]!)
            }
            else{
                service.imagefile.append(imglocalArr[sender.tag]!)
            }
        }
        print(sender.tag)
        ModalClass.startLoading(self.view)
        
        service.primaryid = primaryid
        if service.docfilereg.count > 0 && service.imagefile.count > 0
        {
            service.istypeimage = (imglocalArr[2] == nil ? false : true)
        }
        service.uploadImage { (success, response) in
            ModalClass.stopLoadingAllLoaders(self.view)
            if success
            {
                self.SelectedIndex.removeAllObjects()
                self.servicelist = response
                ModalController.showSuccessCustomAlertWith(title: self.servicelist?.error_description ?? "", msg: "")
                self.primaryid = self.servicelist?.data?.id ?? 0
                self.imgArr = [self.servicelist?.data?.national_id ?? "",self.servicelist?.data?.driving_license ?? "",self.servicelist?.data?.registration ?? "",self.servicelist?.data?.insurance ?? "",self.servicelist?.data?.authorization ?? "",self.servicelist?.data?.front_side ?? ""]
                for i in 0...self.imgArr.count - 1
                {
                    if self.imgArr[i] != ""
                    {
                        let imageUrl = URL(string: self.imgArr[i])!
                        
                        do {
                            let imageData = try Data(contentsOf: imageUrl)
                            self.imglocalArr[i] = UIImage(data: imageData)
                            if self.imglocalArr[i] == nil{
                                self.documentlocalArr[i] = imageUrl
                            }
                        }
                        catch{
                            self.imglocalArr[i] = nil
                        }
                    }
                    else
                    {
                        self.imglocalArr[i] = nil
                    }
                }
                
                self.imgIdArr = [self.servicelist?.data?.national_id_uploaded ?? false,self.servicelist?.data?.driving_license_uploaded ?? false,self.servicelist?.data?.registration_uploaded ?? false,self.servicelist?.data?.insurance_uploaded ?? false,self.servicelist?.data?.authorization_uploaded ?? false,self.servicelist?.data?.front_side ?? "" == "" ? false : true,self.servicelist?.data?.reason_for_change ?? "" == "" ? false : true]
                self.descriparr = [self.servicelist?.data?.national_id_content ?? "", "",self.servicelist?.data?.registration_content ?? "", "",self.servicelist?.data?.authorization_content ?? ""]
                self.toptxtArr = [self.servicelist?.data?.full_name ?? "",self.servicelist?.data?.dob ?? "",self.servicelist?.data?.iqama_no ?? "",self.servicelist?.data?.doe ?? ""]
                self.txtArr = [self.servicelist?.data?.registration_type ?? "",self.servicelist?.data?.vehicle_brand ?? "",self.servicelist?.data?.vehicle_name ?? "",self.servicelist?.data?.production_year ?? "",self.servicelist?.data?.vehicle_color ?? "",self.servicelist?.data?.vehicle_kind ?? "",self.servicelist?.data?.maximum_load ?? "",self.servicelist?.data?.plate_no ?? ""]
                if sender.tag == 8
                {
                    self.servicedocList_API()
                }
                self.tabvw.reloadData()
            }
        }
    }
    func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
        guard let data = try? Data(contentsOf: url),
            let page = PDFDocument(data: data)?.page(at: 0) else {
                return nil
        }
        let pageSize = page.bounds(for: .mediaBox)
        let pdfScale = width / pageSize.width
        
        // Apply if you're displaying the thumbnail on screen
        let scale = UIScreen.main.scale * pdfScale
        let screenSize = CGSize(width: pageSize.width * scale,
                                height: pageSize.height * scale)
        
        return page.thumbnail(of: screenSize, for: .mediaBox)
    }
    @objc func clickedvehicleUpload(_ sender:UIButton)
    {
        if servicelist?.data?.status ?? 0 == 1
               {
                   ModalController.showNegativeCustomAlertWith(title: " You cannot edit the form when it is pending for approval", msg: "")
            
                                  return
               }
        tag1 = sender.tag
        
        OpenGallery.shared.viewControl = self
        OpenGallery.shared.openGallery()
        OpenGallery.shared.delegate = self
    }
    @objc func clickupload(_ sender:UIButton) {
        if servicelist?.data?.status ?? 0 == 1
               {
                   ModalController.showNegativeCustomAlertWith(title: " You cannot edit the form when it is pending for approval", msg: "")
            
                                  return
               }
        let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
        vc.delegate = self
        vc.isproduct = true
        vc.iswarning = true
        vc.index = sender.tag
        vc.nameAr =  ["Device Gallery".localized,"Document".localized]
        vc.imgAr  = ["galery_Picture","dataEntryService"]
        let popupController = MTPopupController(rootViewController: vc)
        popupController.autoAdjustKeyboardEvent = false
        popupController.style = .bottomSheet
        popupController.navigationBarHidden = true
        popupController.hidesCloseButton = false
        let blurEffect = UIBlurEffect(style: .dark)
        popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
        popupController.backgroundView?.alpha = 0.6
        popupController.backgroundView?.onClick {
            popupController.dismiss()
        }
        popupController.present(in: self)
        
        
    }
    
}
extension DeliveryDocumentViewController:UITableViewDelegate,UITableViewDataSource
{
    func doc_headerCell(index:IndexPath) ->UITableViewCell
    {
        let cell = tabvw.dequeueReusableCell(withIdentifier: "DocHeaderTableViewCell", for: index) as! DocHeaderTableViewCell
        cell.arrow.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"rightArrow_dash")!)
        cell.headerlbl.text = headerarr[index.section - 1].localized
        if SelectedIndex.contains(index.section)
        {
            cell.arrow.image = UIImage(named: "down-arrow-2")
        }
        cell.edit.image = UIImage(named: "edit_red")
        if imgIdArr[index.section - 1] 
        {
            cell.edit.image = UIImage(named: "greenTick")
        }
        if index.section == 7
        {
        if reasonforvehicle.count > 0
        {
            cell.edit.image = UIImage(named: "greenTick")
        }
        else{
            cell.edit.image = UIImage(named: "edit_red")
    }
        }
        return cell
    }
    func vehicle_DescriptionCell(index:IndexPath) ->UITableViewCell
    {
        let cell = tabvw.dequeueReusableCell(withIdentifier: "VehicleDescriptionTableViewCell", for: index) as! VehicleDescriptionTableViewCell
        cell.topconst.constant = -6
        if index.row == 1
        {
            cell.topconst.constant = 5
            
        }
        cell.downarrow.isHidden = false
        cell.txt.delegate = self
        cell.txt.isUserInteractionEnabled = false
        cell.txt.keyboardType = .default
        if index.row == 4 || index.row == 7
        {
            cell.txt.isUserInteractionEnabled = true
            cell.downarrow.isHidden = true
            cell.txt.keyboardType = .asciiCapableNumberPad
        }
        
        
        if index.row == 8
        {
            cell.txt.isUserInteractionEnabled = true
            cell.txt.autocapitalizationType = .allCharacters
            cell.downarrow.isHidden = true
        }
        cell.toplbl.text = vehicledescriparr[index.row - 1].localized
        cell.txt.text =  txtArr[index.row - 1]
        cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
        if txtArr[index.row - 1] == ""
        {
            if index.row == 7{
                cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
            }else{
            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
            }
        }
//        if txtArr[6] == ""{
//            cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
//        }
        
        return cell
    }
    func service_DetailCell(index:IndexPath) ->UITableViewCell
    {
        let cell = tabvw.dequeueReusableCell(withIdentifier: "ServiceDetailTableViewCell", for: index) as! ServiceDetailTableViewCell
        var section = index.section
        cell.bottomConst.constant = 0
        if index.section == 3
        {
            if index.row == 1
            {
               cell.bottomConst.constant = -60
            }
        if index.row == 2
        {
            cell.topconstant.constant = -40
            section = headerarr.count - 2
        }
        }
        cell.topconstant.constant = 5
        if index.section == 1
        {
            cell.topconstant.constant = -10
        }
        
        cell.title.text = headertitlearr[section - 1].localized
        cell.uploadimg.tag = section - 1
        cell.crossclicked.tag = section - 1
        cell.uploadbtn.tag = section - 1
        
       
       // if index.section == 3
//        {
//            if index.row == 1
//            {
//                cell.uploadimg.tag = index.section - 1
//                cell.crossclicked.tag = index.section - 1
//
//            }
//            for i in 0...1
//            {
//                if i == 0
//                {
//                    cell.uploadbtn.tag = index.section - 1
//                    cell.uploadbtn.addTarget(self, action: #selector(clickuploadclicked(_:)), for: .touchUpInside)
//                }
//                else
//                {
//                    cell.uploadbtn.tag = section - 1
//                    cell.uploadbtn.addTarget(self, action: #selector(clickuploadclicked(_:)), for: .touchUpInside)
//                }
//
//            }
//
//
//
//        }
       
      
            cell.uploadbtn.addTarget(self, action: #selector(clickuploadclicked(_:)), for: .touchUpInside)
        cell.uploadimg.addTarget(self, action: #selector(clickupload(_:)), for: .touchUpInside)
            
        cell.crossclicked.addTarget(self, action: #selector(clickcrossed(_:)), for: .touchUpInside)
        cell.uploadbtn.setTitle("Upload & Save".localized, for: .normal)
        cell.crossclicked.isHidden =  true
        cell.lblsampletext.isHidden =  false
        cell.uploadimg.isUserInteractionEnabled = true
//        if imgArr[section - 1] != ""
//        {
//            cell.pswdimg.sd_setImage(with: URL(string: imgArr[section - 1]), placeholderImage: UIImage(named: "passport"))
//
//        }
        cell.pswdimg.image = UIImage(named: "passport")
            if imglocalArr[section - 1] != nil {
                cell.pswdimg.image = imglocalArr[section - 1]
//            cell.crossclicked.isHidden =  false
//                     cell.uploadimg.isUserInteractionEnabled = false
            }


        else if documentlocalArr[section - 1] != nil
        {
            cell.pswdimg.image = pdfThumbnail(url: documentlocalArr[section - 1]!)
//            cell.crossclicked.isHidden =  false
//            cell.uploadimg.isUserInteractionEnabled = false
        }
        cell.crossclicked.isHidden =  true
      cell.uploadimg.isUserInteractionEnabled = true
        if imgIdArr[section - 1] || imgIdUploadedArr[section - 1]
        {
          cell.crossclicked.isHidden =  false
          cell.lblsampletext.isHidden =  true
        cell.uploadimg.isUserInteractionEnabled = false
        }
       
        //                 if imglocalArr[index.section - 1] == nil
        //                 {
        //                     cell.crossclicked.isHidden =  true
        //                     cell.uploadimg.isUserInteractionEnabled = true
        //                 }
        var html = descriparr[index.section - 1]
        
        if index.section == 3
        {
            if index.row == 2
            {
                html = descriparr[4]
            }
        }
        
        let data = Data(html.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            let font = UIFont(name: "Gilroy-Light", size: 12)
            let attributedString = NSMutableAttributedString(attributedString: attributedString)
            attributedString.addAttribute(.font, value:font!, range: NSRange(location: 0, length: attributedString.length))
           
            cell.detaillbl.attributedText = attributedString
        }
        
        
        return cell
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerarr.count + 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            return 1
        }
        else if section == 1
        {
            if self.servicelist?.data?.show_iqama_section ?? false
            {
                if SelectedIndex.contains(section)
                {
                    return 6
                }
                return 1
            }
            return 0
        }
        else if section == headerarr.count - 1
        {
            if SelectedIndex.contains(section)
            {
                return vehicledescriparr.count + 2
            }
            return 1
        }
        else if section == headerarr.count
        {
            if isReasonForVehicle
            {
                if SelectedIndex.contains(section)
                {
                    return 2
                }
                return 1
            }
            return 0
        }
        else if section == headerarr.count + 1
        {
            
            return 1
        }
        else if section == headerarr.count - 2
        {
            
            return 0
        }
        else if section == 3
        {
            if SelectedIndex.contains(section)
            {
                return 3
            }
            return 1
        }
        else
        {
            if SelectedIndex.contains(section)
            {
                return 2
            }
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tabvw.dequeueReusableCell(withIdentifier: "ServiceHeaderTableViewCell", for: indexPath) as! ServiceHeaderTableViewCell
            cell.deliverysercicedoc.text = "Delivery Services Documents".localized
             cell.clickednewcar.isHidden = true
            cell.addimg.isHidden = true
            if self.servicelist?.data?.new_upload_enable ?? false{
                cell.clickednewcar.isHidden = false
                cell.addimg.isHidden = false
//                cell.clickednewcar.sd_setImage(with: URL(string: self.servicelist?.data?.front_side ?? ""), for: .normal, placeholderImage: UIImage(named: "newcar"))
            }
            cell.clickednewcar.addTarget(self, action: #selector(clickedaddnewcar), for: .touchUpInside)
            return cell
        case 1:
            if indexPath.row == 0
            {
                return doc_headerCell(index: indexPath)
            }
            if indexPath.row <= 4
            {
                
                let cell = tabvw.dequeueReusableCell(withIdentifier: "VehicleDescriptionTableViewCell", for: indexPath) as! VehicleDescriptionTableViewCell
                cell.txt.delegate = self
                cell.txt.keyboardType = .default
                cell.topconst.constant = -6
                cell.txt.isUserInteractionEnabled = true
                if indexPath.row == 1
                {
                    cell.txt.keyboardType = .asciiCapable
                }
                if indexPath.row == 2 || indexPath.row == 4
                {
                    cell.txt.isUserInteractionEnabled = false
                }
                if indexPath.row == 1
                {
                    cell.topconst.constant = 5
                }
                if indexPath.row == 3
                {
                    cell.txt.keyboardType = .asciiCapableNumberPad
                }
                cell.toplbl.text = topArr[indexPath.row - 1].localized
                cell.txt.text = toptxtArr[indexPath.row - 1]
                cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                if toptxtArr[indexPath.row - 1] == ""
                {
                    cell.txt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                }
                cell.downarrow.isHidden = true
                return cell
            }
            else
            {
                return service_DetailCell(index: indexPath)
            }
        case headerarr.count - 1:
            if indexPath.row == 0
            {
                return doc_headerCell(index: indexPath)
            }
                
            else  if indexPath.row == vehicledescriparr.count + 1{
                let cell = tabvw.dequeueReusableCell(withIdentifier: "UploadVehicleImageTableViewCell", for: indexPath) as! UploadVehicleImageTableViewCell
                cell.uploadlbl.text = "Upload the Front side Photo".localized
                cell.uploadsaveVehicle.setTitle("Upload & Save".localized, for: .normal)
                cell.uploadvehicle.tag = indexPath.section - 1
                cell.uploadvehicle.addTarget(self, action: #selector(clickedvehicleUpload(_:)), for: .touchUpInside)
                  cell.uploadvehicle.layer.borderColor = UIColor.clear.cgColor
//                if imgArr[indexPath.section - 1] != ""
//                {
//                 cell.vehicleimage.sd_setImage(with: URL(string:imgArr[indexPath.section - 1]), placeholderImage: UIImage(named: "vehicle"))
//                    cell.crossclicked.isHidden = false
//                    cell.uploadvehicle.isUserInteractionEnabled = false
//                }
                     if imglocalArr[indexPath.section - 1] != nil
                {
                     cell.crossclicked.isHidden = false
                    cell.vehicleimage.image = imglocalArr[indexPath.section - 1]
                    cell.uploadvehicle.isUserInteractionEnabled = false
                }
                else{
                     cell.crossclicked.isHidden = true
                    cell.vehicleimage.image = UIImage(named: "vehicle")
                    cell.uploadvehicle.isUserInteractionEnabled = true
                  
                }
               
                cell.uploadsaveVehicle.tag = indexPath.section - 1
                 cell.crossclicked.tag = indexPath.section - 1
                 cell.crossclicked.addTarget(self, action: #selector(clickremoveimage(_:)), for: .touchUpInside)
                cell.uploadsaveVehicle.addTarget(self, action: #selector(clickuploadclicked(_:)), for: .touchUpInside)
                return cell
            }
            return vehicle_DescriptionCell(index: indexPath)
        case headerarr.count :
            if indexPath.row == 0
            {
                return doc_headerCell(index: indexPath)
            }
            else{
                let cell = tabvw.dequeueReusableCell(withIdentifier: "ReasonForChangeTableViewCell", for: indexPath) as! ReasonForChangeTableViewCell
                cell.vehiclelbl.text = "Reason for different vehicle registration".localized
                cell.upload.setTitle("Upload & Save".localized, for: .normal)
                cell.count.textColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
                cell.upload.tag = 7
                cell.upload.addTarget(self, action: #selector(clickuploadclicked(_:)), for: .touchUpInside)
                cell.count.attributedText = ModalController.setProductStricColor(str: "\(reasonforvehicle.count)/200", str1: "\(reasonforvehicle.count)", str2: " /200", fontsize: 12, fontfamily: "LightFontName", txtcolor: #colorLiteral(red: 97/255, green: 192/255, blue: 136/255, alpha: 1))

                cell.txtvw.delegate = self
                cell.txtvw.text = reasonforvehicle
                if reasonforvehicle == ""
                {
                      cell.txtvw.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                }
                if reasonforvehicle.count == 200
                {
                    cell.count.textColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
                                   
                }
                cell.upload.isHidden = true
                return cell
            }
        case headerarr.count + 1 :
            let cell = tabvw.dequeueReusableCell(withIdentifier: "BottomLblTableViewCell", for: indexPath) as! BottomLblTableViewCell
            
            let data = Data((self.servicelist?.data?.note ?? "").utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                
                let font = UIFont(name: "Gilroy-Light", size: 12)
                let attributedString = NSMutableAttributedString(attributedString: attributedString)
                attributedString.addAttribute(.font, value:font!, range: NSRange(location: 0, length: attributedString.length))
                
                cell.lbl.attributedText = attributedString
            }
            return cell
        default:
            if indexPath.row == 0
            {
                return doc_headerCell(index: indexPath)
            }
            else{
            
                return service_DetailCell(index: indexPath)
                
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            if SelectedIndex.contains(indexPath.section)
            {
                SelectedIndex.remove(indexPath.section)
            }
            else{
                SelectedIndex.removeAllObjects()
                SelectedIndex.add(indexPath.section)
            }
            self.tabvw.reloadData()
            
        }
        if indexPath.section == 1
        {
            if indexPath.row == 2 || indexPath.row == 4
            {
                NationalselectDOB(tag: indexPath.row - 1)
            }
        }
        if indexPath.section == headerarr.count - 1
        {
            if indexPath.row > 0 && indexPath.row < 9
            {
                if servicelist?.data?.status ?? 0 == 1
                       {
                           ModalController.showNegativeCustomAlertWith(title: " You cannot edit the form when it is pending for approval", msg: "")
                    
                                          return
                       }
                let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
                vc.tag1 = indexPath.row - 1
                vc.delegate = self
                vc.isfiletr = true
   
                if indexPath.row == 1
                {
                    vc.header = "registration type"
                    vc.nameAr = registrationtypeArr
                    vc.nameArId = registrationtypeidArr
                    vc.namelock = registrationtypeidArr
                    
                }
                else if indexPath.row == 2
                {
                    vc.header = "vehicle brand"
                    vc.nameAr = vehiclebrandArr
                    vc.nameArId = vehiclebrandidArr
                    vc.namelock = vehiclebrandidArr
                }
                else if indexPath.row == 3
                {
                    if vehiclebrandArr.count == 0
                    {
                        ModalController.showNegativeCustomAlertWith(title: "Please Select Brand First", msg: "")
                        return
                    }
                    vc.header = "vehicle name"
                    vc.nameAr = vehiclenameArr
                    vc.nameArId = vehiclenameidArr
                    vc.namelock = vehiclenameidArr
                }
                else if indexPath.row == 5
                {
                    vc.header = "vehicle color"
                    vc.nameAr = vehicleColorArr
                    vc.nameArId = vehicleColoridArr
                    vc.namelock = vehicleColoridArr
                }
                else if indexPath.row == 6
                {
                    vc.header = "vehicle kind"
                    vc.isType = true
                    vc.nameAr = vehiclekindArr
                    vc.nameArId = vehiclekindidArr
                    vc.namelock = vehiclekindidArr
                    vc.imageKind = vehiclekindimageArr
                }
                else{
                    return
                }
                let popupController = MTPopupController(rootViewController: vc)
                popupController.autoAdjustKeyboardEvent = false
                popupController.style = .bottomSheet
                popupController.navigationBarHidden = true
                popupController.hidesCloseButton = false
                let blurEffect = UIBlurEffect(style: .dark)
                popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
                popupController.backgroundView?.alpha = 0.6
                popupController.backgroundView?.onClick {
                    popupController.dismiss()
                }
                popupController.present(in: self)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 100
        }
        else if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                return 57
            }
            else  if indexPath.row <= 4
            {
                return 90
            }
            return UITableView.automaticDimension
        }
        else if indexPath.section == headerarr.count - 1
        {
            if indexPath.row == 0
            {
                return 57
            }
            if indexPath.row == vehicledescriparr.count + 1
            {
                return 180
            }
            return 90
        }
        else if  indexPath.section == headerarr.count
        {
            
            if indexPath.row == 1
            {
                return 200
            }
            return 57
        }
        else if  indexPath.section == headerarr.count + 1
        {
            return UITableView.automaticDimension
        }
        else
        {
            if indexPath.row == 1 || indexPath.row == 2
            {
                return UITableView.automaticDimension
            }
            return 57
        }
        
    }
}



