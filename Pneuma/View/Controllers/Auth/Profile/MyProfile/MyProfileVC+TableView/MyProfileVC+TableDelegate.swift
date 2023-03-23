//
//  MyProfileVC+TableDelegate.swift
//  Pneuma
//
//  Created by Chitra on 02/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension MyProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectItem(at: indexPath)
    }
}
