//
//  DiscoverListVC.swift
//  Pneuma
//
//  Created by Chitra on 11/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class DiscoverListVC: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    var viewModel = CityDiscoverListVM()
    let cellId = "DiscoverListCell"
    var listType = CityDiscoverType.museums
    
    //MARK:- VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customNav.title = "Select \(listType.rawValue)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableHeight.constant = self.tableView.contentSize.height
        self.viewModel.selectionCallback = { (model) in
            let vc = UIStoryboard.laodDiscoverOptionDetailVC()
            self.navigationController?.pushViewController(vc)
        }
    }
    
    //MARK:- PRIVATE FUNCTIONS
    private func registerCell() {
        self.tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.tableView.dataSource = self.viewModel.tableDataSource
    }
    
}
