//
//  TransactionNewPopupViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya on 24/11/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol TransactionNewPopupViewControllerDelegate {
      func yesTransactionClicked()
}

class TransactionNewPopupViewController: UIViewController {

    @IBOutlet weak var lblText: UILabel!
    var  delegate : TransactionNewPopupViewControllerDelegate?
    @IBOutlet weak var yesBtnOutlet: UIButton!
    @IBOutlet weak var noBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        yesBtnOutlet.titleLabel!.font = UIFont(name:"\(fontNameLight)",size:12)
        noBtnOutlet.titleLabel!.font = UIFont(name:"\(fontNameLight)",size:12)
        lblText.font = UIFont(name:"\(fontNameLight)",size:16)
         self.yesBtnOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
         self.noBtnOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
              let touch = touches.first
                   if touch?.view == self.view {
                   dismiss(animated: true, completion: nil)
                  }
            }
        
        @IBAction func yesClicked(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
            self.delegate?.yesTransactionClicked()
        }
        
        @IBAction func DISMISS(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
    }
