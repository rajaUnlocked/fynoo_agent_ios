//
//  GalleryPopUpViewController.swift
//  Fynoo
//
//  Created by IND-SEN-LP-046 on 10/05/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//


import UIKit
class GalleryPopUpViewController: UIViewController {

    @IBOutlet weak var cardVieww:UIView!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var Arr = ["Camera".localized,"Device Gallery".localized]
    var img = ["camera_icon","photo-icon"]
    var choosenOption : ((String) -> Void)?
    
    @IBOutlet weak var chooseLbl: UILabel!
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        self.setFontUI()
        tableView.separatorStyle = .none
        view.isOpaque = false
        view.backgroundColor = .clear
        
        tableView.tableFooterView = UIView()
        contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:200)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.register(UINib(nibName: "BottomPopCellsNewTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomPopCellsNewTableViewCell")
        crossButton.addTarget(self, action: #selector(closePopUp(_:)), for: .touchUpInside)
        
    }
    func setFontUI(){
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.chooseLbl.font = UIFont(name:"\(fontNameLight)",size:12)
    }
    @objc func closePopUp(_ sender : UIButton){
        dismiss(animated: true, completion: nil)
    }
}

extension GalleryPopUpViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
}

extension GalleryPopUpViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        let str = Arr[indexPath.row]
        choosenOption!(str)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomPopCellsNewTableViewCell", for: indexPath) as! BottomPopCellsNewTableViewCell
        cell.img.image = UIImage(named:img[indexPath.row])
        cell.lbl.text  = Arr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
