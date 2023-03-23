//
//  TravelBuddyVC+TableViewDelegate.swift
//  Pneuma
//
//  Created by Chitra on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension TravelBuddyVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.selectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
}
