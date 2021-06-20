//
//  DataEntryListHeaderView.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-040 on 01/12/20.
//  Copyright © 2020 Sendan. All rights reserved.
//

import UIKit
import Cosmos

protocol DataEntryListHeaderViewDelegate: class {
    
    func selecteIndex(_ sender: Any, selectedIndexID:String)
   
}

class DataEntryListHeaderView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
 weak var delegate: DataEntryListHeaderViewDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTxtFld: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    
    @IBAction func searchBtnClicked(_ sender: Any) {
        
    }
    @IBAction func filterBtnClicked(_ sender: Any) {
        
    }
    
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var avergeRatingLbl: UILabel!
    @IBOutlet weak var ratingValueView: CosmosView!
    
    @IBOutlet weak var totalRatingLbl: UILabel!
    
    
    
     var headerTextArray = ["Waiting List".localized,"Inprocess".localized,"Completed".localized,"Rejected".localized]
      
       var headerImageArray = ["waitingDataEntry_selected","inprogress_dataEntry","complete_dataEntry","cancel_DataEntry"]
    
    var selectedIndex:Int = 0
    var avgRating:String = ""
    
    var view: UIView!
      
      override init(frame: CGRect)
      {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
       
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
          let nib = UINib(nibName: "DataEntryListHeaderView", bundle: bundle)
          let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
      
           self.setupCollectionVw()
          return view
          
          // Assumes UIView is top level and only object in CustomView.xib file
          //   let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
      }
      
    func setupCollectionVw() {

        self.collectionView.register(UINib(nibName: "DataEntryHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DataEntryHeaderCollectionViewCell")
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
        self.selectedIndex = indexPath.row
        let selectedTab = self.selectedIndex + 1
        self.delegate?.selecteIndex(self, selectedIndexID: ModalController.toString(selectedTab as Any))
        self.collectionView.reloadData()

    }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
                let size = CGSize(width: (screenWidth / 3) + 20  , height: 40 )
                if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
                    let width = UIScreen.main.bounds.width
                    layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                    layout.minimumInteritemSpacing = 0
                    layout.minimumLineSpacing = 0
                }
                return size
        }

    func categoryCell(index : IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataEntryHeaderCollectionViewCell", for: index) as! DataEntryHeaderCollectionViewCell
        
        cell.nameLbl.text = headerTextArray[index.row]
        
        
        if index.row == 0 {
            cell.leftImgView.image = UIImage(named: "waitingDataEntry_unselected")
            cell.bottomLbl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.nameLbl.textColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
            
        }
        else if index.row == 1 {
            cell.leftImgView.image = UIImage(named: "inprogress_dataEntry")
            cell.bottomLbl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.nameLbl.textColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
            
        }else if index.row == 2 {
            cell.leftImgView.image = UIImage(named: "complete_dataEntry")
            cell.bottomLbl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.nameLbl.textColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
            
        }else if index.row == 3 {
            cell.leftImgView.image = UIImage(named: "cancelled_DataEntry-unselected")
            cell.bottomLbl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.nameLbl.textColor = #colorLiteral(red: 0.1098039216, green: 0.6156862745, blue: 0.8352941176, alpha: 1)
            
        }
        
        if index.row == selectedIndex {
            
            if selectedIndex == 0 {
                cell.leftImgView.image = UIImage(named: "waitingDataEntry_selected")
            }else if selectedIndex == 1 {
                cell.leftImgView.image = UIImage(named: "inprogress_dataEntry-selected")
            }else if selectedIndex == 2 {
                cell.leftImgView.image = UIImage(named: "complete_dataEntry-selected")
            }else if selectedIndex == 3 {
                cell.leftImgView.image = UIImage(named: "cancelled_DataEntry")
            }
            
            
            cell.bottomLbl.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
            cell.nameLbl.textColor = #colorLiteral(red: 0.3803921569, green: 0.7529411765, blue: 0.5333333333, alpha: 1)
            
        }
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                cell.nameLbl.textAlignment = .right
            }else if value[0]=="en"{
                cell.nameLbl.textAlignment = .left
            }
        }
        
        
        cell.tag = index.row
        return cell
    }
   
}
