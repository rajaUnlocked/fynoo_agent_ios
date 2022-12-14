//
//  ReasonForDeleteViewController.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 11/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import ObjectMapper

class ReasonForDeleteViewController: UIViewController, CancelReasonViewCellDelegate {
    
    @IBOutlet weak var containter: UIView!
    @IBOutlet weak var rejectedlbl: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductQty: UILabel!
    @IBOutlet weak var viewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnREduceQtyOutlet: UIButton!
    
    var reasonListData : reasonlistData?
//    var delegate : DECancellationReasonViewControllerDelegate?
    var delegateDelegate : PopUpAcceptProductDelegate?
    var orderId = ""
    var itemId = 0
    
    
    var SelectedIndex:NSMutableArray = NSMutableArray()
    

    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CancelReasonViewCell", bundle: nil), forCellReuseIdentifier: "CancelReasonViewCell")
        getPopupHeight()
        SetFont()
        btnREduceQtyOutlet.backgroundColor = UIColor.AppThemeRedTextColor()

    }
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.rejectedlbl.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblProductName.font = UIFont(name:"\(fontNameLight)",size:12)
        self.lblProductQty.font = UIFont(name:"\(fontNameLight)",size:12)
        self.btnREduceQtyOutlet.titleLabel!.font = UIFont(name:"\(fontNameLight)",size:16)
        
        
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.containter {
            
        }else{
            dismiss(animated: true, completion: nil)

        }
    }
    
            func getPopupHeight() {
    
                   
                        let count = self.reasonListData?.data?.reason_list?.count ?? 0
                        let height = CGFloat(count*35) + 300
                viewHeightConstant.constant = height
//                          self.contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:height)
    
                        self.tableView.reloadData()
                    }
                
    
    
    @IBAction func submitClicked(_ sender: Any){
        

        
        if SelectedIndex.count > 0 {
            
            let selectedID = self.SelectedIndex.object(at: 0)

            print((ModalController.toString(selectedID as Any)))
            let str = Service.deleteIndivisualItem
            let param = ["user_id":Singleton.shared.getUserId(),"lang_code":HeaderHeightSingleton.shared.LanguageSelected,"item_id":itemId,"order_id":orderId,"reason_id":"\(ModalController.toString(selectedID as Any))"] as [String : Any]
            print(param)
            ServerCalls.postRequest(str, withParameters: param) { (response, success) in
                self.delegateDelegate?.reloadPage()
                self.dismiss(animated: true, completion: nil)
            }
            
        }else{
            ModalController.showNegativeCustomAlertWith(title: "", msg: "Please select one reason type".localized)
            return
            
        }
      
        
    }
    
    
    @IBAction func closeClicked(_ sender: Any){
        
        self.dismiss(animated: true, completion: nil)

    }
    
    func selectedReason(_ sender: Any) {
        print("arvvv")
    }

}



extension ReasonForDeleteViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension ReasonForDeleteViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reasonListData?.data?.reason_list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let reasonID = ModalController.toString( reasonListData?.data?.reason_list?[indexPath.row].reason_id as Any)
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
        
            cell.name.text = reasonListData?.data?.reason_list?[indexPath.row].reason ?? ""
        
        let reasonID = ModalController.toString(reasonListData?.data?.reason_list?[indexPath.row].reason_id as Any)
        
        if SelectedIndex.contains(reasonID) {
            cell.selectBtn.isSelected = true
            btnREduceQtyOutlet.backgroundColor = UIColor.AppThemeGreenTextColor()
            
        }else {
            cell.selectBtn.isSelected = false
        }
        
        if SelectedIndex.count == 0{
            btnREduceQtyOutlet.backgroundColor = UIColor.AppThemeRedTextColor()
        }
        
        cell.delegate = self
        return cell
        
    }
    
}
