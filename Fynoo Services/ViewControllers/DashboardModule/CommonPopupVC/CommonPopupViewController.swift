//
//  CommonPopupViewController.swift
//  Fynoo Services
//
//  Created by Aishwarya on 18/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

protocol  CommonPopupViewControllerDelegate {
      func yesBtnClicked()
}

class CommonPopupViewController: UIViewController {

    var  delegate : CommonPopupViewControllerDelegate?
    @IBOutlet weak var yesOutlet: UIButton!
    @IBOutlet weak var noOutlet: UIButton!
    @IBOutlet weak var popupBG: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yesOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        self.noOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
              let touch = touches.first
                   if touch?.view == self.view {
                   dismiss(animated: true, completion: nil)
                  }
            }
        
        @IBAction func yesClicked(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
            self.delegate?.yesBtnClicked()
        }
        
        @IBAction func noClicked(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
}
