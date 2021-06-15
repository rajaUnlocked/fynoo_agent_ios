    //
    //  CreateBranchFirstStepViewController.swift
    //  Fynoo Business
    //
    //  Created by Aishwarya Gupta on 16/07/19.
    //  Copyright © 2019 Sendan. All rights reserved.
    //
    
    import UIKit
    import AVKit
    import Photos
    import GoogleMaps
    import MTPopup
    import BSImagePicker
    class CreateBranchFirstStepViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,LogoTableViewCellDelegate,OpenGalleryDelegate, businessTypeDelegate1,SearchCategoryViewControllerDelegate{
      func selectedCountryCodeMethod(mobileCodeDict: NSMutableDictionary) {
         print("")
      }
      
      func selectPhoneCodeMethod(phoneCodeDict: NSMutableDictionary) {
         print("")
      }
      
      func selectetBranchMethod(BranchDict: NSMutableDictionary) {
         print("")
      }
      
       
        
        @IBOutlet weak var backNewOutlet: UIButton!
      var serviceid = ""
        var isSubcription = false
        var isActive = 0
        var branchlimit = "0"
        var isSpecial = ""
          var images = [UIImage]()
        var SelectedPlatType = NSMutableArray()
        var descriplist:DescriptionValueList?
        var phoneminLength = 0
        var imagetype = ""
        @IBOutlet weak var bgImage: UIImageView!
        var isSave = false
        var selectedCityDict : NSMutableDictionary = NSMutableDictionary()
        var branchCount = 0
          var uploadbranchimg:FynooGalleryUpload?
        var array1:NSMutableDictionary = ["0":[["",""]],"1":[["",""]],"2":[["",""]],"3":[["",""]],
                                          "4":[["",""]],"5":[["",""]],"6":[["",""]]]
        var week = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
        var toparr = NSMutableArray()
        var mobilelength = NSMutableArray()
        var codes = NSMutableArray()
        var conturyFlag = NSMutableArray()
        var SelectedIndex = NSMutableArray()
        var selectedTypeArrays = NSMutableArray()
        var selectedTypeId = NSMutableArray()
        var seletedImg = UIImage()
        var slotCount = 0
        var branch = branchsmodel()
        var addbranch = AddBranchModel()
        var branchlogo:UploadBranchLogo?
        var platformlist:PlatFormType?
        var uploadimg:UploadImage?
         var showimgAllList:ShowImageList?
        var showimgInteriorList:ShowImageList?
        var showimgExteriorList:ShowImageList?
        var showImageList:ShowImageList?
        var displayLbl = ""
        var selectedCountryDict : NSDictionary = NSDictionary()
        var slottArr = NSMutableArray()
        var isFromSubscription:Bool = false
        var numCharCount = 0
        var weekDay:String?
        var isLoc = false
        var isbus = false
         var timing =  [Business_timings]()
        var heightCollectVw = 0
        var headerImgArr = NSMutableArray()
        var headerLblArr = ["Business Details","Business Type","Platform Type","Business Timing","Location","Store Pictures"]
        var ImgArr = ["user","message","mobile","whatsapp","phone"]
        var LblArr = ["  Business / Branch Name","  Email","  Mobile Number","  WhatsApp Number","  Phone Number","  Description"]
        @IBOutlet weak var headervw: NavigationView!
        @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
        @IBOutlet weak var tableVw: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
        
            self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
            self.tableVw.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
            conturyFlag = ["","",""]
            mobilelength = [0,0,0]
            if isFromSubscription == true {
                self.headervw.backButton.isHidden = true
                self.backNewOutlet.isHidden = false
            }
            
            DescriprionLengthAPI()
            countryAPI()
            
            bgImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
            
            self.headervw.titleHeader.text = "Create Branch".localized;
            self.headervw.viewControl = self
            registerNib()
            allimageGallery(imageType: "Interior")
            allimageGallery(imageType: "Exterior")
            allimageGallery(imageType: "")
            // SelectedIndex = AddBranch.shared.platformType
            selectedTypeArrays = AddBranch.shared.BussName
            selectedTypeId = AddBranch.shared.BType
            
            if AddBranch.shared.BranchId == ""
            {
                headerImgArr = ["edit_feature","btype","ptype","btime","loc","cameras-1"]
                let userid:UserData = AuthorisedUser.shared.getAuthorisedUser()
                AddBranch.shared.mail = "\(userid.data!.email)"
                AddBranch.shared.mobileCode = "\(userid.data!.mobile_code)"
                AddBranch.shared.MobileNo = "\(userid.data!.mobile_number)"
                
                tableVw.reloadData()
            }
            else
            {
                headerImgArr = ["edit_feature","btype_green","ptype_green","btime_green","loc_green","cam_green"]
            }
            codes = [AddBranch.shared.mobileCode,AddBranch.shared.whatsappCode,AddBranch.shared.phoneCode]
            toparr = [AddBranch.shared.bName,AddBranch.shared.mail,AddBranch.shared.MobileNo,AddBranch.shared.whatsappNumber,AddBranch.shared.Phone,AddBranch.shared.Descrip]
            let mobilNoo = AddBranch.shared.MobileNo.replacingOccurrences(of: " ", with: "")
            let value = ModalController.customStringFormatting(of: mobilNoo)
            toparr[2] = value
            let mobilNoo1 = AddBranch.shared.whatsappNumber.replacingOccurrences(of: " ", with: "")
            let value1 = ModalController.customStringFormatting(of: mobilNoo1)
            toparr[3] = value1
            let mobilNoo2 = AddBranch.shared.Phone.replacingOccurrences(of: " ", with: "")
            let value2 = ModalController.customStringFormatting(of: mobilNoo2)
            toparr[4] = value2
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.locale = NSLocale(localeIdentifier: "EN") as Locale
            weekDay = dateFormatter.string(from: Date())
            
            ModalClass.startLoading(self.view)
            branch.platformlist { (success, response) in
                ModalClass.stopLoading()
                if success
                {
                    self.platformlist = response
                    
                    self.tableVw.reloadData()
                }
            }
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            if isFromSubscription {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            }
        }
        
        @IBAction func backNewBtn(_ sender: Any) {
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//           let vc = appDelegate.createTabBarMethod()
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
        }
        
        
        func DescriprionLengthAPI()
        {
            
            branch.description { (success, response) in
                ModalClass.stopLoading()
                if success
                {
                    self.descriplist = response
                    self.tableVw.reloadData()
                }
                
            }
        }
        func contentborder(vw:UIView)
        {
            vw.addBorder(.left, color: UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1), thickness: 0.5)
            vw.addBorder(.right, color: UIColor.init(red: 178/255, green: 178/255, blue: 178/255, alpha: 1), thickness: 0.5)
        }
        func countryAPI()
        {
            //   ModalClass.startLoading(self.view)
            let device_id = UIDevice.current.identifierForVendor!.uuidString
            let str = "\(Constant.BASE_URL)\(Constant.Country_List)"
            let parameters = [
                "device_id": "\(device_id)",
                "device_type": "ios",
                "lang_code":HeaderHeightSingleton.shared.LanguageSelected
            ]
            print("request -",parameters)
            ServerCalls.postRequest(str, withParameters: parameters) { (response, success, resp) in
                ModalClass.stopLoading()
                if success == true {
                    let ResponseDict : NSDictionary = (response as? NSDictionary)!
                    print("ResponseDictionary %@",ResponseDict)
                    let x = ResponseDict.object(forKey: "error") as! Bool
                    if x {
                        ModalController.showNegativeCustomAlertWith(title:(ResponseDict.object(forKey: "msg") as? String)!, msg: "")
                    }
                    else{
                        let results = ResponseDict.object(forKey: "data") as! NSArray
                        if results.count > 0
                        {
                            for var i in 0...2{
                                
                                for var j in (0..<results.count)
                                {
                                    let dict1 : NSDictionary = NSDictionary(dictionary: results.object(at: j) as! NSDictionary).RemoveNullValueFromDic()
                                    if dict1.value(forKey: "mobile_code") as? String == self.codes[i] as? String
                                    {
                                        
                                        self.conturyFlag[i] = dict1.value(forKey: "country_flag") as? String ?? ""
                                        self.mobilelength[i] = dict1.value(forKey: "mobile_length") as? Int ?? 0
                                        if i == 2
                                        {
                                           self.mobilelength[i] = dict1.value(forKey: "phone_max_length") as? Int ?? 0
                                            self.phoneminLength = dict1.value(forKey: "phone_min_length") as? Int ?? 0
                                        }
                                        
                                    }
                                }
                            
                            }
                            self.tableVw.reloadData()
                        }
                        
                    }
                }else{
                    if response == nil
                    {
                        print ("connection error")
                        ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                    }else{
                        print ("data not in proper json")
                    }
                }
            }
        }
        
        
        func allimageGallery(imageType:String)
        {
            branch.imageType = imageType
            branch.showGallery { (success, response) in
                ModalClass.stopLoading()
                if success
                {
                    self.showimgAllList = response
                    if imageType == "Interior"
                    {
                        self.showimgInteriorList = response
                    }
                    else  if imageType == "Exterior"
                    {
                        self.showimgExteriorList = response
                    }
                    else
                    {
                        self.showImageList = response
                        AddBranch.shared.showImgId.removeAllObjects()
                        if self.showImageList?.data?.images_list?.count ?? 0 > 0
                        {
                            for i in 0...((self.showImageList?.data?.images_list?.count)! - 1)
                            {
                                AddBranch.shared.showImgId.add((self.showImageList?.data?.images_list?[i].id)!)
                            }
                        }
                        if AddBranch.shared.showImgId.count > 0
                        {
                            self.headerImgArr[5] = "cam_green"
                        }
                        self.mandatoryCheck()
                    }
                    
                    self.tableVw.reloadData()
                }
                
            }
            
        }
        func mandatoryCheck()
        {
            let br = AddBranch.shared
               if AddBranch.shared.platformType.contains(48)
               {
            if br.bName.count > 0 && br.mail.count > 0 && br.mobileCode.count > 0 && br.MobileNo.count > 0 && br.Descrip.count > 0 && br.BType.count > 0 && br.platformType.count > 0 && br.location.count > 0 && br.branchImgUrl.count > 0 && br.branchLogoId.count > 0 && AddBranch.shared.showImgId.count > 0
            {
                self.headerImgArr[0] = "section_filled.png"
                isSave = true
            }
                else
            {
                self.headerImgArr[0] = "edit_feature"
                              isSave = false
                }
               }
                  else if AddBranch.shared.platformType.contains(47)
               {
               if br.bName.count > 0 && br.mail.count > 0 && br.mobileCode.count > 0 && br.MobileNo.count > 0 && br.Descrip.count > 0 && br.BType.count > 0 && br.platformType.count > 0  && br.branchImgUrl.count > 0 && br.branchLogoId.count > 0 && AddBranch.shared.showImgId.count > 0
               {
                   self.headerImgArr[0] = "section_filled.png"
                   isSave = true
               }
                else
                        {
                            self.headerImgArr[0] = "edit_feature"
                                          isSave = false
                            }
                  }
            else
            {
                self.headerImgArr[0] = "edit_feature"
                isSave = false
            }
            self.tableVw.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
            self.tableVw.reloadSections(IndexSet(integer: 6), with: .none)
        }
        func selectedCityMethod(cityDict: NSMutableDictionary) {
            print("")
        }
        
        func selectedEducationMethod(educationDict: NSMutableDictionary) {
            print("")
        }
        
        func selectedMajorEducationMethod(educationDict: NSMutableDictionary) {
            print("")
        }
        
        func selectedCurrency(currency: NSMutableDictionary) {
            print("")
        }
        
        func selectedBankMethod(bankDict: NSMutableDictionary) {
            print("")
        }
        func selectetCourierCompanyMethod(courierCompanyDict: NSMutableDictionary) {
            
        }
        func selectedCategoryMethod(countryDict: NSMutableDictionary,tag:Int) {
            
            if self.selectedCountryDict != countryDict {
                self.selectedCityDict.removeAllObjects()
                
            }
            self.selectedCountryDict = countryDict
            
            if let name = self.selectedCountryDict.object(forKey: "country_flag") as? String{
                conturyFlag[tag] = name
                
                
            }
            
            if let name = self.selectedCountryDict.object(forKey: "mobile_code") as? String{
                codes[tag] = name
                if tag == 0
                {
                    AddBranch.shared.mobileCode = codes[tag] as! String
                }
                else if tag == 1
                {
                    AddBranch.shared.whatsappCode = codes[tag] as! String
                }
                else
                {
                    AddBranch.shared.phoneCode = codes[tag] as! String
                }
                
            }
            if let name = self.selectedCountryDict.object(forKey: "mobile_length") as? Int{
                mobilelength[tag] = name
                if tag == 2
                {
                  mobilelength[tag] =  self.selectedCountryDict.object(forKey: "phone_max_length") as! Int
                    self.phoneminLength = self.selectedCountryDict.object(forKey: "phone_min_length") as! Int
                }
               
            }
            tableVw.reloadData()
            
        }
        func businessTypeName(name: NSMutableArray, id: NSMutableArray) {
            selectedTypeArrays = name
            selectedTypeId = id
            AddBranch.shared.BType = id
            tableVw.reloadSections(IndexSet(integer: 1), with: .none)
        }
        func registerNib()
        {
            
            tableVw.register(UINib(nibName: "topBranchTableViewCell", bundle: nil), forCellReuseIdentifier: "topBranchTableViewCell");
            tableVw.register(UINib(nibName: "BusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessTableViewCell");
            tableVw.register(UINib(nibName: "LogoTableViewCell", bundle: nil), forCellReuseIdentifier: "LogoTableViewCell");
            tableVw.register(UINib(nibName: "PhoneNumberTableViewCell", bundle: nil), forCellReuseIdentifier: "PhoneNumberTableViewCell");
            tableVw.register(UINib(nibName: "HeaderBranchTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderBranchTableViewCell");
            tableVw.register(UINib(nibName: "CollectionViewTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionViewTableViewCell");
            tableVw.register(UINib(nibName: "BranchTimingTableViewCell", bundle: nil), forCellReuseIdentifier: "BranchTimingTableViewCell")
            tableVw.register(UINib(nibName: "ViewLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewLocationTableViewCell")
            tableVw.register(UINib(nibName: "nextTableViewCell", bundle: nil), forCellReuseIdentifier: "nextTableViewCell")
            tableVw.register(UINib(nibName: "CountingTableViewCell", bundle: nil), forCellReuseIdentifier: "CountingTableViewCell")
            
        }
        func numberOfSections(in tableView: UITableView) -> Int {
            return 7
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch section {
            case 0:
                return 10
            case 2:
                return (platformlist?.data?.platform_type?.count ?? 0) + 1
            case 3:
                
                if isbus
                {
                    return slottArr.count == 0 ? 2 : slottArr.count + 1
                }
                else
                {
                    
                    return 2
                    
                    
                    
                }
                
            case 4:
                if AddBranch.shared.platformType.contains(48)
                                   {
                                     if isLoc
                                                     {
                                                         return 3
                                                     }
                                                     else
                                                     {
                                                         return 2
                                                     }
                                   }
                return 0
               
                
            case 5:
                
                return 7
               
            case 6:
                return 1
            default:
                return 2
            }
            
            
        }
        
        @objc func saveClick(_ sender:UIButton)
        {
            let mobilNo = AddBranch.shared.MobileNo.replacingOccurrences(of: " ", with: "")
            AddBranch.shared.MobileNo = mobilNo
            let mobilNo1 = AddBranch.shared.whatsappNumber.replacingOccurrences(of: " ", with: "")
            AddBranch.shared.whatsappNumber = mobilNo1
            let mobilNo2 = AddBranch.shared.Phone.replacingOccurrences(of: " ", with: "")
            AddBranch.shared.Phone = mobilNo2
            
            if sender.tag == 0
            {
                if isFromSubscription == true {
//                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                    let vc = appDelegate.createTabBarMethod()
//                    vc.modalPresentationStyle = .fullScreen
//                    self.present(vc, animated: true, completion: nil)
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
            }
                
                
            else
            {
                let br = AddBranch.shared
                //   br.platformType = SelectedIndex
                if br.branchImgUrl.count == 0
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please upload branch logo".localized, msg: "" )
                    return
                }
                if br.bName.count == 0
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please enter branch name".localized, msg: "" )
                    return
                }
                if br.bName.count > 0
                {
                    if !br.bName.containArabicNumber
                                    {
                    ModalController.showNegativeCustomAlertWith(title: "Branch Name Should not accept Arbic Number", msg: "" )
                                                                          return
                                    }
                               
                    if br.bName.first!.isWhitespace ||  br.bName.count > 70
                    {
                        ModalController.showNegativeCustomAlertWith(title: "Please Enter Valid Branch Name", msg: "" )
                        return
                    }
                    
                }
                if br.mail.count == 0
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please Enter Mail", msg: "" )
                    return
                }
                if br.mail.count > 0
                {
                    if br.mail.isArabic
                                                      {
                            ModalController.showNegativeCustomAlertWith(title: "Mail Should not accept Arbic Char", msg: "" )
                                                      }
                    let name = ModalController.isValidEmail(testStr:br.mail)
                    if !name{
                        ModalController.showNegativeCustomAlertWith(title: "Please Enter Valid Email", msg: "" )
                        return
                    }
                    
                    
                }
                if br.MobileNo.count == 0
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please Enter Mobile Number", msg: "" )
                    return
                }
                if br.mobileCode.count > 0
                {
                    if !br.MobileNo.containArabicNumber
                                                       {
                                       ModalController.showNegativeCustomAlertWith(title: "Mobile Number Should not accept Arbic Number", msg: "" )
                                                                                             return
                                                       }
                    if br.MobileNo.count != mobilelength[0] as! Int
                    {
                        ModalController.showNegativeCustomAlertWith(title: "Please Enter Valid Mobile Number", msg: "" )
                        return
                    }
                    
                    
                    
                }
                
                
                
                if br.whatsappCode.count > 0
                {
                    if br.whatsappNumber.count == 0
                    {
                        
                    }
                    else
                    {
                        if !br.whatsappNumber.containArabicNumber
                                                           {
                                           ModalController.showNegativeCustomAlertWith(title: "WhatsApp Number Should not accept Arbic Number", msg: "" )
                                                                                                 return
                                                           }
                        if br.whatsappNumber.count != mobilelength[1] as! Int
                        {
                            ModalController.showNegativeCustomAlertWith(title: "Please Enter Valid WhatsApp Number", msg: "" )
                            return
                        }
                        
                    }
                    
                    
                    
                }
                if br.phoneCode.count > 0
                {
                    if br.Phone.count == 0
                    {
                        
                    }
                    else
                    {
                        if !br.Phone.containArabicNumber
                                                           {
                                           ModalController.showNegativeCustomAlertWith(title: "Phone Number Should not accept Arbic Number", msg: "" )
                                                                                                 return
                                                           }
                        if br.Phone.count != mobilelength[2] as! Int &&  br.Phone.count != phoneminLength
                        {
                            ModalController.showNegativeCustomAlertWith(title: "Please Enter Valid Phone Number", msg: "" )
                            return
                        }
                        
                    }
                    
                    
                    
                }
                if br.Descrip.count == 0
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please add description".localized, msg: "" )
                    return
                }
                if br.Descrip.count > 0
                               {
                                   if !br.Descrip.containArabicNumber
                                                                                             {
                                                                             ModalController.showNegativeCustomAlertWith(title: "Description Should not accept Arbic Number", msg: "" )
                                                                                                                                   return
                                                                                             }
                               }
                if br.BType.count == 0
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please select business type".localized, msg: "" )
                    return
                }
                if br.platformType.count == 0
                {
                    ModalController.showNegativeCustomAlertWith(title: "Please select platform type".localized, msg: "" )
                    return
                }
                if br.BTimeDict.count == 0
                                                                   {
                            ModalController.showNegativeCustomAlertWith(title: "Please select business timing".localized, msg: "" )
                                                return
                                                                   }
                if br.showImgId.count == 0
                                                                   {
                                                                    ModalController.showNegativeCustomAlertWith(title: "Please add store pictures".localized, msg: "" )
                                                                       return
                                                                   }
                if br.video_url.count > 0
                                                        {
                                             if br.video_url.isArabic
                                                                                 {
                              ModalController.showNegativeCustomAlertWith(title: "Enter valid link".localized, msg: "" )
                                                                                                                                                            return
                                                                                                                      }
                                                            if !br.video_url.isValidURL()
                                                                                                                                         {
                                                                                                                                            ModalController.showNegativeCustomAlertWith(title: "Enter valid link".localized, msg: "" )
                                                                                                                                                                                                                    return
                                                                                                                                                                              }
                                                        }
                if AddBranch.shared.platformType.contains(48)
                                  {
                                    
                                                    if br.location.count == 0
                                                    {
                                                        ModalController.showNegativeCustomAlertWith(title: "Please select address".localized, msg: "" )
                                                        return
                                                    }
                                                   
                                                 
                                  }
                else
                {
                    br.lat = 0.0
                    br.long = 0.0
                    br.location = ""
                }
               
              
                    ModalClass.startLoading(self.view)
                addbranch.serviceId = serviceid
                    addbranch.getBranch { (success, response) in
                        ModalClass.stopLoading()
                        if success
                        {
                            
                            let value = response!
                            if value.value(forKey: "error") as! Int == 0
                            {
                                ModalController.showSuccessCustomAlertWith(title: "Success", msg: value.value(forKey: "error_description") as! String)
                                
                                if self.isFromSubscription == true {
//                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                                   let vc = appDelegate.createTabBarMethod()
//                                    vc.modalPresentationStyle = .fullScreen
//                                    self.present(vc, animated: true, completion: nil)
                                }
                                else{
                                    
                                    AddBranch.shared.BranchId = "0"; self.navigationController?.popViewController(animated: true)
                                }
                            }
                            else
                            {
                                ModalController.showSuccessCustomAlertWith(title: value.value(forKey: "error_description") as! String, msg:"" )
                            }
                            
                        }
                        
                    }
                
                
            }
            
        }
        @objc func checkmain()
        {
            if branchlimit == "1"
            {
                 let vc = DeliveryPopupViewController(nibName: "DeliveryPopupViewController", bundle: nil)
                 vc.activateHandler = { result in
                     if result == "true"{
                        AddBranch.shared.isSpecial = "1"
                        AddBranch.shared.ismain = !AddBranch.shared.ismain
                        self.tableVw.reloadSections(IndexSet(integer: 0), with: .none)
                     }else{
                        AddBranch.shared.isSpecial = ""
                     }
                 }
                 vc.modalPresentationStyle = .overFullScreen
                 vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                 self.present(vc, animated: true, completion: nil)
                
             }
            else
            {
            if AddBranch.shared.BranchId.count > 0
            {
                if isSubcription && isActive == 1
                          {
                          AddBranch.shared.ismain = !AddBranch.shared.ismain
                          self.tableVw.reloadSections(IndexSet(integer: 0), with: .none)
                          }
                else
                          {
                              ModalController.showNegativeCustomAlertWith(title: "This cannot be main branch as status is deactivated", msg: "")
                          }
            }
          else
            {
                if isSubcription
                    {
                    AddBranch.shared.ismain = !AddBranch.shared.ismain
                    self.tableVw.reloadSections(IndexSet(integer: 0), with: .none)
                    }
            else
            {
                ModalController.showNegativeCustomAlertWith(title: "This cannot be main branch as limit is over and this branch will be saved with deactivate status", msg: "")
            }
          
        }
            }
           
        }
        @objc func clickdown(_ sender:UIButton)
        {
            if sender.tag == 3
            {
                isbus = !isbus
                tableVw.reloadSections(IndexSet(integer: 3), with: .none)
            }
            else
            {
                isLoc = !isLoc
                tableVw.reloadSections(IndexSet(integer: 4), with: .none)
            }
            
        }
        
         @objc func crossClicked(_ sender : UIButton){
            if sender.tag == 6
            {
                AddBranch.shared.whatsappCode = ""
                AddBranch.shared.whatsappNumber = ""
                self.conturyFlag[1] = ""
                codes[1] = ""
                toparr[3] = ""
            }
            else
            {
             AddBranch.shared.phoneCode = ""
                AddBranch.shared.Phone = ""
                self.conturyFlag[2] = ""
                codes[2] = ""
                toparr[4] = ""
            }
            self.tableVw.reloadSections(IndexSet(integer: 0), with: .none)
        }
        @objc func countryClicked(_ sender : UIButton){
            
            let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
            vc.delegate = self
            
            vc.isForCountry = true
            vc.isForCity = false
            vc.tag = sender.tag
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.section {
                
            case 0:
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "topBranchTableViewCell", for: indexPath) as!
                    topBranchTableViewCell
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as!
                    HeaderBranchTableViewCell
                    cell.btnclick.isHidden = true
                    cell.isUserInteractionEnabled = true
                    cell.rightarrow.isHidden = true
                    let image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"DownArror_new")!)
                    
                    cell.rightarrow.setImage(image, for: .normal)
                    
                    cell.rgtlbl.isHidden = true
                    cell.btn.setImage(UIImage(named: headerImgArr[indexPath.section] as! String), for: .normal)
                    cell.lbl.text = headerLblArr[indexPath.section].localized
                    cell.innerView.layer.borderWidth = 0
                    cell.innerView.layer.cornerRadius = 0
                    cell.trailingConstant.constant = -0.5
                    cell.leadingConstant.constant = -0.5
                    cell.btn.isEnabled = false
                    cell.bottomConst.constant = 0
                    cell.innerView.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
                    return cell
                case 2:
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "LogoTableViewCell", for: indexPath) as! LogoTableViewCell
                    cell.delegate = self
                    contentborder(vw: cell.contentView)
                    
                    cell.addphotoutlet.sd_setImage(with: URL(string:AddBranch.shared.branchImgUrl), placeholderImage: UIImage(named: "branchlogo"))
                    
                    if branchCount == 0
                    {
                        cell.checkMain.isSelected = true
                        cell.checkMain.isUserInteractionEnabled = false
                    }
                    else
                    {
                        cell.checkMain.isUserInteractionEnabled = true
                        if AddBranch.shared.ismain
                        {
                            cell.checkMain.isSelected = true
                        }
                        else
                        {
                            cell.checkMain.isSelected = false
                        }
                    }
                    
                    cell.checkMain.addTarget(self, action: #selector(checkmain), for: .touchUpInside)
                    return cell
                case 3,4,8:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as!
                    BusinessTableViewCell
                    cell.ocrtrailing.constant = 10
                    cell.bordertxt.backgroundColor = .white
                    
                    cell.widthconst.constant = 0
                    if indexPath.row == 4
                    {
                        cell.nameTextField.textAlignment = .left
                        
                    }
                    cell.isUserInteractionEnabled = true
                   if "\(toparr[indexPath.row - 3])".count > 0
                                              {
                                                  if !"\(toparr[indexPath.row - 3])".containArabicNumber
                                                                              {
                                         cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                                                              }
                                                                          else
                                                                          {
                                                                  cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                                                }
                                              }
                                              else
                                              {
                                       cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor                }
                                 
                    contentborder(vw: cell.outerVw)
                    cell.downarrow.isHidden = true
                    cell.nameTextField.tag = indexPath.row
                    cell.nameTextField.text = toparr[indexPath.row - 3] as? String
                    cell.nameTextField.delegate = self
                    cell.nameTextField.addTarget(self, action: #selector(CreateBranchFirstStepViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                    
                    if  indexPath.row == 8
                    {
                        
                        cell.txtView.delegate = self
                        cell.txtView.isHidden = false
                        cell.nameTextField.isHidden = true
                        cell.lblk.text = LblArr[indexPath.row - 3].localized
                        cell.txtView.tag = 100
                        cell.txtView.text = AddBranch.shared.Descrip
                        if "\(toparr[indexPath.row - 3])".count > 0
                                                                     {
                                                                         if !"\(toparr[indexPath.row - 3])".containArabicNumber
                                                                                                     {
                                                                cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                                                                                     }
                                                                                                 else
                                                                                                 {
                                                                                         cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                                                                       }
                                                                     }
                                                                     else
                                                                     {
                                                              cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor                }
                    }
                        
                    else
                    {
                        cell.txtView.tag = indexPath.row
                        cell.txtView.isHidden = true
                        cell.nameTextField.isHidden = false
                        cell.lblk.text = LblArr[indexPath.row - 3].localized
                        cell.img.image = UIImage(named: ImgArr[indexPath.row - 3])
                        
                    }
                    
                    
                    return cell
                case 9:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CountingTableViewCell", for: indexPath) as! CountingTableViewCell
                    contentborder(vw: cell.vw)
                    cell.vw.layer.cornerRadius = 0
                    cell.bottomConst.constant = -4
                    cell.counlbl.text = "\(AddBranch.shared.Descrip.count) / \(self.descriplist?.data?.br_limit_list?[0].value ?? 0)"
                    cell.counlbl.textColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1)
                    if AddBranch.shared.Descrip.count == self.descriplist?.data?.br_limit_list?[0].value ?? 0
                    {
                        cell.counlbl.textColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
                        
                    }
                    return cell
                    
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneNumberTableViewCell", for: indexPath) as!
                    PhoneNumberTableViewCell
                    cell.rotatevw.semanticContentAttribute = .forceLeftToRight
                    cell.phoneNumberTextField.keyboardType = .asciiCapableNumberPad
                    contentborder(vw: cell.contentView)
                                  cell.phoneNumberTextField.tag = indexPath.row
                    cell.phoneNumberTextField.textAlignment = .left
                                  cell.phoneNumberTextField.delegate = self
                                  cell.phoneNumberTextField.addTarget(self, action: #selector(CreateBranchFirstStepViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
                                  cell.phoneNumberTextField.text = toparr[indexPath.row - 3] as? String
                                  cell.phoneCode.text = codes[indexPath.row - 5] as? String
                                  cell.downarrow.tag = indexPath.row - 5
                                  cell.downarrow.addTarget(self, action: #selector(countryClicked(_:)), for: .touchUpInside)
                     cell.cross.isHidden = true
                    if (codes[indexPath.row - 5] as! String).count > 0
                    {
                        cell.cross.isHidden = false
                    }
                    cell.cross.tag = indexPath.row
                    cell.cross.addTarget(self, action: #selector(crossClicked(_:)), for: .touchUpInside)
                                  cell.flag.setImageSDWebImage(imgURL:conturyFlag[indexPath.row - 5] as! String, placeholder: "category")
                                  cell.toplbl.text = LblArr[indexPath.row - 3].localized
                                  cell.img.image = UIImage(named: ImgArr[indexPath.row - 3])
                    if indexPath.row == 5
                    {
                        cell.cross.isHidden = true
                if "\(toparr[indexPath.row - 3])".replacingOccurrences(of: " ", with: "").count  == mobilelength[0] as! Int
                            {
                                if !"\(toparr[indexPath.row - 3])".containArabicNumber
                                                            {
                                        cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                                            }
                                                        else
                                                        {
                                                cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                              }
                            }
                            else
                            {
                     cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor                }
               
                    }
              
                
                    
                    
                    return cell
                }
            case 1:
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as!
                    HeaderBranchTableViewCell
                    cell.isUserInteractionEnabled = true
                    cell.btnclick.isHidden = true
                    contentborder(vw: cell.contentView)
                    let image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"DownArror_new")!)
                    
                    cell.rightarrow.setImage(image, for: .normal)
                    cell.innerView.layer.cornerRadius = 10
                    cell.innerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                    cell.rgtlbl.isHidden = true
                    cell.rightarrow.isHidden = false
                    cell.btn.setImage(UIImage(named: headerImgArr[indexPath.section] as! String), for: .normal)
                    cell.lbl.text = headerLblArr[indexPath.section].localized
                    cell.innerView.layer.borderWidth = 0
                    cell.trailingConstant.constant = 10
                    cell.leadingConstant.constant = 10
                    cell.bottomConst.constant = 3
                    cell.btn.isEnabled = false
                    
                    cell.innerView.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
                    
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell", for: indexPath) as!
                    CollectionViewTableViewCell
                    cell.isUserInteractionEnabled = true
                    contentborder(vw: cell.contentView)
                    cell.delegate = self
                    cell.topConst.constant = 0
                    cell.isType = true
                    cell.SelectedName = selectedTypeArrays
                    cell.SelectedId = selectedTypeId
                    cell.collectionVIEW.isScrollEnabled = false
                    if let flowLayout =  cell.collectionVIEW.collectionViewLayout as? UICollectionViewFlowLayout {
                        flowLayout.scrollDirection = .vertical
                    }
                    cell.collectionVIEW.reloadData()
                    return cell
                }
            case 2:
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as!
                    HeaderBranchTableViewCell
                    cell.btnclick.isHidden = true
                    cell.isUserInteractionEnabled = true
                    contentborder(vw: cell.contentView)
                    cell.innerView.layer.cornerRadius = 10
                    cell.innerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                    cell.rgtlbl.isHidden = true
                    cell.rightarrow.isHidden = true
                    cell.bottomConst.constant = 3
                    cell.innerView.layer.borderWidth = 0
                    cell.btn.setImage(UIImage(named: headerImgArr[indexPath.section] as! String), for: .normal)
                    cell.lbl.text = headerLblArr[indexPath.section].localized
                    cell.innerView.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
                    cell.trailingConstant.constant = 10
                    cell.leadingConstant.constant = 10
                    
                    cell.btn.isEnabled = false
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as! HeaderBranchTableViewCell
                    cell.isUserInteractionEnabled = true
                    
                    contentborder(vw: cell.contentView)
                    let image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"DownArror_new")!)
                    cell.trailingConstant.constant = 10
                    cell.leadingConstant.constant = 10
                    cell.rightarrow.setImage(image, for: .normal)
                    contentborder(vw: cell.contentView)
                    cell.innerView.layer.cornerRadius = 0
                    cell.rightarrow.isHidden = true
                    cell.rgtlbl.isHidden = true
                    cell.btn.isEnabled = false
                    cell.lbl.text = platformlist?.data?.platform_type?[indexPath.row - 1].value ?? ""
                    cell.innerView.backgroundColor = .white
                    cell.topConst.constant = 0
                    cell.bottomConst.constant = -1
                    cell.innerView.layer.borderWidth = 0.5
                    
                    if indexPath.row == platformlist?.data?.platform_type?.count ?? 0
                    {
                        cell.topConst.constant = -1
                        cell.bottomConst.constant = 10
                        
                    }
                    if AddBranch.shared.platformType.contains(platformlist?.data?.platform_type?[indexPath.row - 1].id ?? 0)
                    {
                        
                        cell.btn.setImage(UIImage(named: "check"), for: .normal)
                    }
                    else
                    {
                        cell.btn.setImage(UIImage(named:"uncheck"), for: .normal)
                    }
                    return cell
                }
            case 3:
                
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as!
                    HeaderBranchTableViewCell
                    cell.btnclick.isHidden = true
                    cell.isUserInteractionEnabled = false
                    if AddBranch.shared.platformType.contains(48)
                    {
                        cell.isUserInteractionEnabled = true
                    }
                    contentborder(vw: cell.contentView)
                    cell.innerView.layer.cornerRadius = 10
                    cell.innerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                    cell.rgtlbl.isHidden = true
                    let image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"DownArror_new")!)
                    
                    cell.rightarrow.setImage(image, for: .normal)
                    cell.rightarrow.isHidden = false
                    cell.innerView.layer.borderWidth = 0
                    cell.bottomConst.constant = 3
                    cell.btn.setImage(UIImage(named: headerImgArr[indexPath.section] as! String), for: .normal)
                    cell.lbl.text = headerLblArr[indexPath.section].localized
                    cell.trailingConstant.constant = 10
                    cell.leadingConstant.constant = 10
                    cell.btn.isEnabled = false
                    cell.innerView.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BranchTimingTableViewCell", for: indexPath) as! BranchTimingTableViewCell
                    cell.isUserInteractionEnabled = false
                    if HeaderHeightSingleton.shared.LanguageSelected == "AR"
                    {
                        cell.lbl.textAlignment = .right
                    }
                    if AddBranch.shared.platformType.contains(48)
                    {
                        cell.isUserInteractionEnabled = true
                    }
                    contentborder(vw: cell.contentView)
                    cell.rgtlbl.isHidden = false
                    cell.lbl.textColor = ModalController.hexStringToUIColor(hex: "#EC4A53")
                     if slottArr.count == 0
                     {
                       cell.rgtlbl.text = ""
                     }
                    if slottArr.count > 0
                    {
                        cell.rgtlbl.text = slottArr[indexPath.row - 1] as? String
                    }
                    
                    if indexPath.row == 1
                    {
                        
                        if slottArr.count == 0
                        {
                            
                            cell.lbl.text = slotCount > 0 ? " Closed Now".localized: ""
                            
                            if displayLbl.count > 1
                                                        {
                                                            cell.lbl.text = "  \(displayLbl)"
                                                       }
                          
                           
                            if  AddBranch.shared.BTimeDict.count == 0
                            {
                                cell.lbl.text = ""
                                
                            }
                            cell.downbtn.isHidden = true
                        }
                            
                        else if slottArr.count == 1
                        {
                            cell.lbl.text = "   \(displayLbl)"
                            cell.downbtn.isHidden = true
                        }
                        else
                        {
                            cell.lbl.text = "    \(displayLbl)"
                            cell.downbtn.isHidden = false
                        }
                        
                        if isbus
                        {
                            cell.bottomConst.constant  = -1
                            cell.topConst.constant = 0
                        }
                        else
                        {
                            cell.bottomConst.constant  = 10
                            cell.topConst.constant = 0
                        }
                        
                        
                    }
                    else
                    {
                        cell.lbl.text = ""
                        cell.downbtn.isHidden = true
                        cell.bottomConst.constant  = 10
                        cell.topConst.constant = -1
                    }
                    cell.downbtn.tag = indexPath.section
                    cell.downbtn.addTarget(self, action: #selector(clickdown(_:)), for: .touchUpInside)
                    return cell
                }
            case 4:
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as!
                    HeaderBranchTableViewCell
                    cell.btnclick.isHidden = true
                    cell.isUserInteractionEnabled = false
                    if AddBranch.shared.platformType.contains(48)
                    {
                        cell.isUserInteractionEnabled = true
                    }
                    contentborder(vw: cell.contentView)
                    cell.innerView.layer.cornerRadius = 10
                    cell.innerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                    let image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"DownArror_new")!)
                    
                    cell.rightarrow.setImage(image, for: .normal)
                    cell.rgtlbl.isHidden = true
                    cell.rightarrow.isHidden = false
                    cell.innerView.layer.borderWidth = 0
                    cell.bottomConst.constant = 3
                    cell.btn.setImage(UIImage(named: headerImgArr[indexPath.section] as! String), for: .normal)
                    cell.lbl.text = headerLblArr[indexPath.section].localized
                    cell.btn.isEnabled = false
                    cell.trailingConstant.constant = 10
                    cell.leadingConstant.constant = 10
                    cell.innerView.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
                    return cell
                default:
                    if indexPath.row == 1
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "BranchTimingTableViewCell", for: indexPath) as! BranchTimingTableViewCell
                        cell.isUserInteractionEnabled = false
                        if AddBranch.shared.platformType.contains(48)
                        {
                            cell.isUserInteractionEnabled = true
                        }
                        contentborder(vw: cell.contentView)
                        cell.lbl.textColor = ModalController.hexStringToUIColor(hex: "#393939")
                        cell.downbtn.isHidden = false
                        cell.rgtlbl.isHidden = true
                        cell.lbl.text = "\(AddBranch.shared.location)"
                        cell.lbl.numberOfLines = 2
                        if isLoc
                        {
                            cell.bottomConst.constant  = -4
                        }
                        else
                        {
                            cell.bottomConst.constant  = 10
                        }
                        if AddBranch.shared.location == ""
                        {
                            cell.downbtn.isHidden = true
                        }
                        cell.downbtn.tag = indexPath.section
                        cell.downbtn.addTarget(self, action: #selector(clickdown(_:)), for: .touchUpInside)
                        return cell
                    }
                    else
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewLocationTableViewCell", for: indexPath) as! ViewLocationTableViewCell
                        contentborder(vw: cell.contentView)
                        let marker = GMSMarker()
                        
                        let camera = GMSCameraPosition.camera(withLatitude: AddBranch.shared.lat, longitude: AddBranch.shared.long, zoom: 17.0)
                        cell.mapvw.camera = camera
                        marker.position = CLLocationCoordinate2DMake(AddBranch.shared.lat,AddBranch.shared.long)
                        marker.map = cell.mapvw
                        cell.mapvw.isUserInteractionEnabled = false
                        
                        return cell
                    }
                }
            case 5:
                switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as!
                    HeaderBranchTableViewCell
                    cell.btnclick.isHidden = true
                    contentborder(vw: cell.contentView)
                    let image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"DownArror_new")!)
                    
                    cell.rightarrow.setImage(image, for: .normal)
                    contentborder(vw: cell.contentView)
                    cell.innerView.layer.cornerRadius = 10
                    cell.innerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                    cell.bottomConst.constant = 3
                    cell.rightarrow.isHidden = true
                    cell.rgtlbl.isHidden = false
                    cell.rgtlbl.textColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1)
                                  if AddBranch.shared.showImgId.count == (self.descriplist?.data?.branch_img_limit ?? 0)
                                                            {
                                                               cell.rgtlbl.textColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1)
                                                                
                                                            }
                    cell.rgtlbl.text = "\(AddBranch.shared.showImgId.count)/\(self.descriplist?.data?.branch_img_limit ?? 0)"
                    cell.innerView.layer.borderWidth = 0
                    cell.btn.setImage(UIImage(named: headerImgArr[indexPath.section] as! String), for: .normal)
                    cell.lbl.text = headerLblArr[indexPath.section].localized
                    cell.trailingConstant.constant = 10
                    cell.leadingConstant.constant = 10
                    cell.innerView.backgroundColor = UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
                    return cell
                default:
                    if indexPath.row == 1
                    {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as!
                        HeaderBranchTableViewCell
                        
                        contentborder(vw: cell.contentView)
                        cell.innerView.layer.cornerRadius = 0
                        cell.rgtlbl.isHidden = true
                        let image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"DownArror_new")!)
                        
                        cell.rightarrow.setImage(image, for: .normal)
                        cell.rightarrow.isHidden = true
                        cell.bottomConst.constant = 0
                        cell.btn.setImage(UIImage(named:"exterior-1"), for: .normal)
                        cell.lbl.text = "Exterior".localized
                         if AddBranch.shared.platformType.contains(48)
                         {
                         
                        }
                        else
                         {
                         cell.lbl.text = "Add Images".localized
                        }
                        cell.innerView.layer.borderWidth = 0.5
                        cell.trailingConstant.constant = 10
                        cell.leadingConstant.constant = 10
                        cell.innerView.backgroundColor = .white
                        cell.topConst.constant = 0
                        cell.bottomConst.constant = -2
                        cell.btn.isEnabled = true
                        cell.btnclick.isHidden = false
                        cell.btnclick.addTarget(self, action: #selector(uploadExteriorClicked), for: .touchUpInside)
                        return cell
                    }
                    else  if indexPath.row == 2 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell", for: indexPath) as!
                        CollectionViewTableViewCell
                        cell.delegate = self
                        contentborder(vw: cell.contentView)
                        cell.istype = "Exterior"
                        cell.collectionVIEW.isScrollEnabled = true
                        if let flowLayout =  cell.collectionVIEW.collectionViewLayout as? UICollectionViewFlowLayout {
                            flowLayout.scrollDirection = .horizontal
                        }
                        
                        cell.topConst.constant = -1
                        cell.isType = false
                         if AddBranch.shared.platformType.contains(48)
                         {
                          cell.showimgList = self.showimgExteriorList
                           
                        }
                        else
                         {
                          cell.showimgList = self.showimgAllList
                        }
                        
                       
                        cell.collectionVIEW.reloadData()
                        return cell
                    }
                      
                             if indexPath.row == 3
                                                {
                                                   let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderBranchTableViewCell", for: indexPath) as!
                                                   HeaderBranchTableViewCell
                                                    cell.btnclick.isHidden = false
                                                   contentborder(vw: cell.contentView)
                                                   cell.innerView.layer.cornerRadius = 0
                                                   cell.rgtlbl.isHidden = true
                                                   cell.rightarrow.isHidden = true
                                                   let image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"DownArror_new")!)
                                                   
                                                   cell.rightarrow.setImage(image, for: .normal)
                                                   cell.bottomConst.constant = 0
                                                   cell.btn.setImage(UIImage(named:"interior-1"), for: .normal)
                                                   cell.innerView.layer.borderWidth = 0.5
                                                   cell.lbl.text = "Interior".localized
                                                   cell.trailingConstant.constant = 10
                                                   cell.leadingConstant.constant = 10
                                                   cell.topConst.constant = 0
                                                   cell.bottomConst.constant = -2
                                                   cell.innerView.backgroundColor = .white
                                                   cell.btn.isEnabled = true
                                                   cell.btnclick.addTarget(self, action: #selector(uploadInteriorClicked), for: .touchUpInside)
                                                   return cell
                                               }
                                               else  if indexPath.row == 4 {
                                                   let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewTableViewCell", for: indexPath) as!
                                                   CollectionViewTableViewCell
                                                     cell.delegate = self
                                                  
                                                   contentborder(vw: cell.contentView)
                                                   cell.topConst.constant = -1
                                                   cell.isType = false
                                                   cell.istype = "Interior"
                                                if AddBranch.shared.platformType.contains(48)
                                                                          {
                                                   cell.showimgList = self.showimgInteriorList
                                                                 }
                                                   cell.collectionVIEW.isScrollEnabled = true
                                                   if let flowLayout =  cell.collectionVIEW.collectionViewLayout as? UICollectionViewFlowLayout {
                                                       flowLayout.scrollDirection = .horizontal
                                                   }
                                                   cell.collectionVIEW.reloadData()
                                                   return cell
                                               }
                                               else  if indexPath.row == 6 {
                                                   let cell = tableView.dequeueReusableCell(withIdentifier: "CountingTableViewCell", for: indexPath) as! CountingTableViewCell
                                                   cell.vw.layer.cornerRadius = 15
                                                   cell.vw.layer.borderWidth = 0.5
                                                   cell.bottomConst.constant = 0
                                                   cell.topConst.constant = -10
                                                   cell.counlbl.text = ""
                                                   return cell
                                               }
                                               else
                                               {
                                                   let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as!
                                                   BusinessTableViewCell
                                           cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                                cell.txtView.isHidden = false
                                                   contentborder(vw: cell.contentView)
                                                   cell.txtView.text = AddBranch.shared.video_url
                                                   cell.nameTextField.isHidden = true
                                                   cell.lblk.text = "  Video URL".localized
                                                   cell.txtView.tag = 10
                                                   cell.txtView.delegate = self
                                                   
                                                   return cell
                                               }
                    }
                
                        
                    
                
            default:
                let cell = tableVw.dequeueReusableCell(withIdentifier: "nextTableViewCell", for: indexPath) as! nextTableViewCell
                if isSave
                {
                    cell.nextbtn.layer.borderColor = UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1).cgColor
                    cell.nextbtn.setTitleColor(UIColor.init(red: 97/255, green: 192/255, blue: 136/255, alpha: 1), for: .normal)
                    
                    
                }
                else
                {
                    cell.nextbtn.layer.borderColor = UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1).cgColor
                    cell.nextbtn.setTitleColor(UIColor.init(red: 236/255, green: 74/255, blue: 83/255, alpha: 1), for: .normal)
                }
                
                cell.savedraft.tag = 0
                cell.savedraft.addTarget(self, action: #selector(saveClick(_ :)), for: .touchUpInside)
                cell.nextbtn.tag = 1
                cell.nextbtn.addTarget(self, action: #selector(saveClick(_ :)), for: .touchUpInside)
                return cell
                
            }
            
            
            
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0
            {
                switch indexPath.section {
                case 1:
                    let vc = BusinessTypeListViewController(nibName: "BusinessTypeListViewController", bundle: nil)
                    vc.delegate = self
                    vc.hidesBottomBarWhenPushed = true;
                    vc.selectedTypeArray = selectedTypeArrays
                    vc.selectedIndexs = selectedTypeId
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                case 3:
                    let vc = BusinessTimesheet1PopupViewController(nibName: "BusinessTimesheet1PopupViewController", bundle: nil)
                    vc.hidesBottomBarWhenPushed = true;
                    self.navigationController?.pushViewController(vc, animated: true)
                case 4:
                    let vc = BusinessLocation1ViewController(nibName: "BusinessLocation1ViewController", bundle: nil)
                    vc.hidesBottomBarWhenPushed = true;
                    vc.detaillength = self.descriplist?.data?.br_limit_list?[1].value ?? 0
                    self.navigationController?.pushViewController(vc, animated: true)
                default:
                    break
                }
            }
            if indexPath.section == 2
            {
                if indexPath.row != 0
                {
                    if AddBranch.shared.platformType.contains(platformlist?.data?.platform_type?[indexPath.row - 1].id ?? 0)
                    {
                        AddBranch.shared.platformType.remove(platformlist?.data?.platform_type?[indexPath.row - 1].id ?? 0)
                    }
                    else
                    {
                        AddBranch.shared.platformType.add(platformlist?.data?.platform_type?[indexPath.row - 1].id ?? 0)
                    }
                    
                    if AddBranch.shared.platformType.count > 0
                    {
                        headerImgArr[2] = "ptype_green"
                    }
                    else
                    {
                        headerImgArr[2] = "ptype"
                    }
                    if AddBranch.shared.platformType.contains(48)
                                           {
                                    
                               
                                           }
                    else
                    {
                        AddBranch.shared.BTimeDict.removeAll()
                        timing.removeAll()
                        slottArr.removeAllObjects()
                        for i in 0...6{
                                                  
                        timing.append(Business_timings(dayName: week[i], is24Open: 1, isClose: 0, slotArrayList: []))
                                           }
                          AddBranch.shared.BTimeDict = timing
                         checkTimingStatus()
                        if AddBranch.shared.BTimeDict.count > 0
                        {
                            headerImgArr[3] = "btime_green"
                        }
                        else
                        {
                            headerImgArr[3] = "btime"
                        }
                    }
                    
                    tableVw.reloadData()
                }
                
            }
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.section {
                
            case 0:
                switch indexPath.row {
                    
                case 0,1:
                    return 44
                case 2:
                    return 120
                    
                case 9:
                    return 35
                case 3...7:
                    return 70
                default:
                    return 120
                }
            case 2:
                if indexPath.row == 0
                {
                    return 44
                }
                else
                {
                    return 35
                }
            case 3:
                
                return 50
                
                
            case 4:
                if indexPath.row == 2
                {
                    return 200
                }
                if indexPath.row == 0
                {
                    return 44
                }
                else
                {
                    if isLoc
                    {
                        return 60
                    }
                    
                    return 50
                }
                
                
            case 5:
                if AddBranch.shared.platformType.contains(48)
                {
               switch indexPath.row {
                              case 0,1,3:
                                  return 44
                              case 5:
                                  return 70
                              case 6:
                                  return 30
                              default:
                                  return 100
                              }
                
                }
                else
                {
                    switch indexPath.row {
                                                case 0,1:
                                                    return 44
                                                  case 3,4:
                                                 return 0
                                                case 5:
                                                    return 70
                                                case 6:
                                                    return 30
                                                default:
                                                    return 100
                                                }
                }
                
            case 6:
                return 100
            default:
                switch indexPath.row {
                case 0:
                    return 44
                    
                default:
                    var hei:CGFloat = 0
                    var heighConst = 1
                    if selectedTypeArrays.count > 0
                    {
                        for item in selectedTypeArrays
                        {
                            let widths = ModalController.textWidth(text: (item as? String)!, font: UIFont(name: "Gilroy", size: 10))
                            hei = hei + widths + 40
                            if hei > self.tableVw.frame.width - 20
                            {
                                heighConst = heighConst + 1
                                hei = 0
                            }
                        }
                        return heighConst == 1 ? 85 : CGFloat(heighConst * 75)
                    }
                    else
                    {
                        return 85
                    }
                    
                    
                    
                }
            }
        }
        func setBranchLogo() {
          
            let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
                                     self.imagetype = ""
                                            vc.delegate = self
                                          vc.isproduct = true
                                         vc.iswarning = true
                                         vc.isproduct = true
                                         vc.index = 0
                                           vc.nameAr =  ["Take Photo", "Device Gallery"]
                                           vc.imgAr  = ["camera_picture", "galery_Picture"]
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
        
        
        
        @objc func uploadExteriorClicked() {
          
            let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
                                            vc.delegate = self
                                          vc.isproduct = true
                                         vc.iswarning = true
                                        self.imagetype = "Exterior"
                                           vc.nameAr =  ["Take Photo", "Device Gallery"]
                                           vc.imgAr  = ["camera_picture", "galery_Picture"]
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
        @objc func uploadInteriorClicked()
          {
              
                let vc = BottomPopupEditProductViewController(nibName: "BottomPopupEditProductViewController", bundle: nil)
                                                vc.delegate = self
                                              vc.isproduct = true
                                             vc.iswarning = true
                                             self.imagetype = "Interior"
                                               vc.nameAr =  ["Take Photo", "Device Gallery"]
                                               vc.imgAr  = ["camera_picture", "galery_Picture"]
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
        
        func gallery(img:UIImage,imgtype:String) {
            if imgtype == "Exterior"
            {
                ModalClass.startLoading(self.view)
                branch.imageType = "Exterior"
                branch.imgfile = img
                branch.uploadImage { (success, response) in
                    ModalClass.stopLoading()
                    self.uploadimg = response
                    if success
                    {
                        self.allimageGallery(imageType: "")
                        self.allimageGallery(imageType: "Exterior")

                    }
                    else
                    {
                        ModalController.showNegativeCustomAlertWith(title: self.uploadimg!.error_description!, msg: "")
                    }

                }
            }
            else if imgtype == "Interior"
            {
                ModalClass.startLoading(self.view)
                branch.imageType = "Interior"
                branch.imgfile = img
                branch.uploadImage { (success, response) in
                    ModalClass.stopLoading()
                    self.uploadimg = response
                    if success
                    {
                        self.allimageGallery(imageType: "")
                        self.allimageGallery(imageType: "Interior")

                    }
                    else
                    {
                        ModalController.showNegativeCustomAlertWith(title: self.uploadimg!.error_description!, msg: "")
                    }
                }
            }
            else
        {
                branch.imgfile = img
                ModalClass.startLoading(self.view)
                branch.uploadBranchLogo { (success, response) in
                    ModalClass.stopLoading()
                    if success
                    {
                        self.branchlogo = response
                        AddBranch.shared.branchLogoId = "\(self.branchlogo!.data!.id ?? 0)"
                        AddBranch.shared.branchImgUrl = "\(self.branchlogo!.data!.logo_url!)"
                        self.tableVw.reloadSections(IndexSet(integer: 0), with: .none)
                        self.mandatoryCheck()
                    }
                    
                }
                
            }
                
            }
            func checkTimingStatus()
            {
                
                           for i in 0...6
                           {
                               if AddBranch.shared.BTimeDict.count > 0
                               {
                                   let arrr:Business_timings = AddBranch.shared.BTimeDict[i]
                                   
                                   let dayss =  week[i]
                                   
                                if dayss == weekDay!
                                   {
                                       displayLbl = ""
                                       if arrr.slotArrayList?.count ?? 0 > 0
                                       {
                                           var status = false
                                           slottArr.removeAllObjects()
                                           for j in 0...((arrr.slotArrayList?.count ?? 0) - 1)
                                           {
                                               let ar:SlotArrayList1 = arrr.slotArrayList![j]
                                               slottArr.add(ar.time_slot as Any)
                                               if !status
                                               {
                                                   status = ModalController.checkTime(Slot:ar.time_slot ?? "")
                                               }
                                               
                                               if status
                                               {
                                                   displayLbl = "Open Now".localized
                                               }
                                               else
                                               {
                                                   displayLbl = "Closed Now".localized
                                                   
                                               }
                                               
                                           }
                                       }
                                       else
                                       {
                                           
                                           if arrr.is24Open == 0 &&  arrr.isClose == 0
                                           {
                                            displayLbl = "Always Close".localized
                                           }
                                           if arrr.is24Open == 1 &&  arrr.isClose == 0
                                           {
                                               displayLbl = "Always Open".localized
                                            AddBranch.shared.displaycode = "ALWAYS_OPEN"
                                           }
                                           
                                       }
                                       
                                   }
                                   else
                                   {
                                       slotCount = (arrr.slotArrayList?.count ?? 0) + slotCount
                                       
                                       
                                   }
                               }
                               
                           }
            }
            
        
        
        override func viewDidAppear(_ animated: Bool) {
            UITableView.setAnimationsEnabled(false)
            if AddBranch.shared.BType.count > 0
            {
                headerImgArr[1] = "btype_green"
            }
            else{
                headerImgArr[1] = "btype"
            }
            if AddBranch.shared.BTimeDict.count > 0
            {
                headerImgArr[3] = "btime_green"
            }
            else
            {
                headerImgArr[3] = "btime"
            }
            if AddBranch.shared.location.count > 0
            {
                headerImgArr[4] = "loc_green"
            }
            else
            {
                headerImgArr[4] = "loc"
            }
            if isFromSubscription{
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            }
            if AddBranch.shared.isLocation
            {
                tableVw.reloadData()
                AddBranch.shared.isLocation = false
                return
            }
            slottArr.removeAllObjects()
           checkTimingStatus()
            self.mandatoryCheck()
            tableVw.reloadData()
        }
        
    }
    
    
    extension CreateBranchFirstStepViewController:UITextFieldDelegate,UITextViewDelegate,CollectionViewTableViewCellDelegate,BottomPopupEditProductViewControllerDelegate,BussinessGalleryViewControllerDelegate
    {
        func gallerySave(img: [UIImage],id:NSMutableArray,imgurl:NSMutableArray) {
            
            if self.imagetype == ""
            {
                AddBranch.shared.branchLogoId = "\(id[0])"
                AddBranch.shared.branchImgUrl = "\(imgurl[0])"
                self.tableVw.reloadSections(IndexSet(integer: 0), with: .none)            }
            else
            {
                var imgid = ""
                if id.count > 0
                {
                    imgid.removeAll()
                    for item in id{
                        imgid = "\(item),\(imgid)"
                    }
                    imgid.removeLast()
                }
                branch.branchfrom = "Branch"
                branch.imgtype = imagetype
                branch.galleryid = imgid
                ModalClass.startLoading(view)
                branch.uploadbranchGalleryImage { (success, response) in
                    ModalClass.stopLoading()
                    
                    if success
                    {
                        self.uploadbranchimg = response
                        self.allimageGallery(imageType: "")
                        self.allimageGallery(imageType: self.imagetype)
                        
                    }
                    
                }
            }
            
        }
        
        func information(Value: String) {
            print("")
        }
        
        func actionPerform(tag: Int, index: Int) {
            OpenGallery.shared.delegate = self
                  if tag == 0
                  {
                    OpenGallery.shared.imgType = self.imagetype
                      OpenGallery.shared.viewControl = self
                         OpenGallery.shared.openCamera()
                  }
                  else if tag == 1
                  {
                            if self.imagetype == ""
                            {
                                
                                OpenGallery.shared.imgType = self.imagetype
                                    OpenGallery.shared.viewControl = self
                                    OpenGallery.shared.openGallery()
                                }
                             
                               if self.imagetype == "Exterior"
                                         {
                                            self.imgaes()
                                         }
                                         if self.imagetype == "Interior"
                                         {
                                             self.imgaes()
                                         }
                                           
                  }
                  else{
                   
                   let vc = BussinessGalleryViewController(nibName: "BussinessGalleryViewController", bundle: nil)
                    if self.imagetype == ""
                    {
                        vc.isTypeFrom = "Profile"
                    }
                  else
                    {
                        vc.isTypeFrom = "Branch"
                        vc.branchImgCount = (self.descriplist?.data?.branch_img_limit ?? 0) - (AddBranch.shared.showImgId.count)
                    }
                    vc.selectedVl = 1001
                    vc.delegate = self
                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                
                    
            
        }
        
        func filterIdval(tag: Int, Value: String, id: Int) {
            print("")
        }
        
        func deleteDoc(tag: Int) {
             ModalClass.startLoading(self.view)
                  branch.mediaId = "\(tag)"
                 branch.deleteImg { (success, response) in
                      ModalClass.stopLoading()
                      if success
                      {
                       if AddBranch.shared.platformType.contains(47)
                       {
                         self.allimageGallery(imageType: "")
                        }
                        else
                       {
                         self.allimageGallery(imageType: "")
                        self.allimageGallery(imageType: "Exterior")
                        self.allimageGallery(imageType: "Interior")
                          self.mandatoryCheck()
                        }
                      }
                      
                  }
          
        }
        
        func attachedPdf() {
            print("")
        }
        
        func cancelBtn() {
        
               
            if selectedTypeArrays.count > 0
            {
                headerImgArr[1] = "btype_green"
            }
            else
            {
                headerImgArr[1] = "btype"
            }
            self.tableVw.reloadSections(IndexSet(integer: 1), with: .none)
        }
        
      
        
       func imgaes(){

            let imagePicker = ImagePickerController()

            

            let val = showimgInteriorList?.data?.images_list?.count

            let val2 = showimgExteriorList?.data?.images_list?.count

            

            print(val2,"val2",val)

        if (val!+val2!) < (self.descriplist?.data?.branch_img_limit ?? 0){

                imagePicker.settings.selection.max = (self.descriplist?.data?.branch_img_limit ?? 0) - (val!+val2!)

            }else{

                imagePicker.settings.selection.max = 0

                

            }

            imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]

            

            

            presentImagePicker(imagePicker, select: { (asset) in

                // User selected an asset. Do something with it. Perhaps begin processing/upload?

            }, deselect: { (asset) in

                print("ghg")

                // User deselected an asset. Cancel whatever you did when asset was selected.

            }, cancel: { (assets) in

                print("ghg")

                

                

                // User canceled selection.

            }, finish: { (assets) in

                self.images = self.getAssetThumbnail(assets: assets)

                self.UploadProfileImage_API()

                print("hdgjj")

                // User finished selection assets.

            })

        }
         func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {

               var arrayOfImages = [UIImage]()

               for asset in assets {

                   let manager = PHImageManager.default()

                   let option = PHImageRequestOptions()

                   option.deliveryMode = .highQualityFormat

                   option.resizeMode = .exact

                   var image = UIImage()

                   option.isSynchronous = true

                   manager.requestImage(for: asset, targetSize: CGSize(width: 800, height: 800), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in

                       image = result!

                       arrayOfImages.append(image)

                   })
               }
               return arrayOfImages
           }
        
        
         func UploadProfileImage_API()
         {
            let str = "\(Constant.BASE_URL)\(Constant.branchMultipleImageType)"
            
            let param = [
               "user_id":Singleton.shared.getBoId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"branch_id":AddBranch.shared.BranchId,"image_type":imagetype
                ] as [String : Any]
            
            
            print(param)
            
            ModalClass.startLoading(self.view)
            print(self.images.count)
            ServerCalls.fileUploadAPINewMultipleImage(inputUrl: str, parameters: param, imageName: "images[]", imageFile: self.images) { (response, success, resp) in
                
                ModalClass.stopLoading()
                if let value = response as? NSDictionary{
                    let msg = value.object(forKey: "error_description") as! String
                    let error = value.object(forKey: "error_code") as! Int
                    if error == 100{
                        ModalController.showNegativeCustomAlertWith(title:" Error", msg: msg)
                    }else{
                       self.allimageGallery(imageType: "")
                        self.allimageGallery(imageType: self.imagetype)
                       // let str  = ((value.object(forKey: "data") as! NSDictionary).object(forKey: "image_url") as! String)
                 
                    }
                }
                else{
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                }
            }
            
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            var textstr = ""
            if let text1 = textView.text as NSString? {
                let txtAfterUpdate = text1.replacingCharacters(in: range, with: text)
                textstr = txtAfterUpdate
            }
            if textView.tag == 10
            {
             if text.isArabic
                {
                    return false
                }
                AddBranch.shared.video_url = textstr
                if ((tableVw.indexPathsForVisibleRows?.contains(IndexPath(row: 5, section: 5)))!)
                                {
                                   let cell = tableVw.cellForRow(at: IndexPath(row: 5, section: 5)) as! BusinessTableViewCell
                if textstr.count > 0
                                {
                                  
                                    if !textstr.isValidURL()
                                                {
                                        cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                                                                                        }
                                                                                                    else
                                                                                                    {
                                                                                            cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                                                                          }
                                                                        }
                                                                        else
                                                                        {
                                                                 cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor                }
            }
            }
            else
            {
                if !text.containArabicNumber
                {
                    return false
                }
                if textstr.count > 200
                {
                    return false
                }
                AddBranch.shared.Descrip = textstr
                toparr[5] = textstr
                 if ((tableVw.indexPathsForVisibleRows?.contains(IndexPath(row: 8, section: 0)))!)
                 {
                    let cell = tableVw.cellForRow(at: IndexPath(row: 8, section: 0)) as! BusinessTableViewCell

                                   if textstr.count > 0
                                                         {
                                                             if !textstr.containArabicNumber
                                                                                         {
                                                                     cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                                                                         }
                                                                                     else
                                                                                     {
                                                                             cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                                                           }
                                                         }
                                                         else
                                                         {
                                                  cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor                }
                }
               
                tableVw.reloadRows(at: [IndexPath(row: 9, section: 0)], with: .none)
            }
            self.mandatoryCheck()
            return true
            
        }
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            switch textField.tag {
            case 5,6,7:
                if codes[textField.tag - 5] as! String == ""
                {
                    return false
                }
                else
                {
                    return true
                }
            default:
                return true
                
            }
            
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField.tag == 4
            {
             if string.isArabic
             {
                 return false
             }
            }
            if !string.containArabicNumber
                       {
                           return false
                       }
                     var textstr = ""
            if let text = textField.text as NSString? {
                let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                textstr = txtAfterUpdate
            }
            let num = textstr.replacingOccurrences(of: " ", with: "")
            if textField.tag == 5 || textField.tag == 6 || textField.tag == 7
            {
                if num.count > mobilelength[textField.tag - 5] as! Int
                {
                    return false
                }
                else{
                    return true
                }
            }
            
            return true
            
        }
        @objc private func textFieldDidChange(_ textField: UITextField)
        {
         
            
            if textField.tag == 3
            {
                
                AddBranch.shared.bName = textField.text ?? ""
                toparr[0] = textField.text ?? ""
                
                let cell = tableVw.cellForRow(at: IndexPath(row: 3, section: 0)) as! BusinessTableViewCell
                
               
                if textField.text!.count > 0
                          {
                            if AddBranch.shared.bName.first!.isWhitespace ||  AddBranch.shared.bName.count > 70
                                                           {
                                                             cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                                              return
                                                          }
                              if !textField.text!.containArabicNumber
                                                          {
                                      cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                                          }
                                                      else
                                                      {
                                              cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                            }
                          }
                          else
                          {
                   cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor                }
            }
            else if textField.tag == 4
            {
                
                AddBranch.shared.mail = textField.text ?? ""
                toparr[1] = textField.text ?? ""
                let cell = tableVw.cellForRow(at: IndexPath(row: 4, section: 0)) as! BusinessTableViewCell
                  let name = ModalController.isValidEmail(testStr:AddBranch.shared.mail)
                                  if !name{
                       cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                     return
                }
                               if textField.text!.count > 0
                                         {
                                             if textField.text!.isArabic
                                                                         {
                                                     cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                                                         }
                                                                     else
                                                                     {
                                                             cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                                           }
                                         }
                                         else
                                         {
                                  cell.bordertxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor                }
                
            }
            else if textField.tag == 5
            {
                AddBranch.shared.MobileNo = textField.text ?? ""
                
                let mobilNoo = AddBranch.shared.MobileNo.replacingOccurrences(of: " ", with: "")
                let value = ModalController.customStringFormatting(of: mobilNoo)
                toparr[2] = value
                let cell = tableVw.cellForRow(at: IndexPath(row: 5, section: 0)) as! PhoneNumberTableViewCell
             cell.phoneNumberTextField.text = toparr[2] as! String
                if value.replacingOccurrences(of: " ", with: "").count  == mobilelength[0] as! Int
                {
                    if !textField.text!.containArabicNumber
                                                {
                            cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                                }
                                            else
                                            {
                                    cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                  }
                }
                else
                {
         cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor                }

            }
                
            else if textField.tag == 6
            {
                
                AddBranch.shared.whatsappNumber = textField.text ?? ""
                let mobilNoo = AddBranch.shared.whatsappNumber.replacingOccurrences(of: " ", with: "")
                let value = ModalController.customStringFormatting(of: mobilNoo)
                toparr[3] = value
                let cell = tableVw.cellForRow(at: IndexPath(row: 6, section: 0)) as! PhoneNumberTableViewCell
            cell.phoneNumberTextField.text = toparr[3] as! String
                if value.replacingOccurrences(of: " ", with: "").count  == mobilelength[1] as! Int
                              {
                                  if !textField.text!.containArabicNumber
                                                              {
                                          cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                                              }
                                                          else
                                                          {
                                                  cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                                }
                              }
                              else
                              {
                                if textField.text ?? "" == ""
                                {
                                 cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                }
                                else
                                {
                                 cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                }
                      
                                
                }
             
            }
            else if textField.tag == 7
            {
                AddBranch.shared.Phone = textField.text ?? ""
                let mobilNoo = AddBranch.shared.Phone.replacingOccurrences(of: " ", with: "")
                let value = ModalController.customStringFormatting(of: mobilNoo)
                toparr[4] = value
                let cell = tableVw.cellForRow(at: IndexPath(row: 7, section: 0)) as! PhoneNumberTableViewCell
                cell.phoneNumberTextField.text = toparr[4] as! String
             if   value.replacingOccurrences(of: " ", with: "").count  >= phoneminLength && value.replacingOccurrences(of: " ", with: "").count  <= mobilelength[2] as! Int
                                          {
                                              if !textField.text!.containArabicNumber
                                                                          {
                                                      cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                                                          }
                                                                      else
                                                                      {
                                                              cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                                            }
                                          }
                                          else
                                          {
                                            if textField.text ?? "" == ""
                                            {
                                             cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#B2B2B2").cgColor
                                            }
                                            else
                                            {
                                             cell.borderTxt.layer.borderColor =  ModalController.hexStringToUIColor(hex: "#EC4A53").cgColor
                                            }
                                  
                                            
                            }
            }
           
            
            self.mandatoryCheck()
            
        }
        
    }
    
   
