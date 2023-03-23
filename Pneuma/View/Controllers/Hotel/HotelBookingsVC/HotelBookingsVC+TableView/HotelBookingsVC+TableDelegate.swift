//
//  HotelBookingsResultVC+TableDelegate.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension HotelBookingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.loadHotelInfoVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
