//
//  DatabankpopupViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 18/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol DatabankpopupDelegate {
    func productsellinfo()
}
class DatabankpopupViewController: UIViewController {
    var delegate:DatabankpopupDelegate?
    var id = ""
    @IBOutlet weak var heightconst: NSLayoutConstraint!
    var productIds = NSMutableArray()
    @IBOutlet weak var yesbtn: UIButton!
    var isDatabank = false
    var count = 0
    @IBOutlet weak var nobtn: UIButton!
    @IBOutlet weak var lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        lbl.font = UIFont(name:"\(fontNameLight)",size:16)
        yesbtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:13)
        nobtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:13)
        heightconst.constant = 176
        if isDatabank
        {
             heightconst.constant = 230
        lbl.text = "As per the subscription package,\(count) data has been successfully added.\n\n Please proceed to pay for paid data."
        }
    }
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          let touch = touches.first
               if touch?.view == self.view {
                
               dismiss(animated: true, completion: nil)
    //           super.touchesEnded(touches , with: event)
                
              }
        }
    @IBAction func yes(_ sender: Any) {
        if isDatabank
        {
            self.dismiss(animated: true) {
                                               self.delegate?.productsellinfo()
                                           }
           
        }
        else
        {
        let productmodel = AddProductModel()
        ModalClass.startLoading(view)
        productmodel.proid = id
                  productmodel.selproductinfo { (success, response) in
                           ModalClass.stopLoading()
                              if success == true {
                                
                                self.dismiss(animated: true) {
                                    self.delegate?.productsellinfo()
                                }
                                
                    }
                              }
                          }
       
    }
    
    @IBAction func no(_ sender: Any) {
         self.dismiss(animated: true)
         {
        self.delegate?.productsellinfo()
            }
    }
    
}
