//
//  OrderSuccessViewC.swift
//  Fynoo Services
//
//  Created by SedanMacBookAir on 16/06/21.
//  Copyright © 2021 Aishwarya. All rights reserved.
//

import UIKit

class OrderSuccessViewC: UIViewController {
   
    @IBOutlet weak var lblMsg: UILabel!
    var confirmDeliveryData : Dictionary<String,Any> = ["":""]
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()

        SetFont()
        
        print(confirmDeliveryData)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let vc = AgentDeliveryViewController()
            vc.orderSuccessData = self.confirmDeliveryData
            vc.isfrom = "100"
            vc.selectedTrip = 3
            Singleton.shared.setDeliveryDashBoardTabID(tabId: 3)
            Singleton.shared.setDelServiceID(delServiceId: "\(self.confirmDeliveryData["del_service_id"] as! Int)")

            vc.isRating = true
            self.navigationController?.pushViewController(vc, animated: true)
            
            var dictPass = [String:Any]()
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: Constant.NF_KEY_FOR_PASS_DATA_TO_DELIVERYDASHBOARD), object: nil, userInfo: dictPass)
            
        }
    }
    
    func SetFont() {
        
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
        
        self.lblMsg.font = UIFont(name:"\(fontNameLight)",size:24)!
        
    }

}
