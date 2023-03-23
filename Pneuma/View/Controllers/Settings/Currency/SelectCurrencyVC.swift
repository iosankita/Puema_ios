//
//  SelectCurrencyVC.swift
//  Pneuma
//
//  Created by Chitra on 10/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

class SelectCurrencyVC: UIViewController {

    @IBOutlet weak var customNav: CustomNavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    let cellId = "CustomListCell"
    var viewModel = SelectCurrencyVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNav.delegate = self
        registerCell()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.tableHeight.constant = self.tableView.contentSize.height
    }
    
    func registerCell() {
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
}

extension SelectCurrencyVC: CustomNavigationViewDelegate {
    func view(_ view: CustomNavigationView, didPressRight button: UIButton) {
        var selectedCurrency : CurrencyDataModel?
        for (i, currency) in self.viewModel.tableDataSource.listArray.enumerated() {
            if currency.isSelected {
                selectedCurrency = viewModel.responseModel?.data?[i]
                break
            }
        }
        guard let selected = selectedCurrency else {
            return
        }
        
        self.viewModel.storeRequestModel.currency_id = selected.id

        if let message = self.viewModel.validation() {
           self.showAlertWithText(message)
        }else{
           self.storeCurrency()
        }
    }
    
    func view(_ view: CustomNavigationView, didPressLeft button: UIButton) {
//        self.navigationController?.popViewController()
    }
}

extension SelectCurrencyVC: AlertProtocol {
     fileprivate func storeCurrency() {
           CustomLoader.shared.show()
           self.viewModel.addPreferredCurrency { [weak self] (result) in
               CustomLoader.shared.hide()
               guard let `self` = self else {
                   return
               }
               switch result {
               case .success(_):
                   //Handle UI or navigation
                   self.showAlertWithText(self.viewModel.storeResponseModel?.message ?? "", buttonTitle: LocalizedStringEnum.ok.localized) { (UIAlertAction) in
                       self.dismiss(animated: true, completion: nil)
                   }
                   return
               case .failure(let error):
                   self.showAlertWithText(error.message)
               }
           }
       }
}
