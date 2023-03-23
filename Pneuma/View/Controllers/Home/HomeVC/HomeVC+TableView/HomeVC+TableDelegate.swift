//
//  HomeVC+TableDelegate.swift
//  Pneuma
//
//  Created by Jatin on 26/02/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectItem(at: indexPath)
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
}
