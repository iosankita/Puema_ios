//
//  PayVC.swift
//  Pneuma
//
//  Created by Jatin on 15/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import MapKit

class PayVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var flightView: UIView!
    @IBOutlet weak var flightOriginAddressLabel: UILabel!
    @IBOutlet weak var flightDestinationAddressLabel: UILabel!
    @IBOutlet weak var flightTimeLabel: UILabel!
    @IBOutlet weak var flightDayLabel: UILabel!
    @IBOutlet weak var flightTableView: UITableView!
    @IBOutlet weak var flightTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var flightWayDottedLine: UIView!
    
    @IBOutlet weak var rideView: UIView!
    @IBOutlet weak var rideDateTimeLabel: UILabel!
    @IBOutlet weak var rideStatusLabel: UILabel!
    @IBOutlet weak var rideOriginLabel: UILabel!
    @IBOutlet weak var rideDestinationLabel: UILabel!
    @IBOutlet weak var ridePriceLabel: UILabel!
    @IBOutlet weak var rideCurrencyLabel: UILabel!
    @IBOutlet weak var ridePaymentInfoLabel: UILabel!
    @IBOutlet weak var rideWayDottedLineView: UIView!
    
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelRatingView: HCSStarRatingView!
    @IBOutlet weak var hotelDateTimeLabel: UILabel!
    @IBOutlet weak var hotelBookingDaysLabel: UILabel!
    @IBOutlet weak var hotelAmenitiesCollectionView: UICollectionView!
    @IBOutlet weak var hotelMapView: MKMapView!
    @IBOutlet weak var hotelLocationLabel: UILabel!
    @IBOutlet weak var hotelRoomTypeLabel: UILabel!
    @IBOutlet weak var hotelRoomAmountLabel: UILabel!
    @IBOutlet weak var hotelRoomCurrencyLabel: UILabel!
    @IBOutlet weak var hotelRoomDescriptionLabel: UILabel!
    @IBOutlet weak var hotelBenifitsCollectionView: UICollectionView!
    @IBOutlet weak var hotelAmenitiesHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var hotelBenifitHeightConstraint: NSLayoutConstraint!
    
    // MARK: - VARIABLES
    private let flightTableCellIdentifier = "OutboundDetailTableCell"
    private let hotelAmenitiesCollectionCellIdentifier = "HotelInfoCollectionCell"
    let viewModel = PayVM()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupHotelAmenitiesCollectionView()
        self.setupHotelBenifitsCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.drawDottedLine()
    }
    
    // MARK: - IBACTIONS
    @IBAction func seeHotelOnMapButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func payButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.loadPaymentMethodVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        // link to share
        let shareLink = NSURL(string:"https://dummylink.toshare")
        let shareAll = [shareLink]
        
        // set up activity view controller
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToWhatsApp, UIActivity.ActivityType.postToLinkedIn, UIActivity.ActivityType.mail, UIActivity.ActivityType.message, UIActivity.ActivityType.copyToPasteboard ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func drawDottedLine() {
        let x = self.flightWayDottedLine.center.x
        self.flightWayDottedLine.drawDottedLine(start: CGPoint(x: x, y: 0), end: CGPoint(x: x, y: self.flightWayDottedLine.frame.maxY), color: .lightBlueGrey40Opacity)
        
        let rideLineX = self.rideWayDottedLineView.center.x
        self.rideWayDottedLineView.drawDottedLine(start: CGPoint(x: rideLineX, y: 0), end: CGPoint(x: rideLineX, y: self.rideWayDottedLineView.frame.maxY), color: .lightBlueGrey40Opacity)
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: self.flightTableCellIdentifier, bundle: nil)
        self.flightTableView.register(nib, forCellReuseIdentifier: self.flightTableCellIdentifier)
        self.flightTableView.dataSource = self.viewModel.flightTableDataSource
        self.flightTableView.reloadData { [weak self] in
            guard let `self` = self else {
                return
            }
            self.flightTableViewHeightConstraint.constant = self.flightTableView.contentSize.height
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupHotelAmenitiesCollectionView() {
        let nib = UINib(nibName: self.hotelAmenitiesCollectionCellIdentifier, bundle: nil)
        self.hotelAmenitiesCollectionView.register(nib, forCellWithReuseIdentifier: self.hotelAmenitiesCollectionCellIdentifier)
        
        self.hotelAmenitiesCollectionView.dataSource = self.viewModel.hotelAmenitiesCollectionDataSource
        self.hotelAmenitiesCollectionView.reloadData { [weak self] in
            guard let `self` = self else {
                return
            }
            self.hotelAmenitiesHeightConstraint.constant = self.hotelAmenitiesCollectionView.contentSize.height
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupHotelBenifitsCollectionView() {
        let nib = UINib(nibName: self.hotelAmenitiesCollectionCellIdentifier, bundle: nil)
        self.hotelBenifitsCollectionView.register(nib, forCellWithReuseIdentifier: self.hotelAmenitiesCollectionCellIdentifier)
        
        self.hotelBenifitsCollectionView.dataSource = self.viewModel.hotelBenifitsCollectionDataSource
        self.hotelBenifitsCollectionView.reloadData { [weak self] in
            guard let `self` = self else {
                return
            }
            self.hotelBenifitHeightConstraint.constant = self.hotelBenifitsCollectionView.contentSize.height
            self.view.layoutIfNeeded()
        }
    }
}
