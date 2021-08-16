//
//  TimeSheetPOpUpViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 04/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol TimeSheetPOpUpDelegate {
    func applyToAll(arrr:[[String]])
}
class TimeSheetPOpUpViewController: UIViewController {
    var arr = [[String]]()
    var delegate:TimeSheetPOpUpDelegate?
    @IBOutlet weak var applytoall: UIButton!
    @IBOutlet weak var cancelbtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        titlelbl.font = UIFont(name:"\(fontNameLight)",size:16)
        cancelbtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:15)
        applytoall.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:15)
    }

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applytoall(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.applyToAll(arrr: self.arr)
        }
    }
    
}
