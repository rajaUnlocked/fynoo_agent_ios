//
//  SelectCategoryViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 11/02/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol SelectCategoryDelegate {
    func cataList(dict:NSDictionary)
    func productDiscountCategory(categoryDict:NSMutableDictionary, subCategoryDict:NSMutableDictionary?)
}
class SelectCategoryViewController: UIViewController {
    var delegate:SelectCategoryDelegate?
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var navigationView: NavigationView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var catalbl: UILabel!
    
    @IBOutlet weak var categorySelectedName: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var savebtn: UIButton!
    @IBOutlet weak var bottomVieqHeightConstant: NSLayoutConstraint!
    var isFromProductDiscount:Bool = false
    
    var SubcatList :  SubCategoryList?
    var catList :  CategoryList?
    var filterArray :  [sub_cat_List]?
    var selectedRow = 0
    var subCateogrySelectRow = 99999
    var proName = ""
    var textArray = ["Ladies","Sneakers","Shoes","Slippers","Bathroom Slipper","Baby Shoes"]
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        self.noDataLbl.text = "No discount found.".localized
        self.savebtn.setTitle("Save", for: .normal)
        if isFromProductDiscount == true {
              self.bottomView.isHidden = false
            self.SetUpProductDiscountUI()
        }else{
            self.bottomView.isHidden = true
            self.bottomVieqHeightConstant.constant = 0
        }
        
        productName.text = proName
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        searchField.placeholder = "Search".localized
        searchField.addTarget(self, action: #selector(SelectCategoryViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
     
        self.tabBarController?.tabBar.isHidden = true

        self.topViewHeightConstraint.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
//        bgImage.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
        tableView.register(UINib(nibName: "SelectCategoryCell", bundle: nil), forCellReuseIdentifier: "SelectCategoryCell")
        navigationView.viewControl = self
        navigationView.titleHeader.text = "Manage Your Products".localized
        collectionView.register(UINib(nibName: "SelectSubCat", bundle: nil), forCellWithReuseIdentifier: "SelectSubCat");
        
        collectionView.delegate = self
        collectionView.dataSource = self
        catalbl.text = "Categories".localized
          let fontNameLight = NSLocalizedString("LightFontName", comment: "")
         let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
       productName.font = UIFont(name:"\(fontNameLight)",size:12)
         catalbl.font = UIFont(name:"\(fontNameLight)",size:16)
         categorySelectedName.font = UIFont(name:"\(fontNameLight)",size:12)
         searchField.font = UIFont(name:"\(fontNameLight)",size:12)
        savebtn.titleLabel?.font = UIFont(name:"\(fontNameLight)",size:12)
     noDataLbl.font = UIFont(name:"\(fontNameBold)",size:20)
       self.noDataView.isHidden = true
        let obj =  SelectCategory()
        obj.getSelectCategory { (success, response) in
            if success{
                self.catList = response
                let Id = self.catList?.data?.cat_list?[0].cat_id
                self.categorySelectedName.text = self.catList?.data?.cat_list?[0].cat_name ?? ""

                self.getSubCateData(id: Id!)
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func savebtnClicked(_ sender: Any) {
        
        let catDict = NSMutableDictionary()
        let subCatDict = NSMutableDictionary()
        let id =  catList?.data?.cat_list?[selectedRow].cat_id ?? 0
        let catImage = catList?.data?.cat_list?[selectedRow].category_image ?? ""
        let catName = catList?.data?.cat_list?[selectedRow].cat_name ?? ""
        
        catDict.setValue("\(id)", forKey: "cat_id")
        catDict.setValue(catImage, forKey: "cat_image")
        catDict.setValue(catName, forKey: "cat_name")
        
        var subCatName = ""
        var subCatImage = ""
        var subCatId = ""
      
        
        if subCateogrySelectRow != 99999 {
        if (filterArray?.count) != nil {
            if filterArray?.count == 0 {
                subCatName = SubcatList?.data?.sub_cat_list?[subCateogrySelectRow].sub_cat_name ?? ""
                subCatImage = SubcatList?.data?.sub_cat_list?[subCateogrySelectRow].category_image ?? ""
                subCatId = "\(SubcatList?.data?.sub_cat_list?[subCateogrySelectRow].sub_cat_id ?? 0)"
            }else{
                subCatName = filterArray?[subCateogrySelectRow].sub_cat_name ?? ""
                subCatImage = filterArray?[subCateogrySelectRow].category_image ?? ""
                subCatId =  "\(filterArray?[subCateogrySelectRow].sub_cat_id ?? 0)"
            }
        }else{
            subCatName = SubcatList?.data?.sub_cat_list?[subCateogrySelectRow].sub_cat_name ?? ""
            subCatImage = SubcatList?.data?.sub_cat_list?[subCateogrySelectRow].category_image ?? ""
            subCatId = "\(SubcatList?.data?.sub_cat_list?[subCateogrySelectRow].sub_cat_id ?? 0)"
        }
        }
        subCatDict.setValue("\(subCatId)", forKey: "sub_cat_id")
        subCatDict.setValue(subCatImage, forKey: "sub_cat_image")
        subCatDict.setValue(subCatName, forKey: "sub_cat_name")
        
        print("catDict:-", catDict)
        print("subCatDict:-", subCatDict)
        
        self.delegate?.productDiscountCategory(categoryDict: catDict, subCategoryDict: subCatDict)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    func SetUpProductDiscountUI(){
        
        self.bottomVieqHeightConstant.constant = 85
        
        self.savebtn.layer.cornerRadius = 5
        self.savebtn.clipsToBounds = true
        self.savebtn.layer.borderWidth = 0.3
        self.savebtn.layer.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
        self.savebtn.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: 100)
    }
    
    func getSubCateData(id : Int) {
        
        let obj =  SelectCategory()
        obj.catId = "\(id)"
        obj.getSelectSubCategory { (success, response) in
            if success{
                self.SubcatList = response
                if self.SubcatList?.data?.sub_cat_list?.count ?? 0 > 0 {
                    self.noDataView.isHidden = true
                }else{
                    self.noDataView.isHidden = false
                }
            }else {
                self.noDataView.isHidden = false
            }
            self.collectionView.reloadData()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let textStr = textField.text {
            if self.SubcatList?.data?.sub_cat_list?.count == 0{
                return
            }
            
            if textField.text!.count == 0{
                filterArray?.removeAll()
            }
           // textSTR = textStr
            print("t5y7iglujkgm")
            
            filterArray =  self.SubcatList?.data?.sub_cat_list!.filter{($0.sub_cat_name.lowercased() as AnyObject).contains(textStr.lowercased())}
            
            print(filterArray!.count,"LKk")
            collectionView.reloadData()
        }
    }
}


extension SelectCategoryViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchField.text != "" {
            return filterArray!.count
            
        }else{
            guard let value = SubcatList?.data?.sub_cat_list?.count else{return 0}
            return value
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectSubCat", for: indexPath) as! SelectSubCat
        
        if isFromProductDiscount {
            cell.contentView.cornerRadius = cell.contentView.frame.size.width / 2
            if subCateogrySelectRow == indexPath.row {
                cell.subCatTitle.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
                
            }else{
                cell.subCatTitle.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
                cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
       
        
        if (filterArray?.count) != nil{
            if filterArray?.count == 0{
                cell.subCatTitle.text = SubcatList?.data?.sub_cat_list?[indexPath.item].sub_cat_name ?? ""
                let str = SubcatList?.data?.sub_cat_list?[indexPath.item].category_image ?? ""
                cell.subCat.setImageSDWebImage(imgURL: str, placeholder: "placeholder")
            }else{
                cell.subCatTitle.text = filterArray?[indexPath.item].sub_cat_name ?? ""
                let str = filterArray?[indexPath.item].category_image ?? ""
                cell.subCat.setImageSDWebImage(imgURL: str, placeholder: "placeholder")
            }
        }else{
            cell.subCatTitle.text = SubcatList?.data?.sub_cat_list?[indexPath.item].sub_cat_name ?? ""
            let str = SubcatList?.data?.sub_cat_list?[indexPath.item].category_image ?? ""
            cell.subCat.setImageSDWebImage(imgURL: str, placeholder: "placeholder")
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.frame.width
        let size = CGSize(width: (screenSize - 40)/3  , height: 70)
        return size
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isFromProductDiscount {
            subCateogrySelectRow = indexPath.item
            self.collectionView.reloadData()
            
        }else{
        let tempDict = NSMutableDictionary()
        let id =  catList?.data?.cat_list?[selectedRow].cat_id ?? 0
        let catImage = catList?.data?.cat_list?[selectedRow].category_image ?? ""
        let catName = catList?.data?.cat_list?[selectedRow].cat_name ?? ""
        
        var subCatName = ""
        var subCatImage = ""
        var subCatId = ""
        if (filterArray?.count) != nil {
            if filterArray?.count == 0 {
                subCatName = SubcatList?.data?.sub_cat_list?[indexPath.item].sub_cat_name ?? ""
                subCatImage = SubcatList?.data?.sub_cat_list?[indexPath.item].category_image ?? ""
                subCatId = "\(SubcatList?.data?.sub_cat_list?[indexPath.item].sub_cat_id ?? 0)"
            }else{
                subCatName = filterArray?[indexPath.item].sub_cat_name ?? ""
                subCatImage = filterArray?[indexPath.item].category_image ?? ""
                subCatId =  "\(filterArray?[indexPath.item].sub_cat_id ?? 0)"
            }
        }else{
            subCatName = SubcatList?.data?.sub_cat_list?[indexPath.item].sub_cat_name ?? ""
            subCatImage = SubcatList?.data?.sub_cat_list?[indexPath.item].category_image ?? ""
            subCatId = "\(SubcatList?.data?.sub_cat_list?[indexPath.item].sub_cat_id ?? 0)"
        }
        
        tempDict.setValue("\(id)", forKey: "cat_id")
        tempDict.setValue(catImage, forKey: "cat_image")
        tempDict.setValue(catName, forKey: "cat_name")
        
        tempDict.setValue("\(subCatId)", forKey: "sub_cat_id")
        tempDict.setValue(subCatImage, forKey: "sub_cat_image")
        tempDict.setValue(subCatName, forKey: "sub_cat_name")
          self.delegate?.cataList(dict: tempDict)
        self.navigationController?.popViewController(animated: true)
      
    }
    }
}


extension SelectCategoryViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        subCateogrySelectRow = 99999
        searchField.text = ""
         filterArray?.removeAll()
        let id = catList?.data?.cat_list?[selectedRow].cat_id
        categorySelectedName.text = catList?.data?.cat_list?[selectedRow].cat_name ?? ""
        getSubCateData(id: id!)
        tableView.reloadData()
    }
}

extension SelectCategoryViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let value = catList?.data?.cat_list?.count else {
            return 0
        }
        return value
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectCategoryCell", for: indexPath) as! SelectCategoryCell
        cell.selectionStyle = .none
      
        if selectedRow == indexPath.row {
            cell.selectedImg.isHidden = false
            cell.catTitle.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.937254902, blue: 0.9333333333, alpha: 1)
            
        }else{
            cell.catTitle.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2196078431, alpha: 1)
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.selectedImg.isHidden = true
        }
        let str = catList?.data?.cat_list?[indexPath.item].category_image ?? ""
        cell.catImg.setImageSDWebImage(imgURL: str, placeholder: "placeholder")
        
        cell.catTitle.text = catList?.data?.cat_list?[indexPath.row].cat_name ?? ""
        return cell
    }
    
}
