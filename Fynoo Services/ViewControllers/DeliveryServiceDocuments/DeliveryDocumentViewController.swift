//
//  DeliveryDocumentViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 23/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import MTPopup
import MobileCoreServices
class DeliveryDocumentViewController: UIViewController,BottomPopupEditProductViewControllerDelegate,OpenGalleryDelegate,UIDocumentPickerDelegate,UITextFieldDelegate {
    var tag1 = 0
    var vehiclemodel = ServiceModel()
    var topArr = ["Full Name","Date of Birth","National ID / Iqama ID","Date of Expiry"]
    var toptxtArr = ["","","",""]
    var txtArr = ["","","","","","","",""]
    var imgArr = [String]()
    var imgIdArr = [Bool]()
      var imglocalArr = [UIImage?]()
     var descriparr = [String]()
       var registrationtypeArr = [String]()
       var vehiclebrandArr = [String]()
     var vehiclenameArr = [String]()
     var vehiclenameidArr = [Int]()
    var vehiclekindArr = [String]()
        var vehiclekindidArr = [Int]()
       var vehicleColorArr = [String]()
    var registrationtypeidArr = [Int]()
    var vehiclebrandidArr = [Int]()
    var vehicleColoridArr = [Int]()
    var vehicledescriparr = ["Registration Type ","Vehicle Brand ","Vehicle Name","Production Year","Vehicle Color","Vehicle kind","Maximum Load ","Plat Number"]
    var service = ServiceModel()
    var headerarr = ["National Id / Iqama","Driving License Front ","Car Registration","Car Insurance","Driving Authorization","Car Description"]
      var vehiclenamelist:VehicleName?
    var servicelist:SeviceDocument?
    var typecolorlist:TypeBrandColor?
    var vehiclekind:VehicleKind?
    @IBOutlet weak var tabvw: UITableView!
    @IBOutlet weak var headervw: NavigationView!
    var SelectedIndex = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
    headervw.viewControl = self
    headervw.titleHeader.text = "Delivery Services"
        tabvw.delegate = self
        tabvw.dataSource = self
        registernibs()
          //self.tabvw.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        
        servicedocList_API()
        servicetypeColor_API()
    }
    func NationalselectDOB(tag:Int){
          let calendar = Calendar(identifier: .gregorian)
                  let currentDate = Date()
                  var components = DateComponents()
                  components.calendar = calendar
//                  components.year = -18
//                  components.month = 12
                  let maxDate = calendar.date(byAdding: components, to: currentDate)!

                  let minDate = Calendar.current.date(from: DateComponents(year: 1900 , month: 1, day: 1))
                  
                  print(minDate as Any)
                          
          DatePickerDialog().show("Select - Date of Birth".localized, doneButtonTitle: "Done".localized, cancelButtonTitle: "Cancel".localized,  minimumDate: minDate, maximumDate: maxDate,  datePickerMode: .date){
              (date) -> Void in
              if let dt = date {
                  let formatter = DateFormatter()
                  formatter.dateFormat = "MMM dd,yyyy"
                  print(formatter.string(from: dt))
                self.toptxtArr[tag] = formatter.string(from: dt)
                 self.tabvw.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .none)
              }
          }
      }
    func vehicleKind_API(brandid:Int)
          {
          
             ModalClass.startLoading(self.view)
            vehiclemodel.vehicleId = 10
              service.getvehicleKind { (success, response) in
                  ModalClass.stopLoading()
                  if success
                  {
                      self.vehiclekind = response
                     for i in 0...(self.vehiclekind?.data?.vehicle_kind?.count ?? 0) - 1
                     {
                         self.vehiclekindArr.append(self.vehiclekind?.data?.vehicle_kind?[i].name ?? "")
                         self.vehiclekindidArr.append(self.vehiclekind?.data?.vehicle_kind?[i].id ?? 0)
                     }
                   self.tabvw.reloadData()
               }
           }
       }
    func vehicleName_API(brandid:Int)
       {
       
          ModalClass.startLoading(self.view)
         vehiclemodel.vehicleId = 10
           service.getvehicleName { (success, response) in
               ModalClass.stopLoading()
               if success
               {
                   self.vehiclenamelist = response
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
        // ModalClass.startLoading(self.view)
         service.getservicetypecolor { (success, response) in
             ModalClass.stopLoading()
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
                 self.tabvw.reloadData()
             }
         }
     }
    func servicedocList_API()
    {
        ModalClass.startLoading(self.view)
        service.getservicedocument { (success, response) in
            ModalClass.stopLoading()
            if success
            {
                self.servicelist = response
                self.imglocalArr = [nil,nil,nil,nil,nil]
                self.imgArr = [self.servicelist?.data?.national_id ?? "",self.servicelist?.data?.driving_license ?? "",self.servicelist?.data?.registration ?? "",self.servicelist?.data?.insurance ?? "",self.servicelist?.data?.authorization ?? ""]
                  self.imgIdArr = [self.servicelist?.data?.national_id_uploaded ?? false,self.servicelist?.data?.driving_license_uploaded ?? false,self.servicelist?.data?.registration_uploaded ?? false,self.servicelist?.data?.insurance_uploaded ?? false,self.servicelist?.data?.authorization_uploaded ?? false]
                 self.descriparr = [self.servicelist?.data?.national_id_content ?? "", "",self.servicelist?.data?.registration_content ?? "", "",self.servicelist?.data?.authorization_content ?? ""]
                self.tabvw.reloadData()
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        let touchPoint = textField.convert(CGPoint.zero, to: tabvw)
            let clickedBtn = tabvw.indexPathForRow(at: touchPoint)
            let row = Int(clickedBtn!.row)
        if ModalController.hasSpecialCharacters(str: string)
        {
          return false
        }
        var textstr = ""
                  if let text1 = textField.text as NSString? {
                      let txtAfterUpdate = text1.replacingCharacters(in: range, with: string)
                      textstr = txtAfterUpdate
               }
        if row == 3
        {
            if textstr.count > 10
            {
                return false
            }
            if !textstr.containArabicNumber
            {
                return false
            }
            else
            {
                return true
            }
        }
           
          
        toptxtArr[row - 1] = textstr
        return true
    }
    func registernibs()
       {
           tabvw.register(UINib(nibName: "ServiceHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "ServiceHeaderTableViewCell")
         tabvw.register(UINib(nibName: "DocHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "DocHeaderTableViewCell")
         tabvw.register(UINib(nibName: "ServiceDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ServiceDetailTableViewCell")
        tabvw.register(UINib(nibName: "VehicleDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "VehicleDescriptionTableViewCell")
           tabvw.register(UINib(nibName: "UploadVehicleImageTableViewCell", bundle: nil), forCellReuseIdentifier: "UploadVehicleImageTableViewCell")
           
       }
    func gallery(img: UIImage, imgtype: String) {
        
        imglocalArr[tag1] = img
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
          ModalClass.startLoading(self.view)
        print(urls.first)
      }
      
      func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
          controller.dismiss(animated: true, completion: nil)
      }
     @objc func clickcrossed(_ sender:UIButton)
     {
        imglocalArr[sender.tag] = nil
        tabvw.reloadData()
    }
    
    @objc func clickedvehicleUpload(_ sender:UIButton)
        {
          OpenGallery.shared.viewControl = self
            OpenGallery.shared.openGallery()
            OpenGallery.shared.delegate = self
       }
    @objc func clickupload(_ sender:UIButton) {
           let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
           vc.delegate = self
           vc.isproduct = true
           vc.iswarning = true
        vc.index = sender.tag
           vc.nameAr =  ["Device Gallery","Document"]
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerarr.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        if section == 1
               {
               if SelectedIndex.contains(section)
                          {
                            return 6
                          }
                          return 1
               }
        if section == headerarr.count
        {
          if SelectedIndex.contains(section)
            {
                return vehicledescriparr.count + 2
            }
            return 1
        }
        if SelectedIndex.contains(section)
        {
          return 2
        }
        return 1
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
         let cell = tabvw.dequeueReusableCell(withIdentifier: "ServiceHeaderTableViewCell", for: indexPath) as! ServiceHeaderTableViewCell
            
        return cell
        }
            if indexPath.section == headerarr.count
                   {
                    if indexPath.row == 0
                               {
                              let cell = tabvw.dequeueReusableCell(withIdentifier: "DocHeaderTableViewCell", for: indexPath) as! DocHeaderTableViewCell
                                cell.headerlbl.text = headerarr[indexPath.section - 1]
                                    cell.arrow.image = UIImage(named: "rightArrow_dash")
                                   if SelectedIndex.contains(indexPath.section)
                                   {
                                       cell.arrow.image = UIImage(named: "down-arrow-2")
                                   }
                                
                               return cell
                               }
                    else  if indexPath.row == vehicledescriparr.count + 1{
                        let cell = tabvw.dequeueReusableCell(withIdentifier: "UploadVehicleImageTableViewCell", for: indexPath) as! UploadVehicleImageTableViewCell
                                         cell.uploadvehicle.addTarget(self, action: #selector(clickedvehicleUpload(_:)), for: .touchUpInside)
                        cell.vehicleimage.sd_setImage(with: URL(string:self.servicelist?.data?.vehicle_kind_image ?? ""), placeholderImage: UIImage(named: "passport"))
                        
                                          return cell
                    }
                    let cell = tabvw.dequeueReusableCell(withIdentifier: "VehicleDescriptionTableViewCell", for: indexPath) as! VehicleDescriptionTableViewCell
                    cell.toplbl.text = vehicledescriparr[indexPath.row - 1]
                    cell.txt.text =  txtArr[indexPath.row - 1]
                   return cell
                   }
        else{
            if indexPath.row == 0
            {
           let cell = tabvw.dequeueReusableCell(withIdentifier: "DocHeaderTableViewCell", for: indexPath) as! DocHeaderTableViewCell
                 cell.arrow.image = UIImage(named: "rightArrow_dash")
                 cell.headerlbl.text = headerarr[indexPath.section - 1]
                if SelectedIndex.contains(indexPath.section)
                {
                    cell.arrow.image = UIImage(named: "down-arrow-2")
                }
            return cell
            }
                if indexPath.section == 1
                {
                 if indexPath.row <= 4
            {
                
               let cell = tabvw.dequeueReusableCell(withIdentifier: "VehicleDescriptionTableViewCell", for: indexPath) as! VehicleDescriptionTableViewCell
                cell.txt.delegate = self
                cell.txt.keyboardType = .default
                 cell.topconst.constant = -6
                cell.txt.isUserInteractionEnabled = true
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
                cell.toplbl.text = topArr[indexPath.row - 1]
                cell.txt.text = toptxtArr[indexPath.row - 1]
                cell.downarrow.isHidden = true
                return cell
            }
                    else{
                             let cell = tabvw.dequeueReusableCell(withIdentifier: "ServiceDetailTableViewCell", for: indexPath) as! ServiceDetailTableViewCell
                    cell.topconstant.constant = -10
                             cell.uploadimg.tag = indexPath.section - 1
                             cell.crossclicked.tag = indexPath.section - 1
                             cell.uploadimg.addTarget(self, action: #selector(clickupload(_:)), for: .touchUpInside)
                             cell.crossclicked.addTarget(self, action: #selector(clickcrossed(_:)), for: .touchUpInside)
                             if imglocalArr[indexPath.section - 1] == nil
                             {
                               cell.pswdimg.sd_setImage(with: URL(string: imgArr[indexPath.section - 1]), placeholderImage: UIImage(named: "passport"))
                             }
                             else{
                                 cell.pswdimg.image = imglocalArr[indexPath.section - 1]
                             }
                             if imgIdArr[indexPath.section - 1]
                             {
                                  cell.crossclicked.isHidden =  false
                                 cell.uploadimg.isUserInteractionEnabled = false
                             }
                             else{
                                 cell.crossclicked.isHidden =  true
                                cell.uploadimg.isUserInteractionEnabled = true
                             }
                             if imglocalArr[indexPath.section - 1] == nil
                             {
                                 cell.crossclicked.isHidden =  true
                                 cell.uploadimg.isUserInteractionEnabled = true
                             }
                             let html = descriparr[indexPath.section - 1]
                                let data = Data(html.utf8)
                            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                                
                           let font = UIFont(name: "Gilroy-Light", size: 12)
                           let attributedString = NSMutableAttributedString(attributedString: attributedString)
                             attributedString.addAttribute(.font, value:font!, range: NSRange(location: 0, length: attributedString.length))
                             cell.detaillbl.attributedText = attributedString
                             }
                             
                             
                             return cell
                         }
                     
                }
            else{
                let cell = tabvw.dequeueReusableCell(withIdentifier: "ServiceDetailTableViewCell", for: indexPath) as! ServiceDetailTableViewCell
                cell.uploadimg.tag = indexPath.section - 1
                cell.crossclicked.tag = indexPath.section - 1
                     cell.topconstant.constant = 7
                cell.uploadimg.addTarget(self, action: #selector(clickupload(_:)), for: .touchUpInside)
                cell.crossclicked.addTarget(self, action: #selector(clickcrossed(_:)), for: .touchUpInside)
                if imglocalArr[indexPath.section - 1] == nil
                {
                  cell.pswdimg.sd_setImage(with: URL(string: imgArr[indexPath.section - 1]), placeholderImage: UIImage(named: "passport"))
                }
                else{
                    cell.pswdimg.image = imglocalArr[indexPath.section - 1]
                }
                if imgIdArr[indexPath.section - 1]
                {
                     cell.crossclicked.isHidden =  false
                    cell.uploadimg.isUserInteractionEnabled = false
                }
                else{
                    cell.crossclicked.isHidden =  true
                   cell.uploadimg.isUserInteractionEnabled = true
                }
                if imglocalArr[indexPath.section - 1] == nil
                {
                    cell.crossclicked.isHidden =  true
                    cell.uploadimg.isUserInteractionEnabled = true
                }
                let html = descriparr[indexPath.section - 1]
                   let data = Data(html.utf8)
               if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                   
              let font = UIFont(name: "Gilroy-Light", size: 12)
              let attributedString = NSMutableAttributedString(attributedString: attributedString)
                attributedString.addAttribute(.font, value:font!, range: NSRange(location: 0, length: attributedString.length))
                cell.detaillbl.attributedText = attributedString
                }
                
                
                return cell
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
        tabvw.reloadData()
        }
        if indexPath.section == 1
        {
            if indexPath.row == 2 || indexPath.row == 4
            {
                NationalselectDOB(tag: indexPath.row - 1)
            }
        }
        if indexPath.section == headerarr.count
        {
            if indexPath.row > 0
            {
            let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
                vc.tag1 = indexPath.row - 1
            vc.delegate = self
            vc.isfiletr = true
                vc.nameAr = ["car","car","car","car","car","car","car","car"]
                vc.nameArId = [1,1,1,1,1,1,1,1]
                vc.namelock = [1,1,1,1,1,1,1,1]
                if indexPath.row == 1
                {
                    vc.nameAr = registrationtypeArr
                    vc.nameArId = registrationtypeidArr
                    vc.namelock = registrationtypeidArr
                    
                }
        else if indexPath.row == 2
                       {
                           vc.nameAr = vehiclebrandArr
                        vc.nameArId = vehiclebrandidArr
                        vc.namelock = vehiclebrandidArr
                       }
                     else if indexPath.row == 3
                  {
                    vc.nameAr = vehiclenameArr
                  vc.nameArId = vehiclenameidArr
                 vc.namelock = vehiclenameidArr
                 }
                else if indexPath.row == 5
                               {
                                  vc.nameAr = vehicleColorArr
                                vc.nameArId = vehicleColoridArr
                                vc.namelock = vehicleColoridArr
                               }
                else if indexPath.row == 6
                                              {
                                                 vc.nameAr = vehiclekindArr
                                               vc.nameArId = vehiclekindidArr
                                               vc.namelock = vehiclekindidArr
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
            if indexPath.section == 1
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
        else if indexPath.section == headerarr.count
        {
            if indexPath.row == 0
            {
                return 57
            }
            if indexPath.row == vehicledescriparr.count + 1
                       {
                           return 130
                       }
            return 90
        }
        else
        {
            if indexPath.row == 1
            {
                return UITableView.automaticDimension
            }
         return 57
        }
      
    }
    
}
enum viewBorder: String {
    case Left = "borderLeft"
    case Right = "borderRight"
    case Top = "borderTop"
    case Bottom = "borderBottom"
}

extension UIView {

    func AddBorder(vBorder: viewBorder, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.name = vBorder.rawValue
        switch vBorder {
            case .Left:
                border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            case .Right:
                border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
            case .Top:
                border.frame = CGRect(x: 0, y: -5, width: self.frame.size.width, height: width)
            case .Bottom:
                border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        }
        self.layer.addSublayer(border)
    }

    func removeBorder(border: viewBorder) {
        var layerForRemove: CALayer?
        for layer in self.layer.sublayers! {
            if layer.name == border.rawValue {
                layerForRemove = layer
            }
        }
        if let layer = layerForRemove {
            layer.removeFromSuperlayer()
        }
    }

}
