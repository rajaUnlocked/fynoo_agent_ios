//
//  PopUpBelowViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 27/01/20.
//  Copyright © 2020 Sendan. All right reserved.
//

import UIKit
import MTPopup

protocol PopupSelectedVal {
    func selectedOption(str:String)
}

class PopUpBelowViewController: UIViewController {

    @IBOutlet weak var cardVieww: UIView!
    var delegate : PopupSelectedVal?
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var Arr = ["Business Owner".localized,"Agent Individual".localized,"Agent Company".localized]
    var images : [UIImage] = [#imageLiteral(resourceName: "businessOwner"),#imageLiteral(resourceName: "agent_indivdual"),#imageLiteral(resourceName: "agent_company")]
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        view.isOpaque = false
        view.backgroundColor = .clear
        
        tableView.tableFooterView = UIView()
        contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:230)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PopUpViewCell", bundle: nil), forCellReuseIdentifier: "PopUpViewCell")
        crossButton.addTarget(self, action: #selector(closePopUp(_:)), for: .touchUpInside)
        
    }

    @objc func closePopUp(_ sender : UIButton){
        dismiss(animated: true, completion: nil)
    }
}

extension PopUpBelowViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension PopUpBelowViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = Arr[indexPath.row]
        delegate?.selectedOption(str:str)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopUpViewCell", for: indexPath) as! PopUpViewCell
       
        cell.lbl.text  = Arr[indexPath.row]
        cell.img.image = images[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
