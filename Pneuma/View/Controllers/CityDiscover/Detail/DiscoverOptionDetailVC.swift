//
//  DiscoverOptionDetailVC.swift
//  Pneuma
//
//  Created by Chitra on 12/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import MapKit

class DiscoverOptionDetailVC: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var avgRatingView: HCSStarRatingView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var openingTimeView: UIStackView!
    @IBOutlet weak var openingTimeLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var seeOnMapButton: UIButton!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    //MARK:- VARIABLES
    var tableCell = "ReviewCell"
    var collectionCell = "ImageSliderCell"
    var viewModel = DiscoverDetailVM()
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        setupData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableHeight.constant = reviewsTableView.contentSize.height
    }
    
    //MARK:- IBACTIONS
    @IBAction func seeOnMapAction(_ sender: Any) {
        
    }
    
    //MARK:- PRIVATE FUNCIONS
    private func registerNibs() {
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self.viewModel.dataSource
        self.imageCollectionView.register(UINib(nibName: collectionCell, bundle: nil), forCellWithReuseIdentifier: collectionCell)
        
        self.reviewsTableView.delegate = self
        self.reviewsTableView.dataSource = self.viewModel.dataSource
        self.reviewsTableView.register(UINib(nibName: tableCell, bundle: nil), forCellReuseIdentifier: tableCell)
    }
    
    private func setupData() {
        let model = viewModel.dataSource.detailModel
        customNav.title = "City Center" //model?.title ?? "Detail"
        pageControl.numberOfPages = model?.images.count ?? 0
        openingTimeLabel.text = model?.timings ?? ""
        websiteLabel.text = model?.website ?? ""
        setupMapView()
        addressLabel.text = model?.location.address
        avgRatingView.value = CGFloat(model?.rating.avgRating ?? 0.0)
        averageRatingLabel.text = "\(model?.rating.avgRating ?? 0.0)(\(model?.rating.numberOfReviews ?? 0) reviews)"
    }
    
    private func setupMapView() {
        
    }
}
