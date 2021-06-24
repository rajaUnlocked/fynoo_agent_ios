//
//  CancelReasonViewController.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 20/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import ObjectMapper

class CancelReasonViewController: UIViewController, CancelReasonViewCellDelegate {
    
    var delegate : DECancellationReasonViewControllerDelegate?
      
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!

    @IBOutlet weak var tableView: UITableView!
 
    
    var reasonListData : reasonlistData?
//    var itemListArray:[Item_detail]?
        
         var SelectedIndex:NSMutableArray = NSMutableArray()
        
        override func viewDidLoad() {
            super.viewDidLoad()
              
            self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
            self.headerView.titleHeader.text = "Product Details"
            self.headerView.menuBtn.isHidden = true
            self.headerView.viewControl = self
            
            self.SetFont()
            callReasonForCancelApi()
            tableView.separatorStyle = .none
            view.isOpaque = false
//            view.backgroundColor = .clear
            self.submitBtn.layer.cornerRadius = 5
            self.submitBtn.clipsToBounds = true
    
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CancelReasonViewCell", bundle: nil), forCellReuseIdentifier: "CancelReasonViewCell")
//            cancelBtn.addTarget(self, action: #selector(closePopUp(_:)), for: .touchUpInside)
        }


       func SetFont() {
               let fontNameLight = NSLocalizedString("LightFontName", comment: "")
               
        self.headerView.titleHeader.font = UIFont(name:"\(fontNameLight)",size:16)
        self.submitBtn.titleLabel!.font = UIFont(name:"\(fontNameLight)",size:16)
              
           }
           @objc func closePopUp(_ sender : UIButton){
                 dismiss(animated: true, completion: nil)
             }

     
        @IBAction func submitClicked(_ sender: Any) {
            if SelectedIndex.count > 0 {
                
                 dismiss(animated: true, completion: nil)
                let selectedID = self.SelectedIndex.object(at: 0)
                self.delegate?.selectedCancelReason(reasonID: ModalController.toString(selectedID as Any))
                self.navigationController?.popViewController(animated: true)
                
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "Please select one Reason...".localized)
                return
                
            }
        }
        

        func selectedReason(_ sender: Any) {
            
        }
    
    
    func callReasonForCancelApi(){
        
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"
        
        if userId == "0"{
            userId = ""
            
        }
        let param = ["reason_for":"5",
                     "reason_at":"3",
                     "user_id":userId,
                     "lang_code":HeaderHeightSingleton.shared.LanguageSelected]
        
        print("request:-", param)
        print("Url:-", Service.reasonforreturn)
        ServerCalls.postRequest(Service.reasonforreturn, withParameters: param) { [self] (response, success) in
            if success{
                
                if let body = response as? [String: Any] {
                    self.reasonListData  = Mapper<reasonlistData>().map(JSON: body)
                    
                    print(self.reasonListData?.data?.reason_list ?? "")
                    
                  
                    self.tableView.reloadData()

                }
            }
        }
    }


    }

    extension CancelReasonViewController : UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 40
        }
    }

    extension CancelReasonViewController : UITableViewDataSource {
        
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
            }else {
                cell.selectBtn.isSelected = false
            }
            
            cell.delegate = self
            return cell
            
        }
        
    }

