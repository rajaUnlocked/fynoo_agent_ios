//
//  ProductModel.swift
//  Fynoo Business
//
//  Created by sanjay kumar on 12/10/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation
import UIKit
class ProductModel
{
   
    
    
    //new range Temp Pro
    var isVat = false
    var likeRangeTemp = ""
    var activationTemp = ""
    var priceTemp = ""
    var noBranchTemp = ""
     
    //new range Temp Branch
    var likeRangeBranchTemp = ""
    var followerTemp = ""
    var ratingTemp = ""
    var noItemTemp = ""

    var applyDone = false
    // property
    var activateIndex = NSMutableArray()
    var availIndex = NSMutableArray()
    var discountActivateIndex = NSMutableArray()
    var discountCurrencyIndex = NSMutableArray()
    var cataIndex = NSMutableArray()
    var currencyIndex = NSMutableArray()
    var platformIndex = NSMutableArray()
    var activatebranchIndex = NSMutableArray()
    var activateMangeDropIndex = NSMutableArray()
    var busstypeIndex = NSMutableArray()
    var dataBankActivateIndex = NSMutableArray()
    var commActivateIndex = NSMutableArray()
    var commCurrencyIndex = NSMutableArray()
    var paymentMode = NSMutableArray()
    
    
    
    var availitem = ""
    var purchases = ""
    var availitembranch = ""
    var price = ""
    var paymentId = ""
    var commPercentId = ""
    var data_bank_pro_price = ""
    var numberbranch = ""
    var discountPriceRange = ""
    var PriceRangeDis = ""
    var likerange = ""
    var likerangebranch = ""
    var discountId = ""
    var isdiscountedId = ""
    var priceTypeId = ""
    var dropshipingId = ""
    var timestamp = ""
    var commissionRange = ""
    var commissionRangeManageDS = ""
    var manageCommRangeSlider = ""
    var commPercentRange = ""
    var  follower = ""
    var rating = ""
    var timestampProductRange = ""
    var timestampBranchRange = ""
    // commission range slider
    var commissionRangeSlider = ""
    var commPercentRangeSlider = ""
    
    // data bank range slider
    var data_bank_pro_price_Range_Slider = ""
    var purchasesRangeSlider = ""
    var timestampRange = ""
    
    // discountPrice
    var discountPriceRangeSlider = ""
    var PriceRangeDisSlider = ""
    
    var descriptions = ""
    var supportdescriptions = ""
    var onlineQuanTo = 0
    var QuanTo = 0
    var pro_final_status = 0
    var finalStatus:Int = 1
    var statusActive = 0
    var filledstep = 0
    var productId:String = ""
    var weight = 0.0
    var height = 0.0
    var width = 0.0
    var length = 0.0
    var dimension = 0.0
    var isdraft:Bool = false
    var isedit:Bool = false
    var deliverycharge:String = ""
    var galleryFeatureId:String = ""
    var galleryFeatureImage:String = ""
    var galleryId:NSMutableArray = NSMutableArray()
    var galleryIdImageNew = [UIImage]()
    
    var galleryIdImage:NSMutableArray = NSMutableArray()
    var type:Bool = false
    var Currencyname:String = ""
    var BranchCount = 0
    var BranchName:String = ""
    var pronoqty:NSMutableArray = NSMutableArray()
    var technical:String = ""
    var filterIdName:NSMutableArray = NSMutableArray()
    var filterId:NSMutableArray = NSMutableArray()
    var filterIdValue:NSMutableArray = NSMutableArray()
    var filterIdValueName:NSMutableArray = NSMutableArray()
    var SelectedVarientIndex:NSMutableArray = NSMutableArray()
    var OnlinewholeSalePrice1Unit:NSMutableArray = NSMutableArray()
    var wholeSalePrice1Unit:NSMutableArray = NSMutableArray()
    var retail:Bool = false
    var Whole:Bool = false
    var Onlineretail:Bool = false
    var OnlineWhole:Bool = false
    var cataId:String = ""
    var cataIdname:String = ""
    var subcataId:String = ""
    var cataImage:String = ""
    var subcataImage:String = ""
    var subcataIdName:String = ""
    var QuantityFrom:NSMutableArray = NSMutableArray()
    var Quantityto:NSMutableArray = NSMutableArray()
    var WholeSalePriceFrom:NSMutableArray = NSMutableArray()
    var WholeSalePriceTo:NSMutableArray = NSMutableArray()
    var DeliveryCharges:NSMutableArray = NSMutableArray()
    var discountWhole:NSMutableArray = NSMutableArray()
    var OnlineQuantityFrom:NSMutableArray = NSMutableArray()
    var OnlineQuantityto:NSMutableArray = NSMutableArray()
    var OnlineWholeSalePriceFrom:NSMutableArray = NSMutableArray()
    var OnlineWholeSalePriceTo:NSMutableArray = NSMutableArray()
    var OnlineDeliveryCharges:NSMutableArray = NSMutableArray()
    var OnlinediscountWhole:NSMutableArray = NSMutableArray()
    var varientId:NSMutableArray = NSMutableArray()
    var videoUrl:String = ""
    var isProductType:Bool = false
    var purchaseId = ""
    var OnlinediscountWholePercent:NSMutableArray = NSMutableArray()
    var OnlineVatValue:NSMutableArray = NSMutableArray()
    var OnlineVatPercent:NSMutableArray = NSMutableArray()
    var OnlineFinalPrice:NSMutableArray = NSMutableArray()
    var isoffline:Bool = false
    var pro_reference_id = ""
    var isOnline:Bool = false
    var ocrView:String = ""
    var productTitle:String = ""
    var productcode:String = ""
    var barcode:String = ""
    var productDecription:String = ""
    var productDecriptionVal = 0
    var productImageVal = 0
    var productDocVal = 0
    var descriptionsVal = 0
    var supportdescriptionsVal = 0
    var currencyId:String = ""
    var branchId:String = ""
    var branchIdnew:NSMutableArray = NSMutableArray()
    var BranchNamenew:NSMutableArray = NSMutableArray()
    var BranchImgnew:NSMutableArray = NSMutableArray()
    
    var deliveryDays:String = ""
    var stockQuan:String = ""
    var OnlineRegular:String = ""
    var Onlinediscount:String  = ""
    var OnlinediscountPer:String  = ""
    
    var Onlinesell:String  = ""
    var OnlineFinal:String  = ""
    var OnlineVat:String  = ""
    var OnlineVatPer:String  = ""
    var OnlineMax:String  = ""
    var OnlineMin:String = ""
    var OnlineMaxQuan:String = ""
    var OnlineperProduct:Bool  = false
    var OnlinefixedProduct:Bool  = true
    var OnlineProductRegular:String = ""
    var OnlineProductdiscount:String  = ""
    var OnlineProductsell:String  = ""
    var OnlineProductFinal:String  = ""
    var OnlineProductVat:String  = ""
    var OnlineProducteMax:String  = ""
    var OnlineProductMinQuan:String = ""
    var OnlineReturn:Bool  = false
    var OnlineExchange:Bool  = false
    var OnlineReturnDays:String  = ""
    var OnlineExchangeDays:String  = ""
    var OnlineReturn1:Bool  = false
    var OnlineExchange1:Bool  = false
    var OnlineReturnDays1:String  = ""
    var OnlineExchangeDays1:String  = ""
    var Online:Bool  = false
    var Cash:Bool = false
    var RetailRegular:String  = ""
    var Retaildiscount:String  = ""
    var RetaildiscountPer:String = ""
    var Retailsell:String  = ""
    var RetailFinal:String  = ""
    var RetailVat:String  = ""
    var RetailVatPer:String  = ""
    var RetailMax:String  = ""
    var RetailMin:String  = ""
    var RetailMaxQuan:String = ""
    var RetailperProduct:Bool  = false
    var RetailfixedProduct:Bool  = true
    var RetailProductRegular:String = ""
    var RetailProductdiscount:String  = ""
    var RetailProductsell:String  = ""
    var RetailProductdiscountPer:String = ""
    var RetailProductFinal:String  = ""
    var RetailProductVatPer:String = ""
    var RetailProductVat:String  = ""
    var RetailProducteMax:String  = ""
    var RetailProducteMin:String  = ""
    var RetailProductMaxQuan:String = ""
    var RetailReturn:Bool  = false
    var RetailExchange:Bool  = false
    var RetailReturnDays:String = ""
    var RetailExchangeDays:String = ""
    var RetailReturn1:Bool  = false
    var RetailExchange1:Bool  = false
    var RetailReturnDays1:String = ""
    var RetailExchangeDays1:String = ""
    var Online1:Bool  = false
    var Cash1:Bool  = false
    var perProductArr = NSMutableArray()
    var storePayArr = NSMutableArray()
    var documentId = NSMutableArray()
    var documentImage = NSMutableArray()
    var documentImageSize = NSMutableArray()
    
    
    var editproductsell = false
          
          var orderQtyPro = ""
          var PriceOrder = ""
          var statusOrder = NSMutableArray()
          var statusOrderTemp = NSMutableArray()
          var orderQtyProTemp = ""
          var PriceOrderTemp = ""
         
           var datapricesell = NSMutableArray()
          var statussell = ""
         var numphotosell = ""
           var numsoldsell = ""
            var cataIdsell:String = ""
          var subcataIdsell:String = ""
          var datapriceselltemp = NSMutableArray()
             var statusselltemp = ""
            var numphotoselltemp = ""
              var numsoldselltemp = ""
               var cataIdselltemp:String = ""
             var subcataIdselltemp:String = ""
          var daterangesell:String = ""
           var salecount  = 0
          
          var brandIndex = NSMutableArray()
           var brandIndextemp = NSMutableArray()
            var pricetemp = ""
          var likeRangetemp = ""
          var rangeTemp = ""
            var rangetemp = ""
         
          var ratingrange = ""
            var discountIdtemp = ""
             var dropshipingIdtemp = ""
          var paymentModetemp = NSMutableArray()
          var primaryKeyss = ""
         
            var cataIdtemp:String = ""
           var cataIdnametemp:String = ""
          var productfiltercount = 0
            var subcataIdtemp:String = ""
           var subcataIdnametemp:String = ""
          var availIndextemp = NSMutableArray()
        
          var boidarr = NSMutableArray()
          var coponidarr = NSMutableArray()
    //intialilizer class ref
    static let shared = ProductModel()
    // private constructor
    
    func remove()
    {
        availIndextemp.removeAllObjects()
        ratingrange = ""
            discountIdtemp = ""
             dropshipingIdtemp = ""
        paymentModetemp.removeAllObjects()
        primaryKeyss = ""
         cataIdtemp = ""
         cataIdnametemp = ""
        productfiltercount = 0
          subcataIdtemp = ""
           subcataIdnametemp = ""
        boidarr.removeAllObjects()
        coponidarr.removeAllObjects()
        likeRangetemp = ""
        rangeTemp = ""
        rangetemp = ""
          pricetemp = ""
        brandIndex.removeAllObjects()
        brandIndextemp.removeAllObjects()
        datapricesell.removeAllObjects()
                statussell = ""
               numphotosell = ""
                 numsoldsell = ""
                 cataIdsell = ""
              subcataIdsell = ""
                datapriceselltemp.removeAllObjects()
                 statusselltemp = ""
                numphotoselltemp = ""
                  numsoldselltemp = ""
                    cataIdselltemp = ""
                   subcataIdselltemp = ""
                daterangesell = ""
                salecount  = 0
      editproductsell = false
                 
             orderQtyPro = ""
               PriceOrder = ""
        statusOrder.removeAllObjects()
                statusOrderTemp.removeAllObjects()
               orderQtyProTemp = ""
                PriceOrderTemp = ""
        RetailProducteMin = ""
        RetailMin = ""
        RetaildiscountPer = ""
        RetailProductdiscountPer = ""
        OnlinediscountPer = ""
        availitembranch = ""
        likerangebranch = ""
         follower = ""
        rating = ""
        timestamp = ""
        platformIndex.removeAllObjects()
        busstypeIndex.removeAllObjects()
        activatebranchIndex.removeAllObjects()
        availitem = ""
         discountId = ""
        dropshipingId = ""
        price = ""
        numberbranch = ""
        likerange = ""
        timestamp = ""
        currencyIndex.removeAllObjects()
        cataIndex.removeAllObjects()
        availIndex.removeAllObjects()
        activateIndex.removeAllObjects()
        paymentMode.removeAllObjects()
        pro_reference_id = ""
        purchaseId = ""
        storePayArr.removeAllObjects()
        documentImageSize.removeAllObjects()
        cataIdname = ""
        subcataId = ""
        cataImage = ""
        subcataImage = ""
        subcataIdName = ""
        documentId.removeAllObjects()
        documentImage.removeAllObjects()
        BranchNamenew.removeAllObjects()
        branchIdnew.removeAllObjects()
        SelectedVarientIndex.removeAllObjects()
        OnlinediscountWholePercent.removeAllObjects()
        OnlineVatValue.removeAllObjects()
        OnlineFinalPrice.removeAllObjects()
        OnlineVatPercent.removeAllObjects()
        pro_final_status = 0
        filledstep = 0
        isProductType = false
        supportdescriptions = ""
        BranchCount = 0
        statusActive = 0
        videoUrl = ""
        descriptions = ""
        onlineQuanTo = 0
        QuanTo = 0
        finalStatus = 1
        productId = ""
        weight = 0.0
        height = 0.0
        width = 0.0
        length = 0.0
        dimension = 0.0
        isdraft = false
        isedit = false
        deliverycharge = ""
        galleryFeatureId = ""
        galleryFeatureImage = ""
        galleryId.removeAllObjects()
        galleryIdImage.removeAllObjects()
        
        
        
        pronoqty.removeAllObjects()
        technical  = ""
        filterIdName.removeAllObjects()
        filterId.removeAllObjects()
        filterIdValue.removeAllObjects()
        filterIdValueName.removeAllObjects()
        
        type = false
        Currencyname = ""
        BranchName  = ""
        OnlinewholeSalePrice1Unit.removeAllObjects()
        wholeSalePrice1Unit.removeAllObjects()
        retail = false
        Whole = false
        Onlineretail = false
        OnlineWhole = false
        cataId  = ""
        subcataId  = ""
        QuantityFrom.removeAllObjects()
        Quantityto.removeAllObjects()
        WholeSalePriceFrom.removeAllObjects()
        WholeSalePriceTo.removeAllObjects()
        DeliveryCharges.removeAllObjects()
        discountWhole.removeAllObjects()
        OnlineQuantityFrom.removeAllObjects()
        OnlineQuantityto.removeAllObjects()
        OnlineWholeSalePriceFrom.removeAllObjects()
        OnlineWholeSalePriceTo.removeAllObjects()
        OnlineDeliveryCharges.removeAllObjects()
        OnlinediscountWhole.removeAllObjects()
        isoffline = false
        isOnline = false
        ocrView  = ""
        productTitle  = ""
        barcode  = ""
        productDecription  = ""
        currencyId  = ""
        branchId  = ""
        deliveryDays  = ""
        stockQuan  = ""
        OnlineRegular  = ""
        Onlinediscount   = ""
        Onlinesell   = ""
        OnlineFinal   = ""
        OnlineVat   = ""
        OnlineMax   = ""
        OnlineMaxQuan  = ""
        OnlineperProduct  = false
        OnlinefixedProduct  = true
        OnlineProductRegular  = ""
        OnlineProductdiscount   = ""
        OnlineProductsell   = ""
        OnlineProductFinal   = ""
        OnlineProductVat   = ""
        OnlineProducteMax   = ""
        OnlineProductMinQuan  = ""
        OnlineReturn  = false
        OnlineExchange  = false
        OnlineReturnDays   = ""
        OnlineExchangeDays   = ""
        OnlineReturn1  = false
        OnlineExchange1  = false
        OnlineReturnDays1   = ""
        OnlineExchangeDays1   = ""
        Online  = false
        Cash = false
        RetailRegular   = ""
        Retaildiscount   = ""
        Retailsell   = ""
        RetailFinal   = ""
        RetailVat   = ""
        RetailMax   = ""
        RetailMaxQuan  = ""
        RetailperProduct  = false
        RetailfixedProduct  = true
        RetailProductRegular  = ""
        RetailProductdiscount   = ""
        RetailProductsell   = ""
        RetailProductFinal   = ""
        RetailProductVat   = ""
        RetailProducteMax   = ""
        RetailProductMaxQuan  = ""
        RetailReturn  = false
        RetailExchange  = false
        RetailReturnDays  = ""
        RetailExchangeDays  = ""
        RetailReturn1  = false
        RetailExchange1  = false
        RetailReturnDays1  = ""
        RetailExchangeDays1  = ""
        Online1  = false
        Cash1  = false
        perProductArr.removeAllObjects()
    }
    private  init()
    {
        
    }
}

