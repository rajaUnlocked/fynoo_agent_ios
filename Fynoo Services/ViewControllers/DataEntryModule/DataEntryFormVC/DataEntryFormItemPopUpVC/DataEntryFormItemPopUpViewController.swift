//
//  DataEntryFormItemPopUpViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 05/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

protocol DataEntryFormItemPopUpViewControllerDelegate {
    
    func selectDataEntryItem(str:String, ItemID:String)
}
class DataEntryFormItemPopUpViewController: UIViewController {
    
      var delegate : DataEntryFormItemPopUpViewControllerDelegate?
    @IBOutlet weak var cardVieww: UIView!
      @IBOutlet weak var crossButton: UIButton!
      @IBOutlet weak var tableView: UITableView!
     @IBOutlet weak var headerLbl: UILabel!
     
     var Arr = ["Product".localized, "Branch".localized]
    var images : [UIImage] = [#imageLiteral(resourceName: "product_new"),#imageLiteral(resourceName: "platform_icon")]
    
      var apiManagerModal = DataEntryApiManager()
      var boServicesTypeList  : dataEntryFormTypeModal?

    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.SetFont()
        self.getDataEntryTypeAPI()
        
        tableView.separatorStyle = .none
        view.isOpaque = false
        view.backgroundColor = .clear
        
        tableView.tableFooterView = UIView()
        contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:170)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PopUpViewCell", bundle: nil), forCellReuseIdentifier: "PopUpViewCell")
        crossButton.addTarget(self, action: #selector(closePopUp(_:)), for: .touchUpInside)
    }
    
    func SetFont() {
          let fontNameLight = NSLocalizedString("LightFontName", comment: "")
          
          self.headerLbl.font = UIFont(name:"\(fontNameLight)",size:12)
         
      }
      @objc func closePopUp(_ sender : UIButton){
            dismiss(animated: true, completion: nil)
        }

    func getDataEntryTypeAPI() {
        
        apiManagerModal.dataEntryFormType { (success, response) in
            ModalClass.stopLoading()
            if success{
                self.boServicesTypeList = response
               
                self.tableView.reloadData()
            }else{
                ModalController.showNegativeCustomAlertWith(title: "", msg: "\(self.boServicesTypeList?.error_description ?? "")")
            }
        }
    }
}

extension DataEntryFormItemPopUpViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension DataEntryFormItemPopUpViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return boServicesTypeList?.data?.data_entry_types?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let str = Arr[indexPath.row]
        delegate?.selectDataEntryItem(str:boServicesTypeList?.data?.data_entry_types?[indexPath.row].type_name ?? "", ItemID: ModalController.toString(boServicesTypeList?.data?.data_entry_types?[indexPath.row].type_id as Any))
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopUpViewCell", for: indexPath) as! PopUpViewCell
       
        cell.lbl.text  = boServicesTypeList?.data?.data_entry_types?[indexPath.row].type_name ?? ""
        cell.img.sd_setImage(with: URL(string: "\(boServicesTypeList?.data?.data_entry_types?[indexPath.row].feat_icon ?? "")"), placeholderImage: UIImage(named: "manageProduct_new"))

        cell.selectionStyle = .none
        return cell
        
    }
    
}
