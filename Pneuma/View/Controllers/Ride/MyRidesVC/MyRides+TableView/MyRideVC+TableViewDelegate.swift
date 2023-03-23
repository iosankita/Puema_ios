//
//  MyRideVC+TableViewDelegate.swift
//  Pneuma
//
//  Created by Jatin on 16/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension MyRidesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.loadRideInfoVC()
        let model = self.viewModel.tableDataSource.listArray[indexPath.row]
        let vm = RideInfoVM(model: model)
        vc.setupViewModel(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
