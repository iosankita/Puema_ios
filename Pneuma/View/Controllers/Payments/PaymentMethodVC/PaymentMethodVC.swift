//
//  PaymentMethodVC.swift
//  Pneuma
//
//  Created by Jatin on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import Stripe

class PaymentMethodVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigation: CustomNavigationView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
      // MARK: - VARIABLES
    private let cellIdentifier = "ExistingPaymentMethodCell"
    let viewModel = PaymentMethodVM()
    //var paymentSheet: PaymentSheet?
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigation.delegate = self
        self.setupTableView()
    }
    
    // MARK: - IBACTIONS
    @IBAction func addMethodButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.loadAddPaymentMethodVC()
        self.navigationController?.pushViewController(vc)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setupTableView() {
        self.registerNib()
        self.tableView.dataSource = self.viewModel.tableDataSource
        self.tableView.reloadData { [weak self] in
            guard let `self` = self else {
                return
            }
            self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
            self.view.layoutIfNeeded()
        }
    }
    
    private func registerNib() {
        let nib = UINib(nibName: self.cellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.cellIdentifier)
    }
}

// MARK: - NAVIGATION VIEW DELEGATE
extension PaymentMethodVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressRight button: UIButton) {
        let vc = UIStoryboard.loadMultipleBookingsCompletedVC()
        vc.screentype = .planMyTrip
        self.navigationController?.pushViewController(vc)
    }
}
