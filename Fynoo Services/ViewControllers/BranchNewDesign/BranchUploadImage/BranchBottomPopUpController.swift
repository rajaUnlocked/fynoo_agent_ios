//
//  BranchBottomPopUpController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 31/03/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class BranchBottomPopUpController: UIViewController {
  @IBOutlet weak var cardVieww: UIView!
    
    var textArray = ["Take Photo".localized,"Device Gallery".localized,"Fynoo Gallery".localized]
    var isType = ""
    var choosenOption : ((String) -> Void)?
    var img : [UIImage] = [#imageLiteral(resourceName: "camera_icon"),#imageLiteral(resourceName: "pro_img_outline"),#imageLiteral(resourceName: "fynooGallery")]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        view.isOpaque = false
        view.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PopUpViewCell", bundle: nil), forCellReuseIdentifier: "PopUpViewCell")
        
        contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:280)
        if isType == "Gallery"
              {
                   contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:180)
              }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
   
}


extension BranchBottomPopUpController : UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dismiss(animated: true)
        choosenOption!(textArray[indexPath.row])
    }
    
}

extension BranchBottomPopUpController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isType == "Gallery"
        {
            return textArray.count - 1
        }
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopUpViewCell", for: indexPath) as! PopUpViewCell
        cell.lbl.text = textArray[indexPath.row]
        cell.img.image = img[indexPath.row]
        return cell
    }
    
    
    
    
    
}
