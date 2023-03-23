//
//  RideInfoVC.swift
//  Pneuma
//
//  Created by Jatin on 16/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import MapKit

class RideInfoVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var navigation: CustomNavigationView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var rideInfoContainerView: UIView!
    @IBOutlet weak var locationButton: UIButton!
    
    // MARK: - VARIABLES
    var viewModel: RideInfoVM!
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showRideInfoView()
    }
    
    // MARK: - INTERNAL FUNCTIONS
    func setupViewModel(_ viewModel: RideInfoVM) {
        self.viewModel = viewModel
    }
    
    // MARK: - IBACTIONS
    @IBAction func currentLocationButtonAction(_ sender: UIButton) {
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func showRideInfoView() {
        let infoView: RideRouteAndDriverInfoView = .loadFromNib()
        infoView.setupView(model: self.viewModel.infoModel)
        infoView.delegate = self
        Utility.addEqualConstraints(for: infoView, inSuperView: self.rideInfoContainerView)
    }
}

extension RideInfoVC: RideRouteDriverInfoDelegate {
    func didTapDriverView() {
        let vc = UIStoryboard.loadDriverDetailCompletedRideVC()
        self.navigationController?.pushViewController(vc)
    }
}
