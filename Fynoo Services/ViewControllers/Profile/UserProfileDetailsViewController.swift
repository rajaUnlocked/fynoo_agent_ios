//
//  UserProfileDetailsViewController.swift
//  Fynoo Business
//
//  Created by Aishwarya Gupta on 23/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
class UserProfileDetailsViewController: UIViewController {
    
   // @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var tableVw: UITableView!
    var isEdit = false
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        
        tableVw.register(UINib(nibName: "ProfileNameTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileNameTableViewCell");
        tableVw.register(UINib(nibName: "ProfileDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileDetailTableViewCell");
        tableVw.delegate = self
        tableVw.dataSource = self
        tableVw.reloadData()
    }
    
}

extension UserProfileDetailsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 210
            }else{
                if isEdit{
                    return 46
                }else{
                    return 78
                }
            }
        default:
            return 0
        }
    }
}

extension UserProfileDetailsViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section{
        case 0:
            if indexPath.row == 0{
                let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileNameTableViewCell",for: indexPath) as! ProfileNameTableViewCell
                return cell
                
            }else{
                let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileDetailTableViewCell",for: indexPath) as! ProfileDetailTableViewCell
                cell.delegate = self

                if isEdit{
                    cell.editBtn.isHidden = true
                    cell.editProfileTitle.isHidden = true
                    cell.imageButton.isHidden = true
                }else{
                    cell.editBtn.isHidden = false
                    cell.editProfileTitle.isHidden = false
                    cell.imageButton.isHidden = false
                }
                return cell
                
            }
            
        default:
            let cell = self.tableVw.dequeueReusableCell(withIdentifier: "ProfileDetailTableViewCell",for: indexPath) as! ProfileDetailTableViewCell
            return cell
            
        }
    }
    
    
    
}


extension UserProfileDetailsViewController : ProfileDetailTableViewCellDelegate{
    func edit() {
        isEdit = !isEdit
        tableVw.reloadData()
    }
    
    func followersClicked() {
        
    }
    
    func branchesClicked() {
        
    }
    
    func productsClicked() {
        
    }
    
    func likesClicked() {
        
    }
    
    
    
}
