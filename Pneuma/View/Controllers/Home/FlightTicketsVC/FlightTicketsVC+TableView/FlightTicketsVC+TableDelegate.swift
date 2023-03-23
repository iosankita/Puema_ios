//
//  FlightTicketsVC+TableDelegate.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension FlightTicketsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.loadOutboundDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
