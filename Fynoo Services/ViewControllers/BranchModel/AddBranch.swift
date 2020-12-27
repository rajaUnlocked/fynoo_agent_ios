//
//  AddBranch.swift
//  Fynoo Business
//
//  Created by Sendan IT on 25/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//
import UIKit
import Foundation
class AddBranch
    
    
{
    var isSpecial = ""
    var videos_thumb = ""
    var videos = ""
    var heightCollectVw = 1
    var distance = 0.0
    var store_time_display = ""
    var qr_code = ""
    var avg_rating = 0.0
    var review_count = 0
    var followers = 0
    var isLocation = false
    var timingId = ""
    var branchImgUrl = ""
    var flagImg = ""
    var ismain = false
    var showImgId = NSMutableArray()
    var locationdetails = ""
    var area = ""
    var video_url = ""
    var platformType = NSMutableArray()
    var imgId = NSMutableArray()
    var displayId = 0
      var displaycode = ""
    var SelectedCheck = NSMutableArray()
    var BTimeDict = [Business_timings]()
    var State = ""
    var whatsappCode = ""
    var whatsappNumber = ""
    var isdraft = false
    var Country = ""
    var City = ""
    var ZipCode = ""
    var addTypeId = ""
    var addTypeName = ""
    var BusId = 0
    var BusName = ""
    var is_branch_active:String = ""
    var lat : Double = Double()
    var long : Double = Double()
    var business_type:NSArray = NSArray()
    var branchLogoId:String = ""
    var branchStatus = 1
    var branchLogo:UIImage?
    var uid : String = ""
    var bName:String = ""
    var mail:String = ""
    var mobileCode:String = ""
    var phoneCode:String = ""
    var MobileNo:String = ""
    var Phone:String = ""
    var Descrip:String = ""
    var Maroof:String = ""
    var videoLink:String = ""
    var BType:NSMutableArray = NSMutableArray()
    var BussName:NSMutableArray = NSMutableArray()
    
    var BTime:String = ""
    var location:String = ""
    var category_list:NSMutableArray = NSMutableArray()
    var category_listId:NSMutableArray = NSMutableArray()
    
    var Interior:NSMutableArray = NSMutableArray()
    var Product_data:NSMutableArray = NSMutableArray()
    var Exterior:NSMutableArray = NSMutableArray()
    
    var Video:NSMutableArray = NSMutableArray()
    var facebook:String = ""
    var twitter:String = ""
    var linkdin:String = ""
    var BranchId:String = ""
    var ProductId:String = ""
    var isedit:Bool = false
    var branchPlatformName:NSMutableArray = NSMutableArray()
    static let shared = AddBranch()
    //var addBranchList :AddBranchList?
    private init(){}
    
    func removeall()
    {
        isSpecial = ""
        branchPlatformName.removeAllObjects()
        heightCollectVw = 1
        branchStatus = 1
        store_time_display = ""
        qr_code = ""
        review_count = 0
        avg_rating = 0.0
        category_listId.removeAllObjects()
        category_list.removeAllObjects()
         Interior.removeAllObjects()
        Product_data.removeAllObjects()
         Exterior.removeAllObjects()
        followers = 0
        isLocation = false
        BussName.removeAllObjects()
        timingId = ""
        branchImgUrl = ""
        flagImg = ""
        branchLogoId = ""
        ismain = false
        showImgId.removeAllObjects()
        locationdetails = ""
        area = ""
        video_url = ""
        platformType.removeAllObjects()
        imgId.removeAllObjects()
        displayId = 0
        SelectedCheck.removeAllObjects()
        BTimeDict = []
        State = ""
        whatsappCode = ""
        whatsappNumber = ""
        isdraft = false
        Country = ""
        City = ""
        ZipCode = ""
        business_type = []
        addTypeId = ""
        addTypeName = ""
        BusId = 0
        BusName = ""
        is_branch_active = ""
        isedit = false
        lat = 0.0
        long = 0.0
        location = ""
        branchLogo = nil
        uid = ""
        bName = ""
        mail = ""
        mobileCode = ""
        phoneCode = ""
        MobileNo = ""
        Phone = ""
        Descrip = ""
        Maroof = ""
        videoLink = ""
        BType.removeAllObjects()
        BTime = ""
        Exterior.removeAllObjects()
        Video.removeAllObjects()
        facebook = ""
        twitter = ""
        linkdin = ""
        BranchId = ""
        ProductId = ""
        videos = ""
        videos_thumb = ""
    }
}
