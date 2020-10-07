//
//  DiscountTypePopUpViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 26/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol DiscountTypePopUpViewControllerDelegate {
    func selectedDiscountOption(str:String)
}

class DiscountTypePopUpViewController: UIViewController {
     var delegate : DiscountTypePopUpViewControllerDelegate?
    @IBOutlet weak var cardVieww: UIView!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var discountHeaderLbl: UILabel!
    
    var Arr = ["Take Photo".localized,"Device Gallery".localized]
    var images : [UIImage] = [#imageLiteral(resourceName: "camera_picture"),#imageLiteral(resourceName: "galery_Picture")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetFont()
        tableView.separatorStyle = .none
        view.isOpaque = false
        view.backgroundColor = .clear
        
        tableView.tableFooterView = UIView()
        contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:150)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PopUpViewCell", bundle: nil), forCellReuseIdentifier: "PopUpViewCell")
        crossButton.addTarget(self, action: #selector(closePopUp(_:)), for: .touchUpInside)
        
    }
    
    func SetFont(){
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.discountHeaderLbl.font = UIFont(name:"\(fontNameLight)",size:12)
        
    }

    @objc func closePopUp(_ sender : UIButton){
           dismiss(animated: true, completion: nil)
       }

}
extension DiscountTypePopUpViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension DiscountTypePopUpViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = Arr[indexPath.row]
        dismiss(animated: true, completion: nil)
         delegate?.selectedDiscountOption(str:str)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopUpViewCell", for: indexPath) as! PopUpViewCell
       
        cell.lbl.text  = Arr[indexPath.row]
        cell.img.image = images[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
