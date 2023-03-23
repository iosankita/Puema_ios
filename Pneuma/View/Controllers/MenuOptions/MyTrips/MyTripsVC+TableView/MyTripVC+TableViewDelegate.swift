//
//  MyTripVC+TableViewDelegate.swift
//  Pneuma
//
//  Created by Jatin on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension MyTripsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.loadRideDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

}
