//
//  BusinessTiming.swift
//  Fynoo Business
//
//  Created by Sendan IT on 21/09/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

struct BusinessTiming:Encodable{
    let user_id : String
    let branch_id:String
    let timings : [Timing]
}
struct BusinessTiming1:Encodable{
    let user_id : String
    let branch_id:String
    let branch_timings_id :String
    let timings : [Timing]
}

struct Timing : Encodable {
    let dayName : String
    let is24Open : Int
    let isClose : Int
    let slotArrayList : [SlotArrayList]
}

struct SlotArrayList : Encodable{
        let time_slot : String
}
struct Timingsss  {
    let dayName : String
    let is24Open : Bool
    let isClosed : Bool
    let slotArrayList : [SlotArrayList]
    
}
