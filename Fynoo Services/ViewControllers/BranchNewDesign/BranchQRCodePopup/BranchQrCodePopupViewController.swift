//
//  BranchQrCodePopupViewController.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 14/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class BranchQrCodePopupViewController: UIViewController {
    var isFrom = ""
    var url = ""
    var isType = false
    var businessName = ""
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var qrCodeImg: UIImageView!
    var productName:String = ""

    var urlPass = ""
    var branchId=""
    var isFromBranch = ""
    @IBOutlet weak var screenShotView: UIView!
    @IBOutlet weak var shareBtn: UIButton!
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        view.addDashBorder()
        qrCodeImg.layer.masksToBounds = true
        qrCodeImg.contentMode = .scaleAspectFill
        qrCodeImg.clipsToBounds = true
        qrCodeImg.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "tqrcodeSampleImg"))
        
        
        let img = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named: "share_newIcon")!)
        shareBtn.setImage(img, for: .normal)
        nameLbl.text = businessName
        if isType == true {
            nameLbl.isHidden = false
        }
       
        // Do any additional setup after loading the view.
        self.SetFont()
    }
                                 
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.nameLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        if isFrom == "PRODUCTVIEW" {
        shareBtn.isHidden = true
        }
    }

   
    @IBAction func share(_ sender: Any) {

        UIGraphicsBeginImageContext(self.screenShotView.frame.size)
//        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 100.0)
        self.screenShotView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        var business_id = Singleton.shared.getUserId()
        
         var urls = "\(Constant.BASE_URL)customer/single_branch/" + "\(business_id)" + "/";
        if isFromBranch != "" {
            urls = urlPass
        }else if isFromBranch == "PRODUCTVIEW" {
            urls = urlPass
        }
         let scan = "Scan this QR code to know more about".localized
        let textToShare = "\(scan) \(self.productName)"
       
        if let myWebsite = URL(string: urls) {//Enter link to your app here
            
//        let objectsToShare = [textToShare, myWebsite, image ??  #imageLiteral(resourceName: "dataEntryService") ] as [Any]
        let objectsToShare = [textToShare, myWebsite, image ??  #imageLiteral(resourceName: "dataEntryService") ] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
       
            activityVC.popoverPresentationController?.sourceView = sender as! UIView
            self.present(activityVC, animated: true, completion: nil)
        }

    }
    
  


}
extension UIView {
  func addDashBorder() {
      let color = UIColor.white.cgColor

      let shapeLayer:CAShapeLayer = CAShapeLayer()

      let frameSize = self.frame.size
      let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

      shapeLayer.bounds = shapeRect
      shapeLayer.name = "DashBorder"
      shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
      shapeLayer.fillColor = UIColor.clear.cgColor
      shapeLayer.strokeColor = color
      shapeLayer.lineWidth = 3
      shapeLayer.lineJoin = .round
      shapeLayer.lineDashPattern = [2,4]
      shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 10).cgPath

      self.layer.masksToBounds = false

      self.layer.addSublayer(shapeLayer)
  }
}
