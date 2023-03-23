//
//  MyTripsVC.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class MyTripsVC: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    var viewModel = MyTripsVM()
    let flightTicketsViewModel = FlightTicketsVM()
    let cellId = "MyTripsCell"
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegates()
        self.callApi()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.tableHeight.constant = self.tableView.contentSize.height
    }
    
    //MARK:- PRIVATE FUNCTIONS
    private func setDelegates() {
        customNav.delegate = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
     
    }
    
    func callApi() {
        CustomLoader.shared.show()
        self.viewModel.getList { [weak self] (result) in
            CustomLoader.shared.hide()
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(_):
                //Handle UI or navigation
                self.tableView.dataSource = self.viewModel.tableDataSource
                self.tableView.reloadData()
                self.tableHeight.constant = CGFloat(self.viewModel.tableDataSource.listArray.count * 55) + 15.0
                return
            case .failure(_):
                return
            }
        }
    }
}

//MARK:- CustomNavigationViewDelegate
extension MyTripsVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {
        //show menu
    }
}
