//
//  BottomPopupEditProductViewController.swift
//  Fynoo Business
//
//  Created by Preeti Rathore on 28/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit


protocol BottomPopupEditProductViewControllerDelegate {
    func information(Value : String)
    func actionPerform(tag :Int,index:Int)
    func filterIdval(tag :Int,Value : String,id:Int)
  
}
class BottomPopupEditProductViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,BottomPopupTableViewCellDelegate{
    var branchType = false
    var isType = false
    var index = 0
    var tag1 = 0
   var iswarning = false
    var imageKind = [String]()
    @IBOutlet weak var cardVieww: UIView!
    var value = ""
    @IBOutlet weak var tabView: UITableView!
    var isproduct = false
     var isproductlist = false
    var header = ""
     var isfiletr = false
    @IBOutlet weak var chooselbl: UILabel!
    var delegate : BottomPopupEditProductViewControllerDelegate?
    var isVarient = false
    var nameAr  = ["Edit Product".localized,"Add Similar Product".localized,"Add Product".localized]
    var nameArId = [Int]()
    var namelock = [Int]()
    var imgAr  = ["edit_grey", "add_variant","similar_pro","add_pro_grey"]
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        if header == "registration type"
        {
            self.chooselbl.text = "Select Registration Type.".localized
        }else if header == "vehicle brand"{
            self.chooselbl.text = "Select Vehicle Brand.".localized
        }else if header == "vehicle name"{
            self.chooselbl.text = "Select Vehicle Name.".localized
            
        }else if header == "vehicle color"{
            self.chooselbl.text = "Select Vehicle Color.".localized
            
        }else if header == "vehicle kind"{
            self.chooselbl.text = "Select Vehicle Kind.".localized
            
        }
        else{
        self.chooselbl.text = "Choose your option".localized
        }
        if isVarient
        {
            nameAr  = ["Edit Product".localized, "Add Variant Product".localized,"Add Similar Product".localized,"Add Product".localized]
        }
        if isproduct
        {
            chooselbl.text = "Select Image From".localized
        }
          let fontNameLight = NSLocalizedString("LightFontName", comment: "")
       chooselbl.font = UIFont(name:"\(fontNameLight)",size:12)
        view.isOpaque = false
              view.backgroundColor = .clear
        tabView.tableFooterView = UIView()
        contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:280)
        tabView.delegate = self
        tabView.dataSource = self
        tabView.separatorStyle = .none
        tabView.register(UINib(nibName: "BottomPopupTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomPopupTableViewCell")
        tabView.register(UINib(nibName: "HeaderBranchTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderBranchTableViewCell")
         tabView.register(UINib(nibName: "VehicleKindTableViewCell", bundle: nil), forCellReuseIdentifier: "VehicleKindTableViewCell")
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameAr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isType
        {
             let cell = tabView.dequeueReusableCell(withIdentifier: "VehicleKindTableViewCell", for: indexPath) as! VehicleKindTableViewCell
              cell.selectionStyle = .none
             cell.lbl.text = nameAr[indexPath.row]
            cell.imgvw.sd_setImage(with: URL(string: imageKind[indexPath.row]), placeholderImage: UIImage(named: "passport"))
            return cell
        }
        let cell = tabView.dequeueReusableCell(withIdentifier: "BottomPopupTableViewCell", for: indexPath) as! BottomPopupTableViewCell
        cell.delegate = self
        cell.selectionStyle = .none
        cell.nameLbl.text = nameAr[indexPath.row]
        if isfiletr{
            cell.img.isHidden = true
            if namelock.contains(nameArId[indexPath.row])
            {
                cell.infoBtn.isHidden = true
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else
            {
                
                cell.infoBtn.isHidden = false
              cell.infoBtn.setImage(UIImage(named: "lock"), for: .normal)
                 cell.contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
            }
        }
        else{
            cell.img.isHidden = iswarning
             if isproduct || isproductlist
             {
             cell.img.isHidden = false
             cell.img.image = UIImage(named:imgAr[indexPath.row ])
             }
            
            
             if indexPath.row == 1 || indexPath.row == 2  {
                 cell.infoBtn.isHidden = iswarning
             }
        }
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isproduct
        {
            self.dismiss(animated: true) {
                self.delegate?.actionPerform(tag: indexPath.row,index:self.index)
            }
            
            return
        }
        if isproductlist
        {
            self.delegate?.actionPerform(tag: indexPath.row,index:index)
            return
        }
        
        
        if namelock.contains(nameArId[indexPath.row])
        {
            self.dismiss(animated: true) {
                self.delegate?.filterIdval(tag: self.tag1, Value: self.nameAr[indexPath.row], id: self.nameArId[indexPath.row])
                
                
            }
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isType
        {
            return 60
        }
        return 45
    }
    
  
    
    @IBAction func cancel(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
    }
    
    func info(tag: Int) {
        value = nameAr[tag]
        self.dismiss(animated: true) {
            self.delegate?.information(Value: self.value)
        }
       
     }
     


}
