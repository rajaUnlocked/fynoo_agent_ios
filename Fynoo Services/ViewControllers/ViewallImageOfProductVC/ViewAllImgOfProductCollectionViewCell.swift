//
//  ViewAllImgOfProductCollectionViewCell.swift
//  Fynoo
//
//  Created by SedanMacBookAir on 05/08/21.
//  Copyright © 2021 neerajTiwari. All rights reserved.
//

import UIKit

class ViewAllImgOfProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var proImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
        proImage.addGestureRecognizer(pinch)
    }
    
    // Actions
    @IBAction func pinch(sender:UIPinchGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let currentScale = self.proImage.frame.size.width / self.proImage.bounds.size.width
            let newScale = currentScale*sender.scale
            let transform = CGAffineTransform(scaleX: newScale, y: newScale)
            self.proImage.transform = transform
            sender.scale = 1
        }
    }

}
