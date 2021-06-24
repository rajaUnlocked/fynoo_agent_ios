//
//  ProductListTableViewCell.swift
//  Fynoo Services
//
//  Created by Apple on 23/05/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit
import Cosmos
protocol  ProductListDelegate {
    
     func deleteClicked(_ sender: Any)
     func reduceQuantityClicked(_ sender: Any)
     func cartClicked(_ sender: Any)
}

class ProductListTableViewCell: UITableViewCell,UITableViewDelegate {
    
    var delegate : ProductListDelegate?
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblPriceAlmost: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnReduceQuantity: UIButton!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var lblLineReduceQty : UILabel!
    @IBOutlet weak var imgCart: UIImageView!

    
   
    

    override func awakeFromNib() {
        super.awakeFromNib()
        SetFont()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func SetFont() {

            let fontNameBold = NSLocalizedString("BoldFontName", comment: "")

            let fontNameLight = NSLocalizedString("LightFontName", comment: "")

       

            self.lblAddress.font = UIFont(name:"\(fontNameLight)",size:12)

            self.lblQty.font = UIFont(name:"\(fontNameLight)",size:12)

        self.lblPriceAlmost.font = UIFont(name:"\(fontNameLight)",size:12)
        self.btnDelete.titleLabel!.font = UIFont(name:"\(fontNameLight)",size:12)
        self.btnReduceQuantity.titleLabel!.font = UIFont(name:"\(fontNameLight)",size:10)
      
        }
    
    func configureWithCell(withDict dict : Dictionary<String,Any> , andIndexPath indexPath : IndexPath)
      {
        print(dict)
       lblQty.text = String.getString(dict["name"])
       lblAddress.text = String.getString(dict["class_name"])
        
      }
    
    
    @IBAction func deleteClicked(_ sender: Any) {
        self.delegate?.deleteClicked(self)
  
    }
    
    @IBAction func reduceQuantityClicked(_ sender: Any) {
        self.delegate?.reduceQuantityClicked(self)
    }
    @IBAction func cartClicked(_ sender: Any) {
        self.delegate?.cartClicked(self)
    }
    
}
