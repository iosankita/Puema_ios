//
//  HotelSearchResultVC+TableDelegate.swift
//  Pneuma
//
//  Created by Jatin on 01/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit

extension HotelSearchResultVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.loadHotelInfoVC()
        vc.hotelData = self.viewModel.tableDataSource.listArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
