//
//  UIFont+Extension.swift
//  TheGirlsLockeRoom
//
//  Created by Hitesh Prajapati on 07/12/20.
//

import UIKit

enum FontStyle : String{
    case regular    = "Gilroy"
    case italic     = "Gilroy-Italic"
    case bold       = "Gilroy-Bold"
    case extrabold  = "Gilroy-ExtraBold"
    case boldItalic = "Gilroy-BoldItalic"
//   case regular    =
//      case italic     =
//      case bold       =
//      case boldItalic = 
}

enum FontSize : CGFloat{
    case size8     =   8
    case size9     =   9
    case size10    =   10
    case size12    =   12
    case size14    =   14
    case size16    =   16
    case size20    =   20
}

extension UIFont{
    class func getFont(style : FontStyle = .regular, size : FontSize = .size12) -> UIFont{
        return UIFont(name: style.rawValue, size: size.rawValue)!
    }
    
    func SetFont() {

            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")

            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
    }
    
}
