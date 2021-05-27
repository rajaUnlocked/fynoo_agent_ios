//
//  ProductDetailsViewC.swift
//  Fynoo Services
//
//  Created by Apple on 20/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

class ProductDetailsViewC: UIViewController {
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "BusinessOwnerTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessOwnerTableViewCell");
        tableView.register(UINib(nibName: "BOCustomerTableViewCell", bundle: nil), forCellReuseIdentifier: "BOCustomerTableViewCell");
        tableView.register(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell");
        tableView.register(UINib(nibName: "AddInvoiceInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "AddInvoiceInformationTableViewCell");
        
        
       
        tableView.delegate=self
        tableView.dataSource=self
        
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerView.titleHeader.text = "Product Details"
        self.headerView.menuBtn.isHidden = true
        self.headerView.viewControl = self
    }
 
}

extension ProductDetailsViewC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            return 3
        }else
        {
        
          return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
//        if indexPath.section == 0{
//            if indexPath.row == 0{
//                return 160
//            }else {
//                return 120
//            }
//        }
        
        if indexPath.section == 1{
            
                return 280
        }else if indexPath.section == 3{
            return 380
        }else
        {
            return 160
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        if indexPath.section == 1{
//            if indexPath.row < (tripListListArray!.count) {
//                return deliveryServiceListCell(index: indexPath)
//            }else{
//                return self.loadingCell()
//            }
//        }else{
//        if indexPath.row == 0{
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AgentDeliveryTableViewCell",for: indexPath) as! AgentDeliveryTableViewCell
//              cell.clickservicedocument.addTarget(self, action: #selector(clickedservicedoc), for: .touchUpInside)
//            cell.switches.addTarget(self, action: #selector(switchClicked), for: .touchUpInside)
//            if deliverData?.data?.agent_information?.del_service_status == 1{
//                cell.switches.isSelected = true
//            }else{
//                cell.switches.isSelected = false
//            }
//            cell.name.text = deliverData?.data?.agent_information?.name ?? ""
//            cell.avgRating.text = "\(deliverData?.data?.agent_information?.avg_rating ?? 0)"
//            cell.totalRating.text = "\(deliverData?.data?.agent_information?.total_rating ?? 0)"
//            cell.trip.text = "\(deliverData?.data?.agent_information?.total_trips ?? 0)"
//            cell.year.text = "\(deliverData?.data?.agent_information?.active_years ?? 0)"
//            cell.earning.text = "\(deliverData?.data?.agent_information?.total_earnings ?? 0)"
//            cell.cod.text = "\(deliverData?.data?.del_accept_limit?.today_cod ?? 0)"
//            cell.agentProfileImageView.sd_setImage(with: URL(string: deliverData?.data?.agent_information?.user_img ?? ""), placeholderImage: UIImage(named: "profile_white.png"))
//            cell.langugae.text = "\(deliverData?.data?.user_lang ?? "")"
//
//
//            if deliverData?.data?.agent_information?.del_service_document_uploaded == 1 {
//                cell.delivery.image = UIImage(named: "accepted_tick")
//                //pending
//            }else if deliverData?.data?.agent_information?.del_service_document_uploaded == 2{
//                //approved
//                cell.delivery.image = UIImage(named: "grayTick")
//
//            }else if deliverData?.data?.agent_information?.del_service_document_uploaded == 3{
//                //reject
//                cell.delivery.image = UIImage(named: "cross-1")
//
//            }else if deliverData?.data?.agent_information?.del_service_document_uploaded == 4{
//                //edit & approve
//                cell.delivery.image = UIImage(named: "accepted_tick")
//
//            }else if deliverData?.data?.agent_information?.del_service_document_uploaded == 5 {
//                //removed
//                cell.delivery.image = UIImage(named: "cross-1")
//
//            }
//            cell.editAmount.addTarget(self, action: #selector(editAmountClicked), for: .touchUpInside)
//            cell.infoClicked.addTarget(self, action: #selector(infoClicked), for: .touchUpInside)
//
//
//            cell.selectionStyle = .none
//              return cell
//        }else{
        
                if indexPath.section == 0{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessOwnerTableViewCell",for: indexPath) as! BusinessOwnerTableViewCell
            cell.selectionStyle = .none
            
//            cell.tripAchivementData = deliverData?.data?.agent_information?.trips_achievements
//            cell.collectionView.reloadData()
            
            return cell
                }else if indexPath.section == 1{
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BOCustomerTableViewCell",for: indexPath) as! BOCustomerTableViewCell
                    cell.selectionStyle = .none
                    
                    return cell
                }else if indexPath.section == 3{
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "AddInvoiceInformationTableViewCell",for: indexPath) as! AddInvoiceInformationTableViewCell
                    cell.selectionStyle = .none
                    
                    return cell
                }else
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell",for: indexPath) as! ProductListTableViewCell
                    cell.selectionStyle = .none
                    
                    return cell
                }
       }
    }
    
/*
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
                let vc = ProductDetailsViewC()
        //        vc.serviceID = ModalController.toString(((self.serviceArr.object(at: indexPath.item) as! NSDictionary).object(forKey: "service_id") as! NSNumber) as Any)
                self.navigationController?.pushViewController(vc, animated: true)
     
    }
    
*/
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
           
//           if cell.tag == 999999 {
//
//               currentPageNumber += 1
//               self.getTripData()
//           }
       }
    
    func loadingCell() -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        cell.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        cell.tag = 999999
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = cell.contentView.backgroundColor
        activityIndicator.frame = CGRect(x: (UIScreen.main.bounds.size.width / 2) - 10, y: 12, width: 20, height: 20)
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          if section == 0{
              return 0
          }
          return 70
      }
      
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 0{
//            return UIView()
//        }else{
//
//            if headerView1 == nil
//            {
//
//                headerView1 = DataBankHeader()
//
//                headerView1!.delegate = self
//            }
//            headerView1!.selectedIndex = Index
//
//            return headerView1
//
//
//        }
//
//    }
//}

extension ProductDetailsViewC : UITableViewDelegate {
}
