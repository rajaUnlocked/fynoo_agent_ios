//
//  GalleryFilterViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 25/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol GalleryFilterViewControllerDelegate {
    func reloadFilteredGallery()
}

class GalleryFilterViewController: UIViewController {
    var delegate: GalleryFilterViewControllerDelegate?
    @IBOutlet weak var filter: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tabView: UITableView!
    var list = ["Product Images","Branch Images","Prodile Images","Added By Agent: Aishwarya","Added By Agent: Neeraj","Added By Agent: Sanjay","Added By Agent: Sanchita","Added By Agent: Randhir"]
    var selectedIndex : NSMutableArray = NSMutableArray()
    var startdate = "2020-01-01"
    var endDate = "2020-01-01"
    var gallery_list_model = BusinessGalleryNewModel()
    var filter_gallery : BusinessGalleryList?
     var filter_list : galleryFilterList?
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.delegate = self
        tabView.dataSource = self
        tabView.separatorStyle = .none
        self.topView.setAllSideShadow(shadowShowSize: 3.0)
        registerCell()
        
        galleryFilterListAPI()
        
        // Do any additional setup after loading the view.
    }
    func registerCell(){
        tabView.register(UINib(nibName: "AllfiterHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "AllfiterHeaderTableViewCell")
        tabView.register(UINib(nibName: "DateFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "DateFilterTableViewCell")
       
        
        
        
    }
    func galleryFilterAPi(){
       
        gallery_list_model.toDate = endDate
        gallery_list_model.fromDate = startdate

        gallery_list_model.galleryFilter { (success, response) in
            if success {
                self.filter_gallery = response
                self.delegate?.reloadFilteredGallery()
                self.navigationController?.popViewController(animated: true)
                 
               
                
            }
         
        }
        
    }
    func galleryFilterListAPI(){
          
           gallery_list_model.galleryFilterList { (success, response) in
               if success {
                   self.filter_list = response
                   self.tabView.reloadData()
                   
               }
           }
           
       }
    
    @IBAction func cancel(_ sender: UIButton) {
        
        if selectedIndex.count > 0 {
            if selectedIndex.contains((self.filter_list?.data?.data_list?[sender.tag].name)!)
            {
                selectedIndex.remove((self.filter_list?.data?.data_list?[sender.tag].name)!)
            }
            
            
        }
        startdate = "2020-01-01"
        endDate = "2020-01-01"
        self.navigationController?.popViewController(animated: true)
      tabView.reloadData()
    }
    
    @IBAction func apply(_ sender: Any) {
        galleryFilterAPi()
       
    }
}
extension GalleryFilterViewController: UITableViewDataSource,UITableViewDelegate,DateFilterTableViewCellDelegate{
    func fromDate(sender: String) {
      startdate =  sender
    }
    
    func toDate(sender: String) {
          endDate =  sender
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else{
            return filter_list?.data?.data_list?.count ?? 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tabView.dequeueReusableCell(withIdentifier: "DateFilterTableViewCell", for: indexPath) as! DateFilterTableViewCell
            cell.fromDtLbl.text = startdate
            cell.toDateLbl.text = endDate
              cell.selectionStyle = .none
            cell.delegate = self
        
            return cell
        }
        else {
            let cell = tabView.dequeueReusableCell(withIdentifier: "AllfiterHeaderTableViewCell", for: indexPath) as! AllfiterHeaderTableViewCell
            cell.selectionStyle = .none
            
          
//            cell.leftLbl.text = list[indexPath.row ]
            cell.leftLbl.text = filter_list?.data?.data_list?[indexPath.row].name
            cell.innerView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
            cell.leftLblLeading.constant = 20
            cell.rightBtnTrailing.constant = 25
            cell.innerView.borderWidth = 0.3
            cell.innerView.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.contentView.backgroundColor = .clear
            cell.leftLbl.font = UIFont(name: "Gilroy-Light", size: 12.0)
            cell.leftLbl.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
            cell.rightBtn.setImage(UIImage(named: "Rectangle4"), for: .normal)
            cell.rightBtn.addTarget(self, action: #selector(checkClick(_ :)), for: .touchUpInside)
            
            if selectedIndex.contains((filter_list?.data?.data_list?[indexPath.row].name)!)
            {
                cell.rightBtn.isSelected = true
                cell.rightBtn.setImage(UIImage(named: "righttick_new"), for: .normal)
            }
            else {
                
                cell.rightBtn.isSelected = false
                cell.rightBtn.setImage(UIImage(named: "Rectangle4"), for: .normal)
            }
            cell.rightBtn.tag = indexPath.row

                          
            return cell
        }
    }
    
    @objc func checkClick(_ sender: UIButton){

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
  
            if selectedIndex.contains((self.filter_list?.data?.data_list?[indexPath.row].name)!)
                   {
                       selectedIndex.remove((self.filter_list?.data?.data_list?[indexPath.row].name)!)
                   }
                  else
                   {
                       selectedIndex.add((self.filter_list?.data?.data_list?[indexPath.row].name)!)
                   }
            tabView.reloadData()
        }
        
                }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        else {
            return 30
            
        }
    }
    
    
    
}
extension UIButton {
    func setAllButtonShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.6
//        self.layer.shadowRadius = 0.0
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


