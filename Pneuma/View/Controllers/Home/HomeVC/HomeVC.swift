//
//  HomeVC.swift
//  Pneuma
//
//  Created by Jatin on 26/02/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, NavigationProtocol {

    // MARK:- IBOUTLETS
    @IBOutlet weak var lblUsernameDescription: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customNavView: CustomNavigationView!
    
    // MARK:- VARIABLES
    private let cellIdentifier = "HomeTableCell"
    let viewModel = HomeVM()
    
    // MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setData()
        self.setupTableView()
        self.customNavView.delegate = self

//        fatalError()
    }

    // MARK:- IBACTIONS
    @IBAction func startButtonAction(_ sender: UIButton) {
        self.gotoSelectedOptions()
    }
    
    @IBAction func planMyTripButtonAction(_ sender: UIButton) {
        self.gotoBookFlightVC(screenType: .planMyTrip)
    }

    // MARK:- PRIVATE FUNCTIONS
    private func setData() {
        self.lblUsernameDescription.text = "Hi, \(AppCache.shared.currentUser?.name ?? "")!\nWhat Would you Like to do? "
    }
    
    private func setupTableView() {
        self.registerNib()
        self.tableView.dataSource = self.viewModel.tableDataSource
    }
    
    private func registerNib() {
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    ///Navigation functions
    private func gotoSelectedOptions() {
        
        if let vc = AppCache.shared.selectedBookingOptions.nextController() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        /*guard let bookingType = AppCache.shared.selectedBookingOptions.first else {
            return
        }
        switch bookingType {
        
        case .bookFlight:
            self.gotoBookFlightVC(screenType: .bookFlight)
        case .findHotel:
            self.gotoFindHotelVC()
        case .getRide:
            self.gotoGetRideVC()
        case .askAnnie:
            return
        }*/
    }
    
    private func gotoBookFlightVC(screenType: BookFlightScreenType) {
        let vm = BookFlightVM(screenType: screenType)
        let vc = UIStoryboard.loadBookFlightVC()
        vc.setupViewModel(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func gotoFindHotelVC() {
        let vc = UIStoryboard.loadFindHotelVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func gotoGetRideVC() {
        let vc = UIStoryboard.loadGetRideVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CUSTOM NAVIGATION VIEW DELEGATE
extension HomeVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {
        let vc = UIStoryboard.loadMenuVC()
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}
