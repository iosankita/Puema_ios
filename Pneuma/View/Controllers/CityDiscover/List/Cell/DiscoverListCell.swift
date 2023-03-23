//
//  DiscoverListCell.swift
//  Pneuma
//
//  Created by Chitra on 11/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

protocol AddToRouteDelegate: class {
    func didAddToRoute(_ sender: DiscoverListCell, index: Int)
}

class DiscoverListCell: UITableViewCell {

    //MARK:- IBOUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingView: HCSStarRatingView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addToRouteButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var openingHours: UILabel!
    
    //MARK:- VARIABLES
    weak var delegate: AddToRouteDelegate?
    var imagesArray = [String]()
    let cellId = "ImageSliderCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupContent(model: CityDiscoverListModel) {
        self.titleLabel.text = model.name
        self.ratingView.value = CGFloat(model.rating)
        self.addressLabel.text = model.address
        self.imagesArray = model.images
        if let hours = model.openingHours {
            self.openingHours.isHidden = false
            self.openingHours.text = "Opening Hours: \(hours)"
        } else {
            self.openingHours.isHidden = true
        }
        
        self.pageControl.numberOfPages = model.images.count
        self.collectionView.reloadData()
    }
    
    private func setupUI() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        //setup pageControl
//        let emptyImage = UIImage(named: "pageDotEmpty") ?? UIImage()
//        let filledImage = UIImage(named: "pageDotFilled") ?? UIImage()
//        self.pageControl.pageIndicatorTintColor = UIColor.init(patternImage: emptyImage)
//        self.pageControl.currentPageIndicatorTintColor = UIColor.init(patternImage: filledImage)
//        self.pageControl.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
    }
 
    
    @IBAction func addToRouteAction(_ sender: UIButton) {
        self.delegate?.didAddToRoute(self, index: sender.tag)
    }
    
    private func setPageControlUI() {
//        if #available(iOS 14.0, *) {
//            let emptyImage = UIImage(named: "pageDotEmpty") ?? UIImage()
//            let filledImage = UIImage(named: "pageDotFilled") ?? UIImage()
//            self.pageControl.preferredIndicatorImage = emptyImage
//            for i in 0..<pageControl.subviews.count {
//                if i == pageControl.currentPage {
//                    self.pageControl.setIndicatorImage(filledImage, forPage: i)
//                } else {
//                    self.pageControl.setIndicatorImage(emptyImage, forPage: i)
//                }
//            }
//        }
    }
}

//MARK:- COLLECTION VIEW DELEGATE/DATASOURCE
extension DiscoverListCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageSliderCell
        cell.setupContent(image: self.imagesArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}
