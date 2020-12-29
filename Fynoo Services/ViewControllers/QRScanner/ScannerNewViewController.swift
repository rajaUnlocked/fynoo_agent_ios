//
//  ScannerNewViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya on 20/08/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import BarcodeScanner

class ScannerNewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        viewController.modalPresentationStyle = .fullScreen
        
        present(viewController, animated: true, completion: nil)
    }
}

extension ScannerNewViewController: BarcodeScannerCodeDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    print(code)
    controller.dismiss(animated: true, completion: nil)
 //   controller.reset()
  }
}

extension ScannerNewViewController: BarcodeScannerErrorDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
    print(error)
    controller.dismiss(animated: true, completion: nil)
  }
}

extension ScannerNewViewController: BarcodeScannerDismissalDelegate {
  func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
