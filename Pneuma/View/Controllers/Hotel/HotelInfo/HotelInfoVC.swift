//
//  HotelInfoVC.swift
//  Pneuma
//
//  Created by iTechnolabs on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import MapKit

class HotelInfoVC: UIViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var navigation: CustomNavigationView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var roomDetailTableview: UITableView!
    @IBOutlet weak var roomTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var heightConstraintOfInfoCollection: NSLayoutConstraint!
    
    //MARK:- VARIABLES
    let cellIdentifier = "HotelInfoCollectionCell"
    var viewModel = HotelInfoVM()
    let tableCellIdentifier = "RoomDetailTableCell"
    var hotelData : HotelSearchData?

    var arrRoomDetail = [Room]()
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

//        arrRoomDetail.append(RoomDetail(roomName: "King Heritage", roomBedType: "Single Room", roomAmenties: ["Swimmimg Pool", "Playing Area"], roomPrice: "455.0", payCurrency: "USD"))
//        arrRoomDetail.append(RoomDetail(roomName: "King Heritage", roomBedType: "Sweet Room", roomAmenties: ["Swimmimg Pool", "Playing Area", "Club House"], roomPrice: "1000.0", payCurrency: "USD"))

        self.setupCollectionView()
        self.registerNibForTableview()
        self.setData()
        self.setMap()
        if let arrRooms = hotelData?.rooms {
            self.arrRoomDetail = arrRooms
            self.roomDetailTableview.reloadData()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.customizeUI()
    }
    
    override func viewDidLayoutSubviews() {
//        roomTableViewHeight.constant = roomDetailTableview.contentSize.height
        self.roomTableViewHeight.constant = 68.5 * CGFloat(arrRoomDetail.count)
        let height = infoCollectionView.collectionViewLayout.collectionViewContentSize.height
        heightConstraintOfInfoCollection.constant = height
        self.view.layoutIfNeeded()
    }
    
    // MARK: - IBACTIONS
    @IBAction func hotelImageButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.loadViewPhotosVC()
        if let images = hotelData?.hotelImages {
            vc.arrHotelImages = images
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showOnMapButtonAction(_ sender: UIButton) {
        guard let latitude = Double(hotelData?.latitude ?? "0.0") else { return }
        guard let longitude = Double(hotelData?.longitude ?? "0.0") else { return }
        //let location = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
        let vc = UIStoryboard.loadMapVC()
        vc.hotelData = hotelData
        vc.lat = latitude
        vc.long = longitude
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setData() {
        navigation.title = hotelData?.hotelName
        self.viewModel.collectionDataSource.listArray2 = hotelData?.amenities ?? [String]()
        hotelImageView.kf.setImage(with: URL(string: hotelData?.hotelImages?[0]))
        self.infoCollectionView.reloadData()
    }

    private func setMap() {
        //1
        self.mapView.isUserInteractionEnabled = false
        guard let latitude = Double(hotelData?.latitude ?? "0.0") else { return }
        guard let longitude = Double(hotelData?.longitude ?? "0.0") else { return }
        let location = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)

        // 2
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)

        //3
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = hotelData?.hotelName
        annotation.subtitle = hotelData?.hotelAddress
        mapView.addAnnotation(annotation)
    }
    
    private func customizeUI() {
        self.containerView.addShadowWithRoundCorner(radius: 6, color: .paleGreyFour, opacity: 1, offSet: .zero, shadowRadius: 10)
        self.hotelImageView.roundCorners([.topLeft, .topRight], radius: 6)
    }
    
    private func setupCollectionView() {
        self.registerNib()
        self.infoCollectionView.dataSource = self.viewModel.collectionDataSource
    }
    
    private func registerNib() {
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        self.infoCollectionView.register(nib, forCellWithReuseIdentifier: self.cellIdentifier)
    }
    
    private func registerNibForTableview() {
        let nib = UINib(nibName: self.tableCellIdentifier, bundle: nil)
        self.roomDetailTableview.register(nib, forCellReuseIdentifier: self.tableCellIdentifier)
    }

}


