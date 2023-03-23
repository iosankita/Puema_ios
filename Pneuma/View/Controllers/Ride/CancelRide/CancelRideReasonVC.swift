//
//  CancelRideReasonVC.swift
//  Pneuma
//
//  Created by Chitra on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class CancelRideReasonVC: UIViewController {

    //MARK:- IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    //MARK:- VARIABLES
    var viewModel = CancelRideReasonVM()
    let cellId = "CustomListCell"
    weak var delegate: SearchDriverDelegate?
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableHeight.constant = self.tableView.contentSize.height
    }

    //MARK:- IBACTIONS
    @IBAction func searchAction(_ sender: Any) {
        self.delegate?.didSearchAgain()
    }
    
    @IBAction func cancelOrderAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- PRIVATE FUNCTIOS
    private func registerCell() {
        self.tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.tableView.dataSource = self.viewModel.tableDataSource
    }
}
