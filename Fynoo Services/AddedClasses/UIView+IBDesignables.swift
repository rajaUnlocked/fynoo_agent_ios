//
//  UIView+IBDesignables.swift
//  Fynoo Business
//
//  Created by SENDAN on 02/08/19.
//  Copyright © 2019 Sendan. All rights reserved.
//



import UIKit

@IBDesignable


class CustomUITextField: UITextField {
    
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

extension UIView {
    
    
    //MARK:- Border related
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            self.clipsToBounds = true
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    
    //MARK:- Shadow related
    
    @IBInspectable var shadow: Bool {
        get {
            return self.shadow
        }
        set {
            if(newValue)
            {
                layer.shadowRadius = 3
                layer.shadowOpacity = 0.3
            }
        }
    }
    
    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    func addDashedBorder(width:CGFloat) {
        
        let color = UIColor.darkGray.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [2,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 1).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
   
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat,vc:UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: vc.frame.size.width - width, y: 0, width: width, height: vc.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat ,vc: UIView) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: vc.frame.size.height - width, width: vc.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addShadowView(_ width:CGFloat=0.0, height:CGFloat=1.0, Opacidade:Float=0.7, maskToBounds:Bool=false, radius:CGFloat=4.0) {
        self.layer.cornerRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
    }
    func roundCornerNormal(radius: CGFloat){
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.masksToBounds = false
    }
  
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.masksToBounds = true
    }
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

@IBDesignable class CardView: UIView {
    var cornnerRadius : CGFloat = 16
    var shadowOfSetWidth : CGFloat = 10
    var shadowOfSetHeight : CGFloat = 10
    
    var shadowColour : UIColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    var shadowOpacity : CGFloat = 10
    
    override func layoutSubviews() {
        layer.cornerRadius = cornnerRadius
        layer.shadowColor = shadowColour.cgColor
        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornnerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}

//@IBDesignable class buttonShadow: UIButton {
//    var cornnerRadius : CGFloat = 0
//    var shadowOfSetWidth : CGFloat = 0
//    var shadowOfSetHeight : CGFloat = 5
//
//    var shadowColour : UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//    var shadowOpacity : CGFloat = 0.5
//
//    override func layoutSubviews() {
//        layer.cornerRadius = cornnerRadius
//        self.backgroundColor = UIColor.white
//        layer.shadowColor = shadowColour.cgColor
//        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornnerRadius)
//        layer.shadowPath = shadowPath.cgPath
//        layer.shadowOpacity = Float(shadowOpacity)
//    }
//}

@IBDesignable class CardbUTTON: UIButton {
   var cornnerRadius : CGFloat = 8
    var shadowOfSetWidth : CGFloat = 0
    var shadowOfSetHeight : CGFloat = 5
    
    var shadowColour : UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    var shadowOpacity : CGFloat = 0.3
    
    override func layoutSubviews() {
        layer.shadowColor = shadowColour.cgColor
        layer.shadowOffset = CGSize(width: shadowOfSetWidth, height: shadowOfSetHeight)
          let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornnerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
}

extension UIImageView {
    
    func setImageSDWebImage(imgURL: String, placeholder: String) {
        
        let strUrl = imgURL.replacingOccurrences(of: " ", with: "%20")
        
        if let url = URL(string: strUrl) {
           // self.sd_setShowActivityIndicatorView(true)
           // self.sd_showActivityIndicatorView()
           // self.sd_setIndicatorStyle(.gray)
            self.sd_setImage(with: url, completed: nil)
        } else {
            self.image = UIImage(named: placeholder)
        }
    }
}
