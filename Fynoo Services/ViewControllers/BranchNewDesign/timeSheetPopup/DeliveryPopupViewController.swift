//
//  DeliveryPopupViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya on 29/07/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
 
class DeliveryPopupViewController: UIViewController {
    @IBOutlet weak var yesClickedOutlet: UIButton!
    @IBOutlet weak var noClickedOutlet: UIButton!
    var activateHandler : ((String)-> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yesClickedOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        self.noClickedOutlet.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
    }
    
          override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                 let touch = touches.first
                 if touch?.view == self.view {
                     dismiss(animated: true, completion: nil)
                 }
             }
    
    @IBAction func yesClicked(_ sender: Any) {
                 
                 activateHandler!("true")
                 self.dismiss(animated: true, completion: nil)
                 
             }
             
             @IBAction func noClicked(_ sender: Any) {
                 activateHandler!("false")
                 self.dismiss(animated: true, completion: nil)
             }
}
