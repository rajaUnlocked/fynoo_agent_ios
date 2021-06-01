//
//  ModalClass.swift
//  Silent Panda
//
//  Created by Neeraj Tiwari on 10/5/17.
//  Copyright © 2017 aishwarya sanganan. All rights reserved.
//

import UIKit
import CoreLocation
@available(iOS 10.0, *)
class ModalController: NSObject {
    
    static func showAlertWith(message: String, title: String )
    {
         UIAlertView.init(title: title, message: message , delegate: nil, cancelButtonTitle: "OK").show();
    }
    
    static func setViewBorderColor(color:UIColor, view:UIView) {
        view.borderColor = color
        
    }
   
    
    static func showSuccessCustomAlertWith(title: String, msg: String)
    {
        let banner = Banner(title: title, subtitle: msg, image: UIImage(named: "like_thumb"), backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.0/255.0, alpha:1.000))
        banner.dismissesOnTap = true
        banner.show(duration: 2.5)
    }
    
    static func showNegativeCustomAlertWith(title: String, msg: String)
    {
        
        let banner = Banner(title: title, subtitle: msg, image: UIImage(named: ""), backgroundColor: UIColor(red: 186.0/255, green: 30.0/255, blue: 40.0/255, alpha: 1.0))
        banner.dismissesOnTap = true
        banner.show(duration: 1.5)
    }
    
    static func showSuccessCustomAlertWithoutImage(title: String, msg: String)
    {
        let banner = Banner(title: title, subtitle: msg, image: UIImage(named: ""), backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.0/255.0, alpha:1.000))
        banner.dismissesOnTap = true
        banner.show(duration: 2.5)
    }
    static func convertUrltoImage(url:String) -> UIImage
    {
       let imageUrl = URL(string: url)!
      let imageData = try! Data(contentsOf: imageUrl)
      return UIImage(data: imageData)!
    }
    // MARK: Appdelegate Object
    static func APPDELEGATE() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate;
    }
   static func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
  static func isValidURL(url: String) -> Bool {
           let regex = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
           let test = NSPredicate(format:"SELF MATCHES %@", regex)
           let result = test.evaluate(with: url)
           return result
    }
  
   static func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }

    static func rotateImagesOnLanguageMethod(img: UIImage)-> UIImage {
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"
            {
                let img1 = img
                let image1 = UIImage(cgImage: (img1.cgImage)!, scale: (img1.scale), orientation: UIImage.Orientation.upMirrored)
                return image1
            }
            else if value[0]=="en"
            {
                let image1 = img
                return image1
            }
        }
        return img
    }
    
    static func isValidIBAN(ibanStr: String, length: Int, countryType : String) -> Bool {
    let str1 = ibanStr
    if str1.count > 2 {
    let result = String(str1.prefix(2))
        let silentString = result.uppercased()
        let silentString1 = countryType.uppercased()
        
        if silentString == "\(silentString1)" {
            if str1.count == length {
                let str3 = String(str1.dropFirst(2))
                let num = str3.isNumeric
                if num == true {
                    print("valid")
                    return true
                }
                else {
                 print("not valid")
                    return false
                }
            }
        }else{
            return false
        }
    }
        return false
    }
    
    
    
    //MARK: NSUserDefaultMethods
    static func saveTheContent(_ content : AnyObject?, WithKey key : String )-> Void {
        let defaults = UserDefaults.standard
        defaults.set(content, forKey: key as String)
        defaults.synchronize();
    }
    ///Users/aishwaryasanganan/Documents/projects/SceneAhead_ios/Scene Ahead/Scene Ahead/Scene Ahead.entitlements
    
    static func removeTheContentForKey(_ key : NSString )-> Void {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key as String)
    }
    static func getTheContentForKey(_ key : NSString)-> AnyObject? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: key as String)
        return value as AnyObject
    }
    static func checkStringIsValid(_ str : NSString)-> Bool {
        if (str .isKind(of: NSNull .classForCoder()) || str .trimmingCharacters(in: CharacterSet.whitespaces).isEmpty){
            return false
        }
        return true
    }
    static func checkOriginlStringIsValid(_ str : AnyObject? )-> Bool {

        if str == nil{
            return false
        }else if str is NSNull
        {
            return false
        }else if str is String
        {
            let finalStr : String = str as! String
            if finalStr.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true
            {
                return false
            }
        }
        return true
    }
    static func openMaps(latitute : AnyObject? , longitute : AnyObject? ) {
        
       
    }
    static  func base64Encoded(_ encodeString:String) -> String
    {
        let plainData =  (encodeString as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        print("base64String\n",base64String!);
        return base64String!
    }
    static   func base64Decoded(_ decoString:String) -> String
    {
        let decodedData = Data(base64Encoded: decoString, options:NSData.Base64DecodingOptions(rawValue: 0))
        if let decode = decodedData{
            let decodedString = NSString(data: decode, encoding: String.Encoding.utf8.rawValue)
            
            if decodedString == nil {
                return decoString;
            }
            print("decode string \n",decodedString! );
            return decodedString as! String;
        }
        else
        {
            return decoString;
        }
        
    }
  static  func removeSpecialCharsFromString(text: String) -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ")
        return text.filter {okayChars.contains($0) }
    }
    static func hasSpecialCharacters(str:String) -> Bool {

        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: str, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, str.count)) {
                return true
            }

        } catch {
            debugPrint(error.localizedDescription)
            return false
        }

        return false
    }
    static func isValidTxt(testStr:String) -> Bool {
        if testStr.count > 70
        {
            return false
        }
         let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
   static func textWidth(text: String, font: UIFont?) -> CGFloat {
    let attributes = font != nil ? [NSAttributedString.Key.font: font] : [:]
    return text.size(withAttributes: attributes as [NSAttributedString.Key : Any]).width
    }
static func isStringValid(_ str: String?) -> Bool {
    if (str?.trimmingCharacters(in: CharacterSet.whitespaces).count ?? 0) == 0 || (str is NSNull) || str == nil || (str?.replacingOccurrences(of: "\n", with: "").count ?? 0) == 0 {
            return false
        }
        return true
    }
    
    static func compareImage(image1: UIImage,image2: UIImage) -> Bool {
        let data1: NSData = image1.pngData()! as NSData
        let data2: NSData = image2.pngData()! as NSData 
        return data1.isEqual(data2)
    }
    static func checkTime(Slot:String) -> Bool {
    
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = "HH:mm"
        let fullNameArr = Slot.components(separatedBy: "-")
            let firstName: String = fullNameArr[0]
     let lastName: String = fullNameArr[1]
       let Time1 = firstName.components(separatedBy: ":")
        let t1: Int = Int(Time1[0])!
        let t2: Int = Int(Time1[1].trimmingCharacters(in: .whitespacesAndNewlines))!
        let time1 = (t1 * 60) + t2
        let Time2 = lastName.components(separatedBy: ":")
        let t3: Int = Int(Time2[0].trimmingCharacters(in: .whitespacesAndNewlines))!
        let t4: Int = Int(Time2[1])!
     let time2 = (t3 * 60) + t4
    let date = Date()
  let currentTime = (60*Calendar.current.component(.hour, from: date)) + Calendar.current.component(.minute, from: date) + (Calendar.current.component(.second, from: date)/60) // in minutes
  

    print(currentTime)
    print(time1)
    print(time2)

    if(currentTime >= time1 && currentTime <= time2) {
        return true
    } else {
        return false
    }
    }
   static func customStringFormatting(of str: String) -> String {
    
        return str.chunk(n: 3)
            .map{ String($0) }.joined(separator: " ")
    }
    
    static func customStringFormattingForAccountNumber(of str: String) -> String {
           return str.chunk(n: 4)
               .map{ String($0) }.joined(separator: " ")
       }
   static func setGradientBackground(viewbACK:UIView) {
        let colorTop =  UIColor(red: 254/255.0, green: 254/255.0, blue: 254/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        gradientLayer.frame =  CGRect(x: 0 , y: 0, width: screenWidth, height: screenHeight)
        viewbACK.layer.insertSublayer(gradientLayer, at: 0)
    }
    
   static func setGradientColorBGBlack() -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
    gradientLayer.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: HeaderHeightSingleton.shared.headerHeight)
        gradientLayer.colors =  [UIColor(red: 2/255.0, green: 33/255.0, blue: 160/255.0, alpha: 1.0),UIColor(red: 0/255.0, green: 0/255.0, blue: 2/255.0, alpha: 1.0) ].map{$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }
    static func setnewGradientColorBGBlack(height:Int) -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height:height)
        gradientLayer.colors =  [UIColor(red: 2/255.0, green: 33/255.0, blue: 160/255.0, alpha: 1.0),UIColor(red: 0/255.0, green: 0/255.0, blue: 2/255.0, alpha: 1.0) ].map{$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }
    
    static func setnewGradientColorBGBlackWithPopupHeight() -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height:54)
        gradientLayer.colors =  [UIColor(red: 2/255.0, green: 33/255.0, blue: 160/255.0, alpha: 1.0),UIColor(red: 0/255.0, green: 0/255.0, blue: 2/255.0, alpha: 1.0) ].map{$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }
    
    //MARK:MethodForRoundCorner
    static func roundView(_ view:UIView)
    {
        view.layer.cornerRadius = view.frame.size.width/2
        view.clipsToBounds = true
    }
    static func convertTimeStampIntoDate(timeStamp : String, format : String) -> String
    {
         let timeResult = Double(timeStamp)
         let date = Date(timeIntervalSince1970: timeResult!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.dateFormat = format
            dateFormatter.timeZone = .current
        dateFormatter.locale = NSLocale(localeIdentifier: "EN") as Locale
            let localDate = dateFormatter.string(from: date)
            return localDate
    }

    static func convert13DigitTimeStampIntoDate(timeStamp : String, format : String) -> String
     {
         let timeResult = Int(timeStamp)! / 1000
         let time = Double(timeResult)
          let date = Date(timeIntervalSince1970: time)
             let dateFormatter = DateFormatter()
             dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
             dateFormatter.dateFormat = format
             dateFormatter.timeZone = .current
             let localDate = dateFormatter.string(from: date)
             return localDate
     }
    
    static  func convertInString(str : AnyObject) -> String
    {
        var stringType = ""
        if let person = str as? String {
            stringType = person
        }
        if let personNumber = str as? Int {
            stringType = "\(personNumber)"
        }
        if let personNumber = str as? Float {
            stringType = "\(personNumber)"
        }
        if let personNumber = str as? Double {
            stringType = "\(personNumber)"
        }
        return stringType
    }
  static  func toString(_ anything: Any?) -> String {
        if let any = anything {
            if let num = any as? NSNumber {
                return num.stringValue
            } else if let str = any as? String {
                return str
            }else if let inte = any as? Int
            {
                return "\(inte)"
                
            }else if let doub = any as? Double
            {
                return String(format: "%f", doub)
            }
        }
        return ""
        
    }
    static  func convertInToDouble(str : AnyObject) -> Double {
        
         var stringType = 0.0
        if let result =  str as? NSNumber
        {
            stringType = Double(truncating: result)
        }
        if let result =  str as? String {
            
            stringType = Double(result) ?? 0.0
        }
        if let result =  str as? Float {
            
            stringType = Double(result)
        }
        if let result = str as? Int
        {
            return Double(result)
            
        }
        return stringType
    }
    
  static  func timestampToDateForCollection(timeStamp : Double) -> String{
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "d-MM-yyyy'T'HH:mm:ssZ" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    

    static func convertImageToBase64(image: UIImage) -> String {
       
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
  static  func setAttributedString(str: String,str1:String,str2:String) -> NSMutableAttributedString{
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: str)
        attributedString.setColor(color: #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), forText: str2)
        attributedString.setColor(color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), forText: str1)
        return attributedString
        
    }
    
    static  func setAttributedStringForDiscount(str: String,str1:String,str2:String) -> NSMutableAttributedString{
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: str)
        attributedString.setColor(color: #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), forText: str2)
        attributedString.setColor(color: #colorLiteral(red: 0.3882352941, green: 0.7529411765, blue: 0.5333333333, alpha: 1), forText: str1)
        return attributedString
        
    }
    
  static  func setMultiColorTextString(str: String,str1:String,str2:String) -> NSMutableAttributedString{
         let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: str)
         attributedString.setColor(color: #colorLiteral(red: 0.3882352941, green: 0.7529411765, blue: 0.5333333333, alpha: 1), forText: str2)
         attributedString.setColor(color: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), forText: str1)
         return attributedString
         
     }

    static  func setMultiColorTextForDiscountProduct(str: String,str1:String,str2:String) -> NSMutableAttributedString{
           let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: str)
           attributedString.setColor(color: #colorLiteral(red: 0.3882352941, green: 0.7529411765, blue: 0.5333333333, alpha: 1), forText: str2)
           attributedString.setColor(color: #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1), forText: str1)
           return attributedString
           
       }
    static  func setStricColor(str: String,str1:String,str2:String) -> NSMutableAttributedString{
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: str)
        attributedString.setColor(color: #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1), forText: str2)
        attributedString.setColor(color: #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1), forText: str1)
        return attributedString
        
    }
    static  func setMultiColorTextStringss(str: String,str1:String,str2:String,color:UIColor,color2:UIColor) -> NSMutableAttributedString{
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: str)
        attributedString.setColor(color: color, forText: str2)
        attributedString.setColor(color: color2, forText: str1)
        return attributedString
        
    }
//  static  func customStringFormatting(of str: String) -> String {
//
//          return str.chunk(n: 3)
//
//              .map{ String($0) }.joined(separator: " ")
//
//      }
    
    
    static func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    static func isValidName(title:String)->Bool{
        let  Regex = "[a-z A-Z ء-ي]+"
           let predicate = NSPredicate.init(format: "SELF MATCHES %@", Regex)

           if predicate.evaluate(with: title) || title == "" {
               return true
           }else{
               return false
           }
      }
    
    static func isValidNameWithEnglishNumber(title:String)->Bool{
         var  Regex = "[a-z A-Z 0-9 ء-ي]+"
         let predicate = NSPredicate.init(format: "SELF MATCHES %@", Regex)

         if predicate.evaluate(with: title) || title == "" {
             return true
         }else{
             return false
         }
    }
    
   static  func hexStringToUIColor (hex:String) -> UIColor {
          var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
          
          if (cString.hasPrefix("#")) {
              cString.remove(at: cString.startIndex)
          }
          
          if ((cString.count) != 6) {
              return UIColor.gray
          }
          
          var rgbValue:UInt32 = 0
          Scanner(string: cString).scanHexInt32(&rgbValue)
          
          return UIColor(
              red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: CGFloat(1.0)
          )
      }
}
extension UIApplication {
   
    var isKeyboardPresented: Bool {
        if let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),
            self.windows.contains(where: { $0.isKind(of: keyboardWindowClass) }) {
            return true
        } else {
            return false
        }
    }
}
extension NSMutableAttributedString {
    
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}
extension UINavigationController {
    
    func backToViewController(viewController: Swift.AnyClass) {
        
        for element in viewControllers as Array {
            if element.isKind(of: viewController) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    func validateUrl() -> Bool {
          let urlRegEx = "((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
          return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
        }
    private func matches(pattern: String) -> Bool {
              let regex = try! NSRegularExpression(
                  pattern: pattern,
                  options: [.caseInsensitive])
              return regex.firstMatch(
                  in: self,
                  options: [],
                  range: NSRange(location: 0, length: utf16.count)) != nil
          }
    func isValidURL() -> Bool {
             guard let url = URL(string: self) else { return false }
             if !UIApplication.shared.canOpenURL(url) {
                 return false
             }

             let urlPattern = "^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\?\\'\\\\\\+&amp;%\\$#\\=~_\\-]+))*$"
             return self.matches(pattern: urlPattern)
         }
     var isInt: Bool {
           return Int(self) != nil
       }
}

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
    func decimalCount() -> Int {
           if self == Double(Int(self)) {
               return 0
           }

           let integerString = String(Int(self))
           let doubleString = String(Double(self))
           let decimalCount = doubleString.count - integerString.count - 1

           return decimalCount
       }
}
extension URL {
    subscript(queryParam:String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }
}
extension UIButton {
    func setShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 0.0
    }
}
extension UIView {
    func addBorder(_ edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let subview = UIView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.backgroundColor = color
        self.addSubview(subview)
        switch edge {
        case .top, .bottom:
            subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            subview.heightAnchor.constraint(equalToConstant: thickness).isActive = true
            if edge == .top {
                subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            } else {
                subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            }
        case .left, .right:
            subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            subview.widthAnchor.constraint(equalToConstant: thickness).isActive = true
            if edge == .left {
                subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            } else {
                subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            }
        default:
            break
        }
    }
func setRadiusWithShadow(_ radius: CGFloat? = nil) { // this method adds shadow to right and bottom side of button
    self.layer.cornerRadius = radius ?? self.frame.width / 2
    self.layer.shadowColor = UIColor.darkGray.cgColor
    self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
    self.layer.shadowRadius = 1.0
    self.layer.shadowOpacity = 0.7
    self.layer.masksToBounds = false
}

func setAllSideShadow(shadowShowSize: CGFloat = 1.0) { // this method adds shadow to allsides
    let shadowSize : CGFloat = shadowShowSize
    let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                               y: -shadowSize / 2,
                                               width: self.frame.size.width + shadowSize,
                                               height: self.frame.size.height + shadowSize))
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.layer.shadowOpacity = 0.5
    self.layer.shadowPath = shadowPath.cgPath
}
//    func setAllSideWithDynamicClourShadow(shadowShowSize: CGFloat = 1.0, shadowClour:UIColor) { // this method adds shadow to allsides
//        let shadowSize : CGFloat = shadowShowSize
//        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
//                                                   y: -shadowSize / 2,
//                                                   width: self.frame.size.width + shadowSize,
//                                                   height: self.frame.size.height + shadowSize))
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = shadowClour
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowPath = shadowPath.cgPath
//    }
    func setAllSideShadowForFields(shadowShowSize: CGFloat = 1.0, sizeFloat : CGFloat) { // this method adds shadow to allsides
        let shadowSize : CGFloat = shadowShowSize
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: sizeFloat + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func setAllSideShadowForFieldsWithHeight(shadowShowSize: CGFloat = 1.0, sizeFloat : CGFloat, sizeFloatHeight : CGFloat) { // this method adds shadow to allsides
        let shadowSize : CGFloat = shadowShowSize
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: sizeFloat + shadowSize,
                                                   height: sizeFloatHeight + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
}

extension String {
    var validPassword : Bool{
        if self.count > 8 || self.count == 8{
            if self.containArabicNumber{
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    
    var containArabicNumber : Bool{
        let numberArray = ["٠","١","٢","٣","٤","٥","٦","٨","٧","٩","١٠"]
        for items in numberArray{
            if self.contains(items){
                return false
            }
        }
        return true
    }
   
    var isArabic: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "(?s).*\\p{Arabic}.*")
        return predicate.evaluate(with: self)
    }
}


func calculateDistance(mobileLocationX:Double,mobileLocationY:Double,DestinationX:Double,DestinationY:Double) -> Double {

        let coordinate₀ = CLLocation(latitude: mobileLocationX, longitude: mobileLocationY)
        let coordinate₁ = CLLocation(latitude: DestinationX, longitude:  DestinationY)

        let distanceInMeters = coordinate₀.distance(from: coordinate₁)

        return distanceInMeters
    }

