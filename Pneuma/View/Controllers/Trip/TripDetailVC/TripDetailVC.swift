//
//  TripDetailVC.swift
//  Pneuma
//
//  Created by Jatin on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import MapKit


enum ResultState {
    case NONE
    case YES
    case NO
    
}

class TripDetailVC: UIViewController {
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
    @IBOutlet weak var roomImagesTableView: UITableView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var roomImagesTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    @IBAction func resultAction(_ sender: Any) {
        
    }
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func noAction(_ sender: Any) {
        if (resultState == .NO) {
            resultState = .NONE
            self.resultLabel.text = ""
            self.resultButton.isHidden = true
            self.noButton.setImage(UIImage.init(named: "ic-chechbox-empty"), for: .normal)
            return
        }
        resultState = .NO
        self.resultLabel.text = "Aww, sorry about that. What would you like to change?"
        self.resultButton.setTitle("EDIT", for: .normal)
        self.noButton.setImage(UIImage.init(named: "ic-checkbox-fill"), for: .normal)
        self.yesButton.setImage(UIImage.init(named: "ic-chechbox-empty"), for: .normal)
        self.resultButton.isHidden = false
    }
    @IBAction func yesAction(_ sender: Any) {
        if (resultState == .YES) {
            resultState = .NONE
            self.resultLabel.text = ""
            self.resultButton.isHidden = true
            self.yesButton.setImage(UIImage.init(named: "ic-chechbox-empty"), for: .normal)
            return
        }
        resultState = .YES
        self.resultLabel.text = "Awesome, let's go on to book then."
        self.resultButton.setTitle("BOOK", for: .normal)
        self.yesButton.setImage(UIImage.init(named: "ic-checkbox-fill"), for: .normal)
        self.noButton.setImage(UIImage.init(named: "ic-chechbox-empty"), for: .normal)
        self.resultButton.isHidden = false
    }
    
    // MARK: - VARIABLES
    private var resultState = ResultState.NONE
    private let flightTableCellIdentifier = "OutboundDetailTableCell"
    private let hotelAmenitiesCollectionCellIdentifier = "HotelInfoCollectionCell"
    private let roomImagesCellIdentifier = "ViewPhotosTableCell"
    let viewModel = TripDetailVM()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupHotelAmenitiesCollectionView()
        self.setupHotelBenifitsCollectionView()
        self.resultState = .NONE
        self.resultButton.isHidden = true
        self.resultLabel.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.drawDottedLine()
    }
    
    // MARK: - IBACTIONS
    @IBAction func seeHotelOnMapButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func payButtonAction(_ sender: UIButton) {
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func drawDottedLine() {
        let x = self.flightWayDottedLine.center.x
        self.flightWayDottedLine.drawDottedLine(start: CGPoint(x: x, y: 0), end: CGPoint(x: x, y: self.flightWayDottedLine.frame.maxY), color: .lightBlueGrey40Opacity)
        
        let rideLineX = self.rideWayDottedLineView.center.x
        self.rideWayDottedLineView.drawDottedLine(start: CGPoint(x: rideLineX, y: 0), end: CGPoint(x: rideLineX, y: self.rideWayDottedLineView.frame.maxY), color: .lightBlueGrey40Opacity)
    }
    
    private func setupTableView() {
        self.setupFlightDetailTableView()
        self.setupRoomImagesTableView()
    }
    
    private func setupFlightDetailTableView() {
        ///Setup flight detail table view
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
    
    private func setupRoomImagesTableView() {
        ///Setup room images table view
        let imagesCelNib = UINib(nibName: self.roomImagesCellIdentifier, bundle: nil)
        self.roomImagesTableView.register(imagesCelNib, forCellReuseIdentifier: self.roomImagesCellIdentifier)
        self.roomImagesTableView.dataSource = self.viewModel.roomImagesTableDataSource
        self.roomImagesTableView.reloadData { [weak self] in
            guard let `self` = self else {
                return
            }
            self.roomImagesTableViewHeightConstraint.constant = self.roomImagesTableView.contentSize.height
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
