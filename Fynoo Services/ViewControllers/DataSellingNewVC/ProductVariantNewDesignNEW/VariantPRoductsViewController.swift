//
//  VariantPRoductsViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 17/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class VariantPRoductsViewController: UIViewController {

    @IBOutlet weak var tabView: UITableView!
    @IBOutlet weak var headerVw: NavigationView!
    
    @IBOutlet weak var topHeightConstraints: NSLayoutConstraint!
    var productVariantModel =  ProductVariantModel()
       var varient_List: ProductVariantListModel?
       var productId = ""
       
    @IBOutlet weak var backGroundView: UIImageView!
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        headerVw.titleHeader.text = "Variant Products".localized
        headerVw.viewControl = self
//        backGroundView.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        tabView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        tabView.register(UINib(nibName: "ProductVariantDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductVariantDetailTableViewCell")
        
        tabView.register(UINib(nibName: "VariantSpecificationTableViewCell", bundle: nil), forCellReuseIdentifier: "VariantSpecificationTableViewCell")
       
        
        tabView.separatorStyle = .none
        tabView.delegate  = self
        tabView.dataSource = self
         getProductVarientList()
        // Do any additional setup after loading the view.
    }
    func getProductVarientList(){
        ModalClass.startLoading(self.view)
        productVariantModel.proId = productId
        productVariantModel.getProductVariantList { (success, response) in
            ModalClass.stopLoading()
            if success {
                
                self.varient_List = response
                
                self.tabView.reloadData()
                print(response!)
            }
        }
    }

    
}
extension VariantPRoductsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            
            return varient_List?.data?.pro_variant?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 100
        }
            
        else {
            return 120
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tabView.dequeueReusableCell(withIdentifier: "ProductVariantDetailTableViewCell", for: indexPath) as! ProductVariantDetailTableViewCell
            let url = self.varient_List?.data?.pro_image ?? ""
            cell.proImg.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "category_placeholder"))
            cell.nameLbl.text = self.varient_List?.data?.pro_name
            cell.priceLbl.text = self.varient_List?.data?.pro_price
            cell.avgRatingLbl.text = self.varient_List?.data?.pro_raters
            cell.ratingCountLbl.text = "(\(self.varient_List?.data?.pro_avg_rating ?? 0))"
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tabView.dequeueReusableCell(withIdentifier: "VariantSpecificationTableViewCell", for: indexPath) as! VariantSpecificationTableViewCell
            cell.selectionStyle = .none
            cell.isType = true
            cell.property2Value.isHidden = true
            cell.property2.isHidden = true
            cell.img.image = UIImage(named: "variant_size")
            cell.nameLbl.text = varient_List?.data?.pro_variant?[indexPath.row].filter_value
            cell.propertyLbl.text = varient_List?.data?.pro_variant?[indexPath.row].filter
            cell.underLbl.isHidden = true
            cell.varientList = varient_List
            cell.collectionView.reloadData()
            return cell
        }
        
        
        
        
        
    }
    
}
