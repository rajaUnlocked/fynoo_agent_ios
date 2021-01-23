//
//  AddedServicesInDataEntryViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 27/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol  AddedServicesInDataEntryViewControllerDelegate {
    
     func popUpOkayClicked(_ sender: Any)
}

class AddedServicesInDataEntryViewController: UIViewController {
    
    var  delegate : AddedServicesInDataEntryViewControllerDelegate?
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var okayBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
      var addedserviceDetailData  : serviceDetailData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.okayBtn.setAllSideShadowForFields(shadowShowSize: 3.0, sizeFloat: 100)
        self.SetFont()
        self.tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CancelReasonViewCell", bundle: nil), forCellReuseIdentifier: "CancelReasonViewCell")
        
    }
         
    func SetFont() {
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.textLbl.font = UIFont(name:"\(fontNameLight)",size:16)
        self.okayBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
        
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//          let touch = touches.first
//          if touch?.view == self.view {
//              dismiss(animated: true, completion: nil)
//          }
//      }
    
    @IBAction func okayBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
              
              self.delegate?.popUpOkayClicked(self)
    }
    
    
    
}

extension AddedServicesInDataEntryViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension AddedServicesInDataEntryViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return addedserviceDetailData?.data?.data_entry_lines?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CancelReasonViewCell", for: indexPath) as! CancelReasonViewCell
        cell.selectionStyle = .none
        cell.upperLabel.isHidden = true
        cell.selectBtn.isHidden = true
        
        cell.name.text = addedserviceDetailData?.data?.data_entry_lines?[indexPath.row].des_name ?? ""
        
        return cell
        
    }
    
}
