//
//  CommonSearchViewController.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 22/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class CommonSearchViewController: UIViewController {

    
    @IBOutlet weak var tabView: UITableView!
    @IBOutlet weak var qrCode: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var txtField: UITextField!
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
  
        self.tabView.delegate = self
        self.tabView.dataSource = self
        self.tabView.separatorStyle = .none
        tabView.register(UINib(nibName: "CommonSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "CommonSearchTableViewCell")
//      txtField.addTarget(self, action: #selector(BranchListNewViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
     
       
        // Do any additional setup after loading the view.
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("Search textfield")
    }
    
    

    @IBAction func searchClick(_ sender: Any) {
        print("Serarch click")
    }
    @IBAction func qrcodeClick(_ sender: Any) {
        let vc = QRCOdeViewController(nibName: "QRCOdeViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
  

}
extension CommonSearchViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: "CommonSearchTableViewCell", for: indexPath) as! CommonSearchTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


/*
   @IBAction func searchClick(_ sender: Any) {
   }
   // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
  */
