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
     static let currency : String = "SAR".localized
    //wallet
    static let viewinvoice : String = "invoice/download_invoice/"
    static let DeleteBankURL: String = "businessapi/v2/bankdelete/"
    static let allWalletTransactionsAPI : String = "wallet/wallet_balance_list/"
    static let addedBanksList : String = "businessapi/v2/users_bank_list/"
    static let transferMoneyApi : String = "agentapi/v1/transfer_to_bank/"
    static let addNewBankAPI : String = "wallet/add_bank/"
    static let updateBankAPI : String = "wallet/update_bank/"
    static let deleteBankNewAPI : String = "businessapi/v2/users_bank_delete/"
    static let send_wallet_pdf_email : String = "wallet/send_wallet_pdf_email/"
    static let bankIdentifier_List : String = "businessapi/v2/search_iban_number/";
    
    //service
    static let custratingapi : String = "shared_economy/agent/customer_rating/"
    static let boratingapi : String = "bo_agent_delivery/agent_rating_to_bo/"
     static let productVariantList: String = "/customerapi/v1/variantProduct/"
     static let getproductlistfilter : String = "customerapi/v1/product_list_filter/";
      static let removedatasellproduct : String = "product_api/customerDataBankDeleteProduct/";
     static let payment_method_list : String = "product_api/payment_page/"
    static let customerdatabank : String = "product_api/customerDataBankProduct/";
    static let similarvarientdata : String = "product_api/customerDataBankProductOther/";
    static let addproductNew : String = "services/agent_add_product/";
   static let productlimit : String = "product_api/ProductLimit/";
      static let productsellinfo : String = "product_api/sellProductInfo/";
    static let databankdetails : String = "product_api/customerDataBankProductDetails/";
    static let productcode : String = "product_api/getProductCode/";
      static let checkbar : String = "product_api/checkBarcode/";
     static let storepay : String = "product_api/storePaymentList/";
     static let editproductNew : String = "services/agent_edit_product/";
    static let productdetailnew : String = "product_api/detailProduct/";
    static let Branch_List : String = "businessapi/v2/branchlist/";
    static let addfilternew : String = "product_api/addFilter/";
     static let filterlistnew : String = "product_api/filterList/";
     static let ptatformList: String = "businessapi/v2/platform_type/"
    static let displayTYpe: String = "businessapi/v2/time_display_type/"
       static let uploadBranchImage: String = "businessapi/v2/uploadimage/"
         static let uploadgalleryImage: String = "product_api/uploadGalleryImages/"
       static let uploadbranchgalleryImage: String = "businessapi/v2/upload_fynoo_gallery_images/"
         static let pdfupload : String = "product_api/uploadDocument/";
       static let showimglist: String = "businessapi/v2/uploaded_images_list/"
       static let contentname : String = "common/get_content_name/";
     static let AddBranch : String = "businessapi/v2/addbranch/";
     static let addbranch : String = "services/agent_create_branch/";
      static let addbranchlogo : String = "businessapi/v2/add_branch_logo/";
     static let deleteImg : String = "businessapi/v2/deleteimage/";
     static let branchdetaillist : String = "businessapi/v2/branchdetailview/";
      static let descriptionVal : String = "businessapi/v2/branch_desc_limit/";
     static let AddressType_List : String = "BO/addresstypelist/";
    static let branchMultipleImageType : String = "businessapi/v2/upload_branch_multiple_image/";
       static let branchStoreSave : String = "businessapi/v2/update_branch_store_image/"
     static let BusinessType_List : String = "BO/businessTypeList/";
     static let MAllMarket_List : String = "businessapi/v1/mallmarketlist/";
    static let UpdateProfile_Image : String = "agentapis/v2/update_profile_photo/";
    
    static let upload_invoice : String = "shared_economy/agent/upload_invoice/"
    static let upload_invoiceForBo : String = "bo_agent_delivery/agent_upload_and_confirm_invoice/"
    
    //      static var BASE_URL : String = "http://43.241.61.141:9003/"
    //  static var BASE_URL : String = "http://43.241.61.141:9005/"

    static let getStockDataNew: String = "product_api/getStockData/"
       static let updateStockData: String = "product_api/updateStock/"
     static let updateBranch : String = "services/agent_create_branch/";
    // business gallery
    static let uploadGalleryImg : String = "gallery/business_gallery/"
       static let businessGalleryList: String = "gallery/business_gallery_list/"
       static let deleteBusinessGallery: String = "gallery/business_gallery_delete/"
       static let filterGallery: String = "gallery/business_gallery_filter/"
       static let filterList: String = "gallery/bo_agent_list/"
    

    static let vatlengthlist: String = "product_api/getVatLength/"
    
    static let Country_List : String = "common/getCountry/";
    static let City_List : String = "common/getCity/";
    static let Bank_List : String = "businessapi/v2/bank_list/";
    static let Education_List : String = "businessapi/v3/education_list/";
    static let Service_List : String = "agentapi/v1/agentservices/";
  
//         static var BASE_URL : String = "http://61.95.220.248:9092/"
    //      static var BASE_URL : String = "http://61.95.220.248:9095/"  //CLIENT URL FOR NOW
    //static var BASE_URL : String = "https://dev.fynoo.com:8001/"
    static var BASE_URL : String = "http://uat.sendan.com.sa:9003/"  // dev
     //static var BASE_URL : String = "https://dev.fynoo.com/"   //live
   
    
    //      static var BASE_URL : String = "http://43.241.61.141:9003/"
    //  static var BASE_URL : String = "http://43.241.61.141:9005/"
        
    static let getAppVersion : String = "common/getAppVersion/";
    static let ForgotPswd: String = "customerapi/v2/forgot_password/"
    static let ResetPswd: String = "customerapi/v2/reset_password/"
    static let get_user_type: String = "customerapi/v2/get_user_type/"
    static let agent_dashboard: String = "agentapis/v2/agent_dashboard/"
    static let firebase_token : String = "customerapi/v2/firebase_token/"
    static let add_services: String = "agentapis/v2/add_services/"
    static let logout: String = "customerapi/v2/user_logout/"
    
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
    static let FONT_Extra_BOLD =  NSLocalizedString("BoldFontName", comment: "")
    static let FONT_Light =  NSLocalizedString("LightFontName", comment: "")
    
    
    // Mark:- Google ApiKey
    static let GET_NOTIFICATION = "GET_NOTIFICATION"
    static let GOOGLE_API_KEY = "AIzaSyDGzVH50GxKpAAU69gcux1_VMd45G1gJxc"
    static let GOOGLE_API_DISTANCE = "https://maps.googleapis.com/maps/api/directions/json?"
    static let SEARCH_AGENT_NOTIFICATION = "SEARCH_AGENT"
    static let AGENT_NOTIFICATION = "AGENT_NOTIFICATION"
    static let GET_NOTIFICATIONARV = "AGENT_NOTIFICATIONARV"
    
    static let NF_KEY_FOR_PASS_DATA_TO_DELIVERYDASHBOARD = "PASS_DATA_TO_DELIVERY_DASHBOARD"
    
}

enum Service {
    //wallet
    static let BankList  = Constant.BASE_URL + "businessapi/v2/banklist/"
    
    static let AddBankDetailURL = Constant.BASE_URL + "businessapi/v2/addbankdetails/"
    static let DeleteBankURL = Constant.BASE_URL + "businessapi/v2/bankdelete/"
    static let UpdateBankDetailsURL = Constant.BASE_URL + "businessapi/v2/updatebankdetails/"
    static let Bank_List : String =  Constant.BASE_URL + "businessapi/v2/bank_name_list/"
    static let transferApi : String = Constant.BASE_URL +  "agentapi/v1/transfer_to_bank/"
    static let bankTransferHistory = Constant.BASE_URL +   "agentapi/v1/bank_transfer_list/"
    
    
    static let selectCategory = Constant.BASE_URL + "customerapi/v1/categorylist/"
       static let selectSubCategory = Constant.BASE_URL + "customerapi/v1/subcategorylist/"
        static let productVariantList =  Constant.BASE_URL + "product_api/variantProduct/"
    static let deactivateService = Constant.BASE_URL + "agentapis/v2/deactivate_services/"
    static let saveLanguage = Constant.BASE_URL + "agentapi/v1/save_language/"
    static let activateService = Constant.BASE_URL + "agentapis/v2/activate_services/"
    static let languageList = Constant.BASE_URL + "agentapi/v1/agent_language_list/"
    static let userProfileData = Constant.BASE_URL + "businessapi/v1/GetUserDetails/"
    static let commisionlist = Constant.BASE_URL + "agentapis/v2/agent_commision/"
    static let targetlist = Constant.BASE_URL + "target_master_api/v2/target/"
     static let commisiondetaillist = Constant.BASE_URL + "agentapis/v2/agent_service_page/"
    static let getProfile = Constant.BASE_URL + "agentapis/v2/agent_profile/"
    static let getUserDetail = Constant.BASE_URL + "agentapis/v2/agent_profile_api/"
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
    static let gettripDetail = Constant.BASE_URL + "shared_economy/agent/trip_details/"
    static let acceptedTripDetail = Constant.BASE_URL + "shared_economy/agent/accepted_trip_details/"
    static let orderDetail = Constant.BASE_URL + "shared_economy/agent/order_detail/"
    
    static let reasonforreturn = Constant.BASE_URL + "customerapi/v2/reason_for_return/"
    static let deleteIndivisualItem = Constant.BASE_URL + "shared_economy/agent/delete_individual_item/"
    static let reduceQuantity = Constant.BASE_URL + "shared_economy/agent/change_product_qty/"
    static let acceptIndivisualItem = Constant.BASE_URL + "shared_economy/agent/accept_individual_item/"
    static let onTheWayTripDetail = Constant.BASE_URL + "shared_economy/agent/on_the_way_trip_details/"
    static let deliverOrder = Constant.BASE_URL + "shared_economy/agent/deliver_order/"
    
    static let agentAcceptCancellation = Constant.BASE_URL + "shared_economy/agent/agent_accept_cancellation/"
    static let agentRejectCancellation = Constant.BASE_URL + "shared_economy/agent/agent_reject_cancellation/"
    static let agentCancellationDetail = Constant.BASE_URL + "shared_economy/agent/agent_cancellation_detail/"
    
    static let agentAcceptRequest = Constant.BASE_URL + "shared_economy/agent/request_accept/"
    static let agentDeclineRequest = Constant.BASE_URL + "shared_economy/agent/request_decline/"
    
    static let agentCancelOrder = Constant.BASE_URL + "shared_economy/agent/agent_cancel_order/"
    static let agentSetLatLong = Constant.BASE_URL + "shared_economy/agent/set_lat_long/"
    
    static let agentReachedToBoStore = Constant.BASE_URL + "bo_agent_delivery/agent_reached_to_bo_store/"
    
    static let agentConfirmToReceiveItems = Constant.BASE_URL + "bo_agent_delivery/agent_confirm_to_receive_items/"
    
    static let reportToBoByAgent = Constant.BASE_URL + "/shared_economy/agent/report_to_bo_by_agent/"
  
}

enum Authentication {
     static let productVariantList =  Constant.BASE_URL + "product_api/variantProduct/"
    static let similaralllist = Constant.BASE_URL +   "product_api/customerDataBankAllProductList/"
     static let databankProductView = Constant.BASE_URL +   "product_api/customerDataBankProductView/"
    static let changePassword = Constant.BASE_URL +    "customerapi/v2/changepassword/"
    static let dataBankSelling = Constant.BASE_URL +   "product_api/customerDataBankList/"
       static let dataBankSellingfilter = Constant.BASE_URL +   "product_api/customerDataBankListFilter/"
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

 // dataEntryModule APIs
enum dataEntryModuleApi {
    
     static let agentServicesOrder_list : String =  Constant.BASE_URL + "services/agent_data_entry_services/"
     static let serviceType_list : String =  Constant.BASE_URL + "services/add_new_order_page/"
     static let branchName_list : String =   Constant.BASE_URL + "services/bo_branch_list/"
     static let save_newDataEntry : String =   Constant.BASE_URL + "services/agent_accept_des/"
     static let newDataEntry_orderSummery : String =   Constant.BASE_URL + "/services/des_order_summary/"
     static let dataEntryCancel_Reason : String =   Constant.BASE_URL + "services/data_entry_cancel_reasons/"
     static let cancelDataEntry_BO : String =   Constant.BASE_URL + "services/agent_reject_service_order/"
    static let orderDataEntry_service : String =   Constant.BASE_URL + "services/bo_des_place_order/"
    static let DataEntry_Detail : String =   Constant.BASE_URL + "services/agent_service_detail/"
    
    static let DataEntry_Agent_StartWork : String =   Constant.BASE_URL + "services/agent_start_data_entry/"
    static let DataEntry_Agent_WorkConfirmation : String =   Constant.BASE_URL + "services/agent_submit_data_entry/"
     static let otherService_SubmitService_task : String =   Constant.BASE_URL + "services/agent_submit_other_service_task/"
     static let DataEntry_serviceType : String =   Constant.BASE_URL + "services/bo_agent_data_entry_items/"
     static let DataEntry_agentRating : String =   Constant.BASE_URL + "services/add_agent_bo_rating/"
    

    
}
