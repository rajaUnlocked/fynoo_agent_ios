//
//  TargetViewController.swift
//  Fynoo Services
//
//  Created by IND-SEN-LP-039 on 07/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class TargetViewController: UIViewController {
    @IBOutlet weak var headervw: NavigationView!
    
    @IBOutlet weak var tabvw: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        headervw.viewControl = self
        headervw.titleHeader.text = "Target"
        tabvw.delegate = self
        tabvw.dataSource = self
        registernibs()
    }
func registernibs()
{
    tabvw.register(UINib(nibName: "TargetprogressTableViewCell", bundle: nil), forCellReuseIdentifier: "TargetprogressTableViewCell")
     tabvw.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
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
       
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            if indexPath.row == 0
                   {
                       let cell = tabvw.dequeueReusableCell(withIdentifier: "TargetprogressTableViewCell", for: indexPath) as! TargetprogressTableViewCell
                              return cell
                   }
                   else{
                       let cell = tabvw.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
                       cell.descriplbl.text
                           = "hvjewff,b jkvr3kmejfbfhjnfgvhv4m vh23fv4k4kg4  g3gkgk4kg4g4g4gkf4gkfg4g4g4gfggfg4 v4j4jgejgg4g4"
                                        return cell
                   }
        }
            if indexPath.section == 2
                   {
                       if indexPath.row == 0
                              {
                                  let cell = tabvw.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
                                cell.descriplbl.text = "hvjewff,b jkvr3kmejfbfhjnfgvhv4m vh23fv4k4kg4  g3gkgk4kg4g4g4gkf4gkfg4g4g4gfggfg4 v4j4jgejgg4g4"
                                    return cell
                              }
                              else{
                                 let cell = tabvw.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
                                                                        return cell
                              }
                   }
        else{
            let cell = tabvw.dequeueReusableCell(withIdentifier: "AgentListTableViewCell", for: indexPath) as! AgentListTableViewCell
                                         return cell
          
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
                              return 100
                              }
                              return 250
    }
        else{
            if indexPath.row == 0
                   {
                   return 100
                   }
                   return 150
        }
       
    }
    
}
