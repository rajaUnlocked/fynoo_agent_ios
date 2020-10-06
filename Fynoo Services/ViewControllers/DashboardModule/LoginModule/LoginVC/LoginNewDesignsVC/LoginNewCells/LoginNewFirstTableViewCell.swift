//
//  LoginNewFirstTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-049 on 02/01/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit

class LoginNewFirstTableViewCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var pageCntrl: UIPageControl!
       let scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width,height: (UIScreen.main.bounds.height/2) - 40))
   //    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var timer = Timer()
    var isKeyboardOpen = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        configurePageControl()
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(scrollView)
        
        let fontNameBold = NSLocalizedString("BoldFontName", comment: "")
        let fontNameLight = NSLocalizedString("LightFontName", comment: "")
      
        for index in 0..<5 {
            
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            if index == 0 {
                let setView = Bundle.main.loadNibNamed("LoginIntroFirst", owner: nil, options: nil)?[0] as? LoginIntroFirst
                setView?.frame = frame
                
                if let setView = setView {
                                        
                    setView.imagineLbl.font = UIFont(name:"\(fontNameBold)",size:20)
                    setView.allProductsLbl.font = UIFont(name:"\(fontNameLight)",size:17)
                    setView.forBusinessLbl.font = UIFont(name:"\(fontNameLight)",size:16)
                    setView.manageLbl.font = UIFont(name:"\(fontNameLight)",size:9)
             
                    scrollView.addSubview(setView)
                }
            }
            else if index == 1 {
                let setView = Bundle.main.loadNibNamed("LoginIntroSecond", owner: nil, options: nil)?[0] as? LoginIntroSecond
                setView?.frame = frame
                
                setView?.allProductsLbl.font = UIFont(name:"\(fontNameLight)",size:17)
                setView?.forBusinessLbl.font = UIFont(name:"\(fontNameLight)",size:16)
                setView?.manageLbl.font = UIFont(name:"\(fontNameLight)",size:9)
                
                if let setView = setView {
                    scrollView.addSubview(setView)
                }
            }
            else if index == 2 {
                let setView = Bundle.main.loadNibNamed("LoginIntroThird", owner: nil, options: nil)?[0] as? LoginIntroThird
                setView?.frame = frame
                
                setView?.allProductsLbl.font = UIFont(name:"\(fontNameLight)",size:17)
                setView?.forBusinessLbl.font = UIFont(name:"\(fontNameLight)",size:16)
                setView?.manageLbl.font = UIFont(name:"\(fontNameLight)",size:9)
                
                if let setView = setView {
                    scrollView.addSubview(setView)
                }
            }
            else if index == 3 {
                let setView = Bundle.main.loadNibNamed("LoginIntroFourth", owner: nil, options: nil)?[0] as? LoginIntroFourth
                setView?.frame = frame
                
                setView?.allProductsLbl.font = UIFont(name:"\(fontNameLight)",size:17)
                setView?.forBusinessLbl.font = UIFont(name:"\(fontNameLight)",size:16)
                setView?.manageLbl.font = UIFont(name:"\(fontNameLight)",size:9)
                
                if let setView = setView {
                    scrollView.addSubview(setView)
                }
            }
            else{
                let setView = Bundle.main.loadNibNamed("LoginIntroFifth", owner: nil, options: nil)?[0] as? LoginIntroFifth
                setView?.frame = frame
                
                setView?.allProductsLbl.font = UIFont(name:"\(fontNameLight)",size:17)
                setView?.forBusinessLbl.font = UIFont(name:"\(fontNameLight)",size:16)
                setView?.manageLbl.font = UIFont(name:"\(fontNameLight)",size:9)
                
                if let setView = setView {
                    scrollView.addSubview(setView)
                }
            }
        }
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 5,height: self.scrollView.frame.size.height)
        pageCntrl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func timerAction() {
        if isKeyboardOpen {
            return
        }
        var pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        if pageNumber == 4 {
            pageNumber = -1
        }
        pageNumber =  pageNumber + 1
        let x = CGFloat(pageNumber) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        
        switch pageNumber {
        case 0:
            pageImage.image = UIImage(named: "dot1")
            case 1:
            pageImage.image = UIImage(named: "dot2")
            case 2:
            pageImage.image = UIImage(named: "dot3")
            case 3:
            pageImage.image = UIImage(named: "dot4")
        default:
            pageImage.image = UIImage(named: "dot5")
        }
    }
    
    
   func configurePageControl() {
          // The total number of pages that are available is based on how many available colors we have.
          self.pageCntrl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
          self.pageCntrl.numberOfPages = 5
          self.pageCntrl.currentPage = 0
          self.pageCntrl.tintColor = UIColor.red
          self.pageCntrl.pageIndicatorTintColor = UIColor.lightGray
          self.pageCntrl.currentPageIndicatorTintColor = UIColor.darkGray
 //         self.view.addSubview(pageCntrl)
      }
      
      // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
      @objc func changePage(sender: AnyObject) -> () {
          let x = CGFloat(pageCntrl.currentPage) * scrollView.frame.size.width
          scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
      }
      
      func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
          let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
          pageCntrl.currentPage = Int(pageNumber)
        switch pageCntrl.currentPage {
        case 0:
            pageImage.image = UIImage(named: "dot1")
            case 1:
            pageImage.image = UIImage(named: "dot2")
            case 2:
            pageImage.image = UIImage(named: "dot3")
            case 3:
            pageImage.image = UIImage(named: "dot4")
        default:
            pageImage.image = UIImage(named: "dot5")
        }
      }
    
    @objc func keyboardWillAppear() {
           //Do something here
           isKeyboardOpen = true
       }

       @objc func keyboardWillDisappear() {
           //Do something here
           isKeyboardOpen = false
       }
}
