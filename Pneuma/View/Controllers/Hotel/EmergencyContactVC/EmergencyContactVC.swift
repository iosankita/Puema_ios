//
//  EmergencyContactVC.swift
//  Pneuma
//
//  Created by Jatin on 03/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class EmergencyContactVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - VARIABLES
    private let cellIdentifier = "ChooseAddressTableCell"
    let viewModel = EmergencyContactVM()
    
    // MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setupTableView() {
        self.registerNib()
        self.tableView.dataSource = self.viewModel.tableDataSource
        self.tableView.tableFooterView = UIView()
    }
    
    private func registerNib() {
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.cellIdentifier)
    }

}
