//
//  UIView+Extension.swift
//  RishtaMatch
//
//  Created by Aman Chaurasia on 23/03/21.
//

import UIKit

extension UIView{
    
    func roundCorners(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func setBorder(cornerRadius: CGFloat, borderColor : UIColor, borderWidth : CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
    
    func showWithAlpha(){
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func hideWithAlpha(){
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
    }
    
    
}
