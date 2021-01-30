//
//  AgentDeliveryViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-046 on 22/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import ObjectMapper
class AgentDeliveryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var selectedVl = 1000

    var deliverData : deliveryDashboard?
    var tripList : TripListInfo?
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "AgentDeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "AgentDeliveryTableViewCell");
        tableView.register(UINib(nibName: "TripAchievementViewCell", bundle: nil), forCellReuseIdentifier: "TripAchievementViewCell");
        tableView.register(UINib(nibName: "AgentServiceList", bundle: nil), forCellReuseIdentifier: "AgentServiceList");

        getAgentData()
        getTripData()
        self.tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)

        tableView.delegate=self
        tableView.dataSource=self
        // Do any additional setup after loading the view.
    }

    func activateService(){
        
        let str = Service.activateService

        let param = ["user_id":"231","lang_code":"EN","services":"2"]
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
            if success{
                 self.getAgentData()
                let value = response as! NSDictionary
                let msg = value.object(forKey: "error_description") as! String
                ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
                print(response)
            }
        }
    }
    
    func deactivateService(){
        
        let str = Service.deactivateService

        let param = ["user_id":"231","lang_code":"EN","services":"2"]
        ServerCalls.postRequest(str, withParameters: param) { (response, success) in
            if success{
                print(response)
                self.getAgentData()
                let value = response as! NSDictionary
                let msg = value.object(forKey: "error_description") as! String
                ModalController.showSuccessCustomAlertWith(title: "", msg: msg)
            }
        }
    }
    
    
    func getAgentData(){
        var userId = "\(AuthorisedUser.shared.user?.data?.id ?? 0)"

                              if userId == "0"{
                                userId = ""

                              }
        
        let param = ["service_id":"2","user_id":userId,"lang_code":"en"]
        ServerCalls.postRequest(Service.deliveryDashboard, withParameters: param) { (response, success) in
            if success{
                print(response)
                
                if let body = response as? [String: Any] {
                    self.deliverData  = Mapper<deliveryDashboard>().map(JSON: body)

                    print(self.deliverData?.data?.agent_information?.del_service_document ?? "","del_service_document")
                    self.tableView.reloadData()
                                      
                }
            }
        }
    }
    func getTripData(){
    
        var TripId=0
        if selectedVl == 1000{
            TripId = 1
        }else if selectedVl == 1001{
            TripId = 2
        }else{
            TripId=3
        }
        let param = ["service_id":"2","user_id":"1060","lang_code":"en","tab_id":"\(TripId)","next_page_no":"0"]
          ServerCalls.postRequest(Service.tripList, withParameters: param) { (response, success) in
              if success{
               //   print(response)
                  if let body = response as? [String: Any] {
                      self.tripList  = Mapper<TripListInfo>().map(JSON: body)

                    self.tableView.reloadData()
                    
                      
                  }
              }
          }
      }
    
    
    @objc func editAmountClicked(){
        let vc = AddAmountViewController(nibName: "AddAmountViewController", bundle: nil)
        
        vc.modalPresentationStyle = .overFullScreen
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.present(vc, animated: true, completion: nil)
    }
    @objc func segmentClicked(_ sender:UIButton){
        print(sender.tag)
        selectedVl = sender.tag
        getTripData()
       // tableView.reloadData()
    }
    
    @objc func infoClicked(){
        let vc = AddAmountViewController(nibName: "AddAmountViewController", bundle: nil)
        vc.isFrom = true
              vc.modalPresentationStyle = .overFullScreen
              vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
              self.present(vc, animated: true, completion: nil)
    }
    
   
       @objc func clickedservicedoc(_ sender: UIButton)
       {
        let vc = DeliveryDocumentViewController(nibName: "DeliveryDocumentViewController", bundle: nil)
        vc.primaryid = self.deliverData?.data?.agent_information?.dsd_id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func switchClicked(_ sender: UIButton){
        print("switch")
        
        if sender.isSelected {
            sender.isSelected = false
           
             deactivateService()
            
        }else{
            sender.isSelected = true
            activateService()
        }
        
        tableView.reloadData()
    }
}

extension AgentDeliveryViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 2
        }else{
            
            guard let value =  (self.tripList?.data?.trip_list?.count) else {
                return 0
            }
            return value
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0{
            if indexPath.row == 0{
                return 300
            }else {
                return 200
            }
        }
       else{
            return 236
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgentServiceList",for: indexPath) as! AgentServiceList
            
            
            if selectedVl == 1001{
                cell.statusView.backgroundColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
            }else{
                cell.statusView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

            }
            cell.name.text = tripList?.data?.trip_list?[indexPath.row].name ?? ""
            cell.orderId.text = "Order Id:\(tripList?.data?.trip_list?[indexPath.row].order_id ?? "")"
            cell.date.text  = tripList?.data?.trip_list?[indexPath.row].order_date ?? ""
            cell.address.text = "Address:\(tripList?.data?.trip_list?[indexPath.row].order_address ?? "")"
            cell.price.text = tripList?.data?.trip_list?[indexPath.row].final_price ?? ""
            cell.totalCount.text = "\(tripList?.data?.trip_list?[indexPath.row].order_qty ?? 0)"
            cell.selectionStyle = .none
            
            return cell
        }
        
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgentDeliveryTableViewCell",for: indexPath) as! AgentDeliveryTableViewCell
              cell.clickservicedocument.addTarget(self, action: #selector(clickedservicedoc), for: .touchUpInside)
            cell.switches.addTarget(self, action: #selector(switchClicked), for: .touchUpInside)
            if deliverData?.data?.agent_information?.del_service_status == 1{
                cell.switches.isSelected = true
            }else{
                cell.switches.isSelected = false
            }
            cell.name.text = deliverData?.data?.agent_information?.name ?? ""
            cell.avgRating.text = "\(deliverData?.data?.agent_information?.avg_rating ?? 0)"
            cell.totalRating.text = "\(deliverData?.data?.agent_information?.total_rating ?? 0)"
            cell.trip.text = "\(deliverData?.data?.agent_information?.total_trips ?? 0)"
            cell.year.text = "\(deliverData?.data?.agent_information?.active_years ?? 0)"
            cell.earning.text = "\(deliverData?.data?.agent_information?.total_earnings ?? 0)"
            cell.cod.text = "\(deliverData?.data?.del_accept_limit?.today_cod ?? 0)"
            if deliverData?.data?.agent_information?.del_service_document_uploaded == 1{
                cell.delivery.image = UIImage(named: "accepted_tick")
                //pending
            }else if deliverData?.data?.agent_information?.del_service_document_uploaded == 2{
                //approved
                cell.delivery.image = UIImage(named: "grayTick")

            }else if deliverData?.data?.agent_information?.del_service_document_uploaded == 3{
                //reject
                cell.delivery.image = UIImage(named: "cross-1")

            }else if deliverData?.data?.agent_information?.del_service_document_uploaded == 4{
                //edit & approve
                cell.delivery.image = UIImage(named: "accepted_tick")

            }else if deliverData?.data?.agent_information?.del_service_document_uploaded == 4{
                //removed
                cell.delivery.image = UIImage(named: "cross-1")

            }
            cell.editAmount.addTarget(self, action: #selector(editAmountClicked), for: .touchUpInside)
            cell.infoClicked.addTarget(self, action: #selector(infoClicked), for: .touchUpInside)
            
            
            cell.selectionStyle = .none
              return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TripAchievementViewCell",for: indexPath) as! TripAchievementViewCell
      
            
            cell.excellentService.text = deliverData?.data?.agent_information?.trips_achievements?[0].trip_text
            cell.excellentImg.sd_setImage(with: URL(string: deliverData?.data?.agent_information?.trips_achievements?[0].trip_icon ?? ""), placeholderImage: UIImage(named: "flag_placeholder.png"))
            cell.excellentCount.text = "\(deliverData?.data?.agent_information?.trips_achievements?[0].trip_count ?? 0)"
            
            cell.attitudeName.text = deliverData?.data?.agent_information?.trips_achievements?[1].trip_text
            cell.attitudeImg.sd_setImage(with: URL(string : deliverData?.data?.agent_information?.trips_achievements?[1].trip_icon ?? ""), placeholderImage: UIImage(named: "flag_placeholder.png"))
            cell.attitudeCount.text = "\(deliverData?.data?.agent_information?.trips_achievements?[1].trip_count ?? 0)"
//
            cell.aboveLbl.text = deliverData?.data?.agent_information?.trips_achievements?[3].trip_text
            cell.aboveImg.sd_setImage(with: URL(string: deliverData?.data?.agent_information?.trips_achievements?[3].trip_icon ?? ""), placeholderImage: UIImage(named: "flag_placeholder.png"))
            cell.aboveCount.text = "\(deliverData?.data?.agent_information?.trips_achievements?[3].trip_count ?? 0)"
//
            cell.helpful.text = deliverData?.data?.agent_information?.trips_achievements?[2].trip_text
            cell.helpfulImg.sd_setImage(with: URL(string: deliverData?.data?.agent_information?.trips_achievements?[2].trip_icon ?? ""), placeholderImage: UIImage(named: "flag_placeholder.png"))
            cell.helpfulCount.text = "\(deliverData?.data?.agent_information?.trips_achievements?[2].trip_count ?? 0)"

            
            cell.selectionStyle = .none
            
            return cell
        }
  
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          if section == 0{
              return 0
          }
          return 70
      }
      
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return UIView()
        }else{
            let view = DataBankHeader()
            view.productDataBank.setTitle("Current", for: .normal)
             view.purchasedProduct.setTitle("Next", for: .normal)
            view.productDataSale.setTitle("Previous", for: .normal)
         //   view.txtField.placeholder = "Search"
            if selectedVl == 1000{
                view.firstLbl.isHidden = false
                view.secondLbl.isHidden = true
                view.thirdLbl.isHidden = true
                view.productDataBank.backgroundColor = UIColor.white
                view.purchasedProduct.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                view.productDataSale.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                view.productDataBank.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
                view.purchasedProduct.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                view.productDataSale.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                
            }else if selectedVl == 1001{
                
                view.firstLbl.isHidden = true
                view.secondLbl.isHidden = false
                view.thirdLbl.isHidden = true
                view.productDataBank.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                view.purchasedProduct.backgroundColor = UIColor.white
                view.productDataSale.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                view.productDataSale.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                view.purchasedProduct.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
                view.productDataBank.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
            }else{
                view.firstLbl.isHidden = true
                view.secondLbl.isHidden = true
                view.thirdLbl.isHidden = false
                view.productDataBank.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                view.purchasedProduct.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
                view.productDataSale.backgroundColor = UIColor.white
                view.productDataBank.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                view.purchasedProduct.setTitleColor(#colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1), for: .normal)
                view.productDataSale.setTitleColor(#colorLiteral(red: 0.9098039216, green: 0.2941176471, blue: 0.3254901961, alpha: 1), for: .normal)
            }
            view.productDataBank.tag = 1000
            view.purchasedProduct.tag = 1001
            view.productDataSale.tag = 1002
            view.productDataBank.addTarget(self, action: #selector(segmentClicked(_:)), for: .touchUpInside)
             view.purchasedProduct.addTarget(self, action: #selector(segmentClicked(_:)), for: .touchUpInside)
                 view.productDataSale.addTarget(self, action: #selector(segmentClicked(_:)), for: .touchUpInside)
            //view.txtField.addTarget(self, action: #selector(ProductDataBankController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            //view.txtField.text = textSTR
//            view.productDataBank.addTarget(self, action: #selector(productDataBank), for: .touchUpInside)
//            view.purchasedProduct.addTarget(self, action: #selector(purchasedProductClicked), for: .touchUpInside)
//            view.productDataSale.addTarget(self, action: #selector(productDataSale), for: .touchUpInside)
         //   view.barcode.addTarget(self, action: #selector(barcodeClicked), for: .touchUpInside)
          //  view.txtField.addTarget(self, action: #selector(ApplyCommissionViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            
           // view.filter.addTarget(self, action: #selector(filterClicked), for: .touchUpInside)//
            
            return view
        }
        
    }
}

extension AgentDeliveryViewController : UITableViewDelegate {
 
    
}


