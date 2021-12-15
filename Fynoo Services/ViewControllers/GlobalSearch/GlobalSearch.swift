//
//  GlobalSearch.swift
//  Fynoo
//
//  Created by IND-SEN-LP-039 on 27/11/21.
//  Copyright © 2021 neerajTiwari. All rights reserved.
//

import Foundation
import UIKit
import BarcodeScanner
protocol GlobalsearchDelegate
{
func resultscancode(search:String,content:String)
}
class Globalsearch:UIButton,BarcodeScannerCodeDelegate,BarcodeScannerErrorDelegate,BarcodeScannerDismissalDelegate
{
  
    var delegate:GlobalsearchDelegate?
    var product = ProductApiModel()
    var textSTR  = ""
    var vw:UIViewController?
    func scanqrcode(_ vw : UIViewController)
    {
        self.vw = vw
        let controller = BarcodeScannerViewController()
       controller.headerViewController.titleLabel.text = "Scan"
        controller.headerViewController.closeButton.setTitle("Close", for: .normal)
            controller.codeDelegate = self
            controller.errorDelegate = self
            controller.dismissalDelegate = self
       self.vw?.present(controller, animated: true)
  
    }
  
    
    func QRCodeScanner(str: String) {
        
        if ModalController.verifyUrl(urlString: str)
        {
            if str.contains("type")
            {
                let url = URL(string:str)!
                let id = url["type"]!.split(separator: "-")
                product.contentid = String(id[1])
                product.contenttype = String(id[0])
               // ModalClass.startLoading(self.vw!)
                product.getnameapi { (success, response) in
                    if success {
                        ModalClass.stopLoading()
                        let rep:NSDictionary = response?.value(forKey: "data") as! NSDictionary
                        self.textSTR = rep.value(forKey: "keyword") as! String
                        self.delegate?.resultscancode(search: self.textSTR, content: String(id[0]))
                    }
                }
            }
            else{
                self.textSTR = str
                self.delegate?.resultscancode(search: self.textSTR, content: "")
            }
        }
        else{
            
            self.textSTR = str
            self.delegate?.resultscancode(search: self.textSTR, content: "")
        }
    }
    
 func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
    print(error)
    controller.dismiss(animated: true, completion: nil)
  }

  func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
      controller.dismiss(animated: true, completion: nil)
  }

    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        self.QRCodeScanner(str: code)
       controller.dismiss(animated: true, completion: nil)
       
        
        }

}
