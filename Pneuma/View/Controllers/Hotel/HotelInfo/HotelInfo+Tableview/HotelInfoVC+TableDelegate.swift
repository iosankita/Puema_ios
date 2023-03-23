//
//  HotelInfoVC+TableDelegate.swift
//  Pneuma
//
//  Created by iTechnolabs on 17/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension HotelInfoVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.loadSearchResultVC()
        vc.room = self.hotelData!.rooms![indexPath.row]
        vc.hotelData = self.hotelData
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
