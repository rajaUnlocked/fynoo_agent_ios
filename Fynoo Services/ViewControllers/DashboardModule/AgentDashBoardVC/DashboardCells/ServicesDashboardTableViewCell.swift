//
//  ServicesDashboardTableViewCell.swift
//  Fynoo Services
//
//  Created by Aishwarya on 16/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit

class ServicesDashboardTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionVw: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCollectionVw() {
        collectionVw.register(UINib(nibName: "ServiceSingleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceSingleCollectionViewCell")
        self.collectionVw.delegate = self
        self.collectionVw.dataSource = self
    }
    
    // MARK: - UICollectionViewMethods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1    //return number of sections in collection view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return categoryCell(index: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
            let size = CGSize(width: (screenWidth / 2) - 30 , height: 150 )
            if let layout = self.collectionVw.collectionViewLayout as? UICollectionViewFlowLayout{
                let width = UIScreen.main.bounds.width
                layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 0
            }
            return size
    }

    func categoryCell(index : IndexPath) -> UICollectionViewCell {
    let cell = collectionVw.dequeueReusableCell(withReuseIdentifier: "ServiceSingleCollectionViewCell", for: index) as! ServiceSingleCollectionViewCell
        return cell
    }
}
