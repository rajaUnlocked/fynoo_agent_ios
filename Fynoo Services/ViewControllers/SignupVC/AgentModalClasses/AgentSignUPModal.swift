//
//  AgentSignUPModal.swift
//  Fynoo Business
//
//  Created by Sendan IT on 06/10/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
 
class AgentSignUPModal: NSObject {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var ProfileImage: UIImage?
    var agentType = ""
    var imageID : Int = 0
    var serviceIDstr = ""
    var agentBussinessName = ""
    var agentCountry = ""
    var agentCity = ""
    var agentEmail = ""
    var mobileCode = ""
    var mobileCodeImage = ""
    var phoneCode = ""
    var phoneCodeImage = ""
    var mobileLength = 0
    var phoneMinLength = 0
    var PhoneMaxLength = 0
    var agentContactNumber = ""
    var agentPhoneNumber = ""
    var agentMaroofLink = ""
    var agentPassword = ""
    var agentConfirmPassword = ""
    var agentbankName = ""
    var agentbankID = ""
    var agentbankAccountHolderName = ""
    var agentbankAccountNumber = ""
    var agentConfirmEmail = ""
    var agentVatNumber = ""
    var isPolicySelected = false
    var isVatSelected = false
    var isVatNotSelected = false
    
    var vatDocumentUrl:URL?
    var vatLength:Int = 0
     var agentName_CompareCode = ""
    
    var agentIBanLength:Int = 0
    
    func normalAgentSignUPValidation() -> (Bool, String) {
        var isFilled = false
        var isEmail = false
        var message = ""
        
//        if imageID == 0 {
//            return (isFilled, ValidationMessages.companyLogo)
//        }
        if appDelegate?.selectServiceStr.count == 0 {
            return (isFilled, ValidationMessages.services)
        }
        if agentBussinessName == "" {
            return (isFilled, ValidationMessages.businessName)
        }
        
        if ModalController.isValidName(title: agentBussinessName) == false {
            return (isFilled, ValidationMessages.validName)
        }
        if agentEmail == "" {
            return (isFilled, ValidationMessages.businessEmail)
        }
        let value = ModalController.isValidEmail(testStr: agentEmail)
        if !value {
            return (isEmail, ValidationMessages.WrongemailAddress)
        }
        if !agentEmail.containArabicNumber {
            return (isFilled, ValidationMessages.emailArabicNumber)
        }
        if !agentConfirmEmail.containArabicNumber {
            return (isFilled, ValidationMessages.emailArabicNumber)
        }
        if agentConfirmEmail != agentEmail {
            return (isFilled, ValidationMessages.compareConfirmEmail)
        }
        if agentCountry == ""{
            return (isFilled, ValidationMessages.country)
        }
        if agentCity == ""{
            return (isFilled, ValidationMessages.city)
        }
        if agentContactNumber == "" {
            return (isFilled, ValidationMessages.mobile)
        }
        
        if !agentContactNumber.containArabicNumber {
            return (isFilled, ValidationMessages.ContactNumberArabicNumber)
        }
        if mobileLength > 0 {
            agentContactNumber = agentContactNumber.replacingOccurrences(of: " ", with: "")
            if agentContactNumber.count !=  mobileLength {
                return (isFilled, ValidationMessages.mobileLength)
            }
        }
        if !agentPhoneNumber.containArabicNumber {
            return (isFilled, ValidationMessages.ContactNumberArabicNumber)
        }
        if phoneMinLength > 0 && PhoneMaxLength > 0 && agentPhoneNumber != "" {
            agentPhoneNumber = agentPhoneNumber.replacingOccurrences(of: " ", with: "")
            if (agentPhoneNumber.count <  phoneMinLength) ||  (agentPhoneNumber.count > PhoneMaxLength)  {
                return (isFilled, ValidationMessages.phoneNumber)
            }
        }
        
        if  agentMaroofLink.count > 0 && !agentMaroofLink.containArabicNumber {
            return (isFilled, ValidationMessages.maroofArabicNumber)
        }
        if agentPassword == "" {
            return (isFilled, ValidationMessages.password)
        }
        if !agentPassword.containArabicNumber {
            return (isFilled, ValidationMessages.passArabicNumber)
        }
        if agentPassword.count < 8 {
            
            return (isFilled, ValidationMessages.passwordCount)
        }
        if agentConfirmPassword == "" {
            return (isFilled, ValidationMessages.agentConfirmPassword)
        }
        if !agentConfirmPassword.containArabicNumber {
            return (isFilled, ValidationMessages.passArabicNumber)
        }
        if agentPassword != agentConfirmPassword {
            return (isFilled, ValidationMessages.compareConfirmPassword)
            
        }
        if agentContactNumber.count != mobileLength {
            return (isFilled, ValidationMessages.mobileLength)
            
        }
       
        if agentbankAccountHolderName == "" {
            return (isFilled, ValidationMessages.bankAccountHolderName)
        }
        
        if (agentName_CompareCode == "YES".uppercased()) && (agentBussinessName != agentbankAccountNumber) {
           return (isFilled, ValidationMessages.agentName_compare)
        }
        
        if ModalController.isValidName(title: agentbankAccountHolderName) == false {
            return (isFilled, ValidationMessages.validAccountName)
        }
        if agentbankAccountNumber == "" {
            return (isFilled, ValidationMessages.bankAccountNumber)
        }
        if !agentbankAccountNumber.containArabicNumber {
            return (isFilled, ValidationMessages.ibanArabicNumber)
        }
        agentbankAccountNumber = agentbankAccountNumber.replacingOccurrences(of: " ", with: "")
        if agentbankAccountNumber.count != agentIBanLength {
            return (isFilled, ValidationMessages.validIbanNumber)
        }
        
        let bankCode =  agentbankAccountNumber.substring(from: 0, to: 1)
        let ibanBool = ModalController.isValidIBAN(ibanStr: agentbankAccountNumber, length: agentIBanLength, countryType: bankCode)
        if ibanBool == false
        {
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validIbanNumber)
            return (isFilled, ValidationMessages.validIbanNumber)
        }
        if agentbankAccountNumber != "" {
            agentbankAccountNumber = agentbankAccountNumber.replacingOccurrences(of: " ", with: "")
            if agentbankAccountNumber.count !=  agentIBanLength {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validIbanNumber)
                return (isFilled, ValidationMessages.validIbanNumber)
            }
        }
        if agentbankName == "" {
            return (isFilled, ValidationMessages.validIbanNumber)
        }
        
        if !isVatSelected && !isVatNotSelected {
            return (isFilled, ValidationMessages.vat)
        }
        
        if isVatSelected == true && agentVatNumber == "" {
            return (isFilled, ValidationMessages.vatNumber)
        }
        if isVatSelected == true && vatDocumentUrl == nil {
            return (isFilled, ValidationMessages.vat_certificate)
        }
        if isVatSelected == true && (agentVatNumber == "" || vatDocumentUrl == nil) {
            return (isFilled, ValidationMessages.vatNumberDoc)
        }
        if !agentVatNumber.containArabicNumber {
            return (isFilled, ValidationMessages.vatArabicNumber)
        }
        if isVatSelected == true && agentVatNumber != "" {
            
            agentVatNumber = agentVatNumber.replacingOccurrences(of: " ", with: "")
            if agentVatNumber.count !=  vatLength {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.vatNumber)
                return (isFilled, ValidationMessages.vatNumber)
            }
        }
        
        if !isPolicySelected {
            return (isFilled, ValidationMessages.policy)
        }
            
        else{
            isFilled = true
            isEmail = true
            message = "SignUP Success"
        }
        return (isFilled, message)
    }
 
    func agentSignUp(completion:@escaping(Bool, NSDictionary?) -> ()) {
        
        let str = Authentication.AgentsignUp
        
        let pdfdoc = "vat_certificate"
        
        var pfurl : String? = vatDocumentUrl?.absoluteString
        if pfurl == ""
        {
            pfurl = ""
        }else{
            pfurl = vatDocumentUrl?.absoluteString
        }
        
        var vatAvailable:Int = 0

        if isVatSelected {
            vatAvailable = 1
        }else{
            vatAvailable = 0
        }
        
//        var profilePic: UIImage? = ProfileImage
        
//        if profilePic == nil {
//           profilePic = UIImage(named: "profile_white")
//        }
        
//        print("profilePic:-", profilePic)
      print("docURL:-", pfurl)
        
        let param = ["user_type":"AC",
                     "email":agentEmail,
                     "password":agentPassword,
                     "name":agentBussinessName,
                     "mobile_number":agentContactNumber,
                     "mobile_code":mobileCode,
                     "country_id":agentCountry,
                     "city_id":agentCity,
                     "bank_name":agentbankName,
                     "iban_no":agentbankAccountNumber,
                     "maroof_link":agentMaroofLink,
                     "gender":"",
                     "dob":"",
                     "education":"",
                     "education_major_id":"",
                     "phone_number":agentPhoneNumber,
                     "phone_code":phoneCode,
                     "ac_holder_name":agentbankAccountHolderName,
                     "bank_id":agentbankID,
                     "vat_number":agentVatNumber,
                     "services":ModalController.toString(appDelegate?.selectServiceStr as Any) ,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                     "is_vat_available": vatAvailable
            ] as [String : Any]
        
        print("request -",param)
        ServerCalls.PdfFileAndImageUpload(inputUrl: str, parameters: param, pdfname: pdfdoc, pdfurl: pfurl ?? "",imageName: "user_img",imageFile:ProfileImage ?? nil) { (response, success, resp) in
            
            ModalClass.stopLoading()
            if let value = response as? NSDictionary {
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    completion(false,value)
                }else{
                    completion(true,value)
                }
            }else{
                if response == nil {
                    print ("connection error")
                    ModalController.showNegativeCustomAlertWith(title: "Connection Error", msg: "")
                }else{
                    
                    print ("data not in proper json")
                }
            }
        }
    }
}

// personalAgentModal
class PersonalAgentSignUPModal: NSObject {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var ProfileImage: UIImage?
    var personalAgentType = ""
    var personalAgentImageID : Int = 0
    var personalAgentserviceIDstr = ""
    
    var personalAgentName = ""
    var personalAgentGender = ""
    var personalAgentDob = ""
    var personalAgentEducation = ""
    var personalAgentMajorEducation = ""
    var personalAgentMaroofLink = ""
    
    var personalAgentCountry = ""
    var personalAgentCountryName = ""
    var personalAgentmobileLength = 0
    var personalAgentCity = ""
    var personalAgentCityName = ""
    var personalAgentEmail = ""
    var personalAgentmobileCode = ""
    var personalmobileCodeImage = ""
    var personalAgentContactNbr = ""
    var personalAgentPassword = ""
    var personalAgentConfirmPswd = ""
    
    var personalAgentbankName = ""
    var personalAgentbankID = ""
    var personalAgentbankAccountHolderName = ""
    var personalAgentConfirmEmail = ""
    var personalAgentVatNumber = ""
    var personalAgentAccountNbr = ""
    var personalAgentPolicySelected = false
    var isVatSelected = false
    var isVatNotSelected = false
    
    var personalVatDocumentUrl:URL?
    var personalVatLength:Int = 0
    var personalAgentName_CompareCode = ""
     var PersonalAgentAge_limit = ""
      
    var personalAgentIBanLength:Int = 0
    
    
    func personalAgentValidation() -> (Bool, String) {
        var isFilled = false
        var isEmail = false
        var message = ""
        
        if appDelegate?.selectServiceStr.count == 0 {
            return (isFilled, ValidationMessages.services)
        }
        if personalAgentName == "" {
            return (isFilled, ValidationMessages.Name)
        }
        if ModalController.isValidName(title: personalAgentName) == false {
            return (isFilled, ValidationMessages.validName)
        }
//        if personalAgentGender == "" {
//            return (isFilled, ValidationMessages.Gender)
//        }
//        if personalAgentDob == "" {
//           return (isFilled, ValidationMessages.Dob)
//        }
        if !personalAgentDob.containArabicNumber {
            
            return (isFilled, ValidationMessages.dobArabicNumber)
        }
        if personalAgentEducation == "" {
           return (isFilled, ValidationMessages.Education)
        }
        if personalAgentMajorEducation == "" {
            return (isFilled, ValidationMessages.majorEducation)
        }
        if personalAgentEmail == "" {
            return (isFilled, ValidationMessages.businessEmail)
        }
        let value = ModalController.isValidEmail(testStr: personalAgentEmail)
        if !value{
            return (isEmail, ValidationMessages.WrongemailAddress)
        }
        if !personalAgentEmail.containArabicNumber {
            return (isFilled, ValidationMessages.emailArabicNumber)
        }
        if !personalAgentConfirmEmail.containArabicNumber {
            return (isFilled, ValidationMessages.emailArabicNumber)
        }
        if personalAgentConfirmEmail != personalAgentEmail {
            return (isFilled, ValidationMessages.compareConfirmEmail)
        }
        if personalAgentCountry == "" {
            return (isFilled, ValidationMessages.country)
        }
        if personalAgentCity == ""{
            return (isFilled, ValidationMessages.city)
        }
        
        if personalAgentContactNbr == "" {
            return (isFilled, ValidationMessages.mobile)
        }
        if !personalAgentContactNbr.containArabicNumber {
            return (isFilled, ValidationMessages.ContactNumberArabicNumber)
        }
        if personalAgentmobileLength > 0 {
            personalAgentContactNbr = personalAgentContactNbr.replacingOccurrences(of: " ", with: "")
            if personalAgentContactNbr.count !=  personalAgentmobileLength {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.mobileLength)
                return (isFilled, ValidationMessages.mobileLength)
            }
        }
        if  personalAgentMaroofLink.count > 0 && !personalAgentMaroofLink.containArabicNumber {
            return (isFilled, ValidationMessages.maroofArabicNumber)
        }
        if personalAgentPassword.count < 8 {
            
            return (isFilled, ValidationMessages.passwordCount)
        }
        if !personalAgentPassword.containArabicNumber {
            return (isFilled, ValidationMessages.passArabicNumber)
        }
        if personalAgentPassword == "" {
            return (isFilled, ValidationMessages.password)
        }
        if personalAgentConfirmPswd == "" {
            return (isFilled, ValidationMessages.agentConfirmPassword)
        }
        if !personalAgentConfirmPswd.containArabicNumber {
            return (isFilled, ValidationMessages.passArabicNumber)
        }
        if personalAgentPassword != personalAgentConfirmPswd {
            return (isFilled, ValidationMessages.compareConfirmPassword)
        }
       
        if personalAgentbankAccountHolderName == "" {
              return (isFilled, ValidationMessages.bankAccountHolderName)
        }
        
        if (personalAgentName_CompareCode == "YES".uppercased()) && (personalAgentName != personalAgentbankAccountHolderName) {
            return (isFilled, ValidationMessages.agentName_compare)
        }
        if ModalController.isValidName(title: personalAgentbankAccountHolderName) == false {
        return (isFilled, ValidationMessages.validAccountName)
         }
        if personalAgentAccountNbr == "" {
            return (isFilled, ValidationMessages.bankAccountNumber)
        }
        if !personalAgentAccountNbr.containArabicNumber {
            return (isFilled, ValidationMessages.ibanArabicNumber)
        }
         personalAgentAccountNbr = personalAgentAccountNbr.replacingOccurrences(of: " ", with: "")
        if personalAgentAccountNbr.count != personalAgentIBanLength {
              return (isFilled, ValidationMessages.ValidIBANNumber)
        }
         let bankCode =  personalAgentAccountNbr.substring(from: 0, to: 1)
        let ibanBool = ModalController.isValidIBAN(ibanStr: personalAgentAccountNbr, length: personalAgentIBanLength, countryType: bankCode)
          if ibanBool == false {
            
            ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validIbanNumber)
            return (isFilled, ValidationMessages.validIbanNumber)
          }
        if personalAgentAccountNbr != "" {
            personalAgentAccountNbr = personalAgentAccountNbr.replacingOccurrences(of: " ", with: "")
            if personalAgentAccountNbr.count !=  personalAgentIBanLength {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.validIbanNumber)
                return (isFilled, ValidationMessages.validIbanNumber)
            }
        }

        if personalAgentbankName == "" {
            return (isFilled, ValidationMessages.validIbanNumber)
        }
        
          if !isVatSelected && !isVatNotSelected {
            return (isFilled, ValidationMessages.vat)
            }
        if isVatSelected == true && personalAgentVatNumber == "" {
            return (isFilled, ValidationMessages.vatNumber)
        }
        
        if isVatSelected == true && personalVatDocumentUrl == nil {
            return (isFilled, ValidationMessages.vat_certificate)
        }
        
        if isVatSelected == true && (personalAgentVatNumber == "" || personalVatDocumentUrl == nil) {
            return (isFilled, ValidationMessages.vatNumberDoc)
        }
        
        if !personalAgentVatNumber.containArabicNumber {
            
            return (isFilled, ValidationMessages.vatArabicNumber)
        }
        if isVatSelected == true && personalAgentVatNumber != "" {
            
            personalAgentVatNumber = personalAgentVatNumber.replacingOccurrences(of: " ", with: "")
            if personalAgentVatNumber.count !=  personalVatLength {
                ModalController.showNegativeCustomAlertWith(title: "", msg: ValidationMessages.vatNumber)
                return (isFilled, ValidationMessages.vatNumber)
            }
        }
        if !personalAgentPolicySelected {
            return (isFilled, ValidationMessages.policy)
        }
        else{
            isFilled = true
            isEmail = true
            message = "SignUP Success"
        }
        return (isFilled, message)
    }

    func personalAgentSignUp(completion:@escaping(Bool, NSDictionary?) -> ()) {
      let str = Authentication.AgentsignUp
        
        let pdfdoc = "vat_certificate"
        
        var pfurl : String? = personalVatDocumentUrl?.absoluteString
        if pfurl == ""
        {
            pfurl = ""
        }else{
            pfurl = personalVatDocumentUrl?.absoluteString
        }
        
        var vatAvailable:Int = 0

        if isVatSelected {
            vatAvailable = 1
        }else{
            vatAvailable = 0
        }
        
        var gender = ""
        if personalAgentGender == "Male".localized {
            gender = "M"
        }else if personalAgentGender == "Female".localized {
            gender = "F"
        }
         
        let param = ["user_type":"AI",
                     "email":personalAgentEmail,
                     "password":personalAgentPassword,
                     "name":personalAgentName,
                     "mobile_number":personalAgentContactNbr,
                     "mobile_code":personalAgentmobileCode,
                     "country_id":personalAgentCountry,
                     "city_id":personalAgentCity,
                     "bank_name":personalAgentbankName,
                     "iban_no":personalAgentAccountNbr,
                     "maroof_link":personalAgentMaroofLink,
                     "gender":gender,
                     "dob":personalAgentDob,
                     "education":personalAgentEducation,
                     "education_major_id":personalAgentMajorEducation,
                     "phone_number": "",
                     "phone_code":"",
                     "ac_holder_name":personalAgentbankAccountHolderName,
                     "bank_id":personalAgentbankID,
                     "vat_number":personalAgentVatNumber,
                     "services":ModalController.toString(appDelegate?.selectServiceStr as Any),
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected,
                     "is_vat_available": vatAvailable] as [String : Any
                     ]
        
        print(param)
        ServerCalls.PdfFileAndImageUpload(inputUrl: str, parameters: param, pdfname: pdfdoc, pdfurl: pfurl ?? "",imageName: "user_img",imageFile:ProfileImage ?? nil) { (response, success, resp) in
            ModalClass.stopLoading()
            if let value = response as? NSDictionary{
                let msg = value.object(forKey: "error_description") as! String
                let error = value.object(forKey: "error_code") as! Int
                if error == 100{
                    completion(false,value)
                }else{
                    
   //                 AuthorisedUser.shared.setAuthorisedUser(with:response)
                    
                    completion(true,value)
                }
            }
        }
    }
    
}
