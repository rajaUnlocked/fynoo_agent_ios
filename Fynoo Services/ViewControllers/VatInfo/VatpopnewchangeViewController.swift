//
//  VatpopnewchangeViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 04/09/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import MTPopup
 import PDFKit
import MobileCoreServices

class VatpopnewchangeViewController: UIViewController,UITextFieldDelegate {
    var delegate:VatPopupNewViewControllerDelegate?
    var branch = branchsmodel()
    var pfurl:URL?
    var vatlength = 0
    var filesize = 0.0
    var uploaddoc : UploadDocument?
    var pdfImage : UIImage = UIImage()
    @IBOutlet weak var yesCheck: UIButton!
    @IBOutlet weak var noCheck: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var vwheight: NSLayoutConstraint!
    
    @IBOutlet weak var noTxt: UILabel!
    @IBOutlet weak var registerlbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var innervwheight: NSLayoutConstraint!
    @IBOutlet weak var topconst: NSLayoutConstraint!
    @IBOutlet weak var vatcertificate: UILabel!
    @IBOutlet weak var addlbl: UILabel!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var imgheight: NSLayoutConstraint!
    
    @IBOutlet weak var yeslbl: UILabel!
    var vatNo = ""
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
      registerlbl.font = UIFont(name:"\(fontNameLight)",size:15)
        yeslbl.font = UIFont(name:"\(fontNameLight)",size:12)
        noTxt.font = UIFont(name:"\(fontNameLight)",size:12)
        vatcertificate.font = UIFont(name:"\(fontNameLight)",size:12)
        addlbl.font = UIFont(name:"\(fontNameLight)",size:18)
        saveBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        
        
        vatcertificate.text = "Upload VAT Registration Certificate".localized
        registerlbl.text = "Are you registered in VAT?".localized
        txtField.placeholder = "Enter Registered VAT Number".localized
        self.saveBtn.setAllSideShadow(shadowShowSize: 3.0)
        self.yesCheck.setAllSideShadow(shadowShowSize: 3.0)
        self.noCheck.setAllSideShadow(shadowShowSize: 3.0)
        saveBtn.setTitle("Save".localized, for: .normal)
        yeslbl.text = "Yes".localized
        addlbl.text = "Add".localized
        noTxt.text = "No".localized
        txtField.delegate = self
        txtField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        if vatNo != "" {
            yesCheck.isSelected  = true
            noCheck.isSelected  = false
            txtField.isHidden = false
            imgheight.constant = 135
            vatcertificate.isHidden = false
            add.isHidden = false
            addlbl.isHidden = false
            topconst.constant = 15
            vwheight.constant = 422
            innervwheight.constant = 300
            txtField.text = vatNo
            addlbl.isHidden = true
            add.isHidden = true
            closeBtn.isHidden = false
            img.image = pdfImage
            txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
            saveBtn.layer.borderColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1).cgColor
            saveBtn.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
            noTxt.isHidden = true
            noCheck.isHidden = true
            yesCheck.isUserInteractionEnabled = false
            
        }
        txtField.setLeftPaddingPoints(10)
    }
    var mobilNoos = ""
    var values = ""
    
    @objc func textFieldDidChange(textField: UITextField){
        if mobilNoos != ""{
            values = textField.text!
            mobilNoos = values.replacingOccurrences(of: " ", with: "")
            values = ModalController.customStringFormatting(of: mobilNoos)
            
        }else{
            
            values = ModalController.customStringFormatting(of: textField.text!)
            mobilNoos = values.replacingOccurrences(of: " ", with: "")
            
        }
        textField.text = values
        if self.txtField.text!.count > 0 && pfurl != nil
        {
                    saveBtn.layer.borderColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1).cgColor
                    saveBtn.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
        }
        // vat = values
        print(values ,"vatno")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.branch.vatlength { (success, response) in
            ModalClass.stopLoading()
            if success
            {
                let val = response?.value(forKey: "data") as! NSDictionary
                self.vatlength = val.object(forKey: "vat_length") as! Int
                self.filesize = val.object(forKey: "vat_file_size") as! Double
                
            }
        }
        
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.containArabicNumber
        {
            return false
        }
        
        var textstr = ""
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            textstr = txtAfterUpdate
        }
        
        
        //        let mobilNoo = textField.text!.replacingOccurrences(of: " ", with: "")
        //         print(mobilNoo.count,"text")
        //        print( self.vatlength)
        //        if mobilNoo.count+1 == self.vatlength
        //            {
        //            return false
        //            }
        //
        //                    let value = ModalController.customStringFormatting(of: mobilNoo)
        //                txtField.text = value
        
        let currentCount =  textstr.count
        let textCount = textstr.replacingOccurrences(of: " ", with: "").count
        let val = currentCount-textCount
        
        
        // var lenght  = 15
        let str = textField.text
        
        guard let stringRange = Range(range,in: str!) else{
            return false
        }
        let updateText =  str!.replacingCharacters(in: stringRange, with: string)
        
        if textstr.count > 0
        {
            if !textstr.containArabicNumber
            {
                txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                
            }
            else{
               if (updateText.count) < vatlength+val
                {
                   txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
               }
                else{
                    txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                   
                }
                
            }
            
        }
        else
        {
            txtField.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
            
            
        }
        
       
        return (updateText.count) <= vatlength+val
      
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view {
            
            dismiss(animated: true, completion: nil)
            //           super.touchesEnded(touches , with: event)
            
        }
    }
    
    @IBAction func save(_ sender: Any) {
        
   
        if yesCheck.isSelected == false && noCheck.isSelected == false
        {
            ModalController.showNegativeCustomAlertWith(title: "Please select atleast one option", msg: "")
            return
        }
        if yesCheck.isSelected
        {
            if !txtField.text!.containArabicNumber
            {
                ModalController.showNegativeCustomAlertWith(title: "Should not accept Arbic Number", msg: "")
                return
            }
            
            if txtField.text?.count ?? 0 > 0
            {
                
                let txt = self.txtField.text!
                let mobilNoo = txt.replacingOccurrences(of: " ", with: "")
                if self.pfurl == nil
                {
                    ModalController.showNegativeCustomAlertWith(title: "vat certificate is mandatory", msg: "")
                    return
                }
                
                
                if mobilNoo.count != vatlength{
                    ModalController.showNegativeCustomAlertWith(title: "VAT number should be \(vatlength) digits", msg: "")
                    return
                }
                
                
                
                if txtField.text != ""{
                    self.dismiss(animated: true)
                    self.delegate?.save(Str: pfurl!.absoluteString, vat: txtField.text!)
                    return
                    
                }
                
                
                //                ModalClass.startLoading(self.view)
                //                    self.branch.isproduct = true
                //                    self.branch.vatnumber = mobilNoo
                //                    self.branch.pfurl = self.pfurl
                //                    self.branch.uploadPdfImage { (success, response) in
                //                                         ModalClass.stopLoading()
                //
                //                                         if success
                //                                         {
                //                                self.uploaddoc = response
                //                                            ModalController.showSuccessCustomAlertWith(title: self.uploaddoc?.error_description ?? "", msg: "")
                //                         self.dismiss(animated: true, completion: nil)
                //                                         }
                //                                     }
            }
            else
            {
                ModalController.showNegativeCustomAlertWith(title: "Vat number is mandatory", msg: "")
                return
            }
            
        }
            
            
        else
        {
            self.dismiss(animated: true) {
                self.delegate?.cancel()
            }
        }
        
    }
    @IBAction func yesChkBox(_ sender: Any) {
        closeBtn.isHidden = (pfurl != nil ? false:true)
        if yesCheck.isSelected == true {
            yesCheck.isSelected  = false
            noCheck.isSelected  = true
            txtField.isHidden = true
            imgheight.constant = 0
            vatcertificate.isHidden = true
            add.isHidden = true
            addlbl.isHidden = true
            topconst.constant = -30
            vwheight.constant = 250
            innervwheight.constant = 120
          
        }
        else {
            yesCheck.isSelected  = true
            noCheck.isSelected  = false
            txtField.isHidden = false
            imgheight.constant = 135
            vatcertificate.isHidden = false
            add.isHidden = false
            addlbl.isHidden = false
            topconst.constant = 15
            vwheight.constant = 422
            innervwheight.constant = 300
        }
        
//        saveBtn.layer.borderColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1).cgColor
//        saveBtn.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
    }
    
    @IBAction func noChkbox(_ sender: Any) {
        pfurl = nil
        img.image = UIImage(named: "dottedrectangle")
        txtField.text = ""
        if noCheck.isSelected == true {
            noCheck.isSelected  = false
            yesCheck.isSelected = true
            txtField.isHidden = true
            closeBtn.isHidden = false
        }
        else {
            closeBtn.isHidden = true
            noCheck.isSelected  = true
            yesCheck.isSelected = false
            txtField.isHidden = true
            imgheight.constant = 0
            vatcertificate.isHidden = true
            add.isHidden = true
            addlbl.isHidden = true
            topconst.constant = -30
            vwheight.constant = 250
            innervwheight.constant = 120
        }
        saveBtn.layer.borderColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1).cgColor
        saveBtn.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
        
    }
    
    
    @IBAction func cross(_ sender: Any) {
        addlbl.isHidden = false
        add.isHidden = false
        closeBtn.isHidden = true
        img.image = UIImage(named: "dottedrectangle")
        pfurl = nil
    }
    @IBAction func uploadimage(_ sender: Any)
    {
        let importMenu = UIDocumentPickerViewController(documentTypes: ["com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document", kUTTypePDF as String], in: UIDocumentPickerMode.import)
        
        if #available(iOS 11.0, *) {
            importMenu.allowsMultipleSelection = true
        }
        
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        
        present(importMenu, animated: true)
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
}
extension VatpopnewchangeViewController:UIDocumentPickerDelegate
{
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
     
     
     func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
       pfurl = urls.first
         let siz = fileSize(forURL:  urls.first!)
        
         print(".......\(siz)")
        if siz > self.filesize
         {
             ModalController.showNegativeCustomAlertWith(title: "Image Size is large", msg: "")
             return
         }
        addlbl.isHidden = true
        add.isHidden = true
        closeBtn.isHidden = false
        img.image = pdfThumbnail(url: pfurl!)
         if self.txtField.text!.count > 0 && pfurl != nil
         {
                     saveBtn.layer.borderColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1).cgColor
                     saveBtn.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
         }
     }
     
     func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
         controller.dismiss(animated: true, completion: nil)
     }
    
//    func gallery(img: UIImage, imgtype: String) {
//        if imgtype == "doc"
//        {
//            docimg = img
//            self.img.image = docimg!
//            addlbl.isHidden = true
//            add.isHidden = true
//              closeBtn.isHidden = false
//        }
//        else{
//            galimg = img
//             self.img.image = galimg!
//            addlbl.isHidden = true
//            add.isHidden = true
//              closeBtn.isHidden = false
//        }
   
    
    func information(Value: String) {
        
    }
    
    
    func filterIdval(tag: Int, Value: String, id: Int) {
        
    }
    
    
}
