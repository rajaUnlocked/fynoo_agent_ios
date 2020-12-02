//
//  UploadimgTableViewCell.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 26/04/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
protocol UploadimgTableViewCellDelegate: class{
    func imageSwiped(index: Int)
    func imageBeforeSwipe(index: Int)
}

class UploadimgTableViewCell: UITableViewCell,UIScrollViewDelegate {
    
     var scrollView = UIScrollView(frame: CGRect(x:10, y:0, width:UIScreen.main.bounds.width - 20,height: (UIScreen.main.bounds.height/2) - 40))
    weak var delegate: UploadimgTableViewCellDelegate?
    @IBOutlet weak var pageCntrl: UIPageControl!
    var scrolledIndexOld = 0
    
    var imgs = [UIImage]()
    
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setImagesOnScroll(offset:CGFloat) {
        
        configurePageControl()
        self.scrollView.contentOffset.x = offset

        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(scrollView)
        for index in 0..<imgs.count {
            
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            let setView = Bundle.main.loadNibNamed("UploadTopView", owner: nil, options: nil)?[0] as? UploadTopView
            setView?.frame = frame
            
            setView?.galleryImg.image = imgs[index]
            
            if let setView = setView {
                scrollView.addSubview(setView)
            }
        }
        let arrCount = imgs.count
        let wid = self.scrollView.frame.size.width
        let totalWidth = wid * CGFloat(arrCount)
        self.scrollView.contentSize = CGSize(width: totalWidth ,height: self.scrollView.frame.size.height)
        pageCntrl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
    }
    
      func configurePageControl() {
             // The total number of pages that are available is based on how many available colors we have.
             self.pageCntrl.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        self.pageCntrl.numberOfPages = imgs.count
             self.pageCntrl.currentPage = 0
         }
         
         // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
         @objc func changePage(sender: AnyObject) -> () {
             let x = CGFloat(pageCntrl.currentPage) * scrollView.frame.size.width
             scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
            pageCntrl.currentPage = Int(x)
         }
         
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        if scrolledIndexOld == Int(pageNumber) {
            scrolledIndexOld = Int(pageNumber)
            self.delegate?.imageBeforeSwipe(index: Int(pageNumber))
        }
    }
    
         func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
             let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
             pageCntrl.currentPage = Int(pageNumber)
            self.delegate?.imageSwiped(index: pageCntrl.currentPage)
            scrolledIndexOld = Int(pageNumber)
         }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
         pageCntrl.currentPage = Int(pageNumber)
        self.delegate?.imageSwiped(index: pageCntrl.currentPage)
        scrolledIndexOld = Int(pageNumber)
    }
}
