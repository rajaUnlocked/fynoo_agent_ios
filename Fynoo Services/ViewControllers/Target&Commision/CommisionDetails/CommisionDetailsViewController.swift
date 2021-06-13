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
    //var commisionmodel = TargetModel()
    //var commisiondetail:CommisionDetail?
    var media_type = 0
    var videofile = ""
    var video_url = ""
    var service_desc = ""
    var service_name = ""
    var range = ""
    var service_icon = ""
    @IBOutlet weak var headervw: NavigationView!
    @IBOutlet weak var tabvw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headervw.viewControl = self
        headervw.titleHeader.text = "Commission".localized
        tabvw.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        registernibs()
        //commisiondetail_api()
    }
    //func commisiondetail_api()
    //  {
    //    ModalClass.startLoading(self.view)
    //    commisionmodel.serviceid = "4"
    //    commisionmodel.commisiondetails { (success, response) in
    //        ModalClass.stopLoading()
    //        if success
    //        {
    //            self.commisiondetail = response
    //            self.tabvw.delegate = self
    //            self.tabvw.dataSource = self
    //            self.tabvw.reloadData()
    //        }
    //    }
    //    }
    func  registernibs()
    {
        tabvw.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        tabvw.register(UINib(nibName: "CommisionTopTableViewCell", bundle: nil), forCellReuseIdentifier: "CommisionTopTableViewCell")
                 self.tabvw.delegate = self
                    self.tabvw.dataSource = self
                    self.tabvw.reloadData()
        
    }
    
}
extension CommisionDetailsViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1
        {
            if media_type == 1
            {
                if let url = URL(string: video_url) {
                    UIApplication.shared.open(url)
                }
                
            }
            else
            {
                if let url = URL(string: videofile){
                    
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
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
            let cell = tabvw.dequeueReusableCell(withIdentifier: "CommisionTopTableViewCell", for: indexPath) as! CommisionTopTableViewCell
            cell.commisionlbl.text = "Commission".localized
            cell.commisionrangelbl.text = "Commission Range".localized
            cell.detaillbl.text = service_desc
            cell.servicename.text = service_name
            cell.percentagelbl.text = range
            cell.serviceicon.sd_setImage(with: URL(string: service_icon), placeholderImage: UIImage(named: "delivery_newIcon"))
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
