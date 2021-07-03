//
//  DataBankHeader.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-046 on 24/03/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit


protocol DataBankHeaderDelegate: class {
    
    func selecteIndex(_ sender: Any, selectedIndexID:String)
   
}
class DataBankHeader: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var view: UIView!
    var viewControl = UIViewController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: DataEntryListHeaderViewDelegate?
    
    
     var headerTextArray = ["Current".localized,"Next".localized,"Previous".localized,"Cancelled".localized]
      var selectedIndex:Int = 0
    
    
    override init(frame: CGRect)
    {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
        sideMenuCode()
    }
    
    @IBAction func backButton(_ sender: Any) {
        viewControl.navigationController?.popViewController(animated: true)
    }
    required init?(coder aDecoder: NSCoder)
    {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    func xibSetup(){
        
        view = loadViewFromNib()
       
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
    }
    
    func loadViewFromNib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "DataBankHeader", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
         self.setupCollectionVw()
        return view
        
        // Assumes UIView is top level and only object in CustomView.xib file
        //   let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    func setupCollectionVw() {

          self.collectionView.register(UINib(nibName: "DeliveryDashboardHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DeliveryDashboardHeaderCollectionViewCell")
             self.collectionView.delegate = self
             self.collectionView.dataSource = self
        }
    
    // MARK: - UICollectionViewMethods
        func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
            return 1    //return number of sections in collection view
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return headerTextArray.count

        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                return categoryCell(index: indexPath)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selectIndex:-", indexPath.row)
        self.selectedIndex = indexPath.item
        let selectedTab = self.selectedIndex + 1
        self.delegate?.selecteIndex(self, selectedIndexID: ModalController.toString(selectedTab as Any))
        self.collectionView.reloadData()

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let size = CGSize(width: (screenWidth / 4) , height: 35 )
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            let width = UIScreen.main.bounds.width
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
        return size
    }

    func categoryCell(index : IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeliveryDashboardHeaderCollectionViewCell", for: index) as! DeliveryDashboardHeaderCollectionViewCell
        
        cell.textLbl.text = headerTextArray[index.row]
        
        cell.upperLbl.isHidden = true
        cell.mainView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
         cell.textLbl.textColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
        cell.mainView.borders(for: [.left, .bottom, .right], width: 0.2, color:  #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1))
        
        if index.item == selectedIndex {
            
            cell.textLbl.textColor = #colorLiteral(red: 0.9254901961, green: 0.2901960784, blue: 0.3254901961, alpha: 1)
            cell.upperLbl.isHidden = false
            cell.mainView.backgroundColor = .white
            cell.mainView.borders(for: [.left, .bottom, .right], width: 0.2, color:  .clear)
            
        }else{
            
        }
      
        cell.tag = index.item
        return cell
    }
}
   
extension UIView {
    
    func borders(for edges:[UIRectEdge], width:CGFloat = 1, color: UIColor = .black) {
        
        if edges.contains(.all) {
            layer.borderWidth = width
            layer.borderColor = color.cgColor
            
        } else {
            
            let allSpecificBorders:[UIRectEdge] = [.top, .bottom, .left, .right]
            
            for edge in allSpecificBorders {
                
                if let v = viewWithTag(Int(edge.rawValue)) {
                    
                    v.removeFromSuperview()
                    
                }
                
                if edges.contains(edge) {
                    
                    let v = UIView()
                    
                    v.tag = Int(edge.rawValue)
                    
                    v.backgroundColor = color
                    
                    v.translatesAutoresizingMaskIntoConstraints = false
                    
                    addSubview(v)
                    
                    var horizontalVisualFormat = "H:"
                    
                    var verticalVisualFormat = "V:"
                    
                    switch edge {
                        
                    case UIRectEdge.bottom:
                        
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        
                        verticalVisualFormat += "[v(\(width))]-(0)-|"
                        
                    case UIRectEdge.top:
                        
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        
                        verticalVisualFormat += "|-(0)-[v(\(width))]"
                        
                    case UIRectEdge.left:
                        
                        horizontalVisualFormat += "|-(0)-[v(\(width))]"
                        
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                        
                    case UIRectEdge.right:
                        
                        horizontalVisualFormat += "[v(\(width))]-(0)-|"
                        
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                        
                    default:
                        
                        break
                        
                    }
                    
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                    
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                }
            }
        }
    }
}
