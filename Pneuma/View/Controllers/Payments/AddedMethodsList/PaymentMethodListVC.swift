//
//  PaymentMethodListVC.swift
//  Pneuma
//
//  Created by Chitra on 15/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class PaymentMethodListVC: UIViewController {

    // MARK: - IBOUTLETS
    @IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    // MARK: - VARIABLES
    var viewModel = PaymentMethodListVM()
    var cellId = "PaymentMethodCell"
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableHeight.constant = tableView.contentSize.height
    }
    
    // MARK: - IBACTIONS
    @IBAction func addPaymentMethod(_ sender: Any) {
        setValueToVM()
        if let message = self.viewModel.validation() {
           self.showAlertWithText(message)
        }else{
           self.addPaymentMethod()
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func registerNib() {
        self.tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        self.viewModel.tableDataSource.editCallBack = { (index) in
            self.didEdit(at: index)
        }
        self.viewModel.tableDataSource.deleteCallBack = { (index) in
            self.didDelete(at: index)
        }
        self.tableView.dataSource = self.viewModel.tableDataSource
    }
    
    private func setValueToVM() {
        self.viewModel.requestModel.payment_method_id = 2
        self.viewModel.requestModel.card_number = 9292929292929292
        self.viewModel.requestModel.cvv = 213
        self.viewModel.requestModel.expiry_date = "12-2025"
    }
}
extension PaymentMethodListVC: AlertProtocol {
    fileprivate func addPaymentMethod() {
          CustomLoader.shared.show()
          self.viewModel.addPaymentMethod { [weak self] (result) in
              CustomLoader.shared.hide()
              guard let `self` = self else {
                  return
              }
              switch result {
              case .success(_):
                  //Handle UI or navigation
                  self.showAlertWithText(self.viewModel.responseModel?.message ?? "", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                      //self.dismiss(animated: true, completion: nil)
                  }
                  return
              case .failure(let error):
                  self.showAlertWithText(error.message)
              }
          }
      }
    fileprivate func updatePaymentMethod() {
          CustomLoader.shared.show()
          self.viewModel.updatePaymentMethod { [weak self] (result) in
              CustomLoader.shared.hide()
              guard let `self` = self else {
                  return
              }
              switch result {
              case .success(_):
                  //Handle UI or navigation
                  self.showAlertWithText(self.viewModel.updateResponseModel?.message ?? "", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                      //self.dismiss(animated: true, completion: nil)
                  }
                  return
              case .failure(let error):
                  self.showAlertWithText(error.message)
              }
          }
      }
}

extension PaymentMethodListVC {
    private func setUpdateValueToVM() {
        self.viewModel.updateRequestModel.payment_method_id = 2
        self.viewModel.updateRequestModel.card_number = 9292929292929292
        self.viewModel.updateRequestModel.cvv = 213
        self.viewModel.updateRequestModel.expiry_date = "12-2025"
    }
    func didEdit(at index: Int) {
        print(index)
        setUpdateValueToVM()
        if let message = self.viewModel.validation() {
           self.showAlertWithText(message)
        }else{
           self.updatePaymentMethod()
        }
        
    }
    func didDelete(at index: Int) {
        print(index)
    }
}
