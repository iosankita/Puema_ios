//
//  AddPaymentMethod+CollectionDelegate.swift
//  Pneuma
//
//  Created by Jatin on 09/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

// MARK: - COLLECTION VIEW DELEGATE FLOW LAYOUT
extension AddPaymentMethodVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 25
        let width = (collectionView.frame.width - spacing) / 2
        let height = width / 2.5
        return CGSize(width: width, height: height)
    }
}
