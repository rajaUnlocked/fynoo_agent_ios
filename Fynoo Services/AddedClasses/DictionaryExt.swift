//  DictionaryExt.swift
//  BaseProjectSwift
//  Created by Gaurav Sinha on 2/1/17.
//  Copyright © 2017 Sufalam Technologies. All rights reserved.
//
import Foundation
extension NSDictionary
{
    func RemoveNullValueFromDic()-> NSDictionary
    {
        let mutableDictionary:NSMutableDictionary = NSMutableDictionary(dictionary: self)
//        print("comingdict", mutableDictionary)
        for key in mutableDictionary.allKeys
        {
            if("\(mutableDictionary.object(forKey: "\(key)")!)" == "<null>" || "\(mutableDictionary.object(forKey: "\(key)")!)" is NSNull )
            {
                mutableDictionary.setValue("", forKey: key as! String)
                
//                print("outdict", mutableDictionary)
            }
        }
        return mutableDictionary
//        print("returndict", mutableDictionary)

    }
}
