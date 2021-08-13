//
//  BarCodePopupNewViewController.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 27/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol BarCodePopupNewViewControllerDelegate {
    func yourProductList(tag:Int)
    func fynooProductDataBank(tag:Int)
    func continueAdding(tag:Int)
}

class BarCodePopupNewViewController: UIViewController {
    var checkbar:CheckBarCode?
    @IBOutlet weak var productListBtn: UIButton!
    @IBOutlet weak var fynooProductDataBank: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var barmsg: UILabel!
    var delegate:BarCodePopupNewViewControllerDelegate?
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
         let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        productListBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
         fynooProductDataBank.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
          continueBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
          barmsg.font = UIFont(name:"\(fontNameLight)",size:14)
          self.fynooProductDataBank.setAllSideShadow(shadowShowSize: 3.0)
          self.productListBtn.setAllSideShadow(shadowShowSize: 3.0)
          self.continueBtn.setAllSideShadow(shadowShowSize: 3.0)

        // Do any additional setup after loading the view.
    }
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          let touch = touches.first
               if touch?.view == self.view {
                
               dismiss(animated: true, completion: nil)
    //           super.touchesEnded(touches , with: event)
                
              }
        }
       func showData()
       {
        if  checkbar?.data?.status_val ?? 0 == 3
               {
                   productListBtn.isHidden = false
                     fynooProductDataBank.isHidden = false
                barmsg.text = self.checkbar?.data?.status_description ?? ""
               }
               else if  checkbar?.data?.status_val ?? 0 == 1
               {
                   productListBtn.isHidden = false
                  fynooProductDataBank.isHidden = true
                 barmsg.text = self.checkbar?.data?.status_description ?? ""
               }
               else
               {
                   productListBtn.isHidden = true
                   fynooProductDataBank.isHidden = false
                 barmsg.text = self.checkbar?.data?.status_description ?? ""
               }
    }
    @IBAction func productList(_ sender: UIButton) {
        self.dismiss(animated: true) {
              self.delegate?.yourProductList(tag: sender.tag)
        }
      
    }
    
    @IBAction func fynooProductDataBank(_ sender: UIButton) {
        self.dismiss(animated: true) {
                    self.delegate?.fynooProductDataBank(tag: sender.tag)
               }
        
    }
    
    @IBAction func continueAddingProduct(_ sender: UIButton) {
     self.dismiss(animated: true) {
                             self.delegate?.continueAdding(tag: sender.tag)
                      }
     
    }
    
    
   

}
