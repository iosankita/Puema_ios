//
//  SettingsVC.swift
//  Pneuma
//
//  Created by Chitra on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    //MARK:- IBOUTLETS
    @IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var generalTableView: UITableView!
    @IBOutlet weak var notifyTableView: UITableView!
    @IBOutlet weak var notifyViaTableView: UITableView!
    @IBOutlet weak var generalTableHeight: NSLayoutConstraint!
    @IBOutlet weak var notifyTableHeight: NSLayoutConstraint!
    @IBOutlet weak var notifyViaTableHeight: NSLayoutConstraint!
    
    //MARK:- VARIABLES
    let cellID = "CustomListCell"
    var viewModel = SettingsVM()
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.generalTableHeight.constant = self.generalTableView.contentSize.height
            self.notifyTableHeight.constant = self.notifyTableView.contentSize.height
            self.notifyViaTableHeight.constant = self.notifyViaTableView.contentSize.height
        }
    }
    
    //MARK:- PRIVATE FUNCTIONS
    private func registerCells() {
        generalTableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        notifyTableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        notifyViaTableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        generalTableView.dataSource = self.viewModel.tableDataSource
        notifyTableView.dataSource = self.viewModel.tableDataSource
        notifyViaTableView.dataSource = self.viewModel.tableDataSource
    }
    
}
