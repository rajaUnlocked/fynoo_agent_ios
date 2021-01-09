//
//  SubscriptionBuyPaymentMethod.swift
//  Fynoo Business
//
//  Created by neeraj tiwari on 12/11/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import Foundation

struct PaymentMethodList: Decodable {
    var error : Bool?
    var error_description : String?
    var error_code : Int?
    var data : SubscriptionBuyPaymentMethod?
}
struct SubscriptionBuyPaymentMethod: Decodable {
   
    let description : String?
    let order_id : String?
    let statement_descriptor : String?
    let transaction_id : String?
    let pay_from_wallet : Double?
    let pay_online : Double?
    let final_price : Double?
    let pay_from_coupon : Double?
    let payment : [Payment]?
}
struct Payment:Decodable {
    
    let wallet_free_bal : Double?
    let payment_id : Int?
    let payment_name : String?
    let payment_type : String?
    let payment_icon : String?


}
