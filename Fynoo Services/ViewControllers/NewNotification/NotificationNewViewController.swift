//
//  NotificationNewViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-039 on 02/05/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class NotificationNewViewController: UIViewController ,UIScrollViewDelegate{
    @IBOutlet weak var bgimg: UIImageView!
    var notificationlist:NofifyModel?
    var month =  [Notif_lists]()
    var new =  [Notif_lists]()
    var week =  [Notif_lists]()
    var year =  [Notif_lists]()
    var earlier =  [Notif_lists]()
        @IBOutlet weak var headerVw: NavigationView!
@IBOutlet weak var tabvw: UITableView!
    @IBOutlet weak var heighConst: NSLayoutConstraint!
    var notifylist = NotificationApiModel()
    var finalProductArr = NSMutableArray()
    var isShown = false
    @IBOutlet weak var noDataImg: UIImageView!
    @IBOutlet weak var noDataFound: UILabel!
    var isDataLoading:Bool=false
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        
        notify_Api()
        self.tabvw.delegate = self
        self.tabvw.dataSource = self
        self.heighConst.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        self.headerVw.titleHeader.text = "Notification".localized
        self.headerVw.menuBtn.isHidden = false
        self.headerVw.viewControl = self
        self.tabvw.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
//        bgimg.image = ModalController.rotateImagesOnLanguageMethod(img: UIImage(named:"backgroundImage")!)
    
        self.tabvw.register(UINib(nibName: "NotificationNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationNewsTableViewCell")
        self.tabvw.register(UINib(nibName: "NotificationHeadernewTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationHeadernewTableViewCell")
        
        
    }
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//
//           isDataLoading = false
//       }
//
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        
        if ((tabvw.contentOffset.y + tabvw.frame.size.height) >= tabvw.contentSize.height)
        {
            if !isDataLoading{
                  isDataLoading = true
                notifylist.pageNo=notifylist.pageNo + 1
                //self.limit=self.limit+10
                // self.offset = self.limit * self.pageno
                notify_Api()
                // loadCallLogData(offset: self.offset, limit: self.limit)
                
            }
        }
        
        
        
    }
    func getFulldata(str : [Notif_lists]?,index:Int){
        // self.isDataLoading = true
        for i in 0..<str!.count{
            
            if index == 0{
                //  self.isDataLoading = false
                new.append(str![i])
            }
            
            if index == 1{
                //   self.isDataLoading = false
                week.append(str![i])
            }
            if index == 2{
                //  self.isDataLoading = false
                month.append(str![i])
            }
            if index == 3{
                //  self.isDataLoading = false
                year.append(str![i])
            }
            if index == 4{
                // self.isDataLoading = false
                earlier.append(str![i])
            }
        }
        
        
        if new.count == 0 && week.count == 0 && month.count == 0 && year.count == 0 && earlier.count == 0{
            self.noDataImg.isHidden = false
            self.noDataFound.isHidden = false
        }else{
            self.noDataImg.isHidden = true
            self.noDataFound.isHidden = true
        }
                
    }
    func notify_Api() {
        ModalClass.startLoading(view)
        notifylist.notifylist { (success, response) in
            ModalClass.stopLoading()
            self.notificationlist = response
            let allNo = self.notificationlist?.data?.all_notif_list?.count
            self.isDataLoading = true
            //  print(self.notificationlist?.data?.all_notif_list?.count)
            self.isDataLoading = true
            
            if self.notificationlist?.data?.all_notif_list?[0].notif_list!.count == 0 && self.notificationlist?.data?.all_notif_list?[1].notif_list!.count == 0 && self.notificationlist?.data?.all_notif_list?[2].notif_list!.count == 0 && self.notificationlist?.data?.all_notif_list?[3].notif_list!.count == 0 && self.notificationlist?.data?.all_notif_list?[4].notif_list!.count == 0{
                if self.isShown{
                    self.noDataImg.isHidden = true
                    self.noDataFound.isHidden = true
                }else{
                    self.noDataImg.isHidden = false
                    self.noDataFound.isHidden = false
                }
                self.isDataLoading = true
                
                
                return
            }else{
                self.isShown = true
                self.noDataImg.isHidden = true
                self.noDataFound.isHidden = true
                self.isDataLoading = false
            }
            for i in 0..<allNo!{
                if (self.notificationlist?.data?.all_notif_list?[i].notif_list!.count)!>0{
                    self.getFulldata(str:self.notificationlist?.data?.all_notif_list?[i].notif_list , index: i)
                }
            }
            self.tabvw.reloadData()
        }
        
        
    }
    
}
extension NotificationNewViewController:UITableViewDelegate,UITableViewDataSource,DeleteBranchPopupViewControllerDelegate
{
    func reloadPage() {
        notify_Api()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.notificationlist?.data?.all_notif_list?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return (new.count) == 0 ? 0 :
                new.count + 1
        }
        else  if section == 1
        {
            return (week.count) == 0 ? 0 :
            week.count + 1
        }
        else  if section == 2
        {
            return (month.count ) == 0 ? 0 :
            month.count + 1
            
        }
        else  if section == 3
        {
            return (year.count) == 0 ? 0 :
            year.count + 1
        }else{
            return (earlier.count) == 0 ? 0 :
                earlier.count + 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
             let cell = tabvw.dequeueReusableCell(withIdentifier: "NotificationHeadernewTableViewCell", for: indexPath) as! NotificationHeadernewTableViewCell
             cell.lbl.text = self.notificationlist?.data?.all_notif_list?[indexPath.section].notif_category ?? ""
            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
            cell.lbl.font = UIFont(name:"\(fontNameBold)",size:10)
            return cell
        }
        else{
            let cell = tabvw.dequeueReusableCell(withIdentifier: "NotificationNewsTableViewCell", for: indexPath) as! NotificationNewsTableViewCell
            cell.msg.textAlignment = .left
            if HeaderHeightSingleton.shared.LanguageSelected == "AR"
            {
                cell.msg.textAlignment = .right
            }
            // let not = self.notificationlist?.data?.all_notif_list?[indexPath.section]
            if indexPath.section == 0{
                cell.msg.text =  new[indexPath.row - 1].notification ?? ""
                cell.days.text = new[indexPath.row - 1].time ?? ""
            }
            if indexPath.section == 1{
                cell.msg.text =  week[indexPath.row - 1].notification ?? ""
                cell.days.text = week[indexPath.row - 1].time ?? ""
            }
            
            if indexPath.section == 2{
                cell.msg.text =  month[indexPath.row - 1].notification ?? ""
                cell.days.text = month[indexPath.row - 1].time ?? ""
            }
            if indexPath.section == 3{
                cell.msg.text =  year[indexPath.row - 1].notification ?? ""
                cell.days.text = year[indexPath.row - 1].time ?? ""
            }
            if indexPath.section == 4{
                cell.msg.text =  earlier[indexPath.row - 1].notification ?? ""
                cell.days.text = earlier[indexPath.row - 1].time ?? ""
            }
            let fontNameLight = NSLocalizedString("LightFontName", comment: "")
            cell.msg.font = UIFont(name:"\(fontNameLight)",size:10)
            cell.days.font = UIFont(name:"\(fontNameLight)",size:10)
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 30
        }
        return UITableView.automaticDimension
    }
  
     func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         
         if indexPath.row > 0 {
             let action =  UIContextualAction(style: .normal, title: "", handler: { (action,view,completionHandler ) in
                 //do stuff
                 let vc = DeleteBranchPopupViewController(nibName: "DeleteBranchPopupViewController", bundle: nil)
                 vc.isType = "Notification"
                vc.proId = "\(self.notificationlist?.data?.all_notif_list?[indexPath.section].notif_list?[indexPath.row - 1].id ?? 0)"
                 vc.delegate = self
                 vc.modalPresentationStyle = .overFullScreen
                 vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                 self.present(vc, animated: true, completion: nil)
                 completionHandler(true)
             })
        
             action.image = UIImage(named: "deletenew")
             action.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
             let configuration = UISwipeActionsConfiguration(actions: [action])
             return configuration
         }
         else {
             
             let swipeAction = UISwipeActionsConfiguration(actions: [])
             swipeAction.performsFirstActionWithFullSwipe = false // This is the line which disables full swipe
             return swipeAction
             
         }
     }
   
}
