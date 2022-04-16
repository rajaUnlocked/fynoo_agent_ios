//
//  DECancellationReasonViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 20/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol DECancellationReasonViewControllerDelegate {
    
 func selectedCancelReason(reasonID:String)
    
}
class DECancellationReasonViewController: UIViewController, CancelReasonViewCellDelegate {
    
var delegate : DECancellationReasonViewControllerDelegate?
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    
    var apiManagerModal = DataEntryApiManager()
    var rejectReasonList  : ReasonRejectData?
    
     var SelectedIndex:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
          
        
        self.SetFont()
        self.getRejectReasonAPI()
        
        tableView.separatorStyle = .none
        view.isOpaque = false
        view.backgroundColor = .clear
        self.submitBtn.layer.cornerRadius = 5
        self.submitBtn.clipsToBounds = true
//        self.submitBtn.setAllSideShadow(shadowShowSize: 3.0)
        self.contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:300 )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CancelReasonViewCell", bundle: nil), forCellReuseIdentifier: "CancelReasonViewCell")
        cancelBtn.addTarget(self, action: #selector(closePopUp(_:)), for: .touchUpInside)
        submitBtn.backgroundColor = UIColor.AppThemeRedTextColor()
        submitBtn.setTitleColor(UIColor.AppThemeWhiteTextColor(), for: .normal)
    }


   func SetFont() {
           let fontNameLight = NSLocalizedString("LightFontName", comment: "")
           
           self.headerLbl.font = UIFont(name:"\(fontNameLight)",size:12)
           self.submitBtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
           self.headerLbl.text = "Cancellation Reason".localized
       }
       @objc func closePopUp(_ sender : UIButton){
             dismiss(animated: true, completion: nil)
         }

    @IBAction func cancelClicked(_ sender: Any) {
    }
    @IBAction func submitClicked(_ sender: Any) {
        if SelectedIndex.count > 0 {
            
             dismiss(animated: true, completion: nil)
            let selectedID = self.SelectedIndex.object(at: 0)
            self.delegate?.selectedCancelReason(reasonID: ModalController.toString(selectedID as Any))
            
        }else{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please select one reason type")
            return
            
        }
    }
    
    func getRejectReasonAPI() {
       
        apiManagerModal.dataEntryCancelReason { (success, response) in
            ModalClass.stopLoading()
            if success{
                self.rejectReasonList = response
                
                let count = self.rejectReasonList?.data?.reason_list?.count ?? 0
                let height = CGFloat(count*35) + 100
                  self.contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:height)
                
                self.tableView.reloadData()
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "\(self.rejectReasonList?.error_description ?? "")")
            }
        }
    }
    func selectedReason(_ sender: Any) {
        
    }


}

extension DECancellationReasonViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension DECancellationReasonViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rejectReasonList?.data?.reason_list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let reasonID = ModalController.toString( rejectReasonList?.data?.reason_list?[indexPath.row].reason_id as Any)
        if SelectedIndex.count > 0 {
            if SelectedIndex.contains(reasonID){
                SelectedIndex.removeAllObjects()
            }else{
                SelectedIndex.removeAllObjects()
                SelectedIndex.add(reasonID)
            }
        }else{
            SelectedIndex.add(reasonID)
        }
        
        self.tableView.reloadData()
        print("selectedIndex:-", SelectedIndex)
        
        
        //        let str = Arr[indexPath.row]
        //        delegate?.selectDataEntryItem(str:boServicesTypeList?.data?.data_entry_types?[indexPath.row].type_name ?? "", ItemID: ModalController.toString(boServicesTypeList?.data?.data_entry_types?[indexPath.row].type_id as Any))
        //        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CancelReasonViewCell", for: indexPath) as! CancelReasonViewCell
        cell.selectionStyle = .none
            cell.upperLabel.isHidden = true
        cell.selectBtn.isUserInteractionEnabled = false
        
            cell.name.text = rejectReasonList?.data?.reason_list?[indexPath.row].reason_name ?? ""
        
        let reasonID = ModalController.toString(rejectReasonList?.data?.reason_list?[indexPath.row].reason_id as Any)
        
        if SelectedIndex.contains(reasonID) {
            cell.selectBtn.isSelected = true
            submitBtn.backgroundColor = UIColor.AppThemeGreenTextColor()
        }else {
            cell.selectBtn.isSelected = false
        }
        if SelectedIndex.count == 0{
        submitBtn.backgroundColor = UIColor.AppThemeRedTextColor()
        }
        cell.delegate = self
        return cell
        
    }
    
}
