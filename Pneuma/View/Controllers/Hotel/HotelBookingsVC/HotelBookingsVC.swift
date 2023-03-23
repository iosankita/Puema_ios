//
//  HotelBookingsVC.swift
//  Pneuma
//
//  Created by Jatin on 11/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class HotelBookingsVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var pastButton: UIButton!
    @IBOutlet weak var customNavigationView: UIView!
    
    // MARK: - VARIABLES
    private let cellIdentifier = "HotelBookingCell"
    let viewModel = HotelBookingsVM()
    
    // MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupInitialUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.customizeUI()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func customizeUI() {
        self.customNavigationView.roundBottomCorners()
    }
    
    private func setupInitialUI() {
        self.upcomingButton.addBottomBorderWithColor(.white, width: 2)
    }
    
    private func setupTableView() {
        self.registerNib()
        self.tableView.dataSource = self.viewModel.tableDataSource
        self.filterHotelData(isPastData: false)
    }
    
    private func registerNib() {
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    private func filterHotelData(isPastData:Bool){
        if isPastData{
            CustomLoader.shared.show()
            self.viewModel.getPastHotel{ [weak self] (result) in
                CustomLoader.shared.hide()
                guard let `self` = self else {
                    return
                }
                switch result {
                case .success(_):
                    //Handle UI or navigation
                    self.tableView.dataSource = self.viewModel.tableDataSource
                    self.tableView.reloadData()
                    self.view.setNeedsLayout()
                    return
                case .failure(_):
                    return
                }
            }
        }else{
            CustomLoader.shared.show()
            self.viewModel.getUpcomingHotel{ [weak self] (result) in
                CustomLoader.shared.hide()
                guard let `self` = self else {
                    return
                }
                switch result {
                case .success(_):
                    //Handle UI or navigation
                    self.tableView.dataSource = self.viewModel.tableDataSource
                    self.tableView.reloadData()
                    self.view.setNeedsLayout()
                    return
                case .failure(_):
                    return
                }
            }
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func upcomingButtonAction(_ sender: UIButton) {
        self.pastButton.removeBottomBoder()
        self.pastButton.setTitleColor(.lightLavendar, for: .normal)
        self.upcomingButton.setTitleColor(.white, for: .normal)
        self.upcomingButton.addBottomBorderWithColor(.white, width: 2)
        self.filterHotelData(isPastData: false)
    }
    
    @IBAction func pastButtonAction(_ sender: UIButton) {
        self.upcomingButton.removeBottomBoder()
        self.upcomingButton.setTitleColor(.lightLavendar, for: .normal)
        self.pastButton.setTitleColor(.white, for: .normal)
        self.pastButton.addBottomBorderWithColor(.white, width: 2)
        self.filterHotelData(isPastData: true)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
