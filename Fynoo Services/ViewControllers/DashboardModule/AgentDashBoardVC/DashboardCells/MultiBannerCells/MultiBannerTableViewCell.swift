//
//  MultiBannerTableViewCell.swift
//  Fynoo
//
//  Created by Aishwarya on 16/04/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class MultiBannerTableViewCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var pageCntrl: UIPageControl!
    var scrollView = UIScrollView()
    var timer = Timer()
    var isproduct = false
    var multiBannerArray = NSArray()

    override func awakeFromNib() {
        super.awakeFromNib()
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
        let width = UIScreen.main.bounds.size.width - 20
        let widthEsti = 835 / width
        let height = 500 / widthEsti
        
         scrollView = UIScrollView(frame: CGRect(x:10, y:25, width:UIScreen.main.bounds.width-20,height: height))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setBanner() {
                    configurePageControl()
                    
                    scrollView.delegate = self
                    scrollView.isPagingEnabled = true
                    scrollView.showsHorizontalScrollIndicator = false
                    self.contentView.addSubview(scrollView)
        for index in 0..<multiBannerArray.count {
                        
                        frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
                        frame.size = self.scrollView.frame.size
                            let setView = Bundle.main.loadNibNamed("MultiBannerVw", owner: nil, options: nil)?[0] as? MultiBannerVw
            let width = UIScreen.main.bounds.size.width - 20
            let widthEsti = 835 / width
            let height = 500 / widthEsti
            setView?.frame = CGRect(x:frame.origin.x, y:0, width:UIScreen.main.bounds.width-20,height: height)
            
               setView?.multiBannerImage.sd_setImage(with: URL(string: "\((multiBannerArray.object(at: index) as! NSDictionary).object(forKey: "banner_pics") as! String)"), placeholderImage: UIImage(named: "banner_placeholder"))
            
                            if let setView = setView {
                            scrollView.addSubview(setView)
                            }
                    }
        let arrCount = multiBannerArray.count
        let wid = self.scrollView.frame.size.width
        let totalWidth = wid * CGFloat(arrCount)
        self.scrollView.contentSize = CGSize(width: totalWidth ,height: self.scrollView.frame.size.height)
                    pageCntrl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
    }
    
    @objc func timerAction() {
           
           var pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        if self.multiBannerArray.count > 0 {
            if Int(pageNumber) == self.multiBannerArray.count - 1 {
               pageNumber = -1
           }
        }
           pageNumber =  pageNumber + 1
        pageCntrl.currentPage = Int(pageNumber)
           let x = CGFloat(pageNumber) * scrollView.frame.size.width
           scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        
       }
       
      func configurePageControl() {
             // The total number of pages that are available is based on how many available colors we have.
             self.pageCntrl.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.pageCntrl.numberOfPages = multiBannerArray.count
             self.pageCntrl.currentPage = 0
     //        self.pageCntrl.tintColor = UIColor.red
     //        self.pageCntrl.pageIndicatorTintColor = UIColor.lightGray
     //        self.pageCntrl.currentPageIndicatorTintColor = UIColor.darkGray
    //         self.view.addSubview(pageCntrl)
         }
         
         // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
         @objc func changePage(sender: AnyObject) -> () {
             let x = CGFloat(pageCntrl.currentPage) * scrollView.frame.size.width
             scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
            pageCntrl.currentPage = Int(x)
         }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
             let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
             pageCntrl.currentPage = Int(pageNumber)
         }
}
