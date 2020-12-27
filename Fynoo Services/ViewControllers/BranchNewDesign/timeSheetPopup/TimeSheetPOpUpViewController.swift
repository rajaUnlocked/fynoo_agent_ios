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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
