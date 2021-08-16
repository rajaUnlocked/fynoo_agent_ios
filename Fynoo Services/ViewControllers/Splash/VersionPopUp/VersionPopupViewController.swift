//
//  VersionPopupViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya on 18/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol  VersionPopupViewControllerDelegate {
    func updateLaterClicked()
    func updateNowClicked()
}

class VersionPopupViewController: UIViewController {

    var  delegate : VersionPopupViewControllerDelegate?
    @IBOutlet weak var updateLaterOutlet: UIButton!
    @IBOutlet weak var updateNowOutlet: UIButton!
    var isForForceUpdate = false
    @IBOutlet weak var updateNowLEad: NSLayoutConstraint!
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        self.updateLaterOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        self.updateNowOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        
        if isForForceUpdate {
            updateLaterOutlet.isHidden = true
            updateNowLEad.constant = -30
        }
    }
    
    @IBAction func updateLaterBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.updateLaterClicked()
    }
    
    @IBAction func updateNowBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.updateNowClicked()
    }
}
