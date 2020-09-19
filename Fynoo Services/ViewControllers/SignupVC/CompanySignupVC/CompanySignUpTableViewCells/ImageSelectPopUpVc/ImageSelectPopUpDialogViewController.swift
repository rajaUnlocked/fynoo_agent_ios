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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
