//
//  ImageSelectPopUpDialogViewController.swift
//  Fynoo Business
//
//  Created by Sendan IT on 08/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol ImageSelectPopUpDialogViewControllerDelegate {
    func cameraSelected()
     func gallerySelected()
}
class ImageSelectPopUpDialogViewController: UIViewController {
  var delegate :ImageSelectPopUpDialogViewControllerDelegate?
    @IBOutlet var mainView: UIView!
    @IBOutlet var cameraView: UIView!
    @IBOutlet var cameraBtn: UIButton!
    @IBOutlet var galleryView: UIView!
    @IBOutlet var galleryBtn: UIButton!
    
    @IBOutlet weak var takePhotoLbl: UILabel!
    @IBOutlet weak var deviceGalleryLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetFontAndTextColor()
    }
    
    func SetFontAndTextColor(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.takePhotoLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.deviceGalleryLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        
        self.takePhotoLbl.textColor = Constant.Black_TEXT_COLOR
        self.deviceGalleryLbl.textColor = Constant.Black_TEXT_COLOR        
        
    }
    @IBAction func cameraClicked(_ sender: Any) {
         self.dismiss(animated: true)
        self.delegate?.cameraSelected()
       }
    
    @IBAction func galleryBtnClicked(_ sender: Any) {
         self.dismiss(animated: true)
         self.delegate?.gallerySelected()
        
          }

}
