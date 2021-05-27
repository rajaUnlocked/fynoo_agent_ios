//
//  ProfileServiceTableViewCell.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 09/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ProfileServiceTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SearchCategoryViewControllerDelegate  {
    func selectetCourierCompanyMethod(courierCompanyDict: NSMutableDictionary) {
    }
    
    func selectedCountryCodeMethod(mobileCodeDict: NSMutableDictionary) {
    }
    
    func selectPhoneCodeMethod(phoneCodeDict: NSMutableDictionary) {
    }
    
    func selectedCategoryMethod(countryDict: NSMutableDictionary, tag: Int) {
        
    }
    
    func selectedCityMethod(cityDict: NSMutableDictionary) {
        
    }
    
    func selectedEducationMethod(educationDict: NSMutableDictionary) {
        
    }
    
    func selectedMajorEducationMethod(educationDict: NSMutableDictionary) {
        
    }
    
    func selectedCurrency(currency: NSMutableDictionary) {
        
    }
    
    func selectedBankMethod(bankDict: NSMutableDictionary) {
        
    }
    
    func selectedCountryCode(countryCode: NSMutableDictionary) {
        
    }
    func selectetBranchMethod(BranchDict : NSMutableDictionary){
        
    }
  
    
    @IBOutlet weak var collectionView: UICollectionView!
    var serviceList : [service_list_data]?
    var languageList : [language_lists]?
    var isForLanguage = false
    var isEdit = false
    var agentinfo = AgentProfile()
    var layout = UICollectionViewFlowLayout()
    var viewControl = UIViewController()
    weak var delegate: LanguageSelectionViewControllerDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "ProfileServiceViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfileServiceViewCell");
        collectionView.delegate = self
        collectionView.dataSource = self


           if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
               layout.scrollDirection = .horizontal
           }
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isForLanguage{
            return languageList!.count
        }else{
             return serviceList!.count
        }
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isForLanguage{
            if isEdit
            {
            let vc = LanguageSelectionViewController(nibName: "LanguageSelectionViewController", bundle: nil)
            vc.languageSelect = { str in
                print("InSide Closure")
                self.delegate?.reloadPage()
            }
            vc.isFrom = true
            print(agentinfo.langArr)
            vc.selectedArray = agentinfo.langArr
            viewControl.navigationController?.pushViewController(vc, animated: true)
//            let vc = SearchCategoryViewController(nibName: "SearchCategoryViewController", bundle: nil)
//            vc.delegate = self
////            vc.isForLanguage = true
//  //          vc.langArr = agentinfo.langArr
//            viewControl.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            
            let serviceStatus = ModalController.toString(serviceList?[indexPath.row].service_status as Any)
            
            if serviceStatus == "1" {
                if !(serviceList?[indexPath.row].check_service)!
                {
                if agentinfo.serviceArr.contains((serviceList?[indexPath.row].service_id)!){
                    
                    agentinfo.serviceArr.remove((serviceList?[indexPath.row].service_id)!)
                    
                }else{
                    agentinfo.serviceArr.add((serviceList?[indexPath.row].service_id)!)
                }
                }
                else{
                    ModalController.showNegativeCustomAlertWith(title: "This service is inprogress".localized, msg: "")
                }
            }else{
                ModalController.showNegativeCustomAlertWith(title: "This service is disabled. Please contact Fynoo Admin for more information. ".localized, msg: "")
            }
            
            collectionView.reloadData()
        }
       
    }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileServiceViewCell", for: indexPath) as! ProfileServiceViewCell
        if isForLanguage {
            
            cell.serviceName.text = languageList?[indexPath.row].lang_name
            cell.imgCheck.image = UIImage(named: "accepted_tick")
        }else{
            if agentinfo.serviceArr.contains((serviceList?[indexPath.row].service_id)!){
                cell.imgCheck.image = UIImage(named: "check")
            }else{
                cell.imgCheck.image = UIImage(named: "uncheck")
            }
            cell.serviceName.text = serviceList?[indexPath.row].service_name ?? ""

        }
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.frame.width
        if isForLanguage{
            let size = CGSize(width: (screenSize - 40)/3  , height: 50)
               return size
        }else{
            let size = CGSize(width: (screenSize - 40)/2  , height: 50)
               return size
        }
   
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
}
