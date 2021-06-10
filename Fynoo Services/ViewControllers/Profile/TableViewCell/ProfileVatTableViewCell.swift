//
//  ProfileVatTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 04/09/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class ProfileVatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vatcertlbl: UILabel!
    @IBOutlet weak var addText: UILabel!
    @IBOutlet weak var addIon: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var addCertificate: UIButton!
    @IBOutlet weak var vieww: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  self.vieww.addDashBorder()
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func dashedBorderLayerWithColor(color:CGColor) -> CAShapeLayer {
//
//       let  borderLayer = CAShapeLayer()
//        borderLayer.name  = "borderLayer"
//         let frameSize = vieww.frame.size
//        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
//
//        borderLayer.bounds=shapeRect
//        borderLayer.position = CGPoint(x: frameSize.width/2,y: frameSize.height/2)
//        borderLayer.fillColor = UIColor.clear.cgColor
//        borderLayer.strokeColor = color
//        borderLayer.lineWidth=1
//        borderLayer.lineJoin=CAShapeLayerLineJoin.round
//        borderLayer.lineDashPattern = NSArray(array: [NSNumber(value: 8),NSNumber(value:4)]) as? [NSNumber]
//
//        let path = UIBezierPath.init(roundedRect: shapeRect, cornerRadius: 0)
//
//        borderLayer.path = path.cgPath
//
//        return borderLayer
//
//    }
    
}
