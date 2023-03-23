//
//  HotelInfoVC+CollectionviewFlowLayout.swift
//  Pneuma
//
//  Created by iTechnolabs on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension HotelInfoVC : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
           let size:CGFloat = (infoCollectionView.frame.size.width - space) / 2.0
           return CGSize(width: size, height: 50)
    }
    
    
}
