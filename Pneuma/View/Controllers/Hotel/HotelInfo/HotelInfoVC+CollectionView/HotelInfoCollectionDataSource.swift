//
//  HotelInfoCollectionDataSource.swift
//  Pneuma
//
//  Created by Jatin on 15/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation

class HotelInfoCollectionDataSource: HotelInfoCollectionDataSourceModel, UICollectionViewDataSource {
    
    // MARK: - VARIABLES
    private let cellIdentifier = "HotelInfoCollectionCell"
    
    // MARK: - COLLECTION DATA SOURCE
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listArray2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! HotelInfoCollectionCell
        cell.setupCell(title: self.listArray2[indexPath.item])
        return cell
    }
}
