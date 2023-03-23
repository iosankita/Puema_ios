//
//  DiscoverRouteVC.swift
//  Pneuma
//
//  Created by Chitra on 15/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class DiscoverRouteVC: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var routeView: UIView!
    @IBOutlet weak var routeTableView: UITableView!
    @IBOutlet weak var routeTableHeight: NSLayoutConstraint!
    @IBOutlet weak var placesTableView: UITableView!
    @IBOutlet weak var placesTableHeight: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var pathHeight: NSLayoutConstraint!
    @IBOutlet var dottedLabel: UILabel!
    
    //MARK:- VARIABLES
    var optionsViewModel = CityDiscoverVM()
    var routeVM = DiscoverRouteVM()
    let discoverCellId = "CustomListCell"
    let placeCellId = "DiscoverRoutePlaceCell"
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customiseUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        routeTableHeight.constant = routeTableView.contentSize.height
        placesTableHeight.constant = placesTableView.contentSize.height
    }
    
    //MARK:- PRIVATE FUNCTIONS
    private func customiseUI() {
        shadowView.addShadow(ofColor: .lightGray, radius: 10.0, offset: .zero, opacity: 0.5)
        let minY = sourceLabel.frame.midY
        let maxY = destinationLabel.frame.midY
//        pathHeight.constant = maxY-minY
    }
    
    private func registerCell() {
        self.placesTableView.register(UINib(nibName: discoverCellId, bundle: nil), forCellReuseIdentifier: discoverCellId)
        self.placesTableView.dataSource = self.optionsViewModel.tableDataSource
        self.placesTableView.delegate = self
        self.optionsViewModel.selectionCallback = { (type) in
            self.handleSelection(with: type)
        }
        self.routeTableView.register(UINib(nibName: placeCellId, bundle: nil), forCellReuseIdentifier: placeCellId)
        self.routeTableView.dataSource = self.routeVM.tableDataSource
        self.routeTableView.delegate = self
    }
    
    private func handleSelection(with type: CityDiscoverType) {
        switch type {
        case .restaurants:
            print(type.rawValue)
        case .cinemaTheater:
            print(type.rawValue)
        case .museums:
            print(type.rawValue)
        case .shoppingCenters:
            print(type.rawValue)
        case .sights:
            print(type.rawValue)
        case .funPlace:
            print(type.rawValue)
        }
        
        let vc = UIStoryboard.laodDiscoverListVC()
        vc.listType = type
        self.navigationController?.pushViewController(vc)
    }
    
}
