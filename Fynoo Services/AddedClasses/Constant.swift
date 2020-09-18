//
//  Constant.swift
//  BaseProjectSwift
//                          
//  Created by Aishwarya
//  Copyright © 2019 Aishwarya. All rights reserved.
//
import UIKit
enum ValidationMessages {
    static let passwordCount  = "Please enter 8 digit password"
    static var WrongemailAddress = "Please enter valid Email"
    static let emailAddress = "Please enter Email"
    static var OnlyEmail = "Please enter Email"
    static let loginUserType = "Please select login user type."
    static var password = "Please enter password"
    static let mobile  = "Please enter mobile number"
    static let Phone  = "Enter Your phone Number"
    static let name = "Please enter name"
    static let country = "Please enter country"
    static let countryCode = "Please Select Country Code"
    static let city = "Please enter city"
    static let confirmPassword = "Password and confirm password do not match"
   
     static let confPassss = "Please enter confirm password"
    static let confPass = "Please enter 8 digit confirm password"
    static let policy = "Please check user policy"
    static let vat = "Please enter valid vat no"
    static let mobileLength = "Please enter valid mobile number"
    static let mobileContainArabic = "Mobile Number must not contain Arabic Numbers"
    static let phoneNumber = "Please enter valid phone number"
    static let passArabicNumber = "Password must not contain any Arabic Numbers"
    static let emailArabicNumber = "Email must not contain any Arabic Numbers"
    static let ContactNumberArabicNumber = "Contact Number must not contain any Arabic Numbers"
    static let ibanArabicNumber = "IBAN Number must not contain any Arabic Numbers"
    static let vatArabicNumber = "VAT Number must not contain any Arabic Numbers"
    static let maroofArabicNumber = "Maroof Link must not contain any Arabic Numbers"
    static let dobArabicNumber = "DOB must not contain any Arabic Numbers"
    static let otpArabic = "OTP Must Contain Arabic Character" // new
    static let BankName = "Please Enter Iban No. First"
    
    
    //agentSignUPValidationMessages
    static let companyLogo = "Please select company Logo."
    static let profileImage = "Please select profile image."
    static let businessName = "Please enter your business name."
    static let services = "please select minimum one service."
    static let businessEmail = "Please enter email id."
    static let compareConfirmEmail = "Email and confirm email do not match"
    static let maroofLink = "Please enter your maroof link."
    static let agentConfirmPassword = "Please enter your confirm password."
    static let compareConfirmPassword = "Your Password & Confirm Password Does Not Match"
    static let bankName = "Please select your bank name."
    static let bankAccountHolderName = "Please enter your bank account holder name."
    static let bankAccountNumber = "Please enter your IBAN No."
    static let validIbanNumber = "Please enter valid IBAN No."
    static let vatNumber = "Please enter valid vat Number."
    static let NickName = "Please enter your Nick Name."
    static let Name = "Please enter your name."
    static let validName = "Please enter valid name."
    static let validAccountName = "Please enter valid Account Holder Name."
    static let Gender = "Please select your gender."
    static let Dob = "Please enter your DOB."
    static let Education = "Please select your education."
    static let majorEducation = "Please select your major education."
    static let mismatchIban = "Iban and Re-Iban Does not Match."
    //OTP message
    static let verifyOTP = "Please enter valid OTP"
    
    //AddNewProduct
    static let buyerType = "Please select the discount type from 'Buyer gets' field."
    static let discount = "Please enter discount value."
    static let quantity = "Please enter the max qty of product on which the discount will be applied"
    
    static let startDate = "Please select start date and time."
    static let endDate = "Please select end date and time"
    static let DiscountName = "Please enter discount name."
    static let wholesalePrice = "Please enter wholesale Price."
    
    
    //courierCompany Form Message
    
    static let courierCompanyName = "Please select courier Company."
    static let otherCompanyName = "Please enter other courier company name."
    static let trackingNumber = "please enter tracking number."
    static let shortLink = "Please enter valid tracking short link."
    static let companyWebsite = "Please select company website link."
    static let validCompanyWebsite = "Please select valid courier website link."
}

class Constant: NSObject {
    
    static let UpdateProfile_Image : String = "agentapis/v2/update_profile_photo/";

//      static var BASE_URL : String = "http://43.241.61.141:9003/"
      //  static var BASE_URL : String = "http://43.241.61.141:9005/"
    static let vatlengthlist: String = "product_api/getVatLength/"

    static let Country_List : String = "common/getCountry/";
      static let City_List : String = "common/getCity/";
      static let Bank_List : String = "businessapi/v2/bank_list/";
      static let Education_List : String = "businessapi/v3/education_list/";
      static let Service_List : String = "agentapi/v1/agentservices/";
      static let bankIdentifier_List : String = "businessapi/v2/search_iban_number/";
     static var BASE_URL : String = "http://61.95.220.248:9092/"
//      static var BASE_URL : String = "http://61.95.220.248:9095/"  //CLIENT URL FOR NOW
    
 
    static let getAppVersion : String = "common/getAppVersion/";
    
}

enum Service {
    
    static let languageList = Constant.BASE_URL + "agentapi/v1/agent_language_list/"
    static let userProfileData = Constant.BASE_URL + "businessapi/v1/GetUserDetails/"
    static let commisionlist = Constant.BASE_URL + "agentapis/v2/agent_commision/"
    static let targetlist = Constant.BASE_URL + "target_master_api/v2/target/"
    static let getProfile = Constant.BASE_URL + "agentapis/v2/agent_profile/"
    static let updateProfile = Constant.BASE_URL + "agentapis/v2/update_agent_profile/"
    static let getBankDetail = Constant.BASE_URL + "agentapi/v1/get_bank_name_by_identifier/"
    static let getIbanLength = Constant.BASE_URL + "agentapi/v1/get_iban_length/"
    
    
}
