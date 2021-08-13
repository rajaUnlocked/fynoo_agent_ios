//
//  DeleteSlabPopupViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 26/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol DeleteSlabPopupDelegate {
    func yes(max:String)
    func no()
}
class DeleteSlabPopupViewController: UIViewController {
    var delegate:DeleteSlabPopupDelegate?
    var max = ""
    
    @IBOutlet weak var nobtn: UIButton!
    @IBOutlet weak var yesbtn: UIButton!
    @IBOutlet weak var bottomlbl: UILabel!
    @IBOutlet weak var toplbl: UILabel!
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
                let fontNameLight = NSLocalizedString("LightFontName", comment: "")
             toplbl.font = UIFont(name:"\(fontNameLight)",size:16)
           toplbl.font = UIFont(name:"\(fontNameLight)",size:16)
        yesbtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:13)
        nobtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:13)
    }

    @IBAction func yes(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.yes(max: self.max)
        }
       
    }
    
    @IBAction func no(_ sender: Any) {
        self.dismiss(animated: true) {
                    self.delegate?.no()
               }
    }
}
