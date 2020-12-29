//
//  UploadImageViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 22/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import  MTPopup

class UploadImageViewController: UIViewController {
    var gallery_model = BusinessGalleryNewModel()
    var uploadGalleryImg : GalleryImage?
    var img = UIImage()
    var branch_name = ""
    @IBOutlet weak var typenameLbl: UILabel!
    @IBOutlet weak var selectType: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var txtFileld: UITextField!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var headerVw: NavigationView!
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveBtn.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
         self.cancelBtn.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        headerVw.titleHeader.text = "Upload Images".localized
        headerVw.viewControl = self
        self.mainImg.image = img
      
        self.txtFileld.addTarget(self, action: #selector(SelectMultipleBranchesNewDesignViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
      let singleTap = UITapGestureRecognizer(target: self, action: #selector(ViewClicked))
                   let Tap = UITapGestureRecognizer(target: self, action: #selector(ViewClicked))
                   self.selectType.isUserInteractionEnabled = true
                   self.selectType.addGestureRecognizer(Tap)
        // Do any additional setup after loading the view.
    }
    @objc func ViewClicked() {
       let vc = SelectImageTypePopupViewController(nibName: "SelectImageTypePopupViewController", bundle: nil)
          
              let popupController = MTPopupController(rootViewController: vc)
              popupController.autoAdjustKeyboardEvent = false
              popupController.style = .bottomSheet
              popupController.navigationBarHidden = true
              popupController.hidesCloseButton = false
              let blurEffect = UIBlurEffect(style: .dark)
              popupController.backgroundView = UIVisualEffectView(effect: blurEffect)
              popupController.backgroundView?.alpha = 0.6
              popupController.backgroundView?.onClick {
                  popupController.dismiss()
              }
              popupController.present(in: self)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        branch_name = textField.text!
    }

    @IBAction func save(_ sender: Any) {
        if txtFileld.text == "" as String  {
            ModalController.showNegativeCustomAlertWith(title: "Image name is compulsory", msg: "")
            return
        }
      
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
     @IBAction func cancel(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
