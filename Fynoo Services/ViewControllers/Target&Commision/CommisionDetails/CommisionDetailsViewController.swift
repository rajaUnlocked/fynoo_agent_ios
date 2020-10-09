//
//  CommisionDetailsViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 09/10/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import AVKit
class CommisionDetailsViewController: UIViewController {
     var commisionmodel = TargetModel()
    var commisiondetail:CommisionDetail?
    @IBOutlet weak var headervw: NavigationView!
    @IBOutlet weak var tabvw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headervw.viewControl = self
        headervw.titleHeader.text = "Commission"
        
        registernibs()
        commisiondetail_api()
    }
  func commisiondetail_api()
  {
    ModalClass.startLoading(self.view)
    commisionmodel.serviceid = "4"
    commisionmodel.commisiondetails { (success, response) in
        ModalClass.stopLoading()
        if success
        {
            self.commisiondetail = response
            self.tabvw.delegate = self
            self.tabvw.dataSource = self
            self.tabvw.reloadData()
        }
    }
    }
   func  registernibs()
   {
   tabvw.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
     tabvw.register(UINib(nibName: "CommisionTopTableViewCell", bundle: nil), forCellReuseIdentifier: "CommisionTopTableViewCell")
    
    }
    
}
extension CommisionDetailsViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1
                  {
                      if self.commisiondetail?.data?.media_type ?? 0 == 2
                      {
                          if let url = URL(string: self.commisiondetail?.data?.video_file ?? ""){
                              
                             let player = AVPlayer(url: url)
                             let avController = AVPlayerViewController()
                             avController.player = player
                             // your desired frame
                              let cell = tabvw.cellForRow(at: IndexPath(row: 1, section: 0)) as! VideoTableViewCell
                             avController.view.frame = cell.vw.frame
                             cell.vw.addSubview(avController.view)
                             self.addChild(avController)
                             player.play()
                              
                          }
                      }
                      else
                      {
                          if let url = URL(string: self.commisiondetail?.data?.video_url ?? "") {
                              UIApplication.shared.open(url)
                          }
                      }
                  }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
            let cell = tabvw.dequeueReusableCell(withIdentifier: "CommisionTopTableViewCell", for: indexPath) as! CommisionTopTableViewCell
            cell.detaillbl.text = self.commisiondetail?.data?.service_desc ?? ""
            cell.servicename.text = self.commisiondetail?.data?.service_name ?? ""
            cell.percentagelbl.text = "\(self.commisiondetail?.data?.from_com_range ?? 0) - \(self.commisiondetail?.data?.to_com_range ?? 0) %"
            cell.serviceicon.sd_setImage(with: URL(string: self.commisiondetail?.data?.service_icon ?? ""), placeholderImage: UIImage(named: "delivery_newIcon"))
            return cell
        }
        else
        {
            let cell = tabvw.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
              return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return UITableView.automaticDimension
        }
        else
        {
            return 200
        }
    }
    
}
