//
//  SelectImageTypePopupViewController.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-048 on 26/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class SelectImageTypePopupViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    @IBOutlet weak var typeLbl: UILabel!
    
     @IBOutlet weak var cardVieww: UIView!
    @IBOutlet weak var tabView: UITableView!
    
    var textArray = ["Profile".localized,"Branch".localized,"Product".localized]
    var choosenOption : ((String) -> Void)?
    var img : [UIImage] = [#imageLiteral(resourceName: "agent_indivdual"),#imageLiteral(resourceName: "businessOwner"),#imageLiteral(resourceName: "producticonpopup")]
    override func viewDidLoad() {
        super.viewDidLoad()
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        typeLbl.font =  UIFont(name: "\(fontNameLight)", size: 12)
        
        tabView.delegate = self
        tabView.dataSource = self
        view.isOpaque = false
                          view.backgroundColor = .clear
                    tabView.tableFooterView = UIView()
                    contentSizeInPopup = CGSize(width: UIScreen.main.bounds.width, height:250)
        tabView.separatorStyle = .none
        tabView.register(UINib(nibName: "PopUpViewCell", bundle: nil), forCellReuseIdentifier: "PopUpViewCell")
        // Do any additional setup after loading the view.
    }


    @IBAction func cross(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 3
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: "PopUpViewCell", for: indexPath) as! PopUpViewCell
        cell.lbl.text = textArray[indexPath.row]
         cell.img.image = img[indexPath.row]
        return cell
      }
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return 40
         }
         
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {               choosenOption!(textArray[indexPath.row])
             self.dismiss(animated: true)
           
         }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
