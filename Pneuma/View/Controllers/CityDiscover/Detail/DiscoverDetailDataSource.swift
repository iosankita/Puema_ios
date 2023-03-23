//
//  DiscoverDetailDataSource.swift
//  Pneuma
//
//  Created by Chitra on 12/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import Foundation
import UIKit

//MARK:- TABLE VIEW DATASOUCRE
class DiscoverDetailDataSource: DiscoverDetailDataSourceModel, UITableViewDataSource {
    
    let tableCell = "ReviewCell"
    let imageCell = "ImageSliderCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailModel.rating.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! ReviewCell
        cell.setupContent(self.detailModel.rating.reviews[indexPath.row])
        return cell
    }
}

//MARK:- TABLEVIEW DELEGATE
extension DiscoverOptionDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK:- COLLECTION VIEW DATASOUCRE
extension DiscoverDetailDataSource: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.detailModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCell, for: indexPath) as! ImageSliderCell
        cell.setupContent(image: self.detailModel.images[indexPath.item])
        return cell
    }
}

//MARK:- COLLECTION VIEW  DELEGATE
extension DiscoverOptionDetailVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.imageCollectionView.bounds.width, height: self.imageCollectionView.bounds.height)
        return size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
