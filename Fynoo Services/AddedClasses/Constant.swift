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
    static let vat = "Please select vat option."
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
    static let agentName_compare = "Your Business Name & Acount Holder Name Does Not Match"
    static let bankAccountNumber = "Please enter your IBAN No."
    static let validIbanNumber = "IBAN number does not belong to any bank."
    static let vatNumber = "Please enter valid vat Number."
     static let vatNumberDoc = "Please enter valid vat Number/vat certificate."
     static let vat_certificate = "Please submit vat certificate."
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
    
 
    
    //      static var BASE_URL : String = "http://43.241.61.141:9003/"
    //  static var BASE_URL : String = "http://43.241.61.141:9005/"
    
    //      static var BASE_URL : String = "http://61.95.220.248:9095/"  //CLIENT URL FOR NOW
    
    
    static let getAppVersion : String = "common/getAppVersion/";
    static let ForgotPswd: String = "customerapi/v2/forgot_password/"
    static let ResetPswd: String = "customerapi/v2/reset_password/"
    static let get_user_type: String = "customerapi/v2/get_user_type/"
    static let agent_dashboard: String = "agentapis/v2/agent_dashboard/"
    static let add_services: String = "agentapis/v2/add_services/"
  //  static let UpdateProfile_Image : String = "businessapi/v1/ChaneProfileImage/";
    static let activate_services: String = "agentapis/v2/activate_services/"
    static let deactivate_services: String = "agentapis/v2/deactivate_services/"
    
    
    
    // MARK:- AgentAPIs
    
    static let upload_file : String = "businessapi/v2/uploadimage/";
    static let vatInfo_Data : String = "product_api/getVatLength/";
     static let IBANLengthInfo_Data : String = "agentapi/v1/get_iban_length/";
    static let language_List : String = "agentapi/v1/agent_language_list/";
     static let saveSelected_Language : String = "agentapi/v1/save_language/";
    
    // MARK: - COLORS AND FONTS
    static let Green_TEXT_COLOR = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
    static let Blue_TEXT_COLOR = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
    static let Black_TEXT_COLOR = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let Grey_TEXT_COLOR = UIColor(red: 56.0/255, green: 56.0/255, blue: 56.0/255, alpha: 1.0)
    static let Red_TEXT_COLOR = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
    
}

enum Service {
    
    
    static let saveLanguage = Constant.BASE_URL + "agentapi/v1/save_language/"

    static let languageList = Constant.BASE_URL + "agentapi/v1/agent_language_list/"
    static let userProfileData = Constant.BASE_URL + "businessapi/v1/GetUserDetails/"
    static let commisionlist = Constant.BASE_URL + "agentapis/v2/agent_commision/"
    static let targetlist = Constant.BASE_URL + "target_master_api/v2/target/"
    static let getProfile = Constant.BASE_URL + "agentapis/v2/agent_profile/"
    static let getdocumentlist = Constant.BASE_URL + "agentapi/v1/get_vehicle_service_document/"
     static let gettypecolor = Constant.BASE_URL + "agentapi/v1/get_registration_brand_color/"
     static let getvehiclekind = Constant.BASE_URL + "agentapi/v1/get_vehicle_kind/"
      static let getvehiclename = Constant.BASE_URL + "agentapi/v1/get_vehicle_name/"
    static let tripList = Constant.BASE_URL + "agentapis/v2/service_trip_list/"
    static let updateCod = Constant.BASE_URL + "agentapis/v2/update_cod_amount/"
    static let deliveryDashboard = Constant.BASE_URL + "agentapis/v2/delivery_dashboard/"
    static let updateProfile = Constant.BASE_URL + "agentapis/v2/update_agent_profile/"
    static let getBankDetail = Constant.BASE_URL + "agentapi/v1/get_bank_name_by_identifier/"
    static let getIbanLength = Constant.BASE_URL + "agentapi/v1/get_iban_length/"
    static let uploadimage = Constant.BASE_URL + "agentapi/v1/vehicle_service_document/"
       
    
}

enum Authentication {
     static let viewDelivery =  Constant.BASE_URL + "bo_order_api/bo_delivery_charge_details/"
     static let deliverySaved =  Constant.BASE_URL + "bo_order_api/add_update_bo_delivery_charge/"
    static let CouriercompanyList =  Constant.BASE_URL + "bo_order_api/courier_company/"
      static let productReturnPolicy =  Constant.BASE_URL + "customerapi/v2/get_return_policy/"
     static let bo_follower =  Constant.BASE_URL +  "businessapi/v2/bo_followers_list/"
    static let otpExpireTime = Constant.BASE_URL +    "customerapi/v2/dynamic_otp_time/"
    static let vat = Constant.BASE_URL +    "product_api/getVat/"
    static let login = Constant.BASE_URL +    "customerapi/v2/login/"
    static let signUp = Constant.BASE_URL +    "customerapi/v2/signup/"
    static let invoiceList =  Constant.BASE_URL + "customerapi/v1/invoice_list/"
    static let notificationList = Constant.BASE_URL +  "customerapi/v2/notification_list/"
    static let followers_listss =  Constant.BASE_URL +  "customerapi/v1/branch_followers_list/"
    static let productFollowers_list =  Constant.BASE_URL +  "product_api/productFollowerList/"
    static let reviewBranchList = Constant.BASE_URL +   "customerapi/v1/branch_review_list/"

    // Neeraj
    static let verifyOtp = Constant.BASE_URL +    "customerapi/v2/verifyuser/"
    static let AgentsignUp = Constant.BASE_URL + "customerapi/v2/agentsignup/"
    static let resentVerifyOtp = Constant.BASE_URL +   "customerapi/v2/resendverifycode/"
    static let purchasedProductlist = Constant.BASE_URL   + "businessapi/v3/purchased_product_list/"
    static let orderPlace = Constant.BASE_URL +   "customerapi/v2/place_order/"
    static let paymentOption = Constant.BASE_URL +   "businessapi/v3/payment_method/"
    static let cardDetail = Constant.BASE_URL + "customerapi/v2/user_card_details/"
    
    static let CategoryList = Constant.BASE_URL +    "customerapi/v1/categorylist/"
    static let subCatgoryList = Constant.BASE_URL +    "customerapi/v1/subcategorylist/"
    static let productDataBank = Constant.BASE_URL +    "businessapi/v3/data_bank_list/"
    static let payDataBank = Constant.BASE_URL +    "businessapi/v3/product_data_sale/"
    static let imageGallery = Constant.BASE_URL +    "businessapi/v3/image_gallery/"
    static let paymentData = Constant.BASE_URL +    "businessapi/v3/payment_method/"
    static let access_StatusCheck = Constant.BASE_URL + "businessapi/v2/check_subscription_perm/"
    //  static let reviewBranchList = Constant.BASE_URL +   "businessapi/v3/branch_review_list/"
    //   static let reviewProductList = Constant.BASE_URL +   "businessapi/v3/product_review_list/"
    static let reviewProductImage = Constant.BASE_URL +   "businessapi/v3/product_review_image_list/"
    static let reviewBranchImage = Constant.BASE_URL +   "businessapi/v3/branch_review_image_list/"
    
    static let verifyDeliveryOtp = Constant.BASE_URL +   "agentapis/v2/verify_otp/"
    static let cancelServiceCharge = Constant.BASE_URL +   "shared_economy_api/v1/get_cancellation_charges/"
    
    // AddDiscountedProductNewApis
    
    static let addDiscountOnProduct = Constant.BASE_URL +  "businessapi/v3/bo_promotion/"
    static let Discounted_ProductList  = Constant.BASE_URL + "businessapi/v3/GetBoToCustomerDiscountList/"
    static let deleteDiscountOnProduct = Constant.BASE_URL +  "businessapi/v3/delete_btc_promotion/"
     static let changeDiscountStatusOnProduct = Constant.BASE_URL +  "businessapi/v3/ChangeDiscountStatus/"
    static let editDiscountOnProduct = Constant.BASE_URL +  "businessapi/v3/BoToCustomerDiscountEdit/"
    
    
    
    
    

    
}
