//
//  TripDetailVC+CollectionDelegate.swift
//  Pneuma
//
//  Created by Jatin on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension TripDetailVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.hotelAmenitiesCollectionView {
           let width: CGFloat = collectionView.frame.size.width / 2.0
           return CGSize(width: width, height: 40)
        }else {
            let width: CGFloat = collectionView.frame.size.width
            return CGSize(width: width, height: 40)
        }
    }
    
    
}

