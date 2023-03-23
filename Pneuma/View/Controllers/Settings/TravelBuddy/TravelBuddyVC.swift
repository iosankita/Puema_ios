//
//  TravelBuddyVC.swift
//  Pneuma
//
//  Created by Chitra on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class TravelBuddyVC: UIViewController, TravelBuddyDelegate {

    //MARK:- IBOUTLETS
    @IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    //MARK:- VARIABLES
    let cellId = "CustomListCell"
    var viewModel = TravelBuddyVM()
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.customNav.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableHeight.constant = self.tableView.contentSize.height
    }
    
    //MARK:- IBACTIONS
    @IBAction func addNewAction(_ sender: Any) {
        let vc = UIStoryboard.loadAddTravelBuddyVC()
        vc.delegate = self
        self.navigationController?.pushViewController(vc)
    }
    
    //MARK:- PRIVATE FUNCTIONS
    private func registerCell() {
        self.tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.tableView.dataSource = self.viewModel.tableDataSource
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
                self.view.setNeedsLayout()
                return
            case .failure(_):
                return
            }
        }
        
    }

    func reloadTable() {
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
                self.view.setNeedsLayout()
                return
            case .failure(_):
                return
            }
        }
    }
}

//MARK:- CUSTOM NAVIGATION VIEW DELEGATE
extension TravelBuddyVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {
        //
    }
}
