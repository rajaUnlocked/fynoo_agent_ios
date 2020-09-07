//
//  TargetViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 07/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class TargetViewController: UIViewController {
    @IBOutlet weak var headervw: NavigationView!
    
    @IBOutlet weak var tabvw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headervw.viewControl = self
        headervw.titleHeader.text = "Target"
        tabvw.delegate = self
        tabvw.dataSource = self
    }

}

extension TargetViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabvw.dequeueReusableCell(withIdentifier: "TargetprogressTableViewCell", for: indexPath) as! TargetprogressTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
