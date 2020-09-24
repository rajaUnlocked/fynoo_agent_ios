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
class DeliveryDocumentViewController: UIViewController,BottomPopupEditProductViewControllerDelegate,OpenGalleryDelegate,UIDocumentPickerDelegate {
    var imgArr = [UIImage]()
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
        imgArr.append(img)
       }
    func information(Value: String) {
           print("")
       }
       
       func actionPerform(tag: Int, index: Int) {
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
           print("")
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
        print("jbhekhjbklh")
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
        return 8
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        if section == 7
        {
          if SelectedIndex.contains(section)
            {
              return 8
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
            if indexPath.section == 7
                   {
                    if indexPath.row == 0
                               {
                              let cell = tabvw.dequeueReusableCell(withIdentifier: "DocHeaderTableViewCell", for: indexPath) as! DocHeaderTableViewCell
                                    cell.arrow.image = UIImage(named: "rightArrow_dash")
                                   if SelectedIndex.contains(indexPath.section)
                                   {
                                       cell.arrow.image = UIImage(named: "down-arrow-2")
                                   }
                               return cell
                               }
                    else  if indexPath.row == 7{
                        let cell = tabvw.dequeueReusableCell(withIdentifier: "UploadVehicleImageTableViewCell", for: indexPath) as! UploadVehicleImageTableViewCell
                                         cell.uploadvehicle.addTarget(self, action: #selector(clickedvehicleUpload(_:)), for: .touchUpInside)

                                          return cell
                    }
                    let cell = tabvw.dequeueReusableCell(withIdentifier: "VehicleDescriptionTableViewCell", for: indexPath) as! VehicleDescriptionTableViewCell
                  
                   return cell
                   }
        else{
            if indexPath.row == 0
            {
           let cell = tabvw.dequeueReusableCell(withIdentifier: "DocHeaderTableViewCell", for: indexPath) as! DocHeaderTableViewCell
                 cell.arrow.image = UIImage(named: "rightArrow_dash")
                if SelectedIndex.contains(indexPath.section)
                {
                    cell.arrow.image = UIImage(named: "down-arrow-2")
                }
            return cell
            }
                
            else{
                let cell = tabvw.dequeueReusableCell(withIdentifier: "ServiceDetailTableViewCell", for: indexPath) as! ServiceDetailTableViewCell
                cell.uploadimg.addTarget(self, action: #selector(clickupload(_:)), for: .touchUpInside)
                cell.crossclicked.addTarget(self, action: #selector(clickcrossed(_:)), for: .touchUpInside)
             
                let html = "<html><body><h4>Please make sure you follow the below guidelines</h4><ul><li>Sons of Saudi Female can apply.</li><li>Saudi: The applicant must hold a National Id Card.</li><li>Non Saudi: The applicant must be sponsored by a licensed Limo company and car must be authorized by transport ministry.</li></ul></body></html>"
                   let data = Data(html.utf8)
               if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
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
        if indexPath.section == 7
        {
            if indexPath.row > 0
            {
            let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
            vc.delegate = self
            vc.isfiletr = true
            vc.nameAr = ["car","car","car","car","car","car"]
            vc.nameArId = [1,1,1,1,1,1]
            vc.namelock = [1,1,1,1,1,1]
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
        else if indexPath.section == 7
        {
            if indexPath.row == 0
            {
                return 57
            }
            if indexPath.row == 7
                       {
                           return 130
                       }
            return 90
        }
        else
        {
            if indexPath.row == 1
            {
               return 400
            }
         return 57
        }
      
    }
    
}
