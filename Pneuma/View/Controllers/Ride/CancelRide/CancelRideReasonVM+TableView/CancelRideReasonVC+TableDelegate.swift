//
//  CancelRideReasonVC+TableDelegate.swift
//  Pneuma
//
//  Created by Chitra on 05/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension CancelRideReasonVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
