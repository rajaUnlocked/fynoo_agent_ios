//
//  popupViewController.swift
//  Fynoo Business
//
//  Created by Sendan IT on 15/07/19.
//  Copyright © 2019 Sendan. All rights reserved.
//

import UIKit
protocol cancelDelegate {
    func cancelClick()
    func company_Signupbtn()
    func personal_SignUpbtn()
    
   
    
}
class popupViewController: UIViewController {
    
    @IBOutlet weak var companyBtnOutlet: UIButton!
    var delegate:cancelDelegate?
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var personalBtnOutlet: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateImagesOnLanguage()
        self.companyBtnOutlet.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 110)
        self.personalBtnOutlet.setAllSideShadowForFields(shadowShowSize: 2.0, sizeFloat: UIScreen.main.bounds.size.width - 110)
        // Do any additional setup after loading the view.
    }
    
    func rotateImagesOnLanguage(){
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"
            {
                let img1 = UIImage(named: "backgroundImage")
                let image1 = UIImage(cgImage: (img1?.cgImage)!, scale: (img1?.scale)!, orientation: UIImage.Orientation.upMirrored)
                bgImage.image = image1
                let img2 = UIImage(named: "back_new")
                               let image2 = UIImage(cgImage: (img2?.cgImage)!, scale: (img2?.scale)!, orientation: UIImage.Orientation.upMirrored)
                               backBtn.setImage(image2, for: .normal)
            }
            else if value[0]=="en"
            {
                let image1 = UIImage(named: "backgroundImage")
                bgImage.image = image1
                let image12 = UIImage(named: "back_new")
                backBtn.setImage(image12, for: .normal)
            }
        }
    }
   
    @IBAction func cancelbtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
            self.delegate?.cancelClick()
        
    }
    @IBAction func company_Signup(_ sender: Any) {
//       self.navigationController?.popViewController(animated: true)
  //           self.delegate?.company_Signupbtn()
        let vc = CompanyRegViewController(nibName: "CompanyRegViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func personal_SignUp(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//             self.delegate?.personal_SignUpbtn()
        let vc = PersonalRegViewController(nibName: "PersonalRegViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: false)
       
    }
}
