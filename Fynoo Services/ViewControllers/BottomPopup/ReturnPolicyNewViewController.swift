//
//  ReturnPolicyNewViewController.swift
//  Fynoo
//
//  Created by IND-SEN-LP-048 on 17/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ReturnPolicyNewViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var topconstant: NSLayoutConstraint!
    @IBOutlet weak var returnpolicy: UILabel!
    @IBOutlet weak var cardVieww: UIView!
    
    @IBOutlet weak var tabView: UITableView!
  
    var productdesp = ""
 
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        
        tabView.delegate = self
        tabView.dataSource = self
        tabView.separatorStyle = .none
        
        view.isOpaque = false
        view.backgroundColor = .clear
        tabView.tableFooterView = UIView()
        contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:345)
        tabView.register(UINib(nibName: "ProductWarrentySupportTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductWarrentySupportTableViewCell")
       
        topconstant.constant = 0
       
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
          self.returnpolicy.font = UIFont(name:"\(fontNameLight)",size:16)
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tabView.dequeueReusableCell(withIdentifier: "ProductWarrentySupportTableViewCell", for: indexPath) as! ProductWarrentySupportTableViewCell
            
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"
            {
                cell.warrentyDiscriptionlbl.textAlignment = .right
            }else if value[0]=="en"{
                
                cell.warrentyDiscriptionlbl.textAlignment = .left
            }
        }
        
       
            cell.headerTxtLbl.text = ""
            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            cell.headerTxtLbl.font = UIFont(name:"\(fontNameBold)",size:14.0)
            
            cell.headerTxtLbl.isHidden = false
            cell.warrentyDiscriptionlbl.text = productdesp
            cell.warrentyDiscriptionlbl.font =  UIFont(name:"\(fontNameLight)",size:12.0)
            
            cell.bottomLabel.isHidden = true
       
            
            cell.bottomLabel.isHidden = true
        return cell
        }

      
   
    @IBAction func crossClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
 
}
