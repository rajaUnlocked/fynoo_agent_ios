//
//  TargetViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 07/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class TargetViewController: UIViewController {
    var targetmodel = TargetModel()
    @IBOutlet weak var headervw: NavigationView!
    var targetlist:TargetList?
    @IBOutlet weak var tabvw: UITableView!
    var player: AVPlayer!

    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        headervw.viewControl = self
        headervw.titleHeader.text = "Target".localized
        tabvw.delegate = self
        tabvw.dataSource = self
        tabvw.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        registernibs()
    }
    override func viewWillAppear(_ animated: Bool) {
        ModalClass.startLoading(self.view)
        targetmodel.targetlist { (suceess, response) in
            ModalClass.stopLoading()
            if suceess
            {
                self.targetlist = response
                self.tabvw.reloadData()
            }
            
        }
    }
    func registernibs()
    {
        tabvw.register(UINib(nibName: "TargetprogressTableViewCell", bundle: nil), forCellReuseIdentifier: "TargetprogressTableViewCell")
        tabvw.register(UINib(nibName: "DescriptionTableViewCells", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCells")
        tabvw.register(UINib(nibName: "AgentListTableViewCell", bundle: nil), forCellReuseIdentifier: "AgentListTableViewCell")
        tabvw.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        
        
    }
}

extension TargetViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2
        {
            return 2
        }
         
        return ((self.targetlist?.data?.target_end_date ?? "") == "" ? 0:self.targetlist?.data?.top_five_agent?.count ?? 0)
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                let cell = tabvw.dequeueReusableCell(withIdentifier: "TargetprogressTableViewCell", for: indexPath) as! TargetprogressTableViewCell
                let attributedString : NSMutableAttributedString = NSMutableAttributedString(string: "\(self.targetlist?.data?.total_target ?? 0) / \(self.targetlist?.data?.target_to_be_achive ?? 0)")
                attributedString.setColor(color: #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1), forText: " \(self.targetlist?.data?.target_to_be_achive ?? 0)")
                cell.countlbl.attributedText = attributedString
                cell.progressvw.isHidden = false
                cell.targetimg.isHidden = false
                if self.targetlist?.data?.target_end_date ?? "" == ""
                {
                    cell.progressvw.isHidden = true
                    cell.targetimg.isHidden = true
                    cell.countlbl.text = "No Target Activated".localized
                }
               else if self.targetlist?.data?.total_target ?? 0 == self.targetlist?.data?.target_to_be_achive ?? 0
               {
                cell.countlbl.text = "\(self.targetlist?.data?.target_to_be_achive ?? 0) /  \(self.targetlist?.data?.total_target ?? 0)"
                cell.countlbl.textColor = #colorLiteral(red: 0.4423058033, green: 0.7874479294, blue: 0.6033033729, alpha: 1)
                }
                cell.progressvw.progress = Float(self.targetlist?.data?.total_target ?? 0)
                return cell
            }
            else{
                let cell = tabvw.dequeueReusableCell(withIdentifier: "DescriptionTableViewCells", for: indexPath) as! DescriptionTableViewCells
                cell.toplbl.text = "Target".localized
                cell.topconst.constant = 10
                cell.toplbl.isHidden = false
                cell.descriplbl.text = self.targetlist?.data?.top_content ?? ""
                return cell
            }
        }
        if indexPath.section == 2
        {
            if indexPath.row == 0
            {
                let cell = tabvw.dequeueReusableCell(withIdentifier: "DescriptionTableViewCells", for: indexPath) as! DescriptionTableViewCells
                cell.toplbl.isHidden = true
                cell.topconst.constant = -30
                cell.descriplbl.text = self.targetlist?.data?.mid_content ?? ""
                return cell
            }
            else{
                let cell = tabvw.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
                
                
                return cell
            }
        }
        else{
            let cell = tabvw.dequeueReusableCell(withIdentifier: "AgentListTableViewCell", for: indexPath) as! AgentListTableViewCell
            cell.agentname.text = self.targetlist?.data?.top_five_agent?[indexPath.row].username ?? ""
            cell.starlbl.text = "\(indexPath.row + 1)"
            cell.userimg.sd_setImage(with: URL(string: self.targetlist?.data?.top_five_agent?[indexPath.row].user_icon ?? ""), placeholderImage: UIImage(named: "user-logo"))
            cell.currencylbl.text = self.targetlist?.data?.top_five_agent?[indexPath.row].currency ?? ""
            cell.pricelbl.text = "\(self.targetlist?.data?.top_five_agent?[indexPath.row].commision_amount ?? 0)"
            return cell
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2
        {
            if indexPath.row == 1
            {
                if self.targetlist?.data?.media_type ?? 0 == 2
                {
                    if let url = URL(string: "http://techslides.com/demos/sample-videos/small.3gp"){
                        
                        player = AVPlayer(url: url)
                        
                        let playerViewController = AVPlayerViewController()
                        
                        playerViewController.player = player
                        
                        self.present(playerViewController, animated: true)
                            
                            playerViewController.player!.play()
                            
                        
                        
                        
                        //                       let player = AVPlayer(url: url)
                        //                       let avController = AVPlayerViewController()
                        //                       avController.player = player
                        //                       // your desired frame
                        //                        let cell = tabvw.cellForRow(at: IndexPath(row: 1, section: 2)) as! VideoTableViewCell
                        //                       avController.view.frame = cell.vw.frame
                        //                       cell.vw.addSubview(avController.view)
                        //                       self.addChild(avController)
                        //                       player.play()
                        
                    }
                }
                else
                {
                    if let url = URL(string: self.targetlist?.data?.video_url ?? "") {
                        UIApplication.shared.open(url)
                    }
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1
        {
          
            return 70
        }
        else if indexPath.section == 2
        {
            if indexPath.row == 0
            {
                return UITableView.automaticDimension
            }
            return 250
        }
        else{
            if indexPath.row == 0
            {
                
                if targetlist?.data?.target_end_date ?? "" == ""
                          {
                            return 60
                          }
                
                return 80
            }
            return UITableView.automaticDimension
        }
        
    }
    
}
