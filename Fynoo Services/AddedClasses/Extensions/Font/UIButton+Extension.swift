//
//  UIButton+Extension.swift
//  TheGirlsLockeRoom
//
//  Created by Hitesh Prajapati on 09/12/20.
//

import UIKit

extension UIButton{
    func setAppTheme(){
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.getFont(style: .bold, size: .size14)
        self.setBackgroundImage(UIImage(named: "ic_btn_bg"), for: .normal)
    }
}
