//
//  AddPaymentMethod+CollectionDataSource.swift
//  Pneuma
//
//  Created by Jatin on 09/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class AddPaymentMethodCollectionDataSource: AddPaymentMethodCollectionDataSourceModel, UICollectionViewDataSource {
    
    // MARK: - VARIABLES
    private let cellIdentifier = "AddPaymentMethodCollectionCell"
    
    // MARK: - COLLECTION DATA SOURCE
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! AddPaymentMethodCollectionCell
        cell.setupCell(model: self.listArray[indexPath.item])
        return cell
    }
}
