//
//  SettingsVC+TableDelegate.swift
//  Pneuma
//
//  Created by Chitra on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension SettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.generalTableView {
            if let subType = self.viewModel.tableDataSource.listArray[.general]?[indexPath.row].subType {
                switch subType {
                case .appLanguage:
                    self.gotoAppLanguage()
                case .preferredCurrency:
                    self.gotoPreferredCurrency()
                case .payment:
                    self.gotoPayment()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.generalTableView {
            return UITableView.automaticDimension
        } else {
            return 55.0
        }
    }
}

// MARK: - NAVIGATION FUNCTIONS
fileprivate extension SettingsVC {
    
    func gotoAppLanguage() {
        //
    }
    
    func gotoPreferredCurrency() {
        let vc = UIStoryboard.loadSelectCurrencyVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoPayment() {
        let vc = UIStoryboard.loadPaymentMethodListVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
