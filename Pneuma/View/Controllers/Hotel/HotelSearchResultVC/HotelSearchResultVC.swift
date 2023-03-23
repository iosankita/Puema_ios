//
//  HotelSearchResultVC.swift
//  Pneuma
//
//  Created by Jatin on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class HotelSearchResultVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigation: CustomNavigationView!
    
    // MARK: - VARIABLES
    var checkinDate : Date = Date()
    var checkoutDate : Date = Date()
    var location: String = ""
    private let cellIdentifier = "HotelListingCell"
    let viewModel = HotelSearchResultVM()
    
    // MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.title = "Hotels"
        self.setupTableView()
        self.callAPI()
        self.navigation.delegate = self
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func callAPI() {
        CustomLoader.shared.show()
        let checkin_date = checkinDate.string(withFormat: "yyyy-MM-dd")
        let checkout_date = checkoutDate.dayAfter.string(withFormat: "yyyy-MM-dd")
        let param = SearchHotelModelParam(checkin_date: checkin_date, checkout_date: checkout_date, location: location)
        self.viewModel.getList(param) { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(_):
                //Handle UI or navigation
                self.tableView.dataSource = self.viewModel.tableDataSource
                self.tableView.reloadData()
                return
            case .failure(_):
                return
            }
        }
    }

    private func setupTableView() {
        self.registerNib()
        self.tableView.dataSource = self.viewModel.tableDataSource
        self.tableView.delegate = self
    }
    
    private func registerNib() {
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    private func showSortByScreen() {
        let vc = UIStoryboard.loadHotelSortByVC()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }

}

// NAVIGATION VIEW DELEGATE
extension HotelSearchResultVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressRight button: UIButton) {
        //self.showSortByScreen()
    }
}
