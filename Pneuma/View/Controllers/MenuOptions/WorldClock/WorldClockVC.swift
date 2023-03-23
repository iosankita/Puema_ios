//
//  WorldClockVC.swift
//  Pneuma
//
//  Created by Chitra on 09/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class WorldClockVC: UIViewController {

    @IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    let cellId = "ClockCell"
    var viewModel = WorldClockVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        customNav.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableViewHeight.constant = self.tableView.contentSize.height
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        tableView.dataSource = self.viewModel.tableDataSource
    }
}

//MARK:- CUSTOM NAVIGATION DELEGATEs
extension WorldClockVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressRight button: UIButton) {
        let vc = UIStoryboard.loadSearchCountryVC()
        self.present(vc, animated: true, completion: nil)
    }
}
