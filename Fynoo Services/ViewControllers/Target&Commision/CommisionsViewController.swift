//
//  CommisionsViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 08/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit
class CommisionsViewController: UIViewController {
var targetmodel = TargetModel()
    var commisionlist:CommisionList?
    @IBOutlet weak var tabvw: UITableView!
    @IBOutlet weak var headervw: NavigationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headervw.viewControl = self
        headervw.titleHeader.text = "Commission".localized
        tabvw.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tabvw.delegate = self
        tabvw.dataSource = self
        registernibs()
    }
    override func viewWillAppear(_ animated: Bool) {
        ModalClass.startLoading(self.view)
        targetmodel.commisionlist { (suceess, response) in
            ModalClass.stopLoading()
            if suceess
            {
               self.commisionlist = response
                self.tabvw.reloadData()
            }
           
        }
    }
 func registernibs()
 {
 tabvw.register(UINib(nibName: "TargetprogressTableViewCell", bundle: nil), forCellReuseIdentifier: "TargetprogressTableViewCell")
    tabvw.register(UINib(nibName: "DescriptionTableViewCells", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCells")
    tabvw.register(UINib(nibName: "ServiceListTableViewCell", bundle: nil), forCellReuseIdentifier: "ServiceListTableViewCell")
    
    }
}
extension CommisionsViewController:UITableViewDataSource,UITableViewDelegate
{
    @objc func clickVideoClicked(_ sender:UIButton)
    {
        if self.commisionlist?.data?.services?[sender.tag].media_type ?? 0 == 0
                       {
            if let url = URL(string:  self.commisionlist?.data?.services?[sender.tag].video_file ?? ""){
                               
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player

        present(vc, animated: true) {
            vc.player?.play()
        }
                        }
        }
        else{
            if let url = URL(string: self.commisionlist?.data?.services?[sender.tag].video_url ?? "") {
                UIApplication.shared.open(url)
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.commisionlist?.data?.services?.count ?? 0) + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
            let cell = tabvw.dequeueReusableCell(withIdentifier: "TargetprogressTableViewCell", for: indexPath) as! TargetprogressTableViewCell
            cell.progressvw.isHidden = true
            cell.countlbl.isHidden = true
            cell.targetimg.image = UIImage(named: "commision")
            return cell
        }
        else if indexPath.row == 1{
            let cell = tabvw.dequeueReusableCell(withIdentifier: "DescriptionTableViewCells", for: indexPath) as! DescriptionTableViewCells
            cell.toplbl.text = "Commission".localized
            cell.topdescripConst.constant = -8
            cell.descriplbl.text = self.commisionlist?.data?.top_content ?? ""
            return cell
        }
        else if indexPath.row == (self.commisionlist?.data?.services?.count ?? 0) + 2{
                   let cell = tabvw.dequeueReusableCell(withIdentifier: "DescriptionTableViewCells", for: indexPath) as! DescriptionTableViewCells
            cell.toplbl.text = "\("Note".localized):"
               cell.topdescripConst.constant = 0
             cell.descriplbl.text = self.commisionlist?.data?.bottom_content ?? ""
                   return cell
               }
        else{
            let cell = tabvw.dequeueReusableCell(withIdentifier: "ServiceListTableViewCell", for: indexPath) as! ServiceListTableViewCell
            cell.servicename.text = self.commisionlist?.data?.services?[indexPath.row - 2].service_name ?? ""
             cell.servicedescrip.text = self.commisionlist?.data?.services?[indexPath.row - 2].service_description ?? ""
               cell.descriprange.text = "\(self.commisionlist?.data?.services?[indexPath.row - 2].service_range ?? "") \(self.commisionlist?.data?.services?[indexPath.row - 2].currency_type ?? "")"
            cell.serviceimg.sd_setImage(with: URL(string: self.commisionlist?.data?.services?[indexPath.row - 2].service_icon ?? ""), placeholderImage: UIImage(named: "placeholder"))
            cell.clickvideo.tag = indexPath.row - 2
            cell.clickvideo.addTarget(self, action: #selector(clickVideoClicked(_:)), for: .touchUpInside)
                             return cell
        }
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 2 && indexPath.row < (self.commisionlist?.data?.services?.count ?? 0) + 2
        {
        let vc = CommisionDetailsViewController(nibName: "CommisionDetailsViewController", bundle: nil)
            vc.media_type = self.commisionlist?.data?.services?[indexPath.row - 2].media_type ?? 0
              vc.videofile = self.commisionlist?.data?.services?[indexPath.row - 2].video_file ?? ""
              vc.video_url = self.commisionlist?.data?.services?[indexPath.row - 2].video_url ?? ""
             vc.service_desc = self.commisionlist?.data?.services?[indexPath.row - 2].service_description ?? ""
              vc.service_name = self.commisionlist?.data?.services?[indexPath.row - 2].service_name ?? ""
             vc.range = "\(self.commisionlist?.data?.services?[indexPath.row - 2].service_range ?? "") \(self.commisionlist?.data?.services?[indexPath.row - 2].currency_type ?? "")"
              vc.service_icon = self.commisionlist?.data?.services?[indexPath.row - 2].service_icon ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
            {
                return 40
        }
        if indexPath.row == 1 || indexPath.row == 8
                   {
                    return UITableView.automaticDimension
               }
        if indexPath.row == (self.commisionlist?.data?.services?.count ?? 0) + 2
        {
            return UITableView.automaticDimension
        }
          return 70
    }
}
